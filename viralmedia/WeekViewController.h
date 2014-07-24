//
//  WeekViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/12.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
//#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "AFNetworking.h"
#import "TOWebViewController.h"
#import "History.h"
#import "BDBSpinKitRefreshControl.h"
@interface WeekViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BDBSpinKitRefreshControlDelegate>
@property (weak, nonatomic) IBOutlet UITableView *WeekContent;
@property (nonatomic, strong) METransitions *transitions;

@end
