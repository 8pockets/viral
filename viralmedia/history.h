//
//  History.h
//  viralmedia
//
//  Created by 8pockets on 2014/07/19.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSString * view;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * pageid;
@property (nonatomic, retain) NSDate * created_at;

@end
