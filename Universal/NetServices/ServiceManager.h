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

- (void)GET_XML_UrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag;
- (void)POS_XML_TUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag;


- (void)GET_JSON_UrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag;
- (void)POS_JSON_TUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag;

@end
