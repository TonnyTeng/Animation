//
//  OfoView.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/6.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "OfoView.h"
#import "CoreMotionView.h"

@interface OfoView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *grassImageView;
//@property (nonatomic, strong) UIImageView *eyesImageView;
@property (nonatomic, strong) CoreMotionView *leftEyeView;
@property (nonatomic, strong) CoreMotionView *rightEyeView;


@property (nonatomic, strong) UIButton  *noticButton;
@property (nonatomic, strong) UIButton  *refreshButton;

@property (nonatomic, strong) UIButton  *userButton;
@property (nonatomic, strong) UIButton  *giftButton;


@property (nonatomic, assign) CGFloat   originY;
@property (nonatomic, assign) CGFloat   height;

@end

@implementation OfoView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        self.originY = self.frame.origin.y;
        self.height = self.frame.size.height;
        
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.grassImageView];
        
        [self.grassImageView addSubview:self.leftEyeView];
        [self.grassImageView addSubview:self.rightEyeView];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAnimation:)];
        [self addGestureRecognizer:pan];
        
        [self addSubview:self.noticButton];
        [self addSubview:self.refreshButton];
        
        [self addSubview:self.userButton];
        [self addSubview:self.giftButton];
        
    }
    return self;
}

//MARK - Action
- (void)noticAction{

    NSLog(@"noticAction");
    _BlcokType(@"noticAction");
}

- (void)refreshAction{

    NSLog(@"刷新");
    _BlcokType(@"refreshAction");
}

- (void)userAction{
    
    NSLog(@"userAction");
    _BlcokType(@"userAction");
}


- (void)giftAction{
    
    NSLog(@"giftAction");
    _BlcokType(@"giftAction");
}



- (void)panAnimation:(UIPanGestureRecognizer *)pan{

    // 获取手势移动的位置 self.view:规定区域
    CGPoint point = [pan translationInView:self];
    // 获取Y方向的偏移量
    CGFloat offsetY = point.y;
    if(offsetY > 0 && self.frame.origin.y == self.originY){//向下
    
        if (offsetY > self.height / 2) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = CGRectMake(0, self.originY + self.frame.size.height - 80, self.frame.size.width, self.height);
            }];
        }else{
        
            self.frame = CGRectMake(0, self.frame.origin.y + offsetY, self.frame.size.width, self.height);
        }
    }
    if (offsetY < 0 && self.frame.origin.y == self.originY + self.frame.size.height - 80) {//向上
       
       
        if (fabsf(offsetY) > self.height / 2) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = CGRectMake(0, self.originY, self.frame.size.width, self.height);
            }];
        }else{
            
            self.frame = CGRectMake(0, self.frame.origin.y + offsetY, self.frame.size.width, self.height);
        }
    }
    // 判断拖动结束的时候
    if (pan.state == UIGestureRecognizerStateEnded) {
      
        if (offsetY > 0) {//
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = CGRectMake(0, self.originY + self.frame.size.height - 80, self.frame.size.width, self.height);
            }];
        }else{

            if (self.frame.origin.y != self.originY) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.frame = CGRectMake(0, self.originY, self.frame.size.width, self.height);
                }];
            }
            self.userButton.frame = CGRectMake(10, self.height, 40, 40);
            self.giftButton.frame = CGRectMake(self.frame.size.width - 50, self.height, 40, 40);
           
            [UIView animateWithDuration:0.3 animations:^{
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.frame = CGRectMake(0, self.originY, self.frame.size.width, self.height);
                }];
            } completion:^(BOOL finished) {
               
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.userButton.frame = CGRectMake(10, self.height - 50, 40, 40);
                    self.giftButton.frame = CGRectMake(self.frame.size.width - 50, self.height - 50, 40, 40);
                }];
                
            }];
        }
        
    }
    
    NSLog(@"获取Y方向的偏移量%.2f",offsetY);
    
   
}

//MARK - Setter/Getter

