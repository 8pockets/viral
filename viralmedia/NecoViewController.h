//
//  NecoViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/08/22.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NecoCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
#import "AFNetworking.h"
#import "TOWebViewController.h"
#import "History.h"
#import "BDBSpinKitRefreshControl.h"
@interface NecoViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BDBSpinKitRefreshControlDelegate>
@property (nonatomic, strong) METransitions *transitions;
@property (weak, nonatomic) IBOutlet UITableView *nekoTable;

@end
