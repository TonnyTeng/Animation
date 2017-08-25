//
//  SwipeInteraction.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeInteraction : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign) BOOL interactionInProgress;

- (void)wireToViewController:(UIViewController *)viewController;

@end
