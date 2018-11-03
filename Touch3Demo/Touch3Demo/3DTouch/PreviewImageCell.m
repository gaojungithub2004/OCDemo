//
//  PreviewImageCell.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/26.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "PreviewImageCell.h"

@implementation PreviewImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.previewImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        self.previewImageView.frame = CGRectZero;
//        self.previewImageView.center = self.center;
        self.previewImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.previewImageView.autoresizesSubviews = YES;
        self.previewImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview: self.previewImageView];
    }
    return self;
}



@end
