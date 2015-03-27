//
//  PointObject.h
//  DoBaseAnimation
//
//  Created by guodong on 15/3/26.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointObject : NSObject
@property (nonatomic,assign) float x;
@property (nonatomic,assign) float y;
-(id)initWithX:(float)x y:(float)y;
+(PointObject *)createPointWithX:(float)x andY:(float)y;
@end
