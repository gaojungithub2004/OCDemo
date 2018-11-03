//
//  ImageTableCell.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagesModel;
@protocol ImageTableCellSelectDelegate <NSObject>

- (void)selectImageViewWithModel: (ImagesModel *)model;

@end

@interface ImageTableCell : UITableViewCell

@property (nonatomic, strong)ImagesModel *model;
@property (nonatomic, strong)NSMutableArray *imageViews;

@property (nonatomic, weak)id<ImageTableCellSelectDelegate> selectDelegate;

//@property (nonatomic, copy) void((^tapBlock)(ImagesModel *));
@property (nonatomic, strong) UIView *imageContentView;
@end
