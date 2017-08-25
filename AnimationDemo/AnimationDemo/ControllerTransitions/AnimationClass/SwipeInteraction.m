//
//  SwipeInteraction.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "SwipeInteraction.h"

@interface SwipeInteraction ()

@property(nonatomic,assign) BOOL shouldCompleteTransition;

@property(nonatomic,strong) UIViewController *viewController;

@end

@implementation SwipeInteraction

- (void)wireToViewController:(UIViewController *)viewController {
    
    self.viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view {
    
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    edgePanGesture.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:edgePanGesture];
}


/**
 处理左划手势
 
 @param gestureRecognizer 手势
 */
- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    // 1
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGFloat progress = translation.x/200;
    progress = fminf(fmaxf(progress, 0), 1.0);
    // 2
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interactionInProgress = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            self.shouldCompleteTransition = progress > 0.5;
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
            self.interactionInProgress = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.interactionInProgress = NO;
            if (!self.shouldCompleteTransition) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
