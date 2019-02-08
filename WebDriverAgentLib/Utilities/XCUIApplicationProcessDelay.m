/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <objc/runtime.h>
#import "XCUIApplicationProcess.h"
#import "FBLogger.h"

/**
 In certain cases WebDriverAgent fails to create a session because -[XCUIApplication launch] doesn't return
 since it waits for the target app to be quiescenced.
 The reason for this seems to be that 'testmanagerd' doesn't send the events WebDriverAgent is waiting for.
 The expected events would trigger calls to '-[XCUIApplicationProcess setEventLoopHasIdled:]' and
 '-[XCUIApplicationProcess setAnimationsHaveFinished:]', which are the properties that are checked to
 determine whether an app has quiescenced or not.
 Delaying the call to on of the setters can fix this issue. Setting the environment variable
 'EVENTLOOP_IDLE_DELAY_SEC' will swizzle the method '-[XCUIApplicationProcess setEventLoopHasIdled:]'
 and add a thread sleep of the value specified in the environment variable in seconds.
 */
@interface XCUIApplicationProcessDelay : NSObject

@end

static NSString *const EVENTLOOP_IDLE_DELAY_SEC = @"EVENTLOOP_IDLE_DELAY_SEC";
static void (*orig_set_event_loop_has_idled)(id, SEL, BOOL);
static NSTimeInterval delay = 0;

@implementation XCUIApplicationProcessDelay

+ (void)load {
  NSDictionary *env = [[NSProcessInfo processInfo] environment];
  NSString *setEventLoopIdleDelay = [env objectForKey:EVENTLOOP_IDLE_DELAY_SEC];
  if (!setEventLoopIdleDelay || [setEventLoopIdleDelay length] == 0) {
    [FBLogger verboseLog:@"don't delay -[XCUIApplicationProcess setEventLoopHasIdled:]"];
    return;
  }
  delay = [setEventLoopIdleDelay doubleValue];
  if (delay < DBL_EPSILON) {
    [FBLogger log:[NSString stringWithFormat:@"Value of '%@' has to be greater than zero to delay -[XCUIApplicationProcess setEventLoopHasIdled:]",
                   EVENTLOOP_IDLE_DELAY_SEC]];
    return;
  }
  Method original = class_getInstanceMethod([XCUIApplicationProcess class], @selector(setEventLoopHasIdled:));
  if (original == nil) {
    [FBLogger log:@"Could not find method -[XCUIApplicationProcess setEventLoopHasIdled:]"];
    return;
  }
  orig_set_event_loop_has_idled = (void(*)(id, SEL, BOOL)) method_getImplementation(original);
  Method replace = class_getClassMethod([XCUIApplicationProcessDelay class], @selector(setEventLoopHasIdled:));
  method_setImplementation(original, method_getImplementation(replace));
}

+ (void)setEventLoopHasIdled:(BOOL)idled {
  [FBLogger verboseLog:[NSString stringWithFormat:@"Delaying -[XCUIApplicationProcess setEventLoopHasIdled:] by %.2f seconds", delay]];
  [NSThread sleepForTimeInterval:delay];
  orig_set_event_loop_has_idled(self, _cmd, idled);
}

@end
