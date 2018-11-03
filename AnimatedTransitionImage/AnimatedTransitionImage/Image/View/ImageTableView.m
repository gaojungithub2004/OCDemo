//
//  ImageTableView.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageTableView.h"
#import "ImageTableCell.h"
#import "UIView+category.h"
#import "ImagesModel.h"

#define Margin 50
#define MarginH 3
#define ImageWidth (screenWidth - Margin*2 - MarginH*2)/3
#define ImageTableCellID @"ImageTableCell"
@interface ImageTableView()<UITableViewDelegate, UITableViewDataSource, ImageTableCellSelectDelegate>

@end

@implementation ImageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass: [ImageTableCell class] forCellReuseIdentifier: ImageTableCellID];
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier: ImageTableCellID forIndexPath: indexPath];
    ImagesModel *model = [ImagesModel new];
    model.imageArray = self.imageArray[indexPath.row];
    model.row = indexPath.row;
    cell.model = model;
    cell.selectDelegate = self;
//    cell.tapBlock = ^(ImagesModel *model) {
//        NSLog(@"123");
//    };
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = ((NSArray *)self.imageArray[indexPath.row]).count;
    return (((int)count / 3)+1)*ImageWidth + 40 + (((int)count / 3))*MarginH;
}

#pragma mark ImageTableCellSelectDelegate

- (void)selectImageViewWithModel:(ImagesModel *)model{
    
    //拿到点击的图片转换后的位置
    
    ImageTableCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model.row inSection:0]];
    model.cell = cell;
    if (self.tapBlock) {
        self.tapBlock(model);
    }
}

@end
