//
//  ImageModel+Manager.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/13.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageModel+CoreDataClass.h"
#import "CoreDataManager.h"

@interface ImageModel (Manager)

+ (void)addImageModelWithData: (NSData *)data complete: (void(^)(BOOL, ImageModel*))complete;
+ (void)getAllImageModelWithPredicate:(NSPredicate *)predicate complete: (void(^)(NSArray<ImageModel *>*))complete;
@end
