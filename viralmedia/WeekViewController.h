//
//  WeekViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/12.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
//#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "AFNetworking.h"
@interface WeekViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *WeekContent;
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic,assign) BOOL isLoading;

@end
