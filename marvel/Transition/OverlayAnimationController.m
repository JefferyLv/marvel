//
//  OverlayAnimationController.m
//  marvel
//
//  Created by lvwei on 03/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "OverlayAnimationController.h"

@implementation OverlayAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];

    CGFloat duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        CGFloat toViewWidth = containerView.frame.size.width;
        CGFloat toViewHeight = containerView.frame.size.height;
        
        toView.center = containerView.center;
        toView.frame = CGRectMake(toViewWidth / 2, 0, 1, toViewHeight);
        toView.alpha = 0;

        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             
            toView.frame = CGRectMake(0, 0, toViewWidth, toViewHeight);
            toView.alpha = 1;
                             
        } completion:^(BOOL finished) {
            
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
    }

    if (fromVC.isBeingDismissed) {
        CGFloat fromViewHeight = fromView.frame.size.height;
        CGFloat fromViewWidth = fromView.frame.size.width;
        [UIView animateWithDuration:duration animations:^{
                             
            fromView.frame = CGRectMake(fromViewWidth / 2, 0, 1, fromViewHeight);
            fromView.alpha = 0;
                             
        } completion:^(BOOL finished) {
            
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
    }
}

@end
