//
//  UserInfoCoreDataStorage.h
//  Universal
//
//  Created by julius on 14/11/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "XMPPCoreDataStorage.h"


typedef void (^CoreDataStorageBlock)(NSManagedObjectContext *moc);
@interface UserInfoCoreDataStorage : XMPPCoreDataStorage

+ (instancetype)sharedInstance;

+ (void)executeStorageBlock:(CoreDataStorageBlock)block;

+ (void)scheduleStorageBlock:(CoreDataStorageBlock)block;

@end
