//
//  ImageModel+CoreDataProperties.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/13.
//  Copyright © 2018年 ford Gao. All rights reserved.
//
//

#import "ImageModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImageModel (CoreDataProperties)

+ (NSFetchRequest<ImageModel *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *content;

@end

NS_ASSUME_NONNULL_END
