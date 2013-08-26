//  FSImageViewerDemo
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

#import "FSDemoViewController.h"
#import "FSDemoImage.h"
#import "FSDemoImageSource.h"

@interface FSDemoViewController ()

@end

@implementation FSDemoViewController

- (id)init {
    self = [super initWithNibName:@"FSDemoViewController" bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!_imageViewController) {
        [self openGallery];
    }
}


- (IBAction)openGallery {
    FSDemoImage *webPhoto = [[FSDemoImage alloc] initWithImageURL:[NSURL URLWithString:@"http://a3.twimg.com/profile_images/66601193/cactus.jpg"] name:@"Some nice cactus"];
    FSDemoImage *flickrPhoto = [[FSDemoImage alloc] initWithImageURL:[NSURL URLWithString:@"http://farm4.staticflickr.com/3692/9573432231_1e2a0003d3.jpg"] name:@"Some flickr image"];
    FSDemoImage *failingPhoto = [[FSDemoImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/1.jpg"] name:@"Failure image"];

    FSDemoImageSource *photoSource = [[FSDemoImageSource alloc] initWithImages:@[webPhoto, flickrPhoto, failingPhoto]];
    self.imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.navigationController presentViewController:_imageViewController animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:_imageViewController animated:YES];
    }
}

@end
