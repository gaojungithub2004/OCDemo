//
//  DidmissTransition.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "DidmissTransition.h"
#import "ImageTableController.h"
#import "ImagesModel.h"
#import "ImageTableCell.h"
#import "UIView+category.h"
#import "PreviewImageController.h"

@implementation DidmissTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    PreviewImageController *fromVC = (PreviewImageController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ImageTableController *toVC = (ImageTableController *)nav.viewControllers.lastObject;
    ImagesModel *model = [toVC getSelctModel];
    ImageTableCell *cell = (ImageTableCell *)model.cell;
    UIImageView *selectImageView = (UIImageView *)cell.imageViews[model.selectRow];
    
    CGRect finalRect = [cell.imageContentView convertRect: selectImageView.frame toView: transitionContext.containerView];
    CGRect beginRect = CGRectMake(0, (transitionContext.containerView.height - model.dismissImageView.height)/2, transitionContext.containerView.width, model.dismissImageView.height);
    UIView *tempView = [model.dismissImageView snapshotViewAfterScreenUpdates:YES];
    tempView.frame = beginRect;
    [fromVC.view addSubview: tempView];
    [fromVC subViewHidden: YES];
//    fromVC.view.hidden = YES;
//    [transitionContext.containerView addSubview:tempView];
    [transitionContext.containerView addSubview: nav.view];
    [transitionContext.containerView sendSubviewToBack: nav.view];
//    if ([toVC interacting]) {
//
//    }else{
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        tempView.frame = finalRect;
            tempView.frame = finalRect;
            fromVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        } completion: ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [fromVC subViewHidden: NO];
            }else{
                fromVC.view.alpha = 0;
                [fromVC.view removeFromSuperview];
            }
            // 5. Tell context that we completed.
            [tempView removeFromSuperview];
        }];
//    }
}

@end
