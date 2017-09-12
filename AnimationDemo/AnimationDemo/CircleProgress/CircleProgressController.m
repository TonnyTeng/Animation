//
//  CircleProgressController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "CircleProgressController.h"
#import "CircleProgressView.h"

@interface CircleProgressController ()

@property (nonatomic, strong) CircleProgressView    *progressView;

@end

@implementation CircleProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆形进度";
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.progressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   _progressView.progress = arc4random() % 100 / 100.0;
}


#pragma mark - Setter/Getter
- (CircleProgressView *)progressView{
    
    if (!_progressView) {
        
        _progressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(kWidth / 2 - 100,kHeight / 2 - 100,200,200) pathBackColor:[UIColor redColor] pathFillColor:[UIColor blueColor] startAngle:0 strokeWidth:10];
        _progressView.showPoint = YES;
        _progressView.animationModel = CircleIncreaseByProgress;
        _progressView.progress = arc4random() % 100 / 100.0;
        _progressView.pointImage = [UIImage imageNamed:@"test_point"];
    }
    return _progressView;
}

@end
