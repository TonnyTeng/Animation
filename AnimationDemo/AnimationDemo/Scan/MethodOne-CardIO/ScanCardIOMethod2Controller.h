//
//  ScanCardIOMethod2Controller.h
//  AnimationDemo
//
//  Created by dengtao on 2017/8/17.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "XTViewController.h"

@class ScanCardIOMethod2Controller;
@protocol ScanCardVCDelegate <NSObject>

- (void)scanCardVC:(ScanCardIOMethod2Controller *)scanVC didScanSuceessBankInfo:(NSDictionary *)bankInfo;


@end



@interface ScanCardIOMethod2Controller : XTViewController

@property (nonatomic, weak) id<ScanCardVCDelegate>delegate;

@end