- (UIButton *)noticButton{

    if (_noticButton == nil) {
        
        _noticButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, - 100, 40, 40)];
        _noticButton.layer.cornerRadius = _noticButton.frame.size.width / 2;
        _noticButton.backgroundColor = [UIColor redColor];
        [_noticButton addTarget:self action:@selector(noticAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noticButton;
}

- (UIButton *)refreshButton{

    if (_refreshButton == nil) {
        
        _refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, -50, 40, 40)];
        _refreshButton.layer.cornerRadius = _refreshButton.frame.size.width / 2;
        _refreshButton.backgroundColor = [UIColor grayColor];
        [_refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}


- (UIButton *)userButton{
    
    if (_userButton == nil) {
        
        _userButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.height - 50, 40, 40)];
        _userButton.layer.cornerRadius = _refreshButton.frame.size.width / 2;
        _userButton.backgroundColor = [UIColor greenColor];
        [_userButton addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userButton;
}


- (UIButton *)giftButton{
    
    if (_giftButton == nil) {
        
        _giftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, self.height - 50, 40, 40)];
        _giftButton.layer.cornerRadius = _refreshButton.frame.size.width / 2;
        _giftButton.backgroundColor = [UIColor purpleColor];
        [_giftButton addTarget:self action:@selector(giftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftButton;
}



- (UIImageView*)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 380 / 4, self.height / 2 - 380 / 4, 380 / 2, 380 / 2)];
        _backgroundImageView.image = [UIImage imageNamed:@"minions_background"];
    }
    return _backgroundImageView;
}

- (UIImageView*)grassImageView {
    if (!_grassImageView) {
        _grassImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 380 / 4, self.height / 2 - 380 / 4, 380 / 2, 380 / 2)];
        _grassImageView.image = [UIImage imageNamed:@"minions_grass"];
    }
    return _grassImageView;
}

//- (UIImageView*)eyesImageView {
//    if (!_eyesImageView) {
//        _eyesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 380 / 4, self.height / 2 - 380 / 4, 37 / 2, 39 / 2)];
//        _eyesImageView.image = [UIImage imageNamed:@"minions_eyes"];
//    }
//    return _eyesImageView;
//}

- (CoreMotionView*)leftEyeView {
    if (!_leftEyeView) {
        _leftEyeView = [[CoreMotionView alloc]initWithFrame:CGRectZero];
    }
    return _leftEyeView;
}

- (CoreMotionView*)rightEyeView {
    if (!_rightEyeView) {
        _rightEyeView = [[CoreMotionView alloc]initWithFrame:CGRectZero];
    }
    return _rightEyeView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backgroundImageView.frame = CGRectMake(self.frame.size.width / 2 - 380 / 4, self.height / 2 - 380 / 4 + 50, 380 / 2, 380 / 2);
    _grassImageView.frame = CGRectMake(self.frame.size.width / 2 - 380 / 4, self.height / 2 - 380 / 4 + 50, 380 / 2, 380 / 2);
    
    _leftEyeView.frame = CGRectMake(190 / 2 - 30, 190 / 2 - 20, 37 / 2, 39 / 2);
    _rightEyeView.frame = CGRectMake(190 / 2 + 30, 190 / 2 - 20, 37 / 2, 39 / 2);
}

//UIButton是UIView的子视图，但是UIButton超出了UIView的边界，导致超出的部分无法点击，应该怎么解决呢？需要在UIView中实现下面的方法：
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint refreshPoint = [self.refreshButton convertPoint:point fromView:self];
    if ([self.refreshButton pointInside:refreshPoint withEvent:event]) {
        
        return self.refreshButton;
    }
    
    CGPoint noticPoint = [self.noticButton convertPoint:point fromView:self];
    if ([self.noticButton pointInside:noticPoint withEvent:event]) {
        
        return self.noticButton;
    }
    return result;
}


- (void)drawRect:(CGRect)rect {
  
    UIBezierPath *cyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width) radius:self.frame.size.width startAngle:0 endAngle: - M_PI clockwise:NO];
    
     // 传的是正方形，因此就可以绘制出圆了
//      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.frame.size.width/2, 0, self.frame.size.width * 2, self.frame.size.width)];
      
      // 设置填充颜色
      UIColor *fillColor = [UIColor orangeColor];
      [fillColor set];
      [cyclePath fill];
      
      // 设置画笔颜色
//      UIColor *strokeColor = [UIColor blueColor];
//      [strokeColor set];
      
      // 根据我们设置的各个点连线
      [cyclePath stroke];
}


@end
