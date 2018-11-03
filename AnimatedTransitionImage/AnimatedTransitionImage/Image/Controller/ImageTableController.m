//
//  ImageTableController.m
//  AnimatedTransitionImage
//
//  Created by ford Gao on 2018/10/24.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageTableController.h"
#import "ImageTableView.h"
#import "PresentTransition.h"
#import "DidmissTransition.h"
#import "PreviewImageController.h"
#import "ImagesModel.h"
#import "SwipeUpInteractiveTransition.h"

@interface ImageTableController ()<PreviewImageControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) ImageTableView *tableView;
@property (nonatomic, strong) PresentTransition *presentAnimation;
@property (nonatomic, strong) DidmissTransition *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;


@property (nonatomic, strong) ImagesModel *model;

@end

@implementation ImageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[
                         @[
                            [UIImage imageNamed: @"123.png"],
                            [UIImage imageNamed: @"timg.jpeg"]
                          ],
                        @[
                            [UIImage imageNamed: @"123.png"]
                         ],
                        @[
                            [UIImage imageNamed: @"timg.jpeg"],
                            [UIImage imageNamed: @"123.png"],
                            [UIImage imageNamed: @"timg.jpeg"],
                            [UIImage imageNamed: @"123.png"],
                            [UIImage imageNamed: @"timg.jpeg"]
                         ]
                    ];
    self.title = @"previewImage";
    self.tableView.imageArray = arr;
    [self.view addSubview: self.tableView];
    self.presentAnimation = [PresentTransition new];
    self.dismissAnimation = [DidmissTransition new];
    _transitionController = [SwipeUpInteractiveTransition new];
    
    __weak __typeof(self)weakSelf = self;
    self.tableView.tapBlock = ^(ImagesModel *model) {
        weakSelf.model = model;
        [weakSelf presentViewController: [weakSelf createWithModel:model] animated:YES completion:nil];
    };
}

- (ImagesModel *)getSelctModel{
    return self.model;
}

- (BOOL)interacting{
    return self.transitionController.interacting;
}

#pragma mark lazy

- (ImageTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ImageTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    
    return _tableView;
}

#pragma mark UIViewControllerContextTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}

#pragma mark PreviewImageControllerDelegate

-(void) modalViewControllerDidClickedDismissButton:(PreviewImageController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (PreviewImageController *)createWithModel: (ImagesModel *)model{
    PreviewImageController *vc = [PreviewImageController new];
    vc.model = self.model;
    vc.delegate = self;
    vc.transitioningDelegate = self;
    [self.transitionController wireToViewController: vc];
    return vc;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

@end
