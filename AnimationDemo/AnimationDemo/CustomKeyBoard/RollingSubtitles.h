//
//  RollingSubtitles.h
//  字幕组
//
//  Created by Allen_12138 on 15-3-3.
//  Copyright (c) 2015年 mushroom_yan@foxmail.com-八爷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollingSubtitles : NSObject


/**
 *是否循环
 */
@property (nonatomic,assign) BOOL isScroll;

/**
 *滚动速度（0.001-x,默认0.05）
 */
@property (nonatomic,assign) float scrollSpeed;

/**
 *新文字出现的速度（0.1-x,默认1）
 */
@property (nonatomic,assign) float textSpeed;

/**
 *显示字幕的行数(0-9)
 */
@property (nonatomic,assign) int scrollHeightCount;

/**
 *字体颜色数组（UIColor）
 */
@property (nonatomic,strong) NSArray *aryColor;

/**
 *字体大小数组（1-20）
 */
@property (nonatomic,strong) NSArray *aryFont;

/**
 *字幕内容数组
 */
@property (nonatomic,strong) NSMutableArray *aryText;

/**
 *添加到的对象
 */
@property (nonatomic,strong) UIView *RootView;

/**
 *添加滚动字幕(这不是初始化方法)
 */
- (void)initAddRollingSubtitles;

@end
