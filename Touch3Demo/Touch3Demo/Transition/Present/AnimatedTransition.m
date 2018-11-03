//
//  AnimatedTransition.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/20.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "AnimatedTransition.h"
#import "ImageResultViewController.h"

@implementation AnimatedTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext { 
    NSLog(@"123");
    //取出转场前后的视图控制器
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext { 
    return 0.5;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}

@end
