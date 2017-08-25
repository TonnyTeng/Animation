//
//  TransitionDetailsController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "TransitionDetailsController.h"

@interface TransitionDetailsController ()

@property (nonatomic, strong) UILabel  *tipsLabel;

@end

@implementation TransitionDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义转场动画";
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tipsLabel];
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight / 2 - 20, kWidth, 40)];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.text = @"点击背景区域返回";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
