//
//  MessageButton.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/13.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "MessageButton.h"

@interface MessageButton()

@property (nonatomic, strong) UIView *smallCircle;
@property (nonatomic, strong) CAShapeLayer *shpeLayer;

@end

@implementation MessageButton


// MARK:- 形状图层的懒加载
- (CAShapeLayer *)shpeLayer {
    
    if (!_shpeLayer) {
        
        // 创建形状图层
        CAShapeLayer *shpeLayer = [CAShapeLayer layer];
        
        // 将形状图层插入到最底下
        [self.superview.layer insertSublayer:shpeLayer above:0];
        
        // 设置路径填充颜色
        shpeLayer.fillColor = [UIColor redColor].CGColor;
        
        _shpeLayer = shpeLayer;
    }
    
    return _shpeLayer;
}

// MARK:- 控件的初始化
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    /************************** 初始化按钮 **************************/
    
    // 初始化按钮
//    [self setup];
    
    /************************** 添加手势 **************************/
    
    // 添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];
}


// MARK:- 初始化控件
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化按钮
//        [self setup];
        
        /************************** 添加手势 **************************/
        
        // 添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan];
    }
    
    return self;
}

// MARK:-  初始化按钮(保证通过代码创建的tips按钮背景颜色、文字等和通过Main.storyboard创建的一样)
- (void)setup {
    
    // 设置按钮的圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    
    // 设置按钮背景颜色
    [self setBackgroundColor:[UIColor redColor]];
    
    // 设置按钮文字颜色
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitle:@"3" forState:UIControlStateNormal];
    // 设置按钮文字大小
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    
    // 创建小圆
    UIView *smallCircle = [[UIView alloc] initWithFrame:self.frame];  // 小圆的位置和尺寸与按钮一致
    
    // 设置小圆的背景颜色
    smallCircle.backgroundColor = [UIColor redColor];
    
    // 设置小圆的圆角
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    
    // 将smallCircle保存起来
    self.smallCircle = smallCircle;
    
    // 将小圆添加到控制器的view上(也就是按钮的父控件上)
    [self.superview addSubview:smallCircle];
    
    // 将小圆插入到按钮与控制器的view中间
    [self.superview insertSubview:smallCircle belowSubview:self];
}

// MARK:- 实现手势拖动的方法
- (void)panGesture:(UIPanGestureRecognizer *)pan {
    
    // 获取当前手势所在的点
    CGPoint currentPoint = [pan locationInView:self];
    
    // 让按钮根据手势移动做出平移(transform不会修改center的值，它修改的是frame的值)
    //    self.transform = CGAffineTransformTranslate(self.transform, currentPoint.x, currentPoint.y);
    CGPoint center = self.center;  // 取出按钮的center的值
    center.x += currentPoint.x;  // 修改center的x值
    center.y += currentPoint.y;  // 修改center的y值
    self.center = center;  // 将修改过后的center的值赋值回去
    
    // 复位操作
    [pan setTranslation:CGPointZero inView:self];
    
    /************************** 计算两个圆之间的距离 **************************/
    
    CGFloat distance = [self distanceBetweenSmallCircle:self.smallCircle andTipsButton:self];
    
    /************************** 让smallCircle的半径随着距离的增大而减小 **************************/
    
    // 取出小圆的半径
    //    CGFloat smallR = self.smallCircle.bounds.size.width * 0.5;
    CGFloat smallR = self.bounds.size.width * 0.5;
    
    // 让小圆的半径随着距离的增大而缩小
    smallR -= distance / 10.0;
    
    // 重新设置smallCircle的bounds
    self.smallCircle.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
    
    // 重新设置圆角半径
    self.smallCircle.layer.cornerRadius = smallR;
    
    /************************** 形状图层 **************************/
    
    // 获取path
    UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle andTipsButton:self];
    
    // 如果小圆没有被隐藏
    if (self.smallCircle.hidden == NO) {
        
        // 将已经描述好的路径传给CAShapeLayer对象的path属性
        self.shpeLayer.path = path.CGPath;
    }
    
    /************************** 当按钮与小圆之间的距离大于某个值时 **************************/
    
    // 当按钮与小圆之间的距离大于某个值时
    if (distance > 200) {
        
        // 隐藏小圆
        self.smallCircle.hidden = YES;
        
        // 删除形状图层
        [self.shpeLayer removeFromSuperlayer];
    }
    
    /************************** 当手指拖动结束时 **************************/
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        // 如果拖动的距离大于200
        if (distance < 200) {
            
            // 将形状图层从父控件中移除
            [self.shpeLayer removeFromSuperlayer];
            
            // 直接让按钮复位
            self.center = self.smallCircle.center;
            
            // 重新显示小圆
            self.smallCircle.hidden = NO;
            
        } else {
            
            // 创建UIImageView对象
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            
            // 用于存储播放动画的图片
            NSMutableArray *imageArr = [NSMutableArray array];
            
            for (int i = 0; i < 8; i++) {
                
                // 加载图片
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"boom_%d", i + 1]];
                
                // 将图片添加到数组中
                [imageArr addObject:image];
            }
            
            // 设置图片动画
            imageView.animationImages = imageArr;
            
            // 设置动画执行时间
            imageView.animationDuration = 1;
            
            // 开始播放动画
            [imageView startAnimating];
            
            // 将图片添加到按钮上
            [self addSubview:imageView];
            
            // 动画播放的时长是1秒，动画完毕以后直接从父控件中删除按钮
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 移除按钮
                [self removeFromSuperview];
                
            });
        }
    }

}

//去掉这个按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
    highlighted = NO;
}


// MARK:- 计算按钮和它底部小圆之间的距离
- (CGFloat)distanceBetweenSmallCircle:(UIView *)smallCircle andTipsButton:(UIButton *)tipsButton {
    
    // x轴方向上的偏移量
    CGFloat offsetX = tipsButton.center.x - smallCircle.center.x;
    
    // y轴方向上的偏移量
    CGFloat offsetY = tipsButton.center.y - smallCircle.center.y;
    
    // 两个圆形之间的距离
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

// MARK:- 描述两个圆之间的不规则路径
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle andTipsButton:(UIButton *)tipsButton {
    
    // 求点
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = tipsButton.center.x;
    CGFloat y2 = tipsButton.center.y;
    
    CGFloat d = [self distanceBetweenSmallCircle:smallCircle andTipsButton:tipsButton];
    
    if (d <= 0) {
        
        return nil;
        
    }
    
    CGFloat cosΘ = (y2 - y1) / d;
    CGFloat sinΘ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = tipsButton.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosΘ, y1 + r1 * sinΘ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosΘ, y1 - r1 * sinΘ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosΘ, y2 - r2 * sinΘ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosΘ, y2 + r2 * sinΘ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinΘ, pointA.y + d * 0.5 * cosΘ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinΘ, pointB.y + d * 0.5 * cosΘ);
    
    // 描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // AB
    [path moveToPoint:pointA];  // 设置A为起点
    [path addLineToPoint:pointB];  // 添加一根线到B点
    
    // BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];  // 添加一根曲线到C点，其中P点为控制点
    
    // CD
    [path addLineToPoint:pointD];  // 添加一根直线到D点
    
    // DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];  // 添加一根曲线到A点，其中O点为控制点
    
    // 返回路径
    return path;
}


@end
