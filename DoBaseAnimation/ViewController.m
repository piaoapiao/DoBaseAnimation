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
#import  "PointObject.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.greenView.layer.cornerRadius = 10;
//    [self doAnimation2];
    
//    [self.scrollView appearBall];
  
    
    [self.scrollView beginAppear];
    
   // [self.scrollView makeCustomerAnimition];
    
   // [self.scrollView drawBezierPoints:self.scrollView.pointArray];
    
    //[self.scrollView beginAppear];
    
   // [self.greenView.layer addAnimation:[self opacityForever_Animation:0.2] forKey:nil];
    
  //  [self.greenView.layer addAnimation:[self moveX:1 X:[NSNumber numberWithInt:50]] forKey:nil];
   // [self.greenView.layer addAnimation:[self moveY:1 Y:[NSNumber numberWithInt:50]] forKey:nil];
//    [self.greenView.layer addAnimation:[ViewController scale:[NSNumber numberWithInt:2.0] orgin:[NSNumber numberWithInt:0.3] durTimes:2 Rep:2] forKey:nil];
    
//    [self.greenView.layer addAnimation:[ViewController rotation:1 degree:M_PI
//                                                      direction:1 repeatCount:4] forKey:nil];

 
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


- (void) doAnimation2 {
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration= 1.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount=HUGE_VALF;// repeat forever
    animation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 0, 0);
    
    　　//增加4个二阶贝塞尔曲线
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 50, 180, 80, 250);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 120, 584, 180, 180);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 584, 712, 384);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    
    animation.path=curvedPath;
    
    [self.greenView.layer addAnimation:animation forKey:nil];
    
    
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"did start:%@",NSStringFromCGPoint(self.greenView.center));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop finished :%d",flag);
}

-(CABasicAnimation *)opacityForever_Animation:(float)time //永久闪烁的动画
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeRemoved;
    return animation;
}

-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x //横向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=x;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode = kCAFillModeForwards; //  kCAFillModeForwards kCAFillModeBackwards kCAFillModeBoth kCAFillModeRemoved
    return animation;
}

-(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=y;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes //缩放
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=orginMultiple;
    animation.toValue=Multiple;
    animation.duration=time;
    animation.autoreverses=YES;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes //组合动画
{
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes //路径动画
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    return animation;
}

+(CABasicAnimation *)movepoint:(CGPoint )point //点移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount //旋转
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= self;
    
    return animation;
}

@end
