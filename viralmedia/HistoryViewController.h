//
//  HistoryViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/13.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
#import "TOWebViewController.h"
#import "History.h"
@interface HistoryViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *HistoryContent;
@property (nonatomic, strong) METransitions *transitions;

@end
