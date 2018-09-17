//
//  CoreDataManager.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/10.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "CoreDataManager.h"


#define DocumentDirectory  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define DataBaseName @"Mine"
@implementation CoreDataManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static CoreDataManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

+ (instancetype)manager
{
    return [[super alloc] init];
}

/**
 创建上下文对象
 */
- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName {
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}

- (NSManagedObjectContext *)mainContext{
    if (!_mainContext) {
        _mainContext = [self contextWithModelName: @"Mine"];
    }
    return _mainContext;
}

- (NSManagedObjectContext *)backgroundContext{
    if (!_backgroundContext) {
        _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _backgroundContext.parentContext = _mainContext;
    }
    return _backgroundContext;
}


#pragma mark - 往数据库中插入一个对象首先需要将实体类和模型文件关联

/**
 *   将实体类和模型文件建立联系
 *
 *   @param class 传入一个你要操作的实体类的类名
 *
 *   @return 返回一 NSManagedObject的对象
 */
+ (id)insertNewObjectForEntityForName:(Class)modelClass
{
    CoreDataManager *manager = [CoreDataManager manager];
    NSManagedObject  *mgrObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(modelClass) inManagedObjectContext: manager.backgroundContext];
    return mgrObject;
}

/**
 *   保存数据
 *
 *   @param error  error 传& error
 *
 *   @complete  返回是否成功
 */
+ (void)save:(NSError * __autoreleasing *)error complete: (void(^)(BOOL))complete
{
    CoreDataManager *manager = [CoreDataManager manager];
    [manager.backgroundContext performBlock:^{
        NSLog(@"currentThread: %@", [NSThread currentThread]);
        [manager.backgroundContext save: error];
        [manager.mainContext performBlock:^{
            NSLog(@"currentThread: %@", [NSThread currentThread]);
            complete([manager.mainContext save: error]);
        }];
    }];
}
# pragma mark - 输入要查询对象的类名和查询语句 就可以得到一个查询结果集

/**
 *   查询语句
 *
 *   @param entityClass 实体类的类名
 *   @param sql         查询语句
 *   @param error       &error
 *
 *   @return 返回查询结果的数组
 */
//同步
+ (NSArray*)executeFetchRequest:(Class)entityClass predicate:(NSPredicate *)predicate error:(NSError**)error
{
    CoreDataManager *manager = [CoreDataManager manager];
    //创建一个请求对象 （填入要查询的表名-实体类）
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(entityClass)];
    request.predicate = predicate;
    NSArray *emps = [manager.mainContext executeFetchRequest:request error:error];
    return emps;
}

//异步
+ (void)executeFetchRequest:(Class)entityClass predicate:(NSPredicate *)predicate complete:(complete)complete
{
    CoreDataManager *manager = [CoreDataManager manager];
    //创建一个请求对象 （填入要查询的表名-实体类）
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(entityClass)];
    request.predicate = predicate;
    NSError *error = nil;
    NSAsynchronousFetchRequest *asyRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:request completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
        if (complete) {
//            NSLog(@"currentThread: %@", [NSThread currentThread]);
            complete(result.finalResult, error);
        }
    }];
    
    [manager.mainContext executeRequest: asyRequest error: &error];
}
#pragma mark - 删除对象
/**
 *   根据查询的结果集通过便利删除从数据库中删除数据
 *
 *   @param object 查询到的对象
 */
+ (void)deleteObject:(NSManagedObject*)object
{
    CoreDataManager *manager = [CoreDataManager manager];
    [manager.mainContext deleteObject:object];
}

@end
