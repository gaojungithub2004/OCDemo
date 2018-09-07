//
//  SecondViewController.m
//  SliderController
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "SecondViewController.h"
#import "UIButton+action.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"second";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor whiteColor];
    [button addTargetBlock:^(id obj) {
        UIViewController *controller = [UIViewController new];
        controller.title = @"secondPush";
        controller.view.backgroundColor = [UIColor purpleColor];
        [self.navigationController pushViewController: controller animated:YES];
    } for:UIControlEventTouchUpInside];
    
    [self.view addSubview: button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
