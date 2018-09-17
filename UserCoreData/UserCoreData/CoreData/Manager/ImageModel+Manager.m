//
//  ImageModel+Manager.m
//  UserCoreData
//
//  Created by ford Gao on 2018/9/13.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import "ImageModel+Manager.h"

@implementation ImageModel (Manager)

+ (void)addImageModelWithData: (NSData *)data complete:(void (^)(BOOL, ImageModel *))complete{
    
    ImageModel *model = [CoreDataManager insertNewObjectForEntityForName: [ImageModel class]];
    model.content = data;
    //保存
    [CoreDataManager save:nil complete:^(BOOL result) {
        if (result) {
            complete(result, model);
        }
    }];
}

+ (void)getAllImageModelWithPredicate:(NSPredicate *)predicate complete: (void(^)(NSArray<ImageModel *>*))complete{
    
    [CoreDataManager executeFetchRequest: [ImageModel class] predicate: nil complete:^(NSArray *array, NSError *error) {
        complete(array);
    }];
}

@end
