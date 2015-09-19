//
//  FSImageViewTests.m
//  FSImageViewer
//
//  Created by Felix Schulze on 19.09.15.
//  Copyright © 2015 Felix Schulze. All rights reserved.
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
#import "FSImageView.h"
#import "FSImage.h"
#import "FSTestImageHelper.h"

@interface FSImageViewTests : FBSnapshotTestCase

@end

@implementation FSImageViewTests

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}

- (void)testEmptyView {
    FSImageView *view = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    FBSnapshotVerifyView(view, nil);
}

- (void)testEmptyViewWithProgressViewColor {
    FSImageView *view = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view changeProgressViewColor:[UIColor greenColor]];
    FBSnapshotVerifyView(view, nil);
}

- (void)testView {
    id mock = OCMProtocolMock(@protocol(FSImage));
    OCMStub([mock image]).andReturn([FSTestImageHelper imageNamed:@"Testimage.jpg"]);
    FSImageView *view = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    view.image = mock;
    FBSnapshotVerifyView(view, nil);
}

- (void)testViewWithBackgroundColor {
    id mock = OCMProtocolMock(@protocol(FSImage));
    OCMStub([mock image]).andReturn([FSTestImageHelper imageNamed:@"Testimage.jpg"]);
    FSImageView *view = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    view.image = mock;
    [view changeBackgroundColor:[UIColor greenColor]];
    FBSnapshotVerifyView(view, nil);
}

- (void)testFailedView {
    id mock = OCMProtocolMock(@protocol(FSImage));
    OCMStub([mock didFail]).andReturn(YES);
    FSImageView *view = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    view.image = mock;
    FBSnapshotVerifyView(view, nil);
}



@end
