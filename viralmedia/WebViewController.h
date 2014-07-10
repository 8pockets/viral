//
//  WebViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/10.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
