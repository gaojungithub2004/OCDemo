//
//  ViewController.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "Mine+CoreDataClass.h"
#import "Dog+CoreDataClass.h"
#import "MineCell.h"
#import "ImageModel+Manager.h"

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    __weak __typeof(self)weakSelf = self;
//    [CoreDataManager executeFetchRequest: [Mine class] predicate:nil complete:^(NSArray *array, NSError *error) {
//        if (array) {
//            weakSelf.dataSource = [NSMutableArray arrayWithArray: array];
//        }
//    }];
    
    [ImageModel getAllImageModelWithPredicate: nil complete:^(NSArray<ImageModel *> *array) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray: array];
        [weakSelf.tableView reloadData];
    }];
}


- (void)addEntity{
    /*
     NSManagedObject 实例 一定是通过NSEntityDescription获取， 并返回一个实例给你， 然后才能操作数据变动(要现在数据库生成对应的表中的数据， 返回出来在赋值， 然后调用save存储到表中，完成数据变更)
     */
    Mine *mine = [CoreDataManager insertNewObjectForEntityForName: [Mine class]];
    mine.age = 18;
    mine.name = @"123";
    mine.phone = 186907983012;
    Dog *dog = [CoreDataManager insertNewObjectForEntityForName: [Dog class]];
    dog.name = @"dog";
    mine.dog = dog;
    NSError *error = nil;
    __weak __typeof(self)weakSelf = self;
    [CoreDataManager save:nil complete:^(BOOL result) {
        if (result) {
            [weakSelf findAll];
        }
    }];
}

- (void)findAll{
    __weak __typeof(self)weakSelf = self;
    [CoreDataManager executeFetchRequest: [Mine class] predicate:nil complete:^(NSArray *array, NSError *error) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray: array];
        [weakSelf.tableView reloadData];
    }];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (IBAction)add:(UIBarButtonItem *)sender {
//    [self addEntity];

    //删除
//    __weak __typeof(self)weakSelf = self;
//    [CoreDataManager executeFetchRequest: [Mine class] predicate:nil complete:^(NSArray *array, NSError *error) {
//        for (int i=0; i<array.count; i++) {
//            Mine *model = (Mine *)array[i];
//            if ([model.name isEqualToString:@"123"]) {
//                [CoreDataManager deleteObject: model];
//            }
//        }
//        [CoreDataManager save:nil];
//        [weakSelf findAll];
//    }];
    //异步添加图片信息
//    UIImage *image = [UIImage imageNamed: @"start.jpg"];
    __weak __typeof(self)weakSelf = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"start" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile: path];
    [ImageModel addImageModelWithData:data complete:^(BOOL result, ImageModel *model) {
        if (result) {
            [weakSelf.dataSource addObjectsFromArray:@[model]];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MineCell" forIndexPath:indexPath];
//    Mine *model = self.dataSource[indexPath.row];
//    cell.name.text = model.name;
    ImageModel *model = self.dataSource[indexPath.row];
    UIImage *image = [UIImage imageWithData: model.content];
    cell.arrow.image = image;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

@end
