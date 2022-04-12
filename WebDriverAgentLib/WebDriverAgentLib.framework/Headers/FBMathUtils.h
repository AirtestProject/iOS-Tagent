/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <UIKit/UIKit.h>

@class XCUIApplication;

extern CGFloat FBDefaultFrameFuzzyThreshold;

/*! Returns center point of given rect */
CGPoint FBRectGetCenter(CGRect rect);

/*! Returns whether floatss are equal within given threshold */
BOOL FBFloatFuzzyEqualToFloat(CGFloat float1, CGFloat float2, CGFloat threshold);

/*! Returns whether points are equal within given threshold */
BOOL FBPointFuzzyEqualToPoint(CGPoint point1, CGPoint point2, CGFloat threshold);

/*! Returns whether vectors are equal within given threshold */
BOOL FBVectorFuzzyEqualToVector(CGVector a, CGVector b, CGFloat threshold);

/*! Returns whether size are equal within given threshold */
BOOL FBSizeFuzzyEqualToSize(CGSize size1, CGSize size2, CGFloat threshold);

/*! Returns whether rect are equal within given threshold */
BOOL FBRectFuzzyEqualToRect(CGRect rect1, CGRect rect2, CGFloat threshold);

#if !TARGET_OS_TV
/*! Inverts point if necessary to match location on screen */
CGPoint FBInvertPointForApplication(CGPoint point, CGSize screenSize, UIInterfaceOrientation orientation);

/*! Inverts offset if necessary to match screen orientation */
CGPoint FBInvertOffsetForOrientation(CGPoint offset, UIInterfaceOrientation orientation);

/*! Inverts size if necessary to match current screen orientation */
CGSize FBAdjustDimensionsForApplication(CGSize actualSize, UIInterfaceOrientation orientation);
#endif
