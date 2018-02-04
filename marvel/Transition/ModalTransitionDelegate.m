//
//  ModalTransitionDelegate.m
//  marvel
//
//  Created by lvwei on 03/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "ModalTransitionDelegate.h"
#import "OverlayAnimationController.h"

@implementation ModalTransition

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [OverlayAnimationController new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [OverlayAnimationController new];
}

@end
