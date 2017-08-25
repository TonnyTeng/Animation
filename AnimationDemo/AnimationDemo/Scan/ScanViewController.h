//
//  ScanViewController.h
//  AnimationDemo
//
//  Created by dengtao on 2017/7/18.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "XTViewController.h"

typedef enum : NSUInteger {
    ScanTypeBank,
    ScanTypeIDCard,
    ScanTypeOther
} ScanType;


@interface ScanViewController : XTViewController

@property (nonatomic, assign) ScanType scanType;
@property (nonatomic, strong) void (^GetPicture)(UIImage *image);


@end
