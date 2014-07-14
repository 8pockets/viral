//
//  MenuViewController.m
//  viralmedia
//
//  Created by 8pockets on 2014/06/27.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end

@implementation MenuViewController

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
    
    self.menutable.delegate = self;
    self.menutable.dataSource = self;
    
     self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    
    //セパレーターの色
    [self.menutable setSeparatorColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0]];
    //フッターの要らない部分削除
    //self.menutable.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)menuItems {
    if (_menuItems) return _menuItems;
    
    _menuItems = @[@"新着", @"週間ランキング", @"月間ランキング", @"お気に入り", @"ゲーム", @"履歴", @"おすすめアプリ"];
    
    return _menuItems;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *menuItem = self.menuItems[indexPath.row];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.957 green:0.965 blue:0.973 alpha:1.0];
    cell.textLabel.text = menuItem;
    /*
    if ([menuItem isEqualToString:@"HOME"]) {
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"公式スケジュール"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"ライブ日程"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"YouTube"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"歌詞"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"アプリについて"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }else if ([menuItem isEqualToString:@"Setting"]){
        cell.imageView.image = [UIImage imageNamed:@"matome.png"];
    }*/
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //選択の解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *menuItem = self.menuItems[indexPath.row];
    
    if ([menuItem isEqualToString:@"新着"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTable"];
    }
    else if ([menuItem isEqualToString:@"週間ランキング"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeekNavigationController"];
    }
    else if ([menuItem isEqualToString:@"月間ランキング"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthNavigationController"];
    }
    else if ([menuItem isEqualToString:@"お気に入り"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthNavigationController"];
    }
    else if ([menuItem isEqualToString:@"ゲーム"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthNavigationController"];
    }
    else if ([menuItem isEqualToString:@"履歴"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryNavigationController"];
    }
    else if ([menuItem isEqualToString:@"おすすめアプリ"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthNavigationController"];
    }
    [self.slidingViewController resetTopViewAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


@end
