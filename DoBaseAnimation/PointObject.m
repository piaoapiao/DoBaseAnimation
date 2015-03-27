//
//  PointObject.m
//  DoBaseAnimation
//
//  Created by guodong on 15/3/26.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "PointObject.h"

@implementation PointObject

-(id)initWithX:(float)x y:(float)y
{
    self = [super init];
    if(self)
    {
        self.x = x;
        self.y = y;
    }
    return self;
}

+(PointObject *)createPointWithX:(float)x andY:(float)y
{
    PointObject *temp  = [[PointObject alloc] init];
    if(temp)
    {
        temp.x = x;
        temp.y = y;
    }
    return temp;
}
@end
