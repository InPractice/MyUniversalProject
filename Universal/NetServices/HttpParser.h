//
//  HttpParser.h
//  Universal
//
//  Created by julius on 14/12/4.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParser : NSObject

+ (id)parseSearchListWithJson:(NSString *)json modelClass:(NSString *)modelClass;
+ (id)parseSearchListWithXml:(NSString *)xml modelClass:(NSString *)modelClass;
@end
