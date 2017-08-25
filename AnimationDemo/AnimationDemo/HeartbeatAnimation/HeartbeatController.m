//
//  HeartbeatController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/22.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "HeartbeatController.h"
#import "HeartView.h"


@interface HeartbeatController ()

@property (nonatomic, strong) HeartView *heartView;


@end

@implementation HeartbeatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    if (self.type == 0) {
        
        self.title = @"心跳💗";
        [self.view addSubview:self.heartView];
        
    }else
    if (self.type == 1) {
        
        self.title = @"心跳💗轨迹";
        [self.view addSubview:self.heartView];
        
    }
    [self.heartView startAnimation];
}

#pragma mark - Setter/Getter
- (HeartView *)heartView{

    if (!_heartView) {
        
        _heartView = [[HeartView alloc] initWithFrame:CGRectMake(30, (kHeight - 64 - kWidth) / 2, kWidth - 60, kWidth - 60)];
        _heartView.type = self.type;
    }
    return _heartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
