//
//  RadarController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/22.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "RadarController.h"

@interface RadarController ()

@property (nonatomic, strong) UIImageView *downLayerImageView;
@property (nonatomic, strong) UIImageView *upLayerImageView;
@property (nonatomic, assign) CGFloat     diameter;//圆的直径
@property (nonatomic, strong) NSTimer     *timer;

@end

@implementation RadarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雷达动画";
    self.view.backgroundColor = [UIColor blackColor];
    self.diameter = kWidth - 120;
    [self.view addSubview:self.upLayerImageView];
    [self.view addSubview:self.downLayerImageView];
    [self startAnimation];
    
}
#pragma mark - Other

//波纹视图动画
- (void)waveViewAniamtion{
    
    UIView  *waveVview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.diameter, self.diameter)];
    waveVview.backgroundColor = [UIColor colorWithRed:190 green:230 blue:244 alpha:0.8];
    waveVview.layer.cornerRadius = self.diameter / 2;
    waveVview.layer.masksToBounds = YES;
    waveVview.center = CGPointMake(kWidth / 2, kHeight / 2 + 32);
    [self.view insertSubview:waveVview atIndex:0];
    
    [UIView animateWithDuration:4 animations:^{
        
        waveVview.transform = CGAffineTransformScale(waveVview.transform, 2, 2);
        waveVview.alpha = 0;
    } completion:^(BOOL finished) {
        [waveVview removeFromSuperview];
    }];
}

//旋转动画
- (void)startAnimation{
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waveViewAniamtion) userInfo:nil repeats:YES];
    }
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    [self.upLayerImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - Setter/Getter
- (UIImageView *)downLayerImageView{
    
    if (!_downLayerImageView) {
        
        _downLayerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.diameter, self.diameter)];
        _downLayerImageView.image = [UIImage imageNamed:@"gc_about_school"];
        _downLayerImageView.center = CGPointMake(kWidth / 2, kHeight / 2 + 32);
    }
    return _downLayerImageView;
}

- (UIImageView *)upLayerImageView{
    
    if (!_upLayerImageView) {
        
        _upLayerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.diameter, self.diameter)];
        _upLayerImageView.image = [UIImage imageNamed:@"gc_shape"];
        _upLayerImageView.center = CGPointMake(kWidth / 2, kHeight / 2 + 32);
    }
    return _upLayerImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end
