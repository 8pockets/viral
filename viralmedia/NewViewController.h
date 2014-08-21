//
//  NewViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/06/27.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CustomCellItems.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
#import "AFNetworking.h"
#import "TOWebViewController.h"
#import "History.h"
#import "BDBSpinKitRefreshControl.h"
#import "Appirater.h"

@interface NewViewController : UIViewController<ECSlidingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BDBSpinKitRefreshControlDelegate>

@property (strong, nonatomic) IBOutlet UITableView *NewContent;
@property (nonatomic, strong) METransitions *transitions;

@end
