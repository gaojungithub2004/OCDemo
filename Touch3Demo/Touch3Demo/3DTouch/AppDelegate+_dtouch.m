//
//  AppDelegate+_dtouch.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "AppDelegate+_dtouch.h"
#import "TableViewController.h"
#import "ImageViewController.h"

@implementation AppDelegate (_dtouch)

- (void)creatShortcutItem{
    
    //注意：自定义 Icons should be square, single color, and 35x35 points
    if (![self apply3DTouch]) {
        return;
    }
    
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:@"com.gaojun.share" localizedTitle:@"添加" localizedSubtitle:@"******" icon:icon userInfo:nil];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"com.gaojun.image" localizedTitle:@"添加" localizedSubtitle:@"******" icon:icon2 userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[item, item2];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString: @"com.gaojun.share"]) {
        
        TableViewController *controller = [TableViewController new];
        controller.title = @"table";
        controller.navigationController.navigationBar.translucent = NO;
        controller.view.backgroundColor = [UIColor purpleColor];
        [self.window.rootViewController presentViewController: [[UINavigationController alloc] initWithRootViewController:controller] animated: YES completion:nil];
    }
    
    if ([shortcutItem.type isEqualToString: @"com.gaojun.image"]) {
        ImageViewController *imageC = [ImageViewController new];
        [self.window.rootViewController presentViewController: imageC animated: YES completion:nil];
    }
}

- (BOOL)apply3DTouch {
    if ([self.window respondsToSelector:@selector(traitCollection)])
    {
        if ([self.window.traitCollection respondsToSelector:@selector(forceTouchCapability)])
        {
            if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
            {
                // 支持3D Touch
                return true;
            }
            else
            {
                // 不支持3D Touch
                return false;
            }
        }
    }
    return false;
}

@end
