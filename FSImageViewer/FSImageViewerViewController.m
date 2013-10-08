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

#import "FSImageViewerViewController.h"
#import "FSImageTitleView.h"

@interface FSImageViewerViewController ()

@property(strong, nonatomic) FSImageTitleView *titleView;

@end

@implementation FSImageViewerViewController {
    NSInteger pageIndex;
    BOOL rotating;
    BOOL barsHidden;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
}

- (id)initWithImageSource:(id <FSImageSource>)aImageSource {
    return [self initWithImageSource:aImageSource imageIndex:0];
}

- (id)initWithImageSource:(id <FSImageSource>)aImageSource imageIndex:(NSInteger)imageIndex {
    if ((self = [super init])) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleBarsNotification:) name:kFSImageViewerToogleBarsNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewDidFinishLoading:) name:kFSImageViewerDidFinishedLoadingNotificationKey object:nil];

        self.hidesBottomBarWhenPushed = YES;
        self.wantsFullScreenLayout = YES;

        _imageSource = aImageSource;
        pageIndex = imageIndex;
    }
    return self;
}

- (void)dealloc {
    _scrollView.delegate = nil;
    [[FSImageLoader sharedInstance] cancelAllRequests];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    self.imageViews = nil;
    _scrollView.delegate = nil;
    self.scrollView = nil;
    _titleView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

#ifdef __IPHONE_7_0
	if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
#endif

    self.view.backgroundColor = [UIColor whiteColor];

    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _scrollView.scrollEnabled = YES;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.delaysContentTouches = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_scrollView];
    }

    if (!_titleView) {
        self.titleView = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 1)];
        [self.view addSubview:_titleView];
    }

    //  load FSImageView lazy
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [_imageSource numberOfImages]; i++) {
        [views addObject:[NSNull null]];
    }
    self.imageViews = views;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.presentingViewController && (self.modalPresentationStyle == UIModalPresentationFullScreen)) {
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"done") style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
            self.navigationItem.rightBarButtonItem = doneButton;
        }
    }

    [self setupScrollViewContentSize];
    [self moveToImageAtIndex:pageIndex animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    }

    return (UIInterfaceOrientationIsLandscape(interfaceOrientation) || interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    rotating = YES;

    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        _scrollView.contentSize = CGSizeMake(rect.size.height * [_imageSource numberOfImages], rect.size.width);
    }

    NSInteger count = 0;
    for (FSImageView *view in _imageViews) {
        if ([view isKindOfClass:[FSImageView class]]) {
            if (count != pageIndex) {
                [view setHidden:YES];
            }
        }
        count++;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (FSImageView *view in _imageViews) {
        if ([view isKindOfClass:[FSImageView class]]) {
            [view rotateToOrientation:toInterfaceOrientation];
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setupScrollViewContentSize];
    [self moveToImageAtIndex:pageIndex animated:NO];
    [_scrollView scrollRectToVisible:((FSImageView *) [_imageViews objectAtIndex:(NSUInteger) pageIndex]).frame animated:YES];

    for (FSImageView *view in self.imageViews) {
        if ([view isKindOfClass:[FSImageView class]]) {
            [view setHidden:NO];
        }
    }
    rotating = NO;
}

- (void)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)currentImageIndex {
    return pageIndex;
}

#pragma mark - Bar/Caption Methods

- (void)setStatusBarHidden:(BOOL)hidden {
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationFade];
}

- (void)setBarsHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden && barsHidden) {
        return;
    }

    [self setStatusBarHidden:hidden];
    [self.navigationController setNavigationBarHidden:hidden animated:animated];

    [UIView animateWithDuration:0.3 animations:^{
        UIColor *backgroundColor = hidden ? [UIColor blackColor] : [UIColor whiteColor];
        self.view.backgroundColor = backgroundColor;
        self.scrollView.backgroundColor = backgroundColor;
        for (FSImageView *imageView in _imageViews) {
            if ([imageView isKindOfClass:[FSImageView class]]) {
                [imageView changeBackgroundColor:backgroundColor];;
            }
        }
    }];

    [_titleView hideView:hidden];

    barsHidden = hidden;
}

- (void)toggleBarsNotification:(NSNotification *)notification {
    [self setBarsHidden:!barsHidden animated:YES];
}

#pragma mark - Image View

- (void)imageViewDidFinishLoading:(NSNotification *)notification {
    if (notification == nil) {
        return;
    }

    if ([[notification object][@"image"] isEqual:_imageSource[[self centerImageIndex]]]) {
        if ([[notification object][@"failed"] boolValue]) {
            if (barsHidden) {
                [self setBarsHidden:NO animated:YES];
            }
        }
        [self setViewState];
    }
}

- (NSInteger)centerImageIndex {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    return (NSInteger) (floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1);
}

- (void)setViewState {

    if (leftButton) {
        leftButton.enabled = !(pageIndex - 1 < 0);
    }

    if (rightButton) {
        rightButton.enabled = !(pageIndex + 1 >= [_imageSource numberOfImages]);
    }

    NSInteger numberOfImages = [_imageSource numberOfImages];
    if (numberOfImages > 1) {
        self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"%i of %i", @"imageCounter"), pageIndex + 1, numberOfImages];
    } else {
        self.title = @"";
    }

    if (_titleView) {
        _titleView.text = _imageSource[pageIndex].title;
    }

}

