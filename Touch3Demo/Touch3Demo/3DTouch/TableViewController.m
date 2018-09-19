//
//  TableViewController.m
//  Touch3Demo
//
//  Created by ford Gao on 2018/9/19.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "TableViewController.h"
#import "UIButton+action.h"
#import "UIView+category.h"
#import "TableCell.h"
#import "AppDelegate+_dtouch.h"
#import "ResultViewController.h"

#define CellId @"TableCell"
@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview: self.button];
    __weak __typeof(self)weakSelf = self;
    [self.button addTargetBlock:^(id obj) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } for: UIControlEventTouchUpInside];
    [self.view addSubview: self.table];
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [self.dataSource addObjectsFromArray: array];
    [self.table reloadData];
    

}


#pragma mark 懒加载

- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame: CGRectMake(15, 30, 30, 30)];
        [_button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _button;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorColor = [UIColor purpleColor];
        _table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_table registerClass: [TableCell class] forCellReuseIdentifier: CellId];
    }
    return _table;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier: CellId forIndexPath:indexPath];
    if ([(AppDelegate *)[UIApplication sharedApplication].delegate apply3DTouch]) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark UIViewControllerPreviewingDelegate

- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [self.table indexPathForCell:(TableCell *)[previewingContext sourceView]];
    NSString *str = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    
    //创建要预览的控制器
    ResultViewController *presentationVC = [[ResultViewController alloc] init];
    
    presentationVC.str = str;
    //指定当前上下文视图Rect
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    previewingContext.sourceRect = rect;
    
    return presentationVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}


@end
