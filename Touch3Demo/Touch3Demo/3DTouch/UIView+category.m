//
//  UIView+category.m
//  OC基础
//
//  Created by ford Gao on 2018/8/29.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "UIView+category.h"
#import <objc/runtime.h>

static const char *TapGesture = "TapGesture";
static const char *TapGestureAction = "TapGestureAction";
@implementation UIView (category)

- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (CGFloat)top{
    return self.y;
}
- (CGFloat)bottom{
    return self.y + self.height;
}
- (CGFloat)left{
    return self.x;
}
- (CGFloat)right{
    return self.y + self.width;
}
- (CGFloat)centerX{
    return (self.right - self.left)/2;
}
- (CGFloat)centerY{
    return (self.bottom - self.top)/2;
}

/**
 *  添加点击手势
 *
 *  @param action 手势执行的动作
 */
- (void)tapAction:(void (^)(void))action
{
    //获取点击手势属性
    UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, &TapGesture);
    
    //是否获取到点击手势
    if (!tapGesture) {
        //创建点击手势
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        //把手势添加到视图
        [self addGestureRecognizer:tapGesture];
        //添加点击手势属性
        objc_setAssociatedObject(self, &TapGesture, tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //添加点击手势响应代码块属性
    objc_setAssociatedObject(self, &TapGestureAction, action, OBJC_ASSOCIATION_RETAIN);
}

/**
 *  点击手势执行的方法
 *
 *  @param sender 点击手势
 */
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    void (^action)(void) = objc_getAssociatedObject(self, &TapGestureAction);
    if (action) {
        action();
    }
}

@end
