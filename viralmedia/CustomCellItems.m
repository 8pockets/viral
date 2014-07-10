//
//  CustomCellItems.m
//  viralmedia
//
//  Created by 8pockets on 2014/07/03.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "CustomCellItems.h"

@implementation CustomCellItems

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title_KEY"];
    [aCoder encodeObject:self.date forKey:@"date_KEY"];
    [aCoder encodeObject:self.view forKey:@"description_KEY"];
    [aCoder encodeObject:self.site forKey:@"image_KEY"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.title = [aDecoder decodeObjectForKey:@"title_KEY"];
        self.date = [aDecoder decodeObjectForKey:@"date_KEY"];
        self.view = [aDecoder decodeObjectForKey:@"description_KEY"];
        self.site = [aDecoder decodeObjectForKey:@"image_KEY"];
    }
    return self;
}

@end