- (void)moveToImageAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index < [self.imageSource numberOfImages] && index >= 0) {

        pageIndex = index;
        [self setViewState];

        [self enqueueImageViewAtIndex:index];

        [self loadScrollViewWithPage:index - 1];
        [self loadScrollViewWithPage:index];
        [self loadScrollViewWithPage:index + 1];

        [self.scrollView scrollRectToVisible:((FSImageView *) [_imageViews objectAtIndex:(NSUInteger) index]).frame animated:animated];

        if (_imageSource[pageIndex].failed) {
            [self setBarsHidden:NO animated:YES];
        }

        if (index + 1 < [self.imageSource numberOfImages] && (NSNull *) [_imageViews objectAtIndex:(NSUInteger) (index + 1)] != [NSNull null]) {
            [((FSImageView *) [self.imageViews objectAtIndex:(NSUInteger) (index + 1)]) killScrollViewZoom];
        }
        if (index - 1 >= 0 && (NSNull *) [self.imageViews objectAtIndex:(NSUInteger) (index - 1)] != [NSNull null]) {
            [((FSImageView *) [self.imageViews objectAtIndex:(NSUInteger) (index - 1)]) killScrollViewZoom];
        }
    }

}

- (void)layoutScrollViewSubviews {

    NSInteger index = [self currentImageIndex];

    for (NSInteger page = index - 1; page < index + 3; page++) {

        if (page >= 0 && page < [_imageSource numberOfImages]) {

            CGFloat originX = _scrollView.bounds.size.width * page;

            if (page < index) {
                originX -= kFSImageViewerImageGap;
            }
            if (page > index) {
                originX += kFSImageViewerImageGap;
            }

            if ([_imageViews objectAtIndex:(NSUInteger) page] == [NSNull null] || !((UIView *) [_imageViews objectAtIndex:(NSUInteger) page]).superview) {
                [self loadScrollViewWithPage:page];
            }

            FSImageView *imageView = [_imageViews objectAtIndex:(NSUInteger) page];
            CGRect newFrame = CGRectMake(originX, 0.0f, _scrollView.bounds.size.width, _scrollView.bounds.size.height);

            if (!CGRectEqualToRect(imageView.frame, newFrame)) {
                [UIView animateWithDuration:0.1 animations:^{
                    imageView.frame = newFrame;
                }];
            }
        }
    }
}

- (void)setupScrollViewContentSize {

    CGSize contentSize = self.view.bounds.size;
    contentSize.width = (contentSize.width * [_imageSource numberOfImages]);

    if (!CGSizeEqualToSize(contentSize, self.scrollView.contentSize)) {
        self.scrollView.contentSize = contentSize;
    }

    _titleView.frame = CGRectMake(0.0f, self.view.bounds.size.height - 40.0f, self.view.bounds.size.width, 40.0f);
}

- (void)enqueueImageViewAtIndex:(NSInteger)theIndex {

    NSInteger count = 0;
    for (FSImageView *view in _imageViews) {
        if ([view isKindOfClass:[FSImageView class]]) {
            if (count > theIndex + 1 || count < theIndex - 1) {
                [view prepareForReuse];
                [view removeFromSuperview];
            } else {
                view.tag = 0;
            }
        }
        count++;
    }
}

- (FSImageView *)dequeueImageView {

    NSInteger count = 0;
    for (FSImageView *view in self.imageViews) {
        if ([view isKindOfClass:[FSImageView class]]) {
            if (view.superview == nil) {
                view.tag = count;
                return view;
            }
        }
        count++;
    }
    return nil;
}

- (void)loadScrollViewWithPage:(NSInteger)page {

    if (page < 0) {
        return;
    }
    if (page >= [_imageSource numberOfImages]) {
        return;
    }

    FSImageView *imageView = [_imageViews objectAtIndex:(NSUInteger) page];
    if ((NSNull *) imageView == [NSNull null]) {
        imageView = [self dequeueImageView];
        if (imageView != nil) {
            [_imageViews exchangeObjectAtIndex:(NSUInteger) imageView.tag withObjectAtIndex:(NSUInteger) page];
            imageView = [_imageViews objectAtIndex:(NSUInteger) page];
        }
    }

    if (imageView == nil || (NSNull *) imageView == [NSNull null]) {
        imageView = [[FSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        UIColor *backgroundColor = barsHidden ? [UIColor blackColor] : [UIColor whiteColor];
        [imageView changeBackgroundColor:backgroundColor];
        [_imageViews replaceObjectAtIndex:(NSUInteger) page withObject:imageView];
    }

    imageView.image = _imageSource[page];

    if (imageView.superview == nil) {
        [_scrollView addSubview:imageView];
    }

    CGRect frame = _scrollView.frame;
    NSInteger centerPageIndex = pageIndex;
    CGFloat xOrigin = (frame.size.width * page);
    if (page > centerPageIndex) {
        xOrigin = (frame.size.width * page) + kFSImageViewerImageGap;
    } else if (page < centerPageIndex) {
        xOrigin = (frame.size.width * page) - kFSImageViewerImageGap;
    }

    frame.origin.x = xOrigin;
    frame.origin.y = 0;
    imageView.frame = frame;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = [self centerImageIndex];
    if (index >= [_imageSource numberOfImages] || index < 0) {
        return;
    }

    if (pageIndex != index && !rotating) {
        pageIndex = index;
        [self setViewState];

        if (![scrollView isTracking]) {
            [self layoutScrollViewSubviews];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = [self centerImageIndex];
    if (index >= [_imageSource numberOfImages] || index < 0) {
        return;
    }

    [self moveToImageAtIndex:index animated:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self layoutScrollViewSubviews];
}

@end
