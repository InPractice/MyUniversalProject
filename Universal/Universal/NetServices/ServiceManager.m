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
//        _httpSessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//        .acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml", nil];
//        _httpSessionManager.requestSerializer. = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml", nil];
//        _httpSessionManager.baseURL = [NSURL URLWithString:<#(NSString *)#>]
    }
    return self;
}




- (void)GETUrlString:(NSString *)urlString Target:(id)target Selector:(SEL)selector NotificationNameTag:(HttpRequestTag)notificationNameTag
{
    NSString *completeUrlString  =  @"http://soufunapp.3g.soufun.com/http/sfservice.jsp?city=%E5%8C%97%E4%BA%AC&district=%E6%9C%9D%E9%98%B3&gettype=android&housetype=wt&messagename=esflist&oderby=25&page=1&pagesize=20&wirelesscode=3AF532418B0CE711AF7F2114564F6816";//[NSString stringWithFormat:@"%@%@",KINTERFACE_ADDRESS_FOREGROUND,urlString];
    
    
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:target name:[NSString stringWithFormat:@""]object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:target selector:selector name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    
    
    [_httpSessionManager GET:completeUrlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功了");
        
        id sender = nil;
        switch (notificationNameTag) {
            case HttpRequestTag_First:
            {
//                sender = [HttpParser parseSearchListWithJson:responseObject modelClass:@"AlreadyInputModel"];
                sender = [HttpParser parseSearchListWithXml:responseObject modelClass:@"AlreadyInputModel"];
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

- (void)POSTUrlString:(NSString *)urlString parameters:(id)parameters Target:(id)target Selector:(SEL)selector NotificationName:(NSInteger)notificationNameTag
{
    NSString *completeUrlString  =[NSString stringWithFormat:@"%@%@",KINTERFACE_ADDRESS_FOREGROUND,urlString];
    
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:target name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:target selector:selector name:[Utilities covertEnumToString:notificationNameTag] object:nil];
    
    [_httpSessionManager POST:completeUrlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功了");
        [[NSNotificationCenter defaultCenter]postNotificationName:[Utilities covertEnumToString:notificationNameTag] object:responseObject];;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败了");
        [[NSNotificationCenter defaultCenter]postNotificationName:[Utilities covertEnumToString:notificationNameTag] object:error];
    }];
    
}


@end
