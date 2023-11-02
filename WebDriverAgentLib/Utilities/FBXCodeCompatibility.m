/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBXCodeCompatibility.h"

#import "FBConfiguration.h"
#import "FBErrorBuilder.h"
#import "FBLogger.h"
#import "XCUIApplication+FBHelpers.h"
#import "XCUIElementQuery.h"
#import "FBXCTestDaemonsProxy.h"
#import "XCTestManager_ManagerInterface-Protocol.h"

static const NSTimeInterval APP_STATE_CHANGE_TIMEOUT = 5.0;

NSString *const FBApplicationMethodNotSupportedException = @"FBApplicationMethodNotSupportedException";

@implementation XCUIApplication (FBCompatibility)

+ (instancetype)fb_applicationWithPID:(pid_t)processID
{
  if (0 == processID) {
    return nil;
  }

  return [self applicationWithPID:processID];
}

- (void)fb_activate
{
  [self activate];
  if (![self waitForState:XCUIApplicationStateRunningForeground timeout:APP_STATE_CHANGE_TIMEOUT / 2] || ![self fb_waitForAppElement:APP_STATE_CHANGE_TIMEOUT / 2]) {
    [FBLogger logFmt:@"The application '%@' is not running in foreground after %.2f seconds", self.bundleID, APP_STATE_CHANGE_TIMEOUT];
  }
}

- (void)fb_terminate
{
  [self terminate];
  if (![self waitForState:XCUIApplicationStateNotRunning timeout:APP_STATE_CHANGE_TIMEOUT]) {
    [FBLogger logFmt:@"The active application is still '%@' after %.2f seconds timeout", self.bundleID, APP_STATE_CHANGE_TIMEOUT];
  }
}

- (NSUInteger)fb_state
{
  return [[self valueForKey:@"state"] intValue];
}

@end


@implementation XCUIElementQuery (FBCompatibility)

- (XCElementSnapshot *)fb_uniqueSnapshotWithError:(NSError **)error
{
  return [self uniqueMatchingSnapshotWithError:error];
}

- (XCUIElement *)fb_firstMatch
{
  if (FBConfiguration.useFirstMatch) {
    XCUIElement* match = self.firstMatch;
    return [match exists] ? match : nil;
  }
  return self.fb_allMatches.firstObject;
}

- (NSArray<XCUIElement *> *)fb_allMatches
{
  return FBConfiguration.boundElementsByIndex
    ? self.allElementsBoundByIndex
    : self.allElementsBoundByAccessibilityElement;
}

@end


@implementation XCUIElement (FBCompatibility)

+ (BOOL)fb_supportsNonModalElementsInclusion
{
  static dispatch_once_t hasIncludingNonModalElements;
  static BOOL result;
  dispatch_once(&hasIncludingNonModalElements, ^{
    result = [FBApplication.fb_systemApplication.query respondsToSelector:@selector(includingNonModalElements)];
  });
  return result;
}

- (XCUIElementQuery *)fb_query
{
  return FBConfiguration.includeNonModalElements && self.class.fb_supportsNonModalElementsInclusion
    ? self.query.includingNonModalElements
    : self.query;
}

@end

@implementation XCPointerEvent (FBXcodeCompatibility)

+ (BOOL)fb_areKeyEventsSupported
{
  static BOOL isKbInputSupported = NO;
  static dispatch_once_t onceKbInputSupported;
  dispatch_once(&onceKbInputSupported, ^{
    isKbInputSupported = [XCPointerEvent.class respondsToSelector:@selector(keyboardEventForKeyCode:keyPhase:modifierFlags:offset:)];
  });
  return isKbInputSupported;
}

@end

NSInteger FBTestmanagerdVersion(void)
{
  static dispatch_once_t getTestmanagerdVersion;
  static NSInteger testmanagerdVersion;
  dispatch_once(&getTestmanagerdVersion, ^{
    id<XCTestManager_ManagerInterface> proxy = [FBXCTestDaemonsProxy testRunnerProxy];
    if ([(NSObject *)proxy respondsToSelector:@selector(_XCT_exchangeProtocolVersion:reply:)]) {
      [FBRunLoopSpinner spinUntilCompletion:^(void(^completion)(void)){
        [proxy _XCT_exchangeProtocolVersion:testmanagerdVersion reply:^(unsigned long long code) {
          testmanagerdVersion = (NSInteger) code;
          completion();
        }];
      }];
    } else {
      testmanagerdVersion = 0xFFFF;
    }
  });
  return testmanagerdVersion;
}
