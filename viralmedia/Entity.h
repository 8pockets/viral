//
//  Entity.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/18.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;
@end
