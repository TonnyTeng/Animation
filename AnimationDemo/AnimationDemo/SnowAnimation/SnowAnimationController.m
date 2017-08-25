//
//  SnowAnimationController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "SnowAnimationController.h"
#import "SnowView.h"

@interface SnowAnimationController ()

@end

@implementation SnowAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雪花动画";
    // 设置系统屏幕亮度
    [UIScreen mainScreen].brightness = 0.5;
    
    SnowView *snowView = [[SnowView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) withBackgroundImageName:@"snow_background.jpg" withSnowImgName:@"snow"];
    [snowView beginSnow];
    [self.view addSubview:snowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
