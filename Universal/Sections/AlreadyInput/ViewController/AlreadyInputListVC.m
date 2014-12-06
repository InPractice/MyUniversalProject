//
//  AlreadyInputListVC.m
//  Universal
//
//  Created by julius on 14/12/4.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "AlreadyInputListVC.h"
#import "ServiceManager.h"
#import "AFNetworking.h"
#import "AlreadyInputModel.h"
#import "AlreadyInputXmlModel.h"

@interface AlreadyInputListVC ()

@end

@implementation AlreadyInputListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *xmlString = @"http/sfservice.jsp?city=%E5%8C%97%E4%BA%AC&district=%E6%9C%9D%E9%98%B3&gettype=android&housetype=wt&messagename=esflist&oderby=25&page=1&pagesize=20&wirelesscode=3AF532418B0CE711AF7F2114564F6816";
    NSString *jsonString = @"housephoto/photolist/3C714FA107C7A9CE7D8E33150A0DB27C/1/1/1";
    
//    [[ServiceManager shareInstance] GET_XML_UrlString:xmlString Target:self Selector:@selector(finishRequest:) NotificationNameTag:HttpRequestTag_First];
    
        [[ServiceManager shareInstance] GET_JSON_UrlString:jsonString Target:self Selector:@selector(finishRequest:) NotificationNameTag:HttpRequestTag_First];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)finishRequest:(NSNotification *)sender
{
    if ([[sender object] isKindOfClass:[NSError class]]) {
        NSLog(@"应该是个错误");
    }else{
        
        
        NSLog(@"应该成功了  info == %@",[sender object]);
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
