//
//  ViewController.h
//  DoBaseAnimation
//
//  Created by guodong on 15/3/25.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BallScrollView.h"

@interface ViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UIView *greenView;


@property (strong, nonatomic) IBOutlet BallScrollView *scrollView;


@end

