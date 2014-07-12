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
    CustomCellItems *_item;
    UIRefreshControl *_refreshControl;
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
    
//    __weak typeof(self) weakSelf =self;
//    [self.NewContent addPullToRefreshActionHandler:^{
//        [weakSelf startDownload];
//        
//    } ProgressImagesGifName:@"spinner_dropbox@2x.gif" LoadingImagesGifName:@"run@2x.gif" ProgressScrollThreshold:50 LoadingImageFrameRate:30];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.NewContent.delegate = self;
    self.NewContent.dataSource = self;
    
    //カスタムセルの設定
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.NewContent registerNib:nib forCellReuseIdentifier:@"NewCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"NewCell"];

     //ツールバーの非表示
    //[self.navigationController setToolbarHidden:YES animated:YES];
    
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
    
    _items = [[NSMutableArray alloc] init];
    _item = [[CustomCellItems alloc] init];
    
    //初期データ OR 保存していたデータ読み込み
    NSUserDefaults *Newsave = [NSUserDefaults standardUserDefaults];
    _items = [[NSMutableArray alloc] init];
    _item = [[CustomCellItems alloc] init];
    if ([Newsave arrayForKey:@"Newsave"]) {
        NSLog(@"%@",@"DATA!!!");
        for (NSData *object in [Newsave arrayForKey:@"Newsave"]) {
            NSString *dataEncode = [NSKeyedUnarchiver unarchiveObjectWithData:object];
            [_items addObject:dataEncode];
        }
    }else{
        NSLog(@"%@",@"NO DATA!!!");
        _item = [[CustomCellItems alloc] init];
        _items = [[NSMutableArray alloc] init];
        _item.title = @"下に引き伸ばして更新！";
        _item.url = @"";
        [_items addObject:_item];
    }
    
    //RefreshControl設定
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(startDownload)
              forControlEvents:UIControlEventValueChanged];
    [self.NewContent addSubview:_refreshControl];
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell"];
    CustomCellItems *item = _items[indexPath.row];
    cell.title.text = [item title];
    cell.date.text = [item date];
    cell.site.text = [item site];
    NSString *viewtext = [[item view] stringByAppendingString:@" likes"];
    cell.view.text = viewtext;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 選択状態の解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //カスタムセルなので、prepareforSegueは呼ばれない。
    CustomCellItems *selectitem = _items[indexPath.row];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[selectitem title] forKey:@"title"];
    [ud setValue:[selectitem url] forKey:@"url"];
    
    [self performSegueWithIdentifier:@"webSegue" sender:selectitem];
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
//    __weak typeof(self) weakSelf = self;
//    self.isLoading =YES;
//    int64_t delayInSeconds = 2.2;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
//        [weakSelf.NewContent beginUpdates];
        //[weakSelf.pData insertObject:[NSDate date] atIndex:0];
        //[weakSelf.NewContent insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // AFJSONResponseSerializer、AFHTTPResponseSerializerの順にレスポンスを解析
        NSArray *responseSerializers =
        @[
          [AFJSONResponseSerializer serializer],
          [AFHTTPResponseSerializer serializer]
          ];
        
        AFCompoundResponseSerializer *responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:responseSerializers];
        
        manager.responseSerializer = responseSerializer;
        
        [manager GET:@"http://viral.8pockets.com/new.json"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 // 通信に成功した場合の処理
                 _items = [[NSMutableArray alloc] init];
                 for (NSDictionary *json in responseObject) {
                     _item = [[CustomCellItems alloc] init];
                     _item.title = [json objectForKey:@"title"];
                     _item.url = [json objectForKey:@"url"];
                     _item.date = [json objectForKey:@"published_at"];
                     _item.view = [json objectForKey:@"bookmarks"];
                     _item.site = [json objectForKey:@"site_name"];
                     [_items addObject:_item];
                 }
                 [self.NewContent reloadData];
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 // エラーの場合はエラーの内容をコンソールに出力する
                 NSLog(@"Error: %@", error);
             }];
    //データ取得終了
    dispatch_async(dispatch_get_main_queue(), ^{
        [_refreshControl endRefreshing];
        [self.NewContent performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
        NSUserDefaults *Newsave = [NSUserDefaults standardUserDefaults];
        NSMutableArray *archivearray = [NSMutableArray arrayWithCapacity:_items.count];
        for (NSDictionary *object in _items) {
            NSData *dataEncode = [NSKeyedArchiver archivedDataWithRootObject:object];
            [archivearray addObject:dataEncode];
        }
        [Newsave setObject:archivearray forKey:@"Newsave"];
        [Newsave synchronize];
        
    });

}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
