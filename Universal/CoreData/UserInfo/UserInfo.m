//
//  UserInfo.m
//  Universal
//
//  Created by julius on 14/12/3.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "UserInfo.h"
#import "UserInfoCoreDataStorage.h"

@implementation UserInfo

@dynamic id;
@dynamic name;
@dynamic score;


//增删改查
#pragma mark - Student相关操作
+(void)insertStudentItem:(NSMutableDictionary *)LoginItem
{
    
    [UserInfoCoreDataStorage scheduleStorageBlock:^(NSManagedObjectContext *moc){
        
        [UserInfo insertLoginItem:LoginItem inManagedObjectContext:moc];
    }];
}


+(void)removeStudentItem:(NSString *)name
{
    [UserInfoCoreDataStorage scheduleStorageBlock:^(NSManagedObjectContext *moc) {
        [UserInfo removeLoginItem:name inManagedObjectContext:moc];
    }];
}

+ (void)updateStudentInfo:(NSMutableDictionary *)dict
{
    [UserInfoCoreDataStorage scheduleStorageBlock:^(NSManagedObjectContext *moc){

        [UserInfo updateUserInfo:dict inManagedObjectContext:moc];
    }];
}

+ (void)readStudentInfoFromDataBase:(NSMutableArray *)dataSource
{
    __weak NSMutableArray *weakDataSource = dataSource;
    [UserInfoCoreDataStorage scheduleStorageBlock:^(NSManagedObjectContext *moc){

        [UserInfo  readUserInfoInManagedObjectContext:moc dataSource:weakDataSource];
    }];
}


+ (void)updateUserInfo:(NSMutableDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)moc
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPendingChanges:YES];
    
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    if (results.count == 0)
    {
        UserInfo *record = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
        record.name = [dict objectForKey:@"name"];
        record.id = [dict objectForKey:@"id"];
        record.score = [dict objectForKey:@"score"];
    }
    else
    {
        UserInfo *record = [results objectAtIndex:0];
        record.name = [dict objectForKey:@"name"];
        record.id = [dict objectForKey:@"id"];
        record.score = [dict objectForKey:@"score"];
    }
}

+ (void)readUserInfoInManagedObjectContext:(NSManagedObjectContext *)moc dataSource:(NSMutableArray *)dataSource
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPendingChanges:YES];
    
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    
    [dataSource addObjectsFromArray:results];
    //    if (results.count > 0)
    //    {
    //        //        Student *record = [results objectAtIndex:0];
    //        //        NSLog(@"name = %@",record.name);
    //        //        NSLog(@"stu_id = %@",record.stu_id);
    //        for (int i=0; i<results.count; i++) {
    //            UserInfo *record = [results objectAtIndex:i];
    //            NSLog(@"name = %@",record.name);
    //            NSLog(@"stu_id = %@",record.id);
    //
    //        }
    //    }
}

+ (void)insertLoginItem:(NSMutableDictionary *)loginItem inManagedObjectContext:(NSManagedObjectContext *)moc
{
    if (loginItem != nil) {
        NSString *stu_id = [loginItem objectForKey:@"id"];
        [self removeLoginItem:stu_id inManagedObjectContext:moc]; // 删除重复的数据
        
        UserInfo *login = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class])
                                                        inManagedObjectContext:moc];
        login.name = [loginItem objectForKey:@"name"];
        login.id = [loginItem objectForKey:@"id"];
        login.score = [loginItem objectForKey:@"score"];
    }
}



+ (void)removeLoginItem:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)moc
{
    if (name) {
        NSLog(@"NSStringFromClass([self class]) = %@",NSStringFromClass([self class]));
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class])
                                                  inManagedObjectContext:moc];
        NSPredicate *predicate = nil;
        
        predicate = [NSPredicate predicateWithFormat:@"stu_id == %@", name];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        [fetchRequest setIncludesPendingChanges:YES];
        
        NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
        fetchRequest = nil;
        for (UserInfo *login in results) {
            [moc deleteObject:login];
        }
    }
    
}
@end
