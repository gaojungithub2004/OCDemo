//
//  ResultViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc] initWithFrame: self.view.frame];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:30];
    self.label.text = self.str;
    [self.view addSubview:self.label];
}


- (void)setStr:(NSString *)str{
    _str = str;
    self.label.text = str;
}

#pragma mark 快捷功能菜单的生成

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    NSMutableArray *arrItem = [NSMutableArray array];
    
    UIPreviewAction *previewAction0 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"didClickCancel");
    }];
    
    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:@"替换该元素" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        
    }];
    
    [arrItem addObjectsFromArray:@[previewAction0 ,previewAction1]];
    
    return arrItem;
}



@end
