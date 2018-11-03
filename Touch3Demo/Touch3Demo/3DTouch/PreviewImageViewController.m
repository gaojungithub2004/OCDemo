//
//  PreviewImageViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/26.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "PreviewImageViewController.h"
#import "PreviewImageCell.h"
#import "UIView+category.h"

#define PreviewImageCellId @"PreviewImageCellId"
@interface PreviewImageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PreviewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview: self.collectionView];
}


#pragma mark 懒加载

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        [_collectionView registerClass: [PreviewImageCell class] forCellWithReuseIdentifier: PreviewImageCellId];
    }
    return _collectionView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem: self.currentIndex inSection: 0];
//    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self.collectionView setContentOffset: CGPointMake(self.currentIndex * self.view.width, 0)];
}

#pragma mark set

- (void)setImagesArray:(NSMutableArray *)imagesArray{
    _imagesArray = imagesArray;
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PreviewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PreviewImageCellId forIndexPath:indexPath];
    UIImage *image = self.imagesArray[indexPath.row];
    cell.previewImageView.image = image;
    return cell;
}


@end
