//
//  AnimationHelper.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationHelper : NSObject

+ (CATransform3D)yRotation:(double)angle;

+ (void)perspectiveTransformForContainerView:(UIView *)containerView;

+ (UIImageView *)getImage:(UIView *)view;

@end
