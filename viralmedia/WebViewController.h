//
//  WebViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/10.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKScrollFullScreen.h"
#import "UIViewController+NJKFullScreenSupport.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface WebViewController : UIViewController<UIWebViewDelegate,NJKScrollFullscreenDelegate,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
