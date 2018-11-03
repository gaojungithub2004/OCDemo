//
//  AnimatedTransition.h
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/20.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PresentType){
    Present,
    Dismiss
};

@interface AnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@end
