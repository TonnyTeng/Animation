//
//  NSString+XT.h
//  AnimationDemo
//
//  Created by dengtao on 2017/9/11.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XT)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;
- (CGSize)getSpaceLabelHeightWithFont:(UIFont *)font withWidth:(CGFloat)width;

@end
