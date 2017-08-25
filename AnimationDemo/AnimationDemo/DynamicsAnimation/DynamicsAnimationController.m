//
//  DynamicsAnimationController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "DynamicsAnimationController.h"
#import "PullPictureController.h"
@interface DynamicsAnimationController ()

@property (nonatomic, strong) UIView *bordView;
@property (nonatomic, strong) UIView *aniamtionView;

@property (nonatomic, strong) UISlider *angleSlider;
@property (nonatomic, strong) UISlider *magnitudeSlider;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;

@end

@implementation DynamicsAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重播" style:UIBarButtonItemStylePlain target:self action:@selector(replay)];
    [self.view addSubview:self.bordView];
    
    switch (self.type) {
        case DynamicsGravity:
        {
            
            [self.view addSubview:self.angleSlider];
            [self.view addSubview:self.magnitudeSlider];
            
            [self dynamicsGravity];
        }
            break;
        case DynamicsCollision:{
        
            
        
        }
            break;
        
        case DynamicsScram:{
            
            
        }
            break;
        case DynamicsForce:{
            
            
        }
            break;
        case DynamicsCat:{
            
            
        }
            break;
        default:
            break;
    }
    
   
}




#pragma mark - Action
- (void)replay{

    _aniamtionView.frame = CGRectMake(10, 10, 100, 100);
    
    // create a new gravity behavior
    self.gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.aniamtionView]];
    self.gravityBeahvior.angle = _angleSlider.value * M_PI * 2;
    self.gravityBeahvior.magnitude = _magnitudeSlider.value * 10 + 1;
    
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:self.gravityBeahvior];
}

- (void)processControl:(UISlider *)slider{

    UILabel *tipsLabel;
    for (UILabel *label in self.view.subviews) {
        
        if (label.tag == slider.tag && [label isKindOfClass:[UILabel class]]) {
            
            tipsLabel = label;
            break;
        }
    }
    if (tipsLabel) {
        
        if (slider.tag == 100) {
            
            tipsLabel.text = [NSString stringWithFormat:@"角度:%.0f",slider.value];
            self.gravityBeahvior.angle = _angleSlider.value * M_PI * 2;
        }
        if (slider.tag == 101) {
            
            tipsLabel.text = [NSString stringWithFormat:@"重力:%.0f",slider.value];
            self.gravityBeahvior.magnitude = _magnitudeSlider.value * 10 + 1;
        }
    }
    
    
}
//重力演示
- (void)dynamicsGravity{
    
    [self.bordView addSubview:self.aniamtionView];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.bordView];
    self.gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.aniamtionView]];
    [self.animator addBehavior:self.gravityBeahvior];
    
}



#pragma mark - Setter/Getter
-(UIView *)bordView{

    if (!_bordView) {
        
        _bordView = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 10, kWidth - 20, kHeight - 64 - 20 - 100)];
        _bordView.layer.borderColor = [UIColor blueColor].CGColor;
        _bordView.layer.borderWidth = 1;
    }
    return _bordView;
}

- (UIView *)aniamtionView{

    if (!_aniamtionView) {
        
        _aniamtionView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
        _aniamtionView.backgroundColor = [UIColor lightGrayColor];
    }
    return _aniamtionView;
}

-(UISlider *)angleSlider{

    if (!_angleSlider) {
        
        _angleSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, kHeight - 80, kWidth - 110 , 10)];
        _angleSlider.tag = 100;
        [_angleSlider setMinimumValue:0.0];
        [_angleSlider setMaximumValue:360.0];
        [_angleSlider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
        
        
        UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _angleSlider.center.y - 10, 80, 20)];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.text = @"角度：0";
        tipsLabel.tag = 100;
        [self.view addSubview:tipsLabel];
    }
    return _angleSlider;
}

-(UISlider *)magnitudeSlider{
    
    if (!_magnitudeSlider) {
        
        _magnitudeSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, kHeight - 40, kWidth - 110 , 10)];
        _magnitudeSlider.tag = 101;
        [_magnitudeSlider setMinimumValue:0.0];
        [_magnitudeSlider setMaximumValue:100.0];
        [_magnitudeSlider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _magnitudeSlider.center.y - 10, 80, 20)];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.text = @"重力：9.8";
        tipsLabel.tag = 101;
        [self.view addSubview:tipsLabel];
    }
    return _magnitudeSlider;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
