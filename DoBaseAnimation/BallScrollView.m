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
        [_pointArray addObject:[PointObject createPointWithX:0.25*self.frame.size.width andY:self.frame.size.height*0.6]];
        [_pointArray addObject:[PointObject createPointWithX:0.5*self.frame.size.width andY:self.frame.size.height*0.3]];
        [_pointArray addObject:[PointObject createPointWithX:0.75*self.frame.size.width  andY:self.frame.size.height*0.4]];
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
        ballBtn.layer.cornerRadius = 15;
       // [ballBtn setImage:[UIImage imageNamed:@"111"]forState:UIControlStateNormal];
        ballBtn.backgroundColor = [UIColor blackColor];
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
    
   // return;
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
    

    
    for(int i = 1;i < ptArray.count -2;i= i+ 2)
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
   // animation.calculationMode= @"cubicPaced"; //iscrete', `linear',`paced', `cubic' and `cubicPaced'
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
    
    CABasicAnimation *transformAnimation = [self rotation:2 degree:M_PI direction:1 repeatCount:1];
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
    self.moveCurvedPath = curvedPath;
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
    [self setNeedsDisplay];

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

//-(void)drawRect:(CGRect)rect
//{
////    [super drawRect:rect];
//    
//    NSLog(@"drawRect:%@",NSStringFromCGRect(rect));
//    
////    CGContextRef currentContext = UIGraphicsGetCurrentContext();
////
////    CGContextAddPath(currentContext, self.moveCurvedPath);
////    [[UIColor purpleColor] setFill];
////    CGContextDrawPath(currentContext, kCGPathFill);
//    
////    [[UIColor brownColor] set];
////    CGContextRef currentContext = UIGraphicsGetCurrentContext();
////    CGContextSetLineWidth(currentContext, 5.0f);
////    CGContextMoveToPoint(currentContext, 50.0f, 10.0f);
////    CGContextAddLineToPoint(currentContext, 100.0f, 200.0f);
////    CGContextStrokePath(currentContext);
//    
////    CGContextDrawPath(currentContext, [self makePath:self.pointArray]);
//    
////     CGContextRef ctx = UIGraphicsGetCurrentContext(); // 获取绘图的CGContextRef
////    CGContextBeginPath(ctx); // 开始添加路径
////  //  CGContextAddLines(ctx , 5 , 50 , 100 , 30 ,80); // 添加5瓣花朵的路径
////    CGContextSetRGBFillColor(ctx,1, 0, 0, 1); // 设置填充颜色
////    CGContextFillPath(ctx);
////  //  CGContextAddFlower(ctx , 6 , 160 , 100 , 30, 80); // 添加6瓣花朵的路径
////    CGContextSetRGBFillColor(ctx,1, 1, 0, 1); // 设置填充颜色
////    CGContextFillPath(ctx);
////   // CGContextAddFlower(ctx , 7 , 270 , 100 , 30, 80); // 添加7瓣花朵的路径
////    CGContextSetRGBFillColor(ctx,1, 0, 1, 1); // 设置填充颜色
////    CGContextFillPath(ctx);
////    CGContextClosePath(ctx); // 关闭路径
//
//
//    
//}


//- (void)drawRect:(CGRect)rect
//{
//    //    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)];
//    //    
//    //    // Get the CGPathRef and create a mutable version.
//    //    CGPathRef cgPath = aPath.CGPath;
//    //    CGMutablePathRef  mutablePath = CGPathCreateMutableCopy(cgPath);
//    //    
//    //    // Modify the path and assign it back to the UIBezierPath object.
//    //    CGPathAddEllipseInRect(mutablePath, NULL, CGRectMake(50, 50, 200, 200));
//    //    aPath.CGPath = mutablePath;
//    //    
//    //    // Release both the mutable copy of the path.
//    //    CGPathRelease(mutablePath);
//
//      //  [self drawCircle];
//        
//    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, self.frame.size.width - 4 , self.frame.size.height - 4));
//    //    
//    //    CGContextSetLineWidth(ctx, 3);
//    //    
//    //    CGContextSetRGBStrokeColor(ctx, 228/255.0f, 232/255.0f, 235/255.0f, 1);
//    //    
//    //    CGContextStrokePath(ctx);
//    //    [super drawRect:rect];
//    //    if(self.currStep == 1)
//    //    {
//    //        [self drawBezier];
//    //    }
//        
//       // [self caculateMyBezier];
//        
//        
//    //    [self caculateMyBezier:self.percent];
//        [super drawRect:rect];
//        [self caculateMyBezier2];
//    //    [self caculateMyBezier3];
//
//}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    if(!_finished)
//    {
//        [self drawMyBezierPoints:self.drawIngArray];
//    }
//    
//}

