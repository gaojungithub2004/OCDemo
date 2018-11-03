//
//  ImageViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageViewController.h"
#import "UIButton+action.h"
#import "UIView+category.h"
#import "AppDelegate+_dtouch.h"
#import "PreviewImageViewController.h"

@interface ImageViewController ()<UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.button];
    __weak __typeof(self)weakSelf = self;
    [self.button addTargetBlock:^(id obj) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } for: UIControlEventTouchUpInside];
    
    [self.view addSubview: self.imageView];
    if ([(AppDelegate *)[UIApplication sharedApplication].delegate apply3DTouch]) {
        [self registerForPreviewingWithDelegate:self sourceView: self.imageView];
    }
}


#pragma mark 懒加载

- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame: CGRectMake(15, 30, 30, 30)];
        [_button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _button;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(50, 100, self.view.width - 100, self.view.height - 150)];
    
        _imageView.image = [UIImage imageNamed: @"timg.jpeg"];
        _imageView.backgroundColor = [UIColor purpleColor];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

#pragma mark UIViewControllerPreviewingDelegate

- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    //创建要预览的控制器
    PreviewImageViewController *presentationVC = [[PreviewImageViewController alloc] init];
    presentationVC.currentIndex = 1;
    
    presentationVC.imagesArray = [NSMutableArray arrayWithArray:@[[UIImage imageNamed: @"timg.jpeg"], [UIImage imageNamed: @"123.png"]]];
    //指定当前上下文视图Rect
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    previewingContext.sourceRect = rect;
    
    return presentationVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
//    [self showViewController:viewControllerToCommit sender:self];
    PreviewImageViewController *presentationVC = [[PreviewImageViewController alloc] init];
    presentationVC.currentIndex = 1;
    
    presentationVC.imagesArray = [NSMutableArray arrayWithArray:@[[UIImage imageNamed: @"timg.jpeg"], [UIImage imageNamed: @"123.png"]]];
    [self presentViewController:presentationVC animated:NO completion: nil];
}

@end
