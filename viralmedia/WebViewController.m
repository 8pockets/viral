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
{
    IBOutlet __weak UIWebView *_webView;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // スワイプジェスチャーを作成して、登録する。
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture:)];
    // スワイプ動作に必要な指は1本と指定する。
    swipeRightGesture.numberOfTouchesRequired = 1;
    [self.webview addGestureRecognizer:swipeRightGesture];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //_webview.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

-(void)loadWebsite
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    self.title = [ud valueForKey:@"title"];
    NSString *urlstring = [NSString stringWithFormat:@"%@", [ud valueForKey:@"url"]];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlstring]];
    [_webView loadRequest:req];
}

// NavigationViewで、現在の画面から一つ前の画面に戻る。
-(void)handleSwipeRightGesture:(UISwipeGestureRecognizer *)gesture {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@",@"hoge");
}
@end
