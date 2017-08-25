//
//  XTViewController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "XTViewController.h"


@interface XTViewController ()

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //去掉导航栏系统返回按钮的文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -200)
//                                                         forBarMetrics:UIBarMetricsDefault];
    //去掉返回按钮上的文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -200)
//                                                         forBarMetrics:UIBarMetricsDefault];
//        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:0.1], NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
   
    self.navigationController.delegate = self;
    
    if (!self.popAnimation) {
        
        self.popAnimation = [PopAnimation new];
    }
    if (!self.pushAnimation) {
        
        self.pushAnimation = [PushAnimation new];
    }
    
    if (!self.presentAnimation) {
        
        self.presentAnimation = [PresentAnimation new];
    }
    if (!self.dismissAnimation) {
        
        self.dismissAnimation = [DismissAnimation new];
    }
    
    if (!self.swipeInteraction) {
        
        self.swipeInteraction = [SwipeInteraction new];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        
        self.navigationController.delegate = nil;
    }

}

#pragma mask UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return self.popAnimation;
    }
    if (operation == UINavigationControllerOperationPush) {
        
        return self.pushAnimation;
    }
    return nil;
}

#pragma mark UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {
    
    self.presentAnimation.originFrame = self.view.frame;
    
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.dismissAnimation.destinationFrame = self.view.frame;
    
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return self.swipeInteraction.interactionInProgress ? self.swipeInteraction : nil;
}


@end
