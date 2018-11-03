//
//  ImagesModel.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/31.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagesModel : NSObject

@property (nonatomic, strong) NSArray *imageArray;

/**
 table indexPath.row 选中的cell
 */
@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, strong) UITableViewCell *cell;

/**
 选中的imageView, 选中的imageView的下标
 */
@property (nonatomic, assign) int selectRow;
@property (nonatomic, strong) UIImageView *imageView;


/**
 previewImageview 点击将要消失的imageView
 */
@property (nonatomic, strong) UIImageView *dismissImageView;
@end
