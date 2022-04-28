/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <WebDriverAgentLib/XCElementSnapshot.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCElementSnapshot (FBHelpers)

/**
 Returns an array of descendants matching given type

 @param type requested descendant type
 @return an array of descendants matching given type
 */
- (NSArray<XCElementSnapshot *> *)fb_descendantsMatchingType:(XCUIElementType)type;

/**
 Returns first (going up element tree) parent that matches given type. If non found returns nil.

 @param type requested parent type
 @return parent element matching given type
 */
- (nullable XCElementSnapshot *)fb_parentMatchingType:(XCUIElementType)type;

/**
 Returns first (going up element tree) parent that matches one of given types. If non found returns nil.
 
 @param types possible parent types
 @return parent element matching one of given types
 */
- (nullable XCElementSnapshot *)fb_parentMatchingOneOfTypes:(NSArray<NSNumber *> *)types;

/**
 Returns first (going up element tree) visible parent that matches one of given types and has more than one child. If non found returns nil.
 
 @param types possible parent types
 @param filter will filter results even further after matching one of given types
 @return parent element matching one of given types and satisfying filter condition
 */
- (nullable XCElementSnapshot *)fb_parentMatchingOneOfTypes:(NSArray<NSNumber *> *)types filter:(BOOL(^)(XCElementSnapshot *snapshot))filter;

/**
 Retrieves the list of all element ancestors in the snapshot hierarchy.
 
 @return the list of element ancestors or an empty list if the snapshot has no parent.
 */
- (NSArray<XCElementSnapshot *> *)fb_ancestors;

/**
 Returns value for given accessibility property identifier.

 @param attribute attribute's accessibility identifier. Can be one of
 `XC_kAXXCAttribute`-prefixed attribute names.
 @return value for given accessibility property identifier
 */
- (nullable id)fb_attributeValue:(NSString *)attribute;

/**
 Method used to determine whether given element matches receiver by comparing it's parameters except frame.

 @param snapshot element's snapshot to compare against
 @return YES, if they match otherwise NO
 */
- (BOOL)fb_framelessFuzzyMatchesElement:(XCElementSnapshot *)snapshot;

/**
 Returns an array of descendants cell snapshots
 
 @return an array of descendants cell snapshots
 */
- (NSArray<XCElementSnapshot *> *)fb_descendantsCellSnapshots;

/**
 Returns itself if it is either XCUIElementTypeIcon or XCUIElementTypeCell. Otherwise, returns first (going up element tree) parent that matches cell (XCUIElementTypeCell or  XCUIElementTypeIcon). If non found returns nil.
 
 @return parent element matching either XCUIElementTypeIcon or XCUIElementTypeCell.
 */
- (nullable XCElementSnapshot *)fb_parentCellSnapshot;

/**! Human-readable snapshot description */
- (NSString *)fb_description;

/**
 Returns the snapshot visibleFrame with a fallback to direct attribute retrieval from FBXCAXClient in case of a snapshot fault (nil visibleFrame)
 
 @return the snapshot visibleFrame
 */
- (CGRect)fb_visibleFrameWithFallback;

@end

NS_ASSUME_NONNULL_END
