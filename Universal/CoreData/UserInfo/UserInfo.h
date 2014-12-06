//
//  UserInfo.h
//  Universal
//
//  Created by julius on 14/12/3.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * score;


+(void)insertStudentItem:(NSMutableDictionary *)LoginItem;

+(void)removeStudentItem:(NSString *)name;

+ (void)updateStudentInfo:(NSMutableDictionary *)dict;

+ (void)readStudentInfoFromDataBase:(NSMutableArray *)dataSource;


@end
