//
//  UIkit+Category.h
//  Universal
//
//  Created by julius on 14/11/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIkit_Category : NSObject

@end


#pragma mark -
#pragma mark - UILabel
@interface UILabel (Helper)

+ (UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

@end

#pragma mark -
#pragma mark - UIView
@interface UIView (Helper)

- (void)addLabelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize tag:(NSInteger)tag textAlignment:(NSTextAlignment)textAlignment;

@end

#pragma mark -
#pragma mark - UITextField
@interface UITextField (Helper)

+ (UITextField *)textFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

@end

#pragma mark -
#pragma mark - UIImage
@interface UIImage (Helper)
/**
 纯色UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 剪切图片，从图片中心向边缘最大区域
 */
+ (UIImage *)getCutImageSize:(CGSize)size originalImage:(UIImage *)originalImage;

/**
 修改图片处理后旋转的问题
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end