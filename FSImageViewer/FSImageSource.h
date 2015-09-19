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

@protocol FSImage;

/// FSImageSource is the data source for the images. For normal usage you can use FSBasicImageSource
@protocol FSImageSource <NSObject>

/// The array contains all image objects.
@property(strong, nonatomic, readonly) NSArray<id <FSImage>> *images;

/// The number of the image objects are stored in the images array.
@property(assign, nonatomic, readonly) NSInteger numberOfImages;

/// Must return image at the given index - with object subscription you can use it like `imageSource[1];
/// @param index image index
/// @return image at given index
/// @warning index must be in the range of the images
- (id <FSImage>)objectAtIndexedSubscript:(NSUInteger)index;

@end


