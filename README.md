# FSImageViewer [![Build Status](https://travis-ci.org/x2on/FSImageViewer.png)](https://travis-ci.org/x2on/FSImageViewer) [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/p/FSImageViewer/badge.svg)](http://cocoadocs.org/docsets/FSImageViewer/) [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/v/FSImageViewer/badge.svg)](http://cocoadocs.org/docsets/FSImageViewer/)

![Screenshot](https://raw.github.com/x2on/FSImageViewer/master/screen.png)

FSImageViewer is a photo viewer for iOS.

It's initially based on [EGOPhotoViewer](https://raw.github.com/enormego/PhotoViewer), but complettly refactored to use ARC, [AFNetworking](https://github.com/AFNetworking/AFNetworking) for remote image downloads and [EGOCache 2.0](https://github.com/enormego/EGOCache) for image caching.

## Install
Using [CocoaPods](http://cocoapods.org/):

`pod 'FSImageViewer', '~> 1.2.0'`

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
iOS 5.0+ is currently supported.

## License

FSImageViewer is available under the MIT license. See the LICENSE file for more info.

