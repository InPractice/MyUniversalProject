//
//  ServiceManager.m
//  Universal
//
//  Created by julius on 14/12/4.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ServiceManager.h"
#import "AFNetworking.h"
#import "UtilsMacro.h"
#import "Utilities.h"
#import "HttpParser.h"
#import "AFURLResponseSerialization.h"

@interface ServiceManager ()
{
    AFHTTPSessionManager *_httpSessionManager;
}
@end

@implementation ServiceManager


static ServiceManager *shareInstance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[ServiceManager alloc]init];
        
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        
        
    }
    return self;
}





- (void)GET_XML_UrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag
{
    _httpSessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [self GETUrlString:urlString Target:target Selector:selector NotificationNameTag:notificationNameTag isJson:NO];
}
- (void)POS_XML_TUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag
{
    _httpSessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [self POSTUrlString:urlString parameters:parameters Target:target Selector:selector NotificationName:notificationNameTag isJson:NO];
}



- (void)GET_JSON_UrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag
{
    _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self GETUrlString:urlString Target:target Selector:selector NotificationNameTag:notificationNameTag isJson:YES];
}
- (void)POS_JSON_TUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag
{
    _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self POSTUrlString:urlString parameters:parameters Target:target Selector:selector NotificationName:notificationNameTag isJson:YES];
}






- (void)GETUrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag isJson:(BOOL)isJson
{
    NSString *baseUrl = KINTERFACE_ADDRESS_FOREGROUND_XML;
    if (isJson) {
        baseUrl = KINTERFACE_ADDRESS_FOREGROUND_JSON;
    }
    NSString *completeUrlString  =  [NSString stringWithFormat:@"%@%@",baseUrl,urlString];
    
    
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:target name:[NSString stringWithFormat:@""]object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:target selector:selector name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    
    
    [_httpSessionManager GET:completeUrlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功了");
        
        id sender = nil;
        switch (notificationNameTag) {
            case HttpRequestTag_First:
            {
                if (isJson) {
                    sender = [HttpParser parseSearchListWithJson:responseObject modelClass:@"AlreadyInputModel"];
                }else{
                    sender = [HttpParser parseSearchListWithXml:responseObject modelClass:@"AlreadyInputModel"];
                }
            }
                break;
                
            default:
                break;
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:[Utilities covertEnumToString:notificationNameTag] object:sender];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败了  %@",error);
        [[NSNotificationCenter defaultCenter]postNotificationName:[Utilities covertEnumToString:notificationNameTag] object:error];
    }];
    
}

- (void)POSTUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag isJson:(BOOL)isJson
{
    NSString *completeUrlString  =[NSString stringWithFormat:@"%@%@",KINTERFACE_ADDRESS_FOREGROUND_JSON,urlString];
    
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:target name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:target selector:selector name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    
    [_httpSessionManager POST:completeUrlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功了");
        
        id sender = nil;
        switch (notificationNameTag) {
            case HttpRequestTag_First:
            {
                if (isJson) {
                    sender = [HttpParser parseSearchListWithJson:responseObject modelClass:@"AlreadyInputModel"];
                }else{
                    sender = [HttpParser parseSearchListWithXml:responseObject modelClass:@"AlreadyInputModel"];
                }
            }
                break;
                
            default:
                break;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败了");
        [[NSNotificationCenter defaultCenter]postNotificationName:[Utilities covertEnumToString:notificationNameTag] object:error];
    }];
    
}


@end
