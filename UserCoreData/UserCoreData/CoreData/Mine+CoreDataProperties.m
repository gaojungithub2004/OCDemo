//
//  Mine+CoreDataProperties.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/7.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "Mine+CoreDataProperties.h"

@implementation Mine (CoreDataProperties)

+ (NSFetchRequest<Mine *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Mine"];
}

@dynamic name;
@dynamic age;
@dynamic phone;
@dynamic dog;

@end
