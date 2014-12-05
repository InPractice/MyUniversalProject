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
    
    
    [[ServiceManager shareInstance] GETUrlString:@"housephoto/photolist/3C714FA107C7A9CE7D8E33150A0DB27C/1/1/1" Target:self Selector:@selector(finishRequest:) NotificationNameTag:HttpRequestTag_First];
    

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
//        AlreadyInputModel *model = [sender object];
        NSArray *modelAry = [sender object];
        NSLog(@"应该成功了  model = %@",((AlreadyInputXmlModel *)modelAry[0]).houseid);
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
