//
//  ImageTableCell.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageTableCell.h"
#import "UIView+category.h"
#import "ImagesModel.h"

@interface ImageTableCell()


#define Margin 50
#define MarginH 3
#define ImageWidth (screenWidth - Margin*2 - MarginH*2)/3



@end

@implementation ImageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageViews = [NSMutableArray new];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageContentView = [[UIView alloc] initWithFrame: CGRectZero];
        [self addSubview:self.imageContentView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark set

- (void)setModel:(ImagesModel *)model{
    _model = model;
    //创建
    
    self.imageContentView.frame = CGRectMake(Margin, 20, self.width - Margin*2, (model.imageArray.count%4+1)*ImageWidth+ 40);
    for (UIImageView *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    
    for (int i = 0; i < model.imageArray.count; i++) {
        UIImage *image = model.imageArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%3*ImageWidth + (i%3==0? 0: MarginH*(i%3)), ((int)i/3)*ImageWidth + ((int)i/3)*MarginH, ImageWidth, ImageWidth)];
        imageView.image = image;
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.userInteractionEnabled = YES;
        [self.imageViews addObject:imageView];
        [self.imageContentView addSubview:imageView];
        
        __weak __typeof(self)weakSelf = self;
        [imageView tapAction:^{
            if (weakSelf.selectDelegate && [self.selectDelegate respondsToSelector:@selector(selectImageViewWithModel:)]) {
                weakSelf.model.imageView = imageView;
                weakSelf.model.selectRow = i;
                [weakSelf.selectDelegate selectImageViewWithModel: weakSelf.model];
            }
        }];
    }
}

@end