-(void)makeCustomerAnimition
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshImage) userInfo:nil repeats:YES];
}

-(void)refreshImage
{
    self.percent = self.percent + 0.02;
    if(self.percent >= 1.0)
    {
        [self.timer invalidate];
        return;
    }
    
    
    [self setNeedsDisplay];
}

-(void)caculateMyBezier2
{

    self.fristPoint = CGPointMake(10,10);
    
        self.currentPoint1 = CGPointMake(100,70);
    self.currentPoint2 = CGPointMake(150,40);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, self.frame.size.width - 4 , self.frame.size.height - 4));
    
    CGContextSetLineWidth(context, 3);
    
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextSetRGBStrokeColor(context, 0/255.0f, 0/255.0f, 0/255.0f, 1);
    
    CGContextMoveToPoint(context, self.fristPoint.x, self.fristPoint.y);
    
    NSLog(@"self.percent:%f",self.percent);
    
    for (float ti= 0.0; ti<self.percent; ti+=0.001) {
        CGPoint quxianPoint;
        
//        quxianPoint.x = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.x + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.x + 3*ti*ti*(1-ti)*self.currentPoint2.x + ti*ti*ti*self.fristPoint.x;//三阶贝塞尔曲线计算方法
//        quxianPoint.y = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.y + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.y + 3*ti*ti*(1-ti)*self.currentPoint2.y + ti*ti*ti*self.lastPoint.y;
        
        quxianPoint.x = (1-ti)*(1-ti)*self.fristPoint.x + 2*ti*(1-ti)*self.currentPoint1.x+ ti*ti*self.currentPoint2.x;
        
        quxianPoint.y = (1-ti)*(1-ti)*self.fristPoint.y + 2*ti*(1-ti)*self.currentPoint1.y + ti*ti*self.currentPoint2.y;
        
        CGContextAddLineToPoint(context, quxianPoint.x, quxianPoint.y);
        
        self.ballView.center = quxianPoint;
    }
    
    
    CGContextStrokePath(context);
}


-(void)caculateMyBezier3
{
    
    self.fristPoint = CGPointMake(10,10);
    
    self.currentPoint1 = CGPointMake(100,70);
    self.currentPoint2 = CGPointMake(200,40);
    
    self.lastPoint = CGPointMake(300,150);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, self.frame.size.width - 4 , self.frame.size.height - 4));
    
    CGContextSetLineWidth(context, 3);
    
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextSetRGBStrokeColor(context, 0/255.0f, 0/255.0f, 0/255.0f, 1);
    
    CGContextMoveToPoint(context, self.fristPoint.x, self.fristPoint.y);
    
    NSLog(@"self.percent:%f",self.percent);
    
    for (float ti= 0.0; ti<self.percent; ti+=0.05) {
        CGPoint quxianPoint;
        
        quxianPoint.x = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.x + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.x + 3*ti*ti*(1-ti)*self.currentPoint2.x + ti*ti*ti*self.lastPoint.x;//三阶贝塞尔曲线计算方法
        quxianPoint.y = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.y + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.y + 3*ti*ti*(1-ti)*self.currentPoint2.y + ti*ti*ti*self.lastPoint.y;
        
//        quxianPoint.x = (1-ti)*(1-ti)*self.fristPoint.x + 2*ti*(1-ti)*self.currentPoint1.x+ ti*ti*self.currentPoint2.x;
//        
//        quxianPoint.y = (1-ti)*(1-ti)*self.fristPoint.y + 2*ti*(1-ti)*self.currentPoint1.y + ti*ti*self.currentPoint2.y;
        
        CGContextAddLineToPoint(context, quxianPoint.x, quxianPoint.y);
        
        self.ballView.center = quxianPoint;
    }
    
    CGContextStrokePath(context);
}



