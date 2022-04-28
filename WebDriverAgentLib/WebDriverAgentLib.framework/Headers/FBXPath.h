/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>
#import <WebDriverAgentLib/FBElement.h>
#import <WebDriverAgentLib/XCElementSnapshot.h>

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpadded"
#endif

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <libxml/encoding.h>
#import <libxml/xmlwriter.h>

#ifdef __clang__
#pragma clang diagnostic pop
#endif

@class FBXMLGenerationOptions;

NS_ASSUME_NONNULL_BEGIN

@interface FBXPath : NSObject

/**
 Returns an array of descendants matching given xpath query
 
 @param root the root element to execute XPath query for
 @param xpathQuery requested xpath query
 @return an array of descendants matching the given xpath query or an empty array if no matches were found
 @throws NSException if there is an unexpected internal error during xml parsing
 */
+ (NSArray<XCElementSnapshot *> *)matchesWithRootElement:(id<FBElement>)root
                                                forQuery:(NSString *)xpathQuery;

/**
 Gets XML representation of XCElementSnapshot with all its descendants. This method generates the same
 representation, which is used for XPath search
 
 @param root the root element
 @param options Optional values that affect the resulting XML creation process
 @return valid XML document as string or nil in case of failure
 */
+ (nullable NSString *)xmlStringWithRootElement:(id<FBElement>)root
                                        options:(nullable FBXMLGenerationOptions *)options;

@end

NS_ASSUME_NONNULL_END
