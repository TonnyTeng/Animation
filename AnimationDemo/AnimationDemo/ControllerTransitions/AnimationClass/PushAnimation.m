//
//  PushAnimation.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "PushAnimation.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIViewControllerTransitionCoordinator.h>

@implementation PushAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished){
        
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    //    toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //
    //    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    //
    //        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    //
    //        toViewController.view.alpha = 1.0f;
    //
    //        fromViewController.view.alpha = 0.0f;
    //
    //    } completion:^(BOOL finished) {
    //
    //        fromViewController.view.transform = CGAffineTransformIdentity;
    //
    //        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    //
    //    }];
    
    
    //    [UIView animateWithDuration:0.3*[self transitionDuration:transitionContext]  animations:^{
    //
    //        fromViewController.view.transform = CGAffineTransformMakeScale(0.7, 0.7);
    //        toViewController.view.alpha = 0.3;
    //    } completion:^(BOOL finished) {
    //
    //        [UIView animateWithDuration:0.3*[self transitionDuration:transitionContext]  animations:^{
    //
    //            fromViewController.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    //            toViewController.view.alpha = 0.6;
    //
    //        } completion:^(BOOL finished){
    //
    //            [UIView animateWithDuration:0.4*[self transitionDuration:transitionContext] animations:^{
    //
    //                fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    //                toViewController.view.alpha = 1.0;
    //            } completion:^(BOOL finished){
    //
    //                fromViewController.view.transform = CGAffineTransformIdentity;
    //                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    //            }];
    //        }];
    //    }];
}


@end
