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
#import "FSImageViewer.h"
#import "FSImageSource.h"
#import "FSTitleView.h"

@class FSImageViewerViewController;

// Optional Delegate for getting current presented image index.
@protocol FSImageViewerViewControllerDelegate <NSObject>

@optional

// Called if moved to the image at the given index.
- (void)imageViewerViewController:(FSImageViewerViewController *)imageViewerViewController didMoveToImageAtIndex:(NSInteger)index;

- (void)imageViewerViewController:(FSImageViewerViewController *)imageViewerViewController willDismissViewControllerAnimated:(BOOL)animated;
- (void)imageViewerViewController:(FSImageViewerViewController *)imageViewerViewController didDismissViewControllerAnimated:(BOOL)animated;

@end

/// FSImageViewerViewController is an UIViewController which can present images.
@interface FSImageViewerViewController : UIViewController <UIScrollViewDelegate>

/// @param imageSource image data source
- (id)initWithImageSource:(id <FSImageSource>)imageSource;

/// @param imageSource image data source
/// @param imageIndex the index of the first shown image
- (id)initWithImageSource:(id <FSImageSource>)imageSource imageIndex:(NSInteger)imageIndex;

/// Image data source
@property(strong, nonatomic, readonly) id <FSImageSource> imageSource;

/// Title
@property(strong, nonatomic) UIView<FSTitleView>* titleView;

/// Optional Delegate
@property(weak, nonatomic) id<FSImageViewerViewControllerDelegate> delegate;

/// FSImageView array
@property(strong, nonatomic) NSMutableArray *imageViews;

/// Main scrollView
@property(strong, nonatomic) UIScrollView *scrollView;

/// Display a "x of y" images in the navigation title - Default is YES
@property(assign, nonatomic) BOOL showNumberOfItemsInTitle;

/// Disable image sharing - Default is NO
@property(assign, nonatomic, getter = isSharingDisabled) BOOL sharingDisabled;

/// Override rotation of images - Default is YES
@property(assign, nonatomic, getter = isRotationEnabled) BOOL rotationEnabled;

/// Override the background color when overlay is hidden - Default is black
@property(strong, nonatomic) UIColor *backgroundColorHidden;

/// Override the background color when overlay is visible - Default is white
@property(strong, nonatomic) UIColor *backgroundColorVisible;

/// Override the progressView color when overlay is hidden - Default is white
@property(strong, nonatomic) UIColor *progressColorHidden;

/// Override the progressView color when overlay is visible - Default is darkGrayColor
@property(strong, nonatomic) UIColor *progressColorVisible;

/// Used to add additional items to the "share" button
@property(strong, nonatomic) NSArray* applicationActivities;

/// Current index of the image displayed
/// @return current index of the image displayed
- (NSInteger)currentImageIndex;

/// Move the FSImageView to the index
/// @param index index move to
/// @param animated should the movevement animated
- (void)moveToImageAtIndex:(NSInteger)index animated:(BOOL)animated;

@end