//
//  XTViewController.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PushAnimation.h"
#import "PopAnimation.h"

#import "PresentAnimation.h"
#import "DismissAnimation.h"

#import "SwipeInteraction.h"//左右滑动

#define kWidth      self.view.frame.size.width
#define kHeight     self.view.frame.size.height

@interface XTViewController : UIViewController<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) PopAnimation       *popAnimation;
@property(nonatomic, strong) PushAnimation      *pushAnimation;

@property(nonatomic, strong) PresentAnimation   *presentAnimation;
@property(nonatomic, strong) DismissAnimation   *dismissAnimation;

@property(nonatomic, strong) SwipeInteraction   *swipeInteraction;

@end
