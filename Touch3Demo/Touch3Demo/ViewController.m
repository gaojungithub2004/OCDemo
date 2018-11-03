//
//  ViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ViewController.h"
#import "UIView+category.h"
#import "PreviewImageViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak __typeof(self)weakSelf = self;
    [_icon1 tapAction:^{
        PreviewImageViewController *presentationVC = [[PreviewImageViewController alloc] init];
        presentationVC.currentIndex = 0;
        
        presentationVC.imagesArray = [NSMutableArray arrayWithArray:@[[UIImage imageNamed: @"timg.jpeg"], [UIImage imageNamed: @"123.png"]]];
        [weakSelf presentViewController:presentationVC animated:YES completion:nil];
    }];
    
    [_icon2 tapAction:^{
        PreviewImageViewController *presentationVC = [[PreviewImageViewController alloc] init];
        presentationVC.currentIndex = 1;
        
        presentationVC.imagesArray = [NSMutableArray arrayWithArray:@[[UIImage imageNamed: @"timg.jpeg"], [UIImage imageNamed: @"123.png"]]];
        [weakSelf presentViewController:presentationVC animated:YES completion:nil];
    }];
    
}

@end
