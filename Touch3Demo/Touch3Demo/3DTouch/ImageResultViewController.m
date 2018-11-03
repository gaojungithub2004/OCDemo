//
//  ImageResultViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageResultViewController.h"
#import "UIView+category.h"
#import "AnimatedTransition.h"

@interface ImageResultViewController ()


@property (nonatomic, strong) AnimatedTransition *transition;

@end

@implementation ImageResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview: self.imageView];
    self.imageView.image = self.image;
    self.imageView.userInteractionEnabled = YES;
    __weak __typeof(self)weakSelf = self;
    [self.imageView tapAction:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.transition = [AnimatedTransition new];
    self.transitioningDelegate = self.transition;
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame: self.view.bounds];
        
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
