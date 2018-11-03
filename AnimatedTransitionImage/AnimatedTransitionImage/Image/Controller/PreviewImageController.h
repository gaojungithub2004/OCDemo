//
//  PreviewImageController.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/16.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "BaseViewController.h"


@class PreviewImageController, ImagesModel;
@protocol PreviewImageControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(PreviewImageController *)viewController;

@end

@interface PreviewImageController : BaseViewController

@property (nonatomic, strong) ImagesModel *model;

@property (nonatomic, weak) id<PreviewImageControllerDelegate> delegate;

- (void)subViewHidden:(BOOL)isHidden;

@end