- (void)drawBezier{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, self.frame.size.width - 4 , self.frame.size.height - 4));
    
    CGContextSetLineWidth(ctx, 3);
    
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(ctx, 0, lengths,2);
    
    CGContextSetRGBStrokeColor(ctx, 0/255.0f, 0/255.0f, 0/255.0f, 1);
    
    CGContextAddPath(ctx, [self makePath:self.pointArray]);
    
    CGContextStrokePath(ctx);
    
}


-(CGMutablePathRef)makePath:(NSArray *)ptArray
{
    
    // return;
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
    return curvedPath;
}


//-(NSMutableArray *)caculateBezerLinePoint:(NSMutableArray *)array
//{
////    for()
//    //return ;
//    
//}





-(NSMutableArray *)caculate3PointBezerLine:(NSMutableArray *)threePointArray
{
    NSMutableArray *temp  = [NSMutableArray array];
    
    PointObject *beginPt = [temp objectAtIndex:0];
    
    PointObject *controlPt = [temp objectAtIndex:1];
    
    PointObject *endPointPt = [temp objectAtIndex:2];
    

    
    for (float ti= 0.0; ti < 1; ti+=0.05)
    {
        PointObject *linePt = [[PointObject alloc] init];
    
        linePt.x = (1-ti)*(1-ti)*beginPt.x + 2*ti*(1-ti)*controlPt.x+ ti*ti*endPointPt.x;
    
        linePt.y = (1-ti)*(1-ti)*self.fristPoint.y + 2*ti*(1-ti)*controlPt.y + ti*ti*endPointPt.y;
        [temp addObject:linePt];
    }
    return temp;
}


-(NSMutableArray *)caculateAllPointBezerLine:(NSMutableArray *)pointArray
{
    if(pointArray.count <3 || (pointArray.count%2 ==0))
    {
        return nil;
    }
    
    
    NSMutableArray *linePtArray = [NSMutableArray array];
    
    for(int  i = 0;i < pointArray.count -2;i = i + 2)
    {
        PointObject *beginPt = [pointArray objectAtIndex:i];
        
        PointObject *controlPt = [pointArray objectAtIndex:i+1];
        
        PointObject *endPointPt = [pointArray objectAtIndex:i+2];
        
        for (float ti= 0.0; ti < 1; ti+=0.05)
        {
            PointObject *linePt = [[PointObject alloc] init];
            
            linePt.x = (1-ti)*(1-ti)*beginPt.x + 2*ti*(1-ti)*controlPt.x+ ti*ti*endPointPt.x;
            
            linePt.y = 300 -(1-ti)*(1-ti)*self.fristPoint.y + 2*ti*(1-ti)*controlPt.y + ti*ti*endPointPt.y;
            
            NSLog(@"x:%f y:%f",linePt.x ,linePt.y);
            [linePtArray addObject:linePt];
        }
    }
    return linePtArray;
}


-(void)drawMyBezierPoints:(NSMutableArray *)pointArray
{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, self.frame.size.width - 4 , self.frame.size.height - 4));
    
    CGContextSetLineWidth(context, 3);
    
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextSetRGBStrokeColor(context, 0/255.0f, 0/255.0f, 0/255.0f, 1);
    
    CGContextMoveToPoint(context, self.fristPoint.x, self.fristPoint.y);
    
    NSLog(@"self.percent:%f",self.percent);
    
    if(pointArray.count >= 1)
    {
    for (PointObject *point in  pointArray) {

        
        CGContextAddLineToPoint(context, point.x, point.y);
    
    }
    }
    
    
    CGContextStrokePath(context);
}


-(void)drawBezierPoints:(NSMutableArray *)pointArray
{
    self.finished = NO;
    self.allFrameArray = [self caculateAllPointBezerLine:pointArray];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(drawOneFrameBezier) userInfo:nil repeats:YES];
    
}


-(void)drawOneFrameBezier
{
    if(_frameNum == self.allFrameArray.count)
    {
        _frameNum = 0;
        self.finished = YES;
        [self.timer invalidate];
        
        return;
    }
    self.drawIngArray =  [self.allFrameArray subarrayWithRange:NSMakeRange(0, _frameNum)];
    [self setNeedsDisplay];
    _frameNum++;

}


@end
