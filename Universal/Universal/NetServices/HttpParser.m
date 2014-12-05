//
//  HttpParser.m
//  Universal
//
//  Created by julius on 14/12/4.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "HttpParser.h"
#import "AlreadyInputModel.h"
#import "SBJson4.h"
#import "AlreadyInputXmlModel.h"
@interface HttpParser ()<NSXMLParserDelegate>
{

    NSMutableArray *_XmlMutableAry;
    AlreadyInputXmlModel *_xmlModel;
    NSMutableString *_xmlElement;
}
@end

@implementation HttpParser


+ (id)parseSearchListWithXml:(id)xml modelClass:(NSString *)modelClass
{
    //设置该类本身为代理类，即该类在声明时要实现NSXMLParserDelegate委托协议
    
    return [[self alloc] parseSearchListWithXmlDetail:xml modelClass:modelClass];

}

- (id)parseSearchListWithXmlDetail:(id)xml modelClass:(NSString *)modelClass
{

    NSXMLParser *m_parser = xml;
    
    [m_parser setDelegate:self];  //设置代理为本地
    
    BOOL flag = [m_parser parse]; //开始解析
    if(flag) {
        return _XmlMutableAry;
    }else{
        return nil;
    }

}

//第一个代理方法：
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //判断是否是houses
    if ([elementName isEqualToString:@"houses"]) {
        _XmlMutableAry = [NSMutableArray array];

    }
    if ([elementName isEqualToString:@"houseinfo"]) {
        _xmlModel = [[AlreadyInputXmlModel alloc]init];
    }
    

    
}

//第二个代理方法：
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    _xmlElement = [NSMutableString string];
    [_xmlElement appendString:string];

}

//第三个代理方法：
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    if ([elementName isEqualToString:@"houseid"]) {
        _xmlModel.houseid = _xmlElement;
    }else if ([elementName isEqualToString:@"city"]){
        _xmlModel.city = _xmlElement;
    }else if ([elementName isEqualToString:@"district"]){
        _xmlModel.district = _xmlElement;
    }else if ([elementName isEqualToString:@"comarea"]){
        _xmlModel.comarea = _xmlElement;
    }else if ([elementName isEqualToString:@"projcode"]){
        _xmlModel.projcode = _xmlElement;
    }
    
    if([elementName isEqualToString:@"houseinfo"]) {
        
        [_XmlMutableAry addObject:_xmlModel];
    }

    if ([elementName isEqualToString:@"houses"]) {
        return;
    }
    
}

#pragma mark - json  parse


+ (id)parseSearchListWithJson:(id)json modelClass:(NSString *)modelClass
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *dic = ((NSDictionary*)json)[@"data"];

    for (NSDictionary *dataDic in dic) {
        if (modelClass) {
            id model = [[NSClassFromString(modelClass) alloc]initWithDictionary:dataDic error:nil];
            if (model) {
                [array addObject:model];
            }
        }
    }
    return array;

}

@end
