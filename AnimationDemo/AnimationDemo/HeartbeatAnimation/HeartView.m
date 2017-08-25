//
//  HeartView.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/22.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "HeartView.h"

@interface HeartView()

@property (nonatomic, strong) UIView    *demoView;
@property (nonatomic, strong) UIBezierPath *path;


@end

@implementation HeartView

- (UIView *)demoView{
    
    if (!_demoView) {
        
        _demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _demoView.backgroundColor = [UIColor redColor];
        _demoView.layer.cornerRadius = 10;
    }
    return _demoView;
}

- (void)startAnimation{
    
    if (self.type == 0) {
        
        // 给心视图添加心跳动画
        float bigSize = 1.1;
        CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        pulseAnimation.duration = 0.5;
        pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
        pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        // 倒转动画
        pulseAnimation.autoreverses = YES;
        // 设置重复次数为无限大
        pulseAnimation.repeatCount = FLT_MAX;
        // 添加动画到layer
        [self.layer addAnimation:pulseAnimation forKey:@"transform.scale"];
    }
    else if (self.type == 1){
        
        [self addSubview:self.demoView];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        // 设置动画的路径为心形路径
        animation.path = self.path.CGPath;
        animation.calculationMode = kCAAnimationPaced;//动画无卡顿
        // 动画时间间隔
        animation.duration = 3.0f;
        // 重复次数为最大值
        animation.repeatCount = FLT_MAX;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        // 将动画添加到动画视图上
        [_demoView.layer addAnimation:animation forKey:nil];
    }
}

- (void)drawRect:(CGRect)rect {
    
    if (self.type == 0) {
        
        // 间距
        CGFloat padding = 4.0;
        // 半径(小圆半径)
        CGFloat curveRadius = (rect.size.width - 2 * padding)/4.0;
        // 贝塞尔曲线
        UIBezierPath *heartPath = [UIBezierPath bezierPath];
        // 起点(圆的第一个点)
        CGPoint tipLocation = CGPointMake(rect.size.width/2, rect.size.height-padding);
        // 从起点开始画
        [heartPath moveToPoint:tipLocation];
        // (左圆的第二个点)
        CGPoint topLeftCurveStart = CGPointMake(padding, rect.size.height/2.4);
        // 添加二次曲线
        [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
        // 画左圆
        [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x+curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];//圆心  半径 顺时针
        
        // (左圆的第二个点)
        CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
        // 画右圆
        [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x+curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];//圆心  半径 顺时针
        // 右上角控制点
        CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
        // 添加二次曲线
        [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y+curveRadius)];
        // 设置填充色
        [[UIColor redColor] setFill];
        // 填充
        [heartPath fill];
        // 设置边线
        heartPath.lineWidth = 2;
        heartPath.lineCapStyle  = kCGLineCapRound;
        heartPath.lineJoinStyle = kCGLineJoinRound;
        // 设置描边色
        [[UIColor yellowColor] setStroke];
        [heartPath stroke];
        
    }else{
    
        BOOL isHeart = arc4random() % 2;
        if (isHeart) {//是否为标准心形轨迹
            
            // 间距
            CGFloat padding = 4.0;
            // 半径(小圆半径)
            CGFloat curveRadius = (rect.size.width - 2 * padding)/4.0;
            // 贝塞尔曲线
            UIBezierPath *heartPath = [UIBezierPath bezierPath];
            // 起点(圆的第一个点)
            CGPoint tipLocation = CGPointMake(rect.size.width/2, rect.size.height-padding);
            // 从起点开始画
            [heartPath moveToPoint:tipLocation];
            // (左圆的第二个点)
            CGPoint topLeftCurveStart = CGPointMake(padding, rect.size.height/2.4);
            // 添加二次曲线
            [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
            // 画左圆
            [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x+curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];//圆心  半径 顺时针
            
            // (左圆的第二个点)
            CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
            // 画右圆
            [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x+curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];//圆心  半径 顺时针
            // 右上角控制点
            CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
            // 添加二次曲线
            [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y+curveRadius)];
            // 设置填充色
            [[UIColor clearColor] setFill];
            // 填充
            [heartPath fill];
            // 设置边线
            heartPath.lineWidth = 2;
            heartPath.lineCapStyle  = kCGLineCapRound;
            heartPath.lineJoinStyle = kCGLineJoinRound;
            // 设置描边色
            [[UIColor redColor] setStroke];
            [heartPath stroke];
            
            self.path = heartPath;
        }else{
        
            // Drawing code
            // 初始化UIBezierPath
            UIBezierPath *path = [UIBezierPath bezierPath];
            // 首先设置一个起始点
            CGPoint startPoint = CGPointMake(rect.size.width/2, 120);
            // 以起始点为路径的起点
            [path moveToPoint:startPoint];
            // 设置一个终点
            CGPoint endPoint = CGPointMake(rect.size.width/2, rect.size.height-40);
            // 设置第一个控制点
            CGPoint controlPoint1 = CGPointMake(100, 20);
            // 设置第二个控制点
            CGPoint controlPoint2 = CGPointMake(0, 180);
            // 添加三次贝塞尔曲线
            [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
            // 设置另一个起始点
            [path moveToPoint:endPoint];
            // 设置第三个控制点
            CGPoint controlPoint3 = CGPointMake(rect.size.width-100, 20);
            // 设置第四个控制点
            CGPoint controlPoint4 = CGPointMake(rect.size.width, 180);
            // 添加三次贝塞尔曲线
            [path addCurveToPoint:startPoint controlPoint1:controlPoint4 controlPoint2:controlPoint3];
            // 设置线宽
            path.lineWidth = 3;
            // 设置线断面类型
            path.lineCapStyle = kCGLineCapRound;
            // 设置连接类型
            path.lineJoinStyle = kCGLineJoinRound;
            // 设置画笔颜色
            [[UIColor redColor] set];
            [path stroke];
            
            self.path = path;
        }
        
        
    }
}
- (void)setType:(NSInteger)type{
    
    _type = type;
    [self setNeedsDisplay];
}

- (void)setPath:(UIBezierPath *)path{

    _path = path;
    [self startAnimation];
}



@end
