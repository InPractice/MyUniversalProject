//
//  UserInfoCoreDataStorage.m
//  Universal
//
//  Created by julius on 14/11/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "UserInfoCoreDataStorage.h"
#import "XMPPCoreDataStorageProtected.h"

@implementation UserInfoCoreDataStorage

static UserInfoCoreDataStorage *sharedInstance;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[UserInfoCoreDataStorage alloc] initWithDatabaseFilename:nil storeOptions:nil];
    });
    
    return sharedInstance;
}

+ (void)executeStorageBlock:(CoreDataStorageBlock)block
{
    UserInfoCoreDataStorage *storage = [UserInfoCoreDataStorage sharedInstance];
    [storage executeBlock:^{
        block([storage managedObjectContext]);
    }];
}

+ (void)scheduleStorageBlock:(CoreDataStorageBlock)block
{
    UserInfoCoreDataStorage *storage = [UserInfoCoreDataStorage sharedInstance];
    [storage scheduleBlock:^{
        block([storage managedObjectContext]);
    }];
}

@end
