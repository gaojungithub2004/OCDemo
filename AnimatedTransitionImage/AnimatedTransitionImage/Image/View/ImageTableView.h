//
//  ImageTableView.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagesModel;
@interface ImageTableView : UITableView

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, copy) void((^tapBlock)(ImagesModel *));

@end
