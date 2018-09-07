//
//  SliderViewController.m
//  SliderController
//
//  Created by ford Gao on 2018/9/6.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "SliderViewController.h"
#import "UIView+category.h"


#define WeakSelf(type)  __weak typeof(type) weak##type = type;
@interface SliderViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat width;
    CGFloat height;
    CGPoint startDragPoint;
    CGPoint lastDragPoint;
}
@property (nonatomic, strong) UIViewController *main;
@property (nonatomic, strong) UIViewController *left;

@end

@implementation SliderViewController

- (instancetype)initWithMain: (UIViewController *)main left: (UIViewController *)left{
    if(self = [super init]){
        self.main = main;
        self.left = left;
        [self addChildViewController: main];
        [self addChildViewController: left];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.width;
    height = self.view.height;
    [self setupUI];
}

#pragma mark UI

- (void)setupUI {
    
    self.main.view.frame = self.view.bounds;
    self.main.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview: self.main.view];
    
    self.left.view.frame = CGRectMake(-width, self.view.y, width, height);
    self.left.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.left.view];
    
    UIPanGestureRecognizer *panMain = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainPan:)];
    panMain.delegate = self;
    UIPanGestureRecognizer *panLeft = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
    panLeft.delegate = self;
    [self.main.view addGestureRecognizer: panMain];
    [self.left.view addGestureRecognizer:panLeft];
}

- (void)mainPan: (UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    WeakSelf(self)
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            startDragPoint = point;
            NSLog(@"startDragPoint%f", startDragPoint.x);
            break;
        case UIGestureRecognizerStateChanged:
            lastDragPoint = point;
            if (lastDragPoint.x < startDragPoint.x || startDragPoint.x > 100) {
                return;
            }
            CGFloat moveLen = lastDragPoint.x - startDragPoint.x;
            self.main.view.center = CGPointMake((width +moveLen)/2, height/2);
            self.left.view.center = CGPointMake((-width +moveLen)/2, height/2);
            
            NSLog(@"lastDragPoint%f", moveLen);
            break;
        case UIGestureRecognizerStateEnded:
            if (lastDragPoint.x < startDragPoint.x || startDragPoint.x > 100) {
                return;
            }
            if((lastDragPoint.x - startDragPoint.x) < width/2){
                [UIView animateWithDuration:0.1 animations:^{
                    weakself.left.view.frame = CGRectMake(-self->width, self.view.y, self->width, self->height);
                    weakself.main.view.frame = CGRectMake(0, self.view.y, self->width, self->height);
                }];
            }else{
                [UIView animateWithDuration:0.1 animations:^{
                    weakself.left.view.frame = CGRectMake(0, self.view.y, self->width, self->height);
                    weakself.main.view.frame = CGRectMake(self->width, self.view.y, self->width, self->height);
                }];
            }
            break;
        default:
            break;
    }
    
    [pan setTranslation:CGPointZero inView:self.main.view];
}

- (void)leftPan: (UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    WeakSelf(self)
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            startDragPoint = point;
            NSLog(@"startDragPoint%f", startDragPoint.x);
            break;
        case UIGestureRecognizerStateChanged:
            lastDragPoint = point;
            if (lastDragPoint.x > startDragPoint.x || startDragPoint.x < (width - 100)) {
                return;
            }
            CGFloat moveLen = fabs(lastDragPoint.x - startDragPoint.x);
            self.left.view.center = CGPointMake((width - moveLen)/2, height/2);
            self.main.view.center = CGPointMake((width + moveLen)/2, height/2);
            
            NSLog(@"lastDragPoint%f", moveLen);
            break;
        case UIGestureRecognizerStateEnded:
            if (lastDragPoint.x > startDragPoint.x || startDragPoint.x < (width - 100)) {
                return;
            }
            if(fabs(lastDragPoint.x - startDragPoint.x) < width/2){
                [UIView animateWithDuration:0.1 animations:^{
                    weakself.left.view.frame = CGRectMake(0, weakself.view.y, self->width, self->height);
                    weakself.main.view.frame = CGRectMake(self->width, weakself.view.y, self->width, self->height);
                }];
            }else{
                [UIView animateWithDuration:0.1 animations:^{
                    self.left.view.frame = CGRectMake(-self->width, self.view.y, self->width, self->height);
                    self.main.view.frame = CGRectMake(0, self.view.y, self->width, self->height);
                }];
            }
            break;
        default:
            break;
    }
    
    [pan setTranslation:CGPointZero inView:self.left.view];
}


#pragma mark -------------- gesture delegate -----------------------
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 防止进入多级界面后依然可以呼出侧滑菜单栏
    if ([self.main isKindOfClass:[UITabBarController class]]) {
        for (UIViewController *controller in ((UITabBarController *)self.main).viewControllers) {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                if (controller.childViewControllers.count>1) {
                    return NO;
                }
            }
        }
    }
    
    if ([self.left isKindOfClass: [UINavigationController class]]) {
        if (self.left.childViewControllers.count>1) {
            return NO;
        }
    }
    
    return YES;
}


@end
