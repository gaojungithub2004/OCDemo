//
//  ImageCell.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/16.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageCell.h"
#import "UIView+category.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor blackColor];
        self.previewImageView = [[UIImageView alloc] initWithFrame: CGRectZero];
        self.previewImageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.previewImageView.autoresizesSubviews = YES;
        self.previewImageView.backgroundColor = [UIColor lightGrayColor];
//        self.previewImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview: self.previewImageView];
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.previewImageView.image = image;
    self.previewImageView.frame = CGRectMake(0, (self.height - image.size.height)/2, self.width, image.size.height);
}
@end
