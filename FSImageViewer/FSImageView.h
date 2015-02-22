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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSImageSource.h"
#import "FSImageLoader.h"

@class FSImageScrollView, FSImageTitleView;

@interface FSImageView : UIView <UIScrollViewDelegate>

@property(strong, nonatomic) id <FSImage> image;
@property(strong, nonatomic, readonly) UIImageView *imageView;
@property(strong, nonatomic, readonly) FSImageScrollView *scrollView;
@property(assign, nonatomic) BOOL loading;
@property(assign, nonatomic) BOOL rotationEnabled;

- (void)killScrollViewZoom;

- (void)layoutScrollViewAnimated:(BOOL)animated;

- (void)prepareForReuse;

- (void)changeBackgroundColor:(UIColor *)color;

- (void)changeProgressViewColor:(UIColor *)color;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation;

@end
