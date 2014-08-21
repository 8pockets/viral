//
//  MenuViewController.h
//  viralmedia
//
//  Created by 8pockets on 2014/06/27.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameFeatKit/GFController.h>
#import <GameFeatKit/GFView.h>
#import <GameFeatKit/GFController.h>
#import "UIViewController+ECSlidingViewController.h"
#import "appCCloud.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIApplicationDelegate,GFViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menutable;

//クラスメソッド
+(void)onClickBtn;
@end
