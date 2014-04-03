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
#import "FSImageTitleWebView.h"

#define WebViewMaxHeight 150

@implementation FSImageTitleWebView {
    BOOL hidden;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(00.0f, 0.0f, self.frame.size.width, WebViewMaxHeight)];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.webView.scrollView.bounces = NO;
        self.webView.opaque = NO;
        self.webView.delegate = self;
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;

        [self addSubview:self.webView];
    }
    return self;
}

- (void)layoutSubviews {
    [self setNeedsDisplay];
}



- (void)setHtml:(NSString *)html {
    _html = html;
    if (_html == nil || [_html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        self.hidden = YES;
    }
    else {
        self.hidden = NO;
        [self.webView loadHTMLString:_html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
}

- (void)updateMetadata:(NSString *)text index:(NSInteger)index total:(NSInteger)total {
    
    NSString *html = [NSString stringWithFormat:@"<html> \n"
                      "<head> \n"
                      "<style type=\"text/css\"> \n"
                      "body {background-color: rgba(0, 0, 0, 0.8); color:white; text-align:center; font-family: font-family: \"HelveticaNeue-Light\", \"Helvetica Neue Light\", \"Helvetica Neue\", Helvetica, Arial, \"Lucida Grande\", sans-serif;}\n"
                      "img {max-width: 300px; width: auto; height: auto;}\n"
                      "</style> \n"
                      "</head> \n"
                      "<body>%@<br/>(%d of %d)</body> \n"
                      "</html>",  text, index, total];
    
    self.html = html;
}

- (void)hideView:(BOOL)value {
    if (hidden == value) {
        return;
    }

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = value ? 0.0f : 1.0f;
        }];
        hidden = value;
    }
    else {
        if (value) {
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.frame = CGRectMake(0.0f, self.superview.frame.size.height, self.frame.size.width, self.frame.size.height);
            } completion:nil];
        }
        else {
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.frame = CGRectMake(0.0f, self.superview.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            } completion:nil];
        }
    }
    hidden = value;
}

- (BOOL)isHidden {
    return hidden;
}

- (void) adjustTextViewSize:(CGRect)imageViewControllerBounds {
    [self adjustWebViewHeight];
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Loading: %@", [request URL]);
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"didFinish: %@; stillLoading:%@", [[webView request]URL],
          (webView.loading?@"NO":@"YES"));
    [self adjustWebViewHeight];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFail: %@; stillLoading:%@", [[webView request]URL],
          (webView.loading?@"NO":@"YES"));
}

- (void) adjustWebViewHeight {

    if(!self.isHidden) {
        // Adjust webView's hieght
        // http://stackoverflow.com/questions/3936041/how-to-determine-the-content-size-of-a-uiwebview/3937599#3937599
        UIWebView *aWebView = self.webView;
    
        CGRect frame = aWebView.frame;
        frame.size.height = 1;
        aWebView.frame = frame;
        frame.size = [aWebView sizeThatFits:CGSizeZero];
        
        CGFloat newHeight = frame.size.height;
        
        // Don't go over this height
        if (newHeight > WebViewMaxHeight) {
            newHeight = WebViewMaxHeight;
        }

        // Reset the webview's frame
        
        // Animate the size-change of the description.
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake(self.bounds.origin.x, self.superview.bounds.size.height - newHeight, frame.size.width, newHeight);
        } completion:nil];

        aWebView.frame = CGRectMake(0, 0, frame.size.width, newHeight);;
    }
    
    
    // show the scrollbar if the content was too big.
    [self.webView.scrollView flashScrollIndicators];
}

@end
