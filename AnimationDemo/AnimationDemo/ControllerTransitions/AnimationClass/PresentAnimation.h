//
//  PresentAnimation.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

/** 原始大小 */
@property(nonatomic,assign)CGRect originFrame;

@end
