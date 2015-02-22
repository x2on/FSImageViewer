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
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"

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
    FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://farm8.staticflickr.com/7319/9668947331_3112b1fcca_b.jpg"] name:@"Photo by Brian Adamson"];
    FSBasicImage *secondPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://farm9.staticflickr.com/8023/6971840814_68614eba26_b.jpg"] name:@"Photo by Ben Fredericson (http://farm9.staticflickr.com/8023/6971840814_68614eba26_b.jpg)"];
        FSBasicImage *thirdPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://farm5.staticflickr.com/4094/4888398067_36e695177a_o.jpg"] name:@"Photo by digital cat (https://www.flickr.com/photos/14646075@N03/4888398067)"];
    
    FSBasicImage *failingPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/1.jpg"] name:@"Failure image"];

    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto, secondPhoto, thirdPhoto, failingPhoto]];
    self.imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    
    _imageViewController.delegate = self;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_imageViewController];
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:_imageViewController animated:YES];
    }
}

- (void)imageViewerViewController:(FSImageViewerViewController *)imageViewerViewController didMoveToImageAtIndex:(NSInteger)index {
    NSLog(@"FSImageViewerViewController: %@ didMoveToImageAtIndex: %li",imageViewerViewController, (long)index);
}
@end
