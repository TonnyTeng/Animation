//
//  SnowView.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowView : UIView

- (instancetype)initWithFrame:(CGRect)frame withBackgroundImageName:(NSString *)bgImageName withSnowImgName:(NSString *)snowImgName;

- (void)beginSnow;

@end
