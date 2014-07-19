//
//  HistoryViewController.m
//  viralmedia
//
//  Created by 8pockets on 2014/07/13.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController (){
    NSArray *_items;
    CustomCellItems *_item;
}

@end

@implementation HistoryViewController

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
    
    self.HistoryContent.delegate = self;
    self.HistoryContent.dataSource = self;
    
    //カスタムセルの設定
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.HistoryContent registerNib:nib forCellReuseIdentifier:@"historyCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"historyCell"];
    
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
    
    // イニシャライズ
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"History.sqlite"];
    _items = [History MR_findAllSortedBy:@"created_at" ascending:NO];
    NSLog(@"magicalAll count : %lu", (unsigned long)[_items count]);
    
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
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
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
@end
