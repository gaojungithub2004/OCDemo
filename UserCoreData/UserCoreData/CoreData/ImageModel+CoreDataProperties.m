//
//  ImageModel+CoreDataProperties.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/13.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "ImageModel+CoreDataProperties.h"

@implementation ImageModel (CoreDataProperties)

+ (NSFetchRequest<ImageModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ImageModel"];
}

@dynamic content;

@end
