//
//  NSString+XT.m
//  AnimationDemo
//
//  Created by dengtao on 2017/9/11.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "NSString+XT.h"

@implementation NSString (XT)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width{
    
    return [self sizeWithFont:font
            constrainedToSize:CGSizeMake(width, 999999.0f)
                lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)getSpaceLabelHeightWithFont:(UIFont *)font withWidth:(CGFloat)width{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 999999.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height{
    return [self sizeWithFont:font
            constrainedToSize:CGSizeMake(999999.0f, height)
                lineBreakMode:NSLineBreakByWordWrapping];
}

@end
