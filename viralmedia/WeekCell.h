//
//  WeekCell.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/12.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *view;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *site;
+ (CGFloat)rowHeight;
@end
