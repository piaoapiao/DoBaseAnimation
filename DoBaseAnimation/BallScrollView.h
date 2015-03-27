//
//  BallScrollView.h
//  DoBaseAnimation
//
//  Created by guodong on 15/3/26.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointObject.h"

typedef enum {
    BegainAppear,
    CountinueScroll,
    BackScroll,
}ScrollWay;

@interface BallScrollView : UIView
@property (strong, nonatomic)  NSMutableArray *pointArray;
@property (assign,nonatomic) int originStep;
@property (assign,nonatomic) int destStep;
@property (assign,nonatomic) int currStep;
@property (nonatomic,strong) UIView *ballView;

@property (strong, nonatomic)  NSMutableArray *scrollArray;

@property (nonatomic,assign) ScrollWay way;
-(void)scrollBall;
-(void)appearBall;
-(void)beginAppear;
@end
