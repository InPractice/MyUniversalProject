//
//  ServiceManager.h
//  Universal
//
//  Created by julius on 14/12/4.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManager : NSObject

+ (instancetype)shareInstance;

- (void)GETUrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag;
- (void)POSTUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag;

@end
