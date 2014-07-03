//
//  NewViewController.m
//  viralmedia
//
//  Created by 8pockets on 2014/06/27.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController (){
    NSMutableArray *_items;
    //BlogItem *_item;
    //NSXMLParser *_parser;
    //NSString *_elementName;
}
@end

@implementation NewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (METransitions *)transitions {
    if (_transitions) return _transitions;
    _transitions = [[METransitions alloc] init];
    return _transitions;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf =self;
    [self.NewContent addPullToRefreshActionHandler:^{
        [weakSelf startDownload];
        
    } ProgressImagesGifName:@"spinner_dropbox@2x.gif" LoadingImagesGifName:@"run@2x.gif" ProgressScrollThreshold:50 LoadingImageFrameRate:30];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.NewContent.delegate = self;
    //self.NewContent.dataSource = self;
    
    //SlidingViewController
    NSDictionary *transitionData = self.transitions.all[0];
    NSLog(@"%@",transitionData);
    id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
    if (transition == (id)[NSNull null]) {
        self.slidingViewController.delegate = nil;
    } else {
        self.slidingViewController.delegate = transition;
    }
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"Menu";
    return cell;
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


- (void)startDownload
{
    __weak typeof(self) weakSelf = self;
    self.isLoading =YES;
    int64_t delayInSeconds = 2.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [weakSelf.NewContent beginUpdates];
        //[weakSelf.pData insertObject:[NSDate date] atIndex:0];
        //[weakSelf.NewContent insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:@"http://153.121.33.54/viral/select-week.php"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 // 通信に成功した場合の処理
                 NSLog(@"responseObject: %@", responseObject);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 // エラーの場合はエラーの内容をコンソールに出力する
                 NSLog(@"Error: %@", error);
             }];
        [weakSelf.NewContent endUpdates];
        
        //Stop PullToRefresh Activity Animation
        [weakSelf.NewContent stopRefreshAnimation];
        weakSelf.isLoading =NO;
        
    });
/*
    _items = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://pipes.yahoo.com/pipes/pipe.run?_id=b26f6f0b13d2b747850bc3cad62bec63&_render=json"]];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //もしインターネット接続出来てなかった場合の処理を書く
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSArray *array = [[jsonObj objectForKey:@"value"] objectForKey:@"items"];
    
    for (NSDictionary *json in array) {
        
        _item = [[BlogItem alloc] init];
        
        _item.title = [json objectForKey:@"title"];
        
        _item.url = [json objectForKey:@"link"];
        
        //ブログの最初の変な文字消す
        NSString *target = @"^.*<p>.*\n";
        NSString *basetext = [json objectForKey:@"description"];
        NSRegularExpression *textregex = [NSRegularExpression regularExpressionWithPattern:target options:0 error:nil];
        NSString *result =[textregex stringByReplacingMatchesInString:basetext options:0 range:NSMakeRange(0,basetext.length) withTemplate:@""];
        _item.description = result;
        
        //UNIX時刻 → NSDate
        NSString *timestmp = [[json objectForKey:@"y:published"]objectForKey:@"utime"];
        double timestamp = [timestmp doubleValue];
        NSTimeInterval timeInterval = timestamp;
        // convert the time interval to a date
        NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        // create the formatter for the desired output
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // set the label text
        _item.date = [formatter stringFromDate:myDate];
        
        [_items addObject:_item];
    }
    //データ取得終了
    dispatch_async(dispatch_get_main_queue(), ^{
        [_refreshControl endRefreshing];
        [self.blogtable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
        //データ保存
        NSUserDefaults *blogsave = [NSUserDefaults standardUserDefaults];
        NSMutableArray *archivearray = [NSMutableArray arrayWithCapacity:_items.count];
        for (NSDictionary *object in _items) {
            NSData *dataEncode = [NSKeyedArchiver archivedDataWithRootObject:object];
            [archivearray addObject:dataEncode];
        }
        [blogsave setObject:archivearray forKey:@"blogsave"];
        [blogsave synchronize];
    });
*/
}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
