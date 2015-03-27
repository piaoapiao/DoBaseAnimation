//
//  BallScrollView.m
//  DoBaseAnimation
//
//  Created by guodong on 15/3/26.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "BallScrollView.h"

//界面的宽
#define kFBaseWidth [[UIScreen mainScreen]bounds].size.width
//界面的高
#define kFBaseHeight [[UIScreen mainScreen]bounds].size.height

@implementation BallScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)pointArray
{
    if(!_pointArray)
    {
        _pointArray = [[NSMutableArray alloc] init];
        [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height]];
        [_pointArray addObject:[PointObject createPointWithX:0.25*self.frame.size.width andY:self.frame.size.height*0.3 -self.ballView.frame.size.height/2.0]];
        [_pointArray addObject:[PointObject createPointWithX:0.5*self.frame.size.width andY:self.frame.size.height*0.8 -self.ballView.frame.size.height/2.0]];
        [_pointArray addObject:[PointObject createPointWithX:0.75*self.frame.size.width  andY:self.frame.size.height*0.6 -self.ballView.frame.size.height/2.0]];
        [_pointArray addObject:[PointObject createPointWithX:self.frame.size.width andY:self.frame.size.height ]];
        
        
        
        
//        -(NSMutableArray *)pointArray
//        {
//            if(!_pointArray)
//            {
//                _pointArray = [[NSMutableArray alloc] init];
//                [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height]];
//                [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height*0.8]];
//                [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height*0.3]];
//                [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height*0.6]];
//                [_pointArray addObject:[PointObject createPointWithX:0 andY:self.frame.size.height]];
//                
//                for(int i =0;i< _pointArray.count;i++)
//                {
//                    PointObject *point = [_pointArray objectAtIndex:i];
//                    point.x = (self.frame.size.width/(_pointArray.count -1))*i;
//                }
//                
//            }
//            return _pointArray;
//        }

        
//        [_pointArray addObject:[PointObject createPointWithX:40 andY:40]];
    }
    return _pointArray;
}


-(UIView *)ballView
{
    if(!_ballView)
    {  //self.frame.size.height - 3
        _ballView = [[UIView alloc] initWithFrame:CGRectMake(-15, self.frame.size.height - 15, 30, 30)];
      //  _ballView.backgroundColor = [UIColor greenColor];

        //_ballView.autoresizesSubviews = YES;
        [self addSubview:_ballView];
        
//        UIImageView *ballImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        //ballImageView.backgroundColor = [UIColor redColor];
//        //ballImageView.autoresizesSubviews = YES;
//        ballImageView.image = [UIImage imageNamed:@"111"];
//        [_ballView addSubview:ballImageView];
//
//        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 60, 25)];
//        sender.backgroundColor = [UIColor redColor];
//        [sender addTarget:self action:@selector(clickBall:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:sender];
        
        UIButton *ballBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [ballBtn addTarget:self action:@selector(clickBall:) forControlEvents:UIControlEventTouchUpInside];
        [ballBtn setImage:[UIImage imageNamed:@"111"]forState:UIControlStateNormal];
        [_ballView addSubview:ballBtn];
        
        UIButton *rollBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        rollBackBtn.backgroundColor = [UIColor redColor];
        [rollBackBtn addTarget:self action:@selector(rollBack:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rollBackBtn];
        
    }
    return _ballView;
}

-(void)rollBack:(UIButton *)sender
{
    [self backScroll];
    self.currStep = 0;
}

-(void)clickBall:(UIButton *)sender
{
    if(self.currStep == 0)
    {
        [self beginAppear];
    }
    else if (self.currStep == 1)
    {
        [self goonScroll];
    }
    else
    {
        [self backScroll];
    }
}

-(void)beginAppear
{
    NSArray *temp = [self.pointArray subarrayWithRange:NSMakeRange(0,floorf(self.pointArray.count/2)+1)];
    [self scrollPoints:temp];
     self.currStep = 1;
}

-(void)goonScroll
{
    NSArray *temp = [self.pointArray subarrayWithRange:NSMakeRange(floorf(self.pointArray.count/2),self.pointArray.count -floorf(self.pointArray.count/2))];
    [self scrollPoints:temp];
     self.currStep = 2;
}

-(void)backScroll
{
    NSArray *temp = [self.pointArray subarrayWithRange:NSMakeRange(0,floorf(self.pointArray.count/2)+1)];
    
    NSMutableArray *temp2 =[NSMutableArray array];
    
    for(int i = 0;i < temp.count;i++)
    {
        id pt = [temp objectAtIndex:i];
        [temp2 insertObject:pt atIndex:0];
    }
    
    [self scrollPoints:temp2];

}


-(void)scrollPoints:(NSArray *)ptArray
{
    self.scrollArray = ptArray;
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration= 2.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //animation.repeatCount=HUGE_VALF;// repeat forever
   // animation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    
    PointObject *point = [ptArray objectAtIndex:0];
    
    CGPathMoveToPoint(curvedPath, NULL,point.x ,  point.y );
    
    　　//增加4个二阶贝塞尔曲线
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 45 , self.frame.size.height - 120, 75, self.frame.size.height - 60);
//    
//    
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 105, self.frame.size.height - 80, 135, self.frame.size.height - 10);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 165, self.frame.size.height - 65, 195, self.frame.size.height - 100);
    

    
    for(int i = 1;i < ptArray.count;i= i+ 2)
    {
        PointObject *point1 = [ptArray objectAtIndex:i];
        PointObject *point2 = [ptArray objectAtIndex:i+1];
//        CGPathAddQuadCurveToPoint(curvedPath, NULL, point1.x -self.ballView.frame.size.width/2 , point1.y - self.ballView.frame.size.height/2,  point2.x - self.ballView.frame.size.width/2 , point2.y - self.ballView.frame.size.height/2);
        
        CGPathAddQuadCurveToPoint(curvedPath, NULL, point1.x , point1.y ,  point2.x, point2.y);
    }
    
