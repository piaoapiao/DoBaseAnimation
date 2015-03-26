//
//  ViewController.m
//  DoBaseAnimation
//
//  Created by guodong on 15/3/25.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CATransaction.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doAnimation];
    
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doAnimation {
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration= 15.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount=HUGE_VALF;// repeat forever
    animation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 20, 20);
    
    　　//增加4个二阶贝塞尔曲线
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 312, 184, 60, 200);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 584, 512, 584);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 584, 712, 384);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    
    animation.path=curvedPath;

    
//    [self.greenView.layer addAnimation:animation forKey:nil];
    

     CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
     opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
     opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
     opacityAnim.removedOnCompletion = NO;
    opacityAnim.repeatCount = HUGE_VALF;

    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)]; //  基于Y轴和Z轴同时旋转
    transformAnimation.duration = 5;
//    transformAnimation.autoreverses = NO;
    transformAnimation.repeatCount = HUGE_VALF;
    
    
//    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
//    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
//    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
//    opacityAnim.removedOnCompletion = NO;
    
    
//    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    
    
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setDuration:1.0];
    [transitionAnimation setFillMode:kCAFillModeForwards];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [transitionAnimation setType:@"rippleEffect"];// rippleEffect
    [transitionAnimation setSubtype:kCATransitionFromTop];
   // [_imgPic.layer addAnimation:animation forKey:nil];

    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:animation,opacityAnim,transformAnimation,transitionAnimation, nil];
    animGroup.duration = 5;
    animGroup.removedOnCompletion = NO;
    
//    transformAnimation.repeatCount = HUGE_VALF;
    transformAnimation.repeatCount = HUGE_VALF;
    
    [self.greenView.layer addAnimation:animGroup forKey:nil];
    

    
    
//    CGPoint fromPoint = self.greenView.center;
//    
//    //路径曲线
//    UIBezierPath *movePath = [UIBezierPath bezierPath];
//    [movePath moveToPoint:fromPoint];
//    CGPoint toPoint = CGPointMake(300, 460);
//    [movePath addQuadCurveToPoint:toPoint
//                     controlPoint:CGPointMake(280,0)];
//    //关键帧
//    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    moveAnim.path = movePath.CGPath;
//    moveAnim.removedOnCompletion = NO;
//    moveAnim.delegate = self;
//    [self.greenView.layer addAnimation:moveAnim forKey:nil];
//
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"did start:%@",NSStringFromCGPoint(self.greenView.center));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop finished :%d",flag);
}

@end
