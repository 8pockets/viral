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
    [aCoder encodeObject:self.pageid forKey:@"pageid_KEY"];
    [aCoder encodeObject:self.title forKey:@"title_KEY"];
    [aCoder encodeObject:self.date forKey:@"date_KEY"];
    [aCoder encodeObject:self.view forKey:@"view_KEY"];
    [aCoder encodeObject:self.site forKey:@"site_KEY"];
    [aCoder encodeObject:self.url forKey:@"url_KEY"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.pageid = [aDecoder decodeObjectForKey:@"pageid_KEY"];
        self.title = [aDecoder decodeObjectForKey:@"title_KEY"];
        self.date = [aDecoder decodeObjectForKey:@"date_KEY"];
        self.view = [aDecoder decodeObjectForKey:@"view_KEY"];
        self.site = [aDecoder decodeObjectForKey:@"site_KEY"];
        self.url = [aDecoder decodeObjectForKey:@"url_KEY"];
    }
    return self;
}

@end
