//
//  TransitionsController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "TransitionsController.h"
#import "TransitionDetailsController.h"

@interface TransitionsController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel  *tipsLabel;


@end

@implementation TransitionsController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"模态转场自定义动画";
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.tipsLabel];
}

- (void)backAction{

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter/Getter
- (UIButton *)backButton{

    if (!_backButton) {
        
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 60, kHeight - 60, 40, 40)];
        _backButton.layer.cornerRadius = 20;
        _backButton.backgroundColor = [UIColor orangeColor];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)tipsLabel{

    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight / 2 - 20, kWidth, 40)];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.text = @"点击背景空白区域切换控制器";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    TransitionDetailsController *vc = [[TransitionDetailsController alloc] init];
    vc.transitioningDelegate = self;
    // 设置模态跳转的代理方法
    vc.transitioningDelegate = self;
    // 设置需要手势的控制器
    [self.swipeInteraction wireToViewController:vc];
    [self showViewController:vc sender:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
