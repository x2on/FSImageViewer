# FSImageViewer [![Build Status](https://travis-ci.org/x2on/FSImageViewer.png)](https://travis-ci.org/x2on/FSImageViewer) [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/p/FSImageViewer/badge.svg)](http://cocoadocs.org/docsets/FSImageViewer/) [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/v/FSImageViewer/badge.svg)](http://cocoadocs.org/docsets/FSImageViewer/) [![License](https://go-shields.herokuapp.com/license-MIT-blue.png)](http://opensource.org/licenses/MIT)

![Screenshot](https://raw.github.com/x2on/FSImageViewer/master/screen.png)

FSImageViewer is a photo viewer (gallery) for iOS.

It's initially based on [EGOPhotoViewer](https://raw.github.com/enormego/PhotoViewer), but completely refactored to use ARC, [AFNetworking 2.5](https://github.com/AFNetworking/AFNetworking) for remote image downloads and [EGOCache 2.1](https://github.com/enormego/EGOCache) for image caching.

If you must use AFNetworking 1.3 you can use the 1.x version of FSImageViewer (https://github.com/x2on/FSImageViewer/tree/1.x)

## Install
Using [CocoaPods](http://cocoapods.org/):

`pod 'FSImageViewer', '~> 3.2'`

## Basic usage

Create your image objects: 

```objc
FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/1.jpg"] name:@"Photo 1"];
FSBasicImage *secondPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/2.jpg"] name:@"Photo 2"];
```

And add them to the data source:

```objc
FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto, secondPhoto]];
```

And create and show the view controller:
```objc
FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
[self.navigationController pushViewController:imageViewController animated:YES];
```

If you like to use a modal view controller:
```objc
FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];
[self.navigationController presentViewController:navigationController animated:YES completion:nil];
```

## Advanced usage

You can also create your own image class by implementing the `FSImage` protocol and your own datasource by implementing the `FSImageSource` protocol.

## Demo

The demo project uses [CocoaPods](http://cocoapods.org/) for dependency management.

Install dependencies:`pod install`

## System support
iOS 7.0+ is currently supported.

If you must support iOS 5.0+ you can use the 1.x version of FSImageViewer.
If you must support iOS 6.0+ you can use the 2.x version of FSImageViewer.

## License

FSImageViewer is available under the MIT license. See the LICENSE file for more info.

