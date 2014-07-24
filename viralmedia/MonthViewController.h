//
//  MonthViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/11.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
//#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "AFNetworking.h"
#import "TOWebViewController.h"
#import "History.h"
#import "BDBSpinKitRefreshControl.h"
@interface MonthViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BDBSpinKitRefreshControlDelegate>
@property (strong, nonatomic) IBOutlet UITableView *MonthContent;
@property (nonatomic, strong) METransitions *transitions;
@end
