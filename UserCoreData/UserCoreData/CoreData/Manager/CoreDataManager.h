//
//  CoreDataManager.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/10.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^complete)(NSArray*array,NSError*error);
@interface CoreDataManager : NSObject

+ (instancetype)manager;


@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;

#pragma mark - 往数据库中插入一个对象首先需要将实体类和模型文件关联
/**
 *   将实体类和模型文件建立联系
 *
 *   @param modelClass 传入一个你要操作的实体类的类名
 *
 *   @return 返回一 NSManagedObject的对象
 */
+ (id)insertNewObjectForEntityForName:(Class)modelClass;


# pragma mark - 输入要查询对象的类名和查询语句 就可以得到一个查询结果集
/**
 *   查询语句通过 blcok 回调结果
 *
 *   @param entityClass 实体类的类名
 *   @param predicate 通过谓词来查询
 */
+ (void)executeFetchRequest:(Class)entityClass predicate:(NSPredicate *)predicate complete:(complete)complete;
/**
 *   查询语句
 *
 *   @param entityClass 实体类的类名
 *   @param predicate 通过谓词来查询
 *   @param error       &error
 *
 *   @return 返回查询结果的数组
 */
+ (NSArray*)executeFetchRequest:(Class)entityClass predicate:(NSPredicate *)predicate error:(NSError**)error;


#pragma mark - 用来保存上下文
/**
 *   保存数据
 *
 *   @param error  error 传& error
 *
 *   @complete  返回是否成功
 */
+ (void)save:(NSError **)error complete: (void(^)(BOOL))complete;

#pragma mark - 删除对象
/**
 *   根据查询的结果集通过便利删除从数据库中删除数据
 *
 *   @param object 查询到的对象
 */
+ (void)deleteObject:(NSManagedObject*)object;

@end
