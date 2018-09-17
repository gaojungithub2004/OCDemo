//
//  Dog+CoreDataProperties.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "Dog+CoreDataProperties.h"

@implementation Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Dog"];
}

@dynamic name;

@end
