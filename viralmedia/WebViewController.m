//
//  WebViewController.m
//  viralmedia
//
//  Created by 8pockets on 2014/07/10.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property NSMutableArray *_urlStrings;
@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _webview.delegate = self;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    
    //記事のタイトル取得
    self.title = [ud valueForKey:@"title"];
    
    //URLのStringを取得//ここの警告はItemクラスのNSString *urlの部分をNSURLにすれば消える。
    NSString *urlstring = [NSString stringWithFormat:@"%@", [ud valueForKey:@"url"]];
    //NSString *compurl = [urlstring stringByAppendingString:@"#contents"];
    NSLog(@"%@", urlstring);
    
    //これを使って、URLオブジェクトをつくります
    NSURL *posturl = [NSURL URLWithString:[urlstring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSLog(@"%@", posturl);
    
    // さらにこれを使って、Requestオブジェクトをつくります
    NSURLRequest *thisrequest = [NSURLRequest requestWithURL:posturl];
    NSLog(@"%@", thisrequest);
    
    // これを、myFirstWebViewのloadRequestメソッドに渡します
    [self.webview loadRequest:thisrequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