//
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 225, self.frame.size.height - 70, 255, self.frame.size.height - 130);
    
    
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 290, self.frame.size.height - 65, 320, self.frame.size.height - 100);
    //    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    
    animation.path=curvedPath;
    animation.fillMode = kCAFillModeForwards;
    
    //[self.ballView.layer addAnimation:animation forKey:nil];
    
//    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, -1)]; //  基于Y轴和Z轴同时旋转
    
    
    
//    CABasicAnimation *transformAnimation=[CABasicAnimation animation];
//    transformAnimation.keyPath=@"transform";
//    //1.1设置动画执行时间
//    transformAnimation.duration=2.0;
//    //1.2修改属性，执行动画
//    transformAnimation.duration = 1;
//    //    transformAnimation.autoreverses = NO;
////    transformAnimation.repeatCount = HUGE_VALF;
//    
//    transformAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1)];
//    transformAnimation.removedOnCompletion=NO;
//    transformAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *transformAnimation = [self rotation:1 degree:M_PI direction:1 repeatCount:1];
    transformAnimation.repeatCount = HUGE_VALF;
    //CABasicAnimation *transformAnimation  = nil;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:animation,transformAnimation,nil];
    animGroup.duration = 2.0f;
    animGroup.removedOnCompletion = YES;
    //animation.calculationMode = kCAAnimationCubicPaced;
    transformAnimation.repeatCount = HUGE_VALF;
    animGroup.delegate = self;
    animGroup.fillMode = kCAFillModeForwards;
    
    
   // [self.ballView.layer addAnimation:animation forKey:nil];
     [self.ballView.layer addAnimation:animGroup forKey:nil];
    
//    //1.创建动画
//    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform"];
//    //1.1设置动画执行时间
//    anima.duration=1.0;
//    //1.2修改属性，执行动画
//    anima.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 , 0, 0, 1)];
//    
//    anima.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2*3 , 0, 0, 1)];
//    //1.3设置动画执行完毕后不删除动画
//    anima.removedOnCompletion=NO;
//    //1.4设置保存动画的最新状态
//    anima.fillMode=kCAFillModeForwards;
//
//    //2.添加动画到layer
//    [self.ballView.layer addAnimation:anima forKey:nil];
    
    
    
}

