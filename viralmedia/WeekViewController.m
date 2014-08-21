//
//  WeekViewController.m
//  viralmedia
//
//  Created by 8pockets on 2014/07/12.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "WeekViewController.h"

@interface WeekViewController (){
    NSMutableArray *_items;
    CustomCellItems *_item;
}
@property (nonatomic) BDBSpinKitRefreshControl *refreshControl;
@property (nonatomic) NSTimer *colorTimer;
@end

@implementation WeekViewController

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.WeekContent.delegate = self;
    self.WeekContent.dataSource = self;
    
    //ヘッダー画像
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weektitle.png"]];
    
    //カスタムセルの設定
    UINib *nib = [UINib nibWithNibName:@"WeekCell" bundle:nil];
    [self.WeekContent registerNib:nib forCellReuseIdentifier:@"WeekCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"WeekCell"];
    
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
    NSUserDefaults *Weeksave = [NSUserDefaults standardUserDefaults];
    if ([Weeksave arrayForKey:@"Weeksave"]) {
        NSLog(@"%@",@"DATA!!!");
        for (NSData *object in [Weeksave arrayForKey:@"Weeksave"]) {
            NSString *dataEncode = [NSKeyedUnarchiver unarchiveObjectWithData:object];
            [_items addObject:dataEncode];
        }
    }else{
        NSLog(@"%@",@"NO DATA!!!");
        _item = [[CustomCellItems alloc] init];
        _items = [[NSMutableArray alloc] init];
        _item.title = @"↓下に引き伸ばして更新！";
        _item.url = @"";
        [_items addObject:_item];
    }
    
    //RefreshControl設定
    UIColor *color = [UIColor colorWithRed:0.937f green:0.263f blue:0.157f alpha:1.0f];
    self.refreshControl = [BDBSpinKitRefreshControl refreshControlWithStyle:RTSpinKitViewStyleBounce
                                                                      color:color];
    self.refreshControl.delegate = self;
    self.refreshControl.shouldChangeColorInstantly = YES;
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.WeekContent addSubview:_refreshControl];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Refresh Controll
- (void)didShowRefreshControl {
    self.colorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                       target:self
                                                     selector:@selector(doubleRainbow)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)didHideRefreshControl {
    [self.colorTimer invalidate];
}

- (void)doubleRainbow {
    CGFloat h, s, v, a;
    [self.refreshControl.tintColor getHue:&h saturation:&s brightness:&v alpha:&a];
    h = fmodf((h + 0.025f), 1.0f);
    self.refreshControl.tintColor = [UIColor colorWithHue:h saturation:s brightness:v alpha:a];
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
    WeekCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekCell"];
    CustomCellItems *item = _items[indexPath.row];
    cell.title.text = [item title];
    cell.date.text = [item date];
    cell.site.text = [item site];
    NSString *viewtext = [[item view] stringByAppendingString:@" likes"];
    cell.view.text = viewtext;
    
    // For even
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        // does not work
    }
    // For odd
    else {
        cell.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0];     // does not work
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 選択状態の解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //カスタムセルなので、prepareforSegueは呼ばれない。
    CustomCellItems *selectitem = _items[indexPath.row];
    
    // MagicalRecordイニシャライズ
    [MagicalRecord setupCoreDataStack];
    // データの挿入
    History *cellRecord = [History MR_createEntity];
    cellRecord.title = [selectitem title];
    cellRecord.date  = [selectitem date];
    cellRecord.view = [selectitem view];
    cellRecord.site = [selectitem site];
    cellRecord.url = [selectitem url];
    cellRecord.created_at = [NSDate date];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[selectitem url] forKey:@"url"];
    [ud setValue:[selectitem pageid] forKey:@"id"];
    [ud synchronize];
    
    NSURL *url = [NSURL URLWithString:[selectitem url]];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)refresh {
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
    
    [manager GET:@"http://necobuzz.com/weekly.json"
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
             [self.WeekContent reloadData];
             
             NSUserDefaults *Newsave = [NSUserDefaults standardUserDefaults];
             NSMutableArray *archivearray = [NSMutableArray arrayWithCapacity:_items.count];
             for (NSDictionary *object in _items) {
                 NSData *dataEncode = [NSKeyedArchiver archivedDataWithRootObject:object];
                 [archivearray addObject:dataEncode];
             }
             [Newsave setObject:archivearray forKey:@"Weeksave"];
             [Newsave synchronize];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

@end
