//
//  PreviewImageController.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/16.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "PreviewImageController.h"
#import "ImageCollectionView.h"
#import "UIView+category.h"
#import "UIButton+action.h"
#import "ImagesModel.h"
#import "marco.h"
#import "ImageCell.h"

#define deleteImage @"delete.png"
@interface PreviewImageController ()
{
    BOOL initFlag;
}
@property (nonatomic, strong) ImageCollectionView *collectionView;
@property (nonatomic, assign) BOOL hidenStatusBar;


@end

@implementation PreviewImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.hidenStatusBar = NO;
    self.modalTransitionStyle = UIModalPresentationCustom;
    [self.view addSubview: self.collectionView];
    __weak __typeof(self)weakSelf = self;
    self.collectionView.imagesArray = [NSMutableArray arrayWithArray: self.model.imageArray];
    
    //cell点击回调
    self.collectionView.tapBlock = ^(NSUInteger index, UIImageView *imageView) {
        weakSelf.model.selectRow = (integer_t)index;
        weakSelf.model.dismissImageView = imageView;
        if (weakSelf.delegate && [weakSelf.delegate performSelector:@selector(modalViewControllerDidClickedDismissButton:) withObject: weakSelf]) {
            [weakSelf.delegate modalViewControllerDidClickedDismissButton: weakSelf];
        }
    };
    
    self.collectionView.scrollBlock = ^(NSUInteger index, UIImageView *imageView) {
        weakSelf.model.selectRow = (integer_t)index;
        weakSelf.model.dismissImageView = imageView;
    };
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.hidenStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    UIImageView * imageView = ((ImageCell *)[self.collectionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow: self.model.selectRow inSection:0]]).previewImageView;
    self.model.dismissImageView = imageView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(!initFlag){
        [self.collectionView setContentOffset: CGPointMake(self.view.width * self.model.selectRow, 0)];
        
        initFlag = YES;
    }
}

#pragma mark 懒加载

- (ImageCollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[ImageCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    }
    return _collectionView;
}

#pragma mark set

- (void)setModel:(ImagesModel *)model{
    _model = model;
}


#pragma mark StatusBarHidden

- (BOOL)prefersStatusBarHidden{
    return self.hidenStatusBar;
}

- (void)subViewHidden:(BOOL)isHidden {
    if (isHidden) {
        self.collectionView.hidden = YES;
    } else {
        self.collectionView.hidden = NO;
    }
}
@end
