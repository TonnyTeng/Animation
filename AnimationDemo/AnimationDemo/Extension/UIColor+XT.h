//
//  UIColor+XT.h
//  AnimationDemo
//
//  Created by dengtao on 2017/9/11.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XT)

+ (UIColor *)fromHexValue:(NSUInteger)hex;
+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;
+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorHexString:(NSString *)hex;

@end
