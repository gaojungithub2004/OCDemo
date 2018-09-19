//
//  UIButton+action.m
//  AlbumPickTool
//
//  Created by ford Gao on 2018/6/22.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "UIButton+action.h"
#import <objc/runtime.h>

static const char * GJ_CLICKKEY = "gj_clickkey";
@implementation UIButton (action)

- (void)addTargetBlock:(ClickActionBlock)clickBlock for:(UIControlEvents)event{
    
    objc_setAssociatedObject(self, &GJ_CLICKKEY, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(goAction:) forControlEvents:event];
}



- (void)goAction:(UIButton *)sender{
    
    ClickActionBlock block = (ClickActionBlock)objc_getAssociatedObject(self, &GJ_CLICKKEY);
    
    if (block) {
        
        block(sender); 
    }
}

@end
