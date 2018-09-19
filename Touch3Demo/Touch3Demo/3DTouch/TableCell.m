//
//  TableCell.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "TableCell.h"

@interface TableCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup {
    self.label = [[UILabel alloc] initWithFrame: self.contentView.frame];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.label];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = self.title;
}

@end