-(void)scrollBall
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration= 2.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //animation.repeatCount=HUGE_VALF;// repeat forever
    // animation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL,15, self.frame.size.height - 15);
    
    　　//增加4个二阶贝塞尔曲线
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 45 , self.frame.size.height - 120, 75, self.frame.size.height - 60);
    
    
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 105, self.frame.size.height - 80, 135, self.frame.size.height - 10);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 165, self.frame.size.height - 65, 195, self.frame.size.height - 100);
    //
    //    CGPathAddQuadCurveToPoint(curvedPath, NULL, 225, self.frame.size.height - 70, 255, self.frame.size.height - 130);
    
    
    //    CGPathAddQuadCurveToPoint(curvedPath, NULL, 290, self.frame.size.height - 65, 320, self.frame.size.height - 100);
    //    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    
    animation.path=curvedPath;
    animation.fillMode = kCAFillModeForwards;
    
    //[self.ballView.layer addAnimation:animation forKey:nil];
    
    //    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, -1)]; //  基于Y轴和Z轴同时旋转
    
    
    
    //    CABasicAnimation *transformAnimation=[CABasicAnimation animation];
    //    transformAnimation.keyPath=@"transform";
    //    //1.1设置动画执行时间
    //    transformAnimation.duration=2.0;
    //    //1.2修改属性，执行动画
    //    transformAnimation.duration = 1;
    //    //    transformAnimation.autoreverses = NO;
    ////    transformAnimation.repeatCount = HUGE_VALF;
    //
    //    transformAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1)];
    //    transformAnimation.removedOnCompletion=NO;
    //    transformAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *transformAnimation = [self rotation:1 degree:M_PI direction:1 repeatCount:1];
    transformAnimation.repeatCount = HUGE_VALF;
    //CABasicAnimation *transformAnimation  = nil;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:animation,transformAnimation,nil];
    animGroup.duration = 2.0f;
    animGroup.removedOnCompletion = NO;
    //animation.calculationMode = kCAAnimationCubicPaced;
    transformAnimation.repeatCount = HUGE_VALF;
    animGroup.delegate = self;
    animGroup.fillMode = kCAFillModeForwards;
    
    
    // [self.ballView.layer addAnimation:animation forKey:nil];
    [self.ballView.layer addAnimation:animGroup forKey:nil];
    
    //    //1.创建动画
    //    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform"];
    //    //1.1设置动画执行时间
    //    anima.duration=1.0;
    //    //1.2修改属性，执行动画
    //    anima.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 , 0, 0, 1)];
    //
    //    anima.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2*3 , 0, 0, 1)];
    //    //1.3设置动画执行完毕后不删除动画
    //    anima.removedOnCompletion=NO;
    //    //1.4设置保存动画的最新状态
    //    anima.fillMode=kCAFillModeForwards;
    //
    //    //2.添加动画到layer
    //    [self.ballView.layer addAnimation:anima forKey:nil];
    
    
    
}


- (void)animationDidStart:(CAAnimation *)anim
{
   // NSLog(@"did start:%@",NSStringFromCGPoint(self.greenView.center));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop finished :%d",flag);
    
    PointObject *lastPoint = [self.scrollArray lastObject];
    
    
    self.ballView.center = CGPointMake(lastPoint.x, lastPoint.y);
    
    
    if(self.currStep == 1)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        // 动画选项设定
        animation.duration = 1; // 动画持续时间
        //animation.repeatCount = 1; // 重复次数
        animation.removedOnCompletion=NO;
        animation.fillMode = kCAFillModeForwards;
        // animation.autoreverses = YES; // 动画结束时执行逆动画
        
        // 缩放倍数
        //    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
        animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
        
        // 添加动画
        [self.ballView.layer addAnimation:animation forKey:@"scale-layer"];
        
        
        if(_delegate && [_delegate respondsToSelector:@selector(ballPosition:)])
        {
            [_delegate ballPosition:CENTER];
        }
    }
    else
    {
        [self.ballView.layer removeAnimationForKey:@"scale-layer"];
        
        if(self.currStep == 0)
        {
            NSLog(@"roll Back");
            if(_delegate && [_delegate respondsToSelector:@selector(ballPosition:)])
            {
                [_delegate ballPosition:LEFT];
            }
        }
        else if (self.currStep == 2)
        {
            NSLog(@"go netx step");
            [_delegate ballPosition:RIGHT];
        }
    }

}

-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount //旋转
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(0, 0, 0,-1);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.fromValue= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(degree, 0, 0,-1)];
    
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

-(CABasicAnimation *)makeScaleAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 1; // 动画持续时间
    //animation.repeatCount = 1; // 重复次数
    animation.removedOnCompletion=NO;
    animation.fillMode = kCAFillModeForwards;
    // animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    //    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    
    // 添加动画
    //[self.ballView.layer addAnimation:animation forKey:@"scale-layer"];
    return animation;
}

@end
