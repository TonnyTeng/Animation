//
//  LottieAnimationController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/11.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "LottieAnimationController.h"
#import "Lottie.h"


@interface LottieAnimationController ()

@end

@implementation LottieAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lottie动画";
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *jsonArray = @[@"servishero_loading",@"countdown",@"box_creeper",@"5_stars",@"lottie_gflux_logo",@"speaking"];
    
    int rowMax = 3;
    CGFloat viewWidth = (kWidth - 5)/2;
    NSInteger index = 0;
    for (int row = 0; row < rowMax; row ++) {
        
        CGFloat originY = 64 + (viewWidth + 5) * row;
        for (int colum = 0; colum < jsonArray.count / rowMax; colum ++) {
            
            CGFloat originX = (viewWidth + 5) * colum;
            
            NSString *animationNamed = jsonArray[index];
            
            LOTAnimationView *animationView;
//            if (index == 5) {
//
//                animationView = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.lottiefiles.com/storage/datafiles/WgRBwbT0n0IN0Uu/data.json"]];//从服务器下载动画JSON文件
//                
//                
//            }else{
//            
//                if (index == 4) {
//                    animationView = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.lottiefiles.com/storage/datafiles/7UVEwAYph5ig0OW/data.json"]];//从服务器下载动画JSON文件
//                }
                animationView = [LOTAnimationView animationNamed:animationNamed];
//            }
            animationView.frame = CGRectMake(originX, originY, viewWidth, viewWidth);
            animationView.contentMode = UIViewContentModeScaleAspectFill;
            
            if (colum == 0 && row == 0) {
                animationView.transform = CGAffineTransformMake(0, 0, 0, 0, 0.1, 0.1);
                [UIView animateWithDuration:3.0 delay:0.0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
                    
                    animationView.transform = CGAffineTransformIdentity;
                    
                } completion:nil];
            }
        
            animationView.loopAnimation = YES;  //循环播放
            animationView.animationSpeed = 0.5; //动画播放速度
            [animationView play];               //开始动画
            [self.view addSubview:animationView];
            
            index ++;
        }
        
    }
}


- (void)configAnimationViewUI{

    
    LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"servishero_loading"];//
//    animationView = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://github.com/airbnb/lottie-ios/raw/master/Example/Assets/PinJump.json"]];//从服务器下载动画JSON文件
    animationView.frame = CGRectMake(0, 64, kWidth, kWidth);
    animationView.contentMode = UIViewContentModeScaleAspectFill;
    animationView.transform = CGAffineTransformMake(0, 0, 0, 0, 0.1, 0.1);
    [UIView animateWithDuration:3.0 delay:0.0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{

        animationView.transform = CGAffineTransformIdentity;

    } completion:nil];

    animationView.loopAnimation = YES;  //循环播放
    animationView.animationSpeed = 0.5; //动画播放速度
    [animationView play];               //开始动画
    [self.view addSubview:animationView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
