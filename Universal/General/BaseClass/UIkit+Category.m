//
//  UIkit+Category.m
//  Universal
//
//  Created by julius on 14/11/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "UIkit+Category.h"

@implementation UIkit_Category

@end

#pragma mark -
#pragma mark - UIView
@implementation UIView (Helper)

- (void)addLabelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize tag:(NSInteger)tag textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = (UILabel *)[self viewWithTag:tag];
    if (!label) {
        label = [UILabel labelWithRect:rect text:text textColor:textColor fontSize:fontSize textAlignment:textAlignment];
        label.backgroundColor = [UIColor clearColor];
        label.tag = tag;
        [self addSubview:label];
    }else{
        label.frame = rect;
        label.text = text;
        label.textColor = textColor;
    }
}



@end

#pragma mark -
#pragma mark - UIView
@implementation UILabel (Helper)

+ (UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    __autoreleasing UILabel *label = [[UILabel alloc]init];
    label.frame = rect;
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    return label;
}

@end

#pragma mark -
#pragma mark - UITextField
@implementation UITextField (Helper)

+ (UITextField *)textFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    __autoreleasing UITextField *textField = [[UITextField alloc]init];
    textField.frame = rect;
    textField.text = text;
    textField.textColor = textColor;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textAlignment = textAlignment;
    return textField;
}

@end

#pragma mark -
#pragma mark - UIImage
@implementation UIImage (Helper)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



//剪切图片(从中心算起）
+ (UIImage *)getCutImageSize:(CGSize)size originalImage:(UIImage *)originalImage{
    originalImage = [self fixOrientation:originalImage];
    CGRect rect = [self getCutRectWithBigSize:originalImage.size cutSize:size];
    CGImageRef imageRef = originalImage.CGImage;
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, cutImageRef);
    UIImage *cutImage = [UIImage imageWithCGImage:cutImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(cutImageRef);
    
    return cutImage;
}

//获取截图区域(从中心算起）
+ (CGRect)getCutRectWithBigSize:(CGSize)bigSize cutSize:(CGSize)cutSize{
    CGFloat scale = [self getCompressScaleWithBigSize:bigSize smallSize:cutSize];
    CGPoint bigPoint = CGPointMake(bigSize.width / 2.0f, bigSize.height / 2.0f);
    CGSize scaleSize = CGSizeMake(cutSize.width / scale, cutSize.height / scale);
    CGRect Rect = CGRectMake(bigPoint.x - scaleSize.width / 2.0f, bigPoint.y - scaleSize.height / 2.0f, scaleSize.width, scaleSize.height);
    return Rect;
}

//获取压缩比scale
+ (CGFloat)getCompressScaleWithBigSize:(CGSize)bigSize smallSize:(CGSize)smallSize{
    CGFloat scale;
    if (bigSize.height / bigSize.width >= smallSize.height / smallSize.width) {
        scale = smallSize.width / bigSize.width;
    }else{
        scale = smallSize.height / bigSize.height;
    }
    return scale;
}

//修改图片处理后旋转问题
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
