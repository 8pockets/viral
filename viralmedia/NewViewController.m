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
    NSInteger cellCheckNumber;
    NSString *_ADstring;
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.NewContent.delegate = self;
    self.NewContent.dataSource = self;
    
    //ヘッダー画像
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]];
    
    //カスタムセルの設定
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.NewContent registerNib:nib forCellReuseIdentifier:@"NewCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"NewCell"];
    
    //初期データ OR 保存していたデータ読み込み
    NSUserDefaults *Newsave = [NSUserDefaults standardUserDefaults];
    _items = [[NSMutableArray alloc] init];
    _item = [[CustomCellItems alloc] init];
    if ([Newsave arrayForKey:@"Newsave"] != nil) {
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
    
    //RefreshControl設定
    RHRefreshControlConfiguration *refreshConfiguration = [[RHRefreshControlConfiguration alloc] init];
    refreshConfiguration.refreshView = RHRefreshViewStylePinterest;
    //  refreshConfiguration.minimumForStart = @0;
    //  refreshConfiguration.maximumForPull = @120;
    self.refreshControl = [[RHRefreshControl alloc] initWithConfiguration:refreshConfiguration];
    self.refreshControl.delegate = self;
    [self.refreshControl attachToScrollView:self.NewContent];
    self.NewContent.backgroundColor = [UIColor colorWithWhite:0.88 alpha:1.0];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    /*
     *メディアキーを指定します。管理画面内にて確認できるメディアキーを指定しないと成果が取得できません。
     */
    [appCCloud setupAppCWithMediaKey:@"f64a6c161dcc6f01840dee0a09024f22bf296516" option:APPC_CLOUD_AD];
    
    [appCCloud matchAppStartWithDelegate:self count:3];
    
}

- (void)viewDidUnload {
    [appCCloud matchAppStop];
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//広告のデリゲートメソッド
- (void)onGetMatchAppWithIndex:(NSInteger)index
                       appName:(NSString *)app_name
                   description:(NSString *)description
                       caption:(NSString *)caption
                          icon:(UIImage *)icon
                        banner:(UIImage *)banner
{
    _ADstring = description;
    NSLog(@"%@",_ADstring);
    //[appCCloud matchAppRegistWithControl:_ADstring index:0];
    
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
    static NSString *CellIdentifier = @"NewCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CustomCellItems *item = _items[indexPath.row];
    cell.title.text = [item title];
    cell.date.text = [item date];
    cell.site.text = [item site];
    NSString *viewtext = [[item view] stringByAppendingString:@" likes"];
    cell.view.text = viewtext;
    if (indexPath.row == 4) {
        cell.title.text = _ADstring;
        cell.site.text = @"[PR]";
        cell.view.text = @"3 likes";
        //[appCCloud matchAppRegistWithControl:cell index:0];
    }
    // For even
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    // For odd
    else {
        cell.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellItems *selectitem = _items[indexPath.row];
    
    cellCheckNumber = indexPath.row;

    // 選択状態の解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //カスタムセルなので、prepareforSegueは呼ばれない。
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[selectitem url] forKey:@"url"];
    [ud setValue:[selectitem title] forKey:@"title"];
    [ud setValue:[selectitem date] forKey:@"date"];
    [ud setValue:[selectitem view] forKey:@"view"];
    [ud setValue:[selectitem site] forKey:@"site"];
    [ud setValue:[selectitem pageid] forKey:@"id"];
    [ud synchronize];
    
    NSURL *url = [NSURL URLWithString:[selectitem url]];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
    
    // MagicalRecordイニシャライズ
    [MagicalRecord setupCoreDataStack];
    // データの挿入
    History *cellRecord = [History MR_createEntity];
    cellRecord.title = [selectitem title];
    cellRecord.date  = [selectitem date];
    cellRecord.view = [selectitem view];
    cellRecord.site = [selectitem site];
    cellRecord.url = [selectitem url];
    cellRecord.pageid =[selectitem pageid];
    cellRecord.created_at = [NSDate date];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

//PullToRefresh

#pragma mark - TableView ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.refreshControl refreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.refreshControl refreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark - RHRefreshControl Delegate
- (void)refreshDidTriggerRefresh:(RHRefreshControl *)refreshControl {
    self.loading = YES;
	
	[self performSelector:@selector(_fakeLoadComplete) withObject:nil afterDelay:0];
}

- (BOOL)refreshDataSourceIsLoading:(RHRefreshControl *)refreshControl {

    return self.isLoading; // should return if data source model is reloading

}

- (void) _fakeLoadComplete {
    self.loading = NO;
    [self.refreshControl refreshScrollViewDataSourceDidFinishedLoading:self.NewContent];

    _items = [[NSMutableArray alloc] init];
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
             //_items = [[NSMutableArray alloc] init];
             for (NSDictionary *json in responseObject) {
                 _item = [[CustomCellItems alloc] init];
                 _item.pageid = [json objectForKey:@"id"];
                 _item.title = [json objectForKey:@"title"];
                 _item.url = [json objectForKey:@"url"];
                 _item.date = [json objectForKey:@"published_at"];
                 _item.view = [json objectForKey:@"bookmarks"];
                 _item.site = [json objectForKey:@"site_name"];
                 [_items addObject:_item];
             }
             [self.NewContent reloadData];
             
             NSUserDefaults *Newsave = [NSUserDefaults standardUserDefaults];
             NSMutableArray *archivearray = [NSMutableArray arrayWithCapacity:_items.count];
             for (NSDictionary *object in _items) {
                 NSData *dataEncode = [NSKeyedArchiver archivedDataWithRootObject:object];
                 [archivearray addObject:dataEncode];
             }
             [Newsave setObject:archivearray forKey:@"Newsave"];
             [Newsave synchronize];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
    //データ取得終了
    //[self.NewContent performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

@end
