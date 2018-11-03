//
//  PresentTransition.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "PresentTransition.h"
#import "ImageTableController.h"
#import "ImagesModel.h"
#import "ImageTableCell.h"

@implementation PresentTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ImageTableController *fromVC = (ImageTableController *)nav.viewControllers.lastObject;
    UIImageView *selectImageView = ([fromVC getSelctModel]).imageView;
    ImageTableCell *cell = (ImageTableCell *)([fromVC getSelctModel]).cell;
    CGRect rect = [cell.imageContentView convertRect: selectImageView.frame toView: transitionContext.containerView];
    
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    tempView.frame = rect;
    toVC.view.hidden = YES;
    [transitionContext.containerView addSubview:tempView];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    [transitionContext.containerView addSubview:toVC.view];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        tempView.frame = finalFrame;
        toVC.view.frame = finalFrame;
    } completion: ^(BOOL finished) {
        // 5. Tell context that we completed.
        toVC.view.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition: YES];
        
    }];
    
}

@end
