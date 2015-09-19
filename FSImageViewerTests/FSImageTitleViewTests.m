//
//  FSImageViewerTests.m
//  FSImageViewerTests
//
//  Created by Felix Schulze on 01.06.14.
//  Copyright (c) 2014 Felix Schulze. All rights reserved.
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

#import "FSImageTitleView.h"

@interface FSImageTitleViewTests : FBSnapshotTestCase
@end

@implementation FSImageTitleViewTests

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}


- (void)testShortTitle {
    FSImageTitleView *view = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    view.text = @"Some title";
    FBSnapshotVerifyView(view, nil);
    XCTAssertFalse(view.isHidden);
}

- (void)testNormalTitle {
    FSImageTitleView *view = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    view.text = @"Some longer title with some lorem ipsum text";
    FBSnapshotVerifyView(view, nil);
    XCTAssertFalse(view.isHidden);
}

- (void)testLongTitle {
    FSImageTitleView *view = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    view.text = @"Some longer title with some lorem ipsum text and some other lorem ipsum and another lorem ipsum text";
    FBSnapshotVerifyView(view, nil);
    XCTAssertFalse(view.isHidden);
}

- (void)testIsHiddenIfNoText {
    FSImageTitleView *view = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    view.text = nil;
    XCTAssertTrue(view.isHidden);
}

- (void)testIsHiddenIfTextContainsOnlyWhitespace {
    FSImageTitleView *view = [[FSImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    view.text = @"  ";
    XCTAssertTrue(view.isHidden);
}

@end