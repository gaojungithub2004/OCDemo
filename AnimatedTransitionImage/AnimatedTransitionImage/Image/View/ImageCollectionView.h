//
//  ImageCollectionView.h
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/16.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionView : UICollectionView

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, copy) void (^tapBlock)(NSUInteger, UIImageView *);
@property (nonatomic, copy) void (^scrollBlock)(NSUInteger, UIImageView *);
@end
