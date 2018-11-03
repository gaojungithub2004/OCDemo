//
//  ImageTableController.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "BaseViewController.h"

@class ImagesModel;
@interface ImageTableController : BaseViewController


- (ImagesModel *)getSelctModel;
- (BOOL)interacting;
@end
