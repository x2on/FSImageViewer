//  FSImageViewer
//
//  Created by Felix Schulze on 9/04/2013.
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

#import "FSImageViewer.h"

/// FSBasicImage is a standard implementation of FSImage. It can download images from an URL or use an image.
@interface FSBasicImage : NSObject<FSImage>

/// @param URL remote image URL
/// @param name title of the image
- (id)initWithImageURL:(NSURL *)URL name:(NSString *)name;

/// @param URL remote image URL
- (id)initWithImageURL:(NSURL *)URL;

/// @param image an UIImage representation of the image
- (id)initWithImage:(UIImage *)image;

/// @param image an UIImage representation of the image
/// @param name title of the image
- (id)initWithImage:(UIImage *)image name:(NSString *)name;

@end
