//
//  ViewController.m
//  SliderController
//
//  Created by ford Gao on 2018/9/6.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ViewController.h"
#import "SliderViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *controller = [FirstViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.translucent = NO;
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[nav];
    
    SecondViewController *second = [SecondViewController new];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController: second];
    nav2.navigationBar.translucent = NO;
    SliderViewController * slider = [[SliderViewController alloc] initWithMain: tab left: nav2];
    [self addChildViewController:slider];
    slider.view.frame = self.view.bounds;
    [self.view addSubview:slider.view];
}


@end
