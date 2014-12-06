//
//  AlreadyInputCell.h
//  Universal
//
//  Created by julius on 14/12/5.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlreadyInputModel;

@interface AlreadyInputCell : UITableViewCell

@property (nonatomic, strong) AlreadyInputModel *model;

+ (CGFloat)heightForCellWithAlreadyInputModel:(AlreadyInputModel *)post;

@end
