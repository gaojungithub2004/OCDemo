//
//  UIView+category.h
//  OC基础
//
//  Created by ford Gao on 2018/8/29.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (category)

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)width;
- (CGFloat)height;

- (void)tapAction:(void (^)(void))action;
@end
