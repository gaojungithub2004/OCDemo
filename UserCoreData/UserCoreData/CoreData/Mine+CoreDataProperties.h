//
//  Mine+CoreDataProperties.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "Mine+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Mine (CoreDataProperties)

+ (NSFetchRequest<Mine *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nonatomic) int64_t phone;
@property (nullable, nonatomic, retain) Dog *dog;

@end

NS_ASSUME_NONNULL_END
