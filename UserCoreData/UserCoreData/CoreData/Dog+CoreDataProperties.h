//
//  Dog+CoreDataProperties.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "Dog+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
