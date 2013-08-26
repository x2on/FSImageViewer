//  FSImageViewer
//
//  Created by Felix Schulze on 8/26/2013.
//  Copyright 2013 Felix Schulze. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "FSPlaceholderImages.h"

@implementation FSPlaceholderImages

+ (UIImage *)errorImage {
    UIImage *errorImage;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 480), NO, [[UIScreen mainScreen] scale]);

    UIColor *signColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
    UIColor *bangColor = [UIColor whiteColor];

    UIBezierPath *signPath = [UIBezierPath bezierPath];
    [signPath moveToPoint:CGPointMake(161.99, 183.24)];
    [signPath addLineToPoint:CGPointMake(102.02, 281.82)];
    [signPath addCurveToPoint:CGPointMake(102.02, 287.92) controlPoint1:CGPointMake(100.87, 283.71) controlPoint2:CGPointMake(100.87, 286.03)];
    [signPath addCurveToPoint:CGPointMake(107.57, 290.95) controlPoint1:CGPointMake(103.15, 289.78) controlPoint2:CGPointMake(105.27, 290.95)];
    [signPath addLineToPoint:CGPointMake(227.51, 290.95)];
    [signPath addCurveToPoint:CGPointMake(233.06, 287.92) controlPoint1:CGPointMake(229.79, 290.95) controlPoint2:CGPointMake(231.91, 289.78)];
    [signPath addCurveToPoint:CGPointMake(233.06, 281.82) controlPoint1:CGPointMake(234.19, 286.03) controlPoint2:CGPointMake(234.19, 283.71)];
    [signPath addLineToPoint:CGPointMake(173.1, 183.24)];
    [signPath addCurveToPoint:CGPointMake(167.54, 180.18) controlPoint1:CGPointMake(171.95, 181.36) controlPoint2:CGPointMake(169.82, 180.18)];
    [signPath addCurveToPoint:CGPointMake(161.99, 183.24) controlPoint1:CGPointMake(165.26, 180.18) controlPoint2:CGPointMake(163.14, 181.36)];
    [signPath closePath];
    signPath.miterLimit = 4;

    [signColor setFill];
    [signPath fill];


    UIBezierPath *bangPath = [UIBezierPath bezierPath];
    [bangPath moveToPoint:CGPointMake(164.98, 284.2)];
    [bangPath addCurveToPoint:CGPointMake(159.93, 276.55) controlPoint1:CGPointMake(162.12, 282.83) controlPoint2:CGPointMake(159.93, 279.52)];
    [bangPath addCurveToPoint:CGPointMake(171.15, 268.46) controlPoint1:CGPointMake(159.93, 271.03) controlPoint2:CGPointMake(165.7, 266.87)];
    [bangPath addCurveToPoint:CGPointMake(177.3, 276.63) controlPoint1:CGPointMake(174.83, 269.53) controlPoint2:CGPointMake(177.33, 272.85)];
    [bangPath addCurveToPoint:CGPointMake(173.05, 283.87) controlPoint1:CGPointMake(177.27, 279.84) controlPoint2:CGPointMake(175.88, 282.21)];
    [bangPath addCurveToPoint:CGPointMake(164.98, 284.2) controlPoint1:CGPointMake(170.88, 285.14) controlPoint2:CGPointMake(167.25, 285.29)];
    [bangPath closePath];
    [bangPath moveToPoint:CGPointMake(165.63, 262.4)];
    [bangPath addCurveToPoint:CGPointMake(163.76, 260.87) controlPoint1:CGPointMake(165.28, 262.2) controlPoint2:CGPointMake(164.43, 261.51)];
    [bangPath addCurveToPoint:CGPointMake(159.88, 234.65) controlPoint1:CGPointMake(161.41, 258.63) controlPoint2:CGPointMake(161.41, 258.65)];
    [bangPath addCurveToPoint:CGPointMake(159.09, 211.45) controlPoint1:CGPointMake(158.51, 213.31) controlPoint2:CGPointMake(158.5, 212.98)];
    [bangPath addCurveToPoint:CGPointMake(168.22, 206.75) controlPoint1:CGPointMake(160.4, 208) controlPoint2:CGPointMake(163.33, 206.49)];
    [bangPath addCurveToPoint:CGPointMake(175.26, 209.96) controlPoint1:CGPointMake(171.32, 206.91) controlPoint2:CGPointMake(173.71, 208)];
    [bangPath addCurveToPoint:CGPointMake(176.87, 215.27) controlPoint1:CGPointMake(176.59, 211.64) controlPoint2:CGPointMake(176.88, 212.59)];
    [bangPath addCurveToPoint:CGPointMake(174.75, 256.05) controlPoint1:CGPointMake(176.87, 218.18) controlPoint2:CGPointMake(175.02, 253.87)];
    [bangPath addCurveToPoint:CGPointMake(170.29, 262.27) controlPoint1:CGPointMake(174.41, 258.92) controlPoint2:CGPointMake(172.74, 261.24)];
    [bangPath addCurveToPoint:CGPointMake(165.63, 262.4) controlPoint1:CGPointMake(168.89, 262.85) controlPoint2:CGPointMake(166.58, 262.92)];
    [bangPath closePath];
    bangPath.miterLimit = 4;

    [bangColor setFill];
    [bangPath fill];

    errorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return errorImage;
}
@end