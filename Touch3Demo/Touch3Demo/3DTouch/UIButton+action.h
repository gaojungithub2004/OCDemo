//
//  UIButton+action.h
//  AlbumPickTool
//
//  Created by ford Gao on 2018/6/22.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickActionBlock) (id obj);
@interface UIButton (action)

- (void)addTargetBlock:(ClickActionBlock)clickBlock for:(UIControlEvents)event;

@end
