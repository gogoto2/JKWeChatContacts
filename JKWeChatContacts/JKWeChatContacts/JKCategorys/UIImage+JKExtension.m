//
//  UIImage+JKExtension.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "UIImage+JKExtension.h"

@implementation UIImage (JKExtension)

+ (UIImage *)imageWithRGBColor:(UIColor *)color imageSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor
                       cornerRadius:(CGFloat)radius{
    CGFloat scale = [UIScreen mainScreen].scale;
    size = CGSizeMake(size.width * scale, size.height * scale);
    radius *= scale;
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(radius, 0)];
    [bPath addLineToPoint:CGPointMake(size.width - radius, 0)];
    [bPath addArcWithCenter:CGPointMake(size.width - radius, radius)
                     radius:radius startAngle:M_PI * 1.5
                   endAngle:M_PI * 2.0 clockwise:YES];
    [bPath addLineToPoint:CGPointMake(size.width, size.height - radius)];
    [bPath addArcWithCenter:CGPointMake(size.width - radius, size.height - radius)
                     radius:radius startAngle:0
                   endAngle:M_PI * 0.5 clockwise:YES];
    [bPath addLineToPoint:CGPointMake(radius, size.height)];
    [bPath addArcWithCenter:CGPointMake(radius, size.height - radius)
                     radius:radius startAngle:M_PI * 0.5
                   endAngle:M_PI clockwise:YES];
    [bPath addLineToPoint:CGPointMake(0, radius)];
    [bPath addArcWithCenter:CGPointMake(radius, radius)
                     radius:radius startAngle:M_PI
                   endAngle:M_PI * 1.5 clockwise:YES];
    [fillColor setFill];
    [bPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)roundRectBorderImageWithSize:(CGSize)size
                             cornerRadius:(CGFloat)cornerRadius
                                fillColor:(UIColor *)fillColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth{
    CGFloat scale = [UIScreen mainScreen].scale;
    size = CGSizeMake(size.width * scale, size.height * scale);
    borderWidth *= scale;
    cornerRadius *= scale;
    UIGraphicsBeginImageContext(size);
    
    CGPoint point00 = CGPointMake(cornerRadius, borderWidth);
    CGPoint point01 = CGPointMake(size.width - cornerRadius, borderWidth);
    
    CGPoint center1 = CGPointMake(size.width - cornerRadius, cornerRadius);
    CGPoint point10 = CGPointMake(size.width - borderWidth, size.height - cornerRadius);
    
    CGPoint center2 = CGPointMake(size.width - cornerRadius, size.height - cornerRadius);
    CGPoint point20 = CGPointMake(cornerRadius, size.height - borderWidth);
    
    CGPoint center3 = CGPointMake(cornerRadius, size.height - cornerRadius);
    CGPoint point30 = CGPointMake(borderWidth, cornerRadius);
    
    CGPoint center0 = CGPointMake(cornerRadius, cornerRadius);
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:point00];
    [bPath addLineToPoint:point01];
    
    [bPath addArcWithCenter:center1
                     radius:cornerRadius - borderWidth
                 startAngle:M_PI_2 * 3
                   endAngle:M_PI_2 * 4
                  clockwise:YES];
    [bPath addLineToPoint:point10];
    
    [bPath addArcWithCenter:center2
                     radius:cornerRadius - borderWidth
                 startAngle:0
                   endAngle:M_PI_2
                  clockwise:YES];
    [bPath addLineToPoint:point20];
    
    [bPath addArcWithCenter:center3
                     radius:cornerRadius - borderWidth
                 startAngle:M_PI_2
                   endAngle:M_PI
                  clockwise:YES];
    [bPath addLineToPoint:point30];
    
    [bPath addArcWithCenter:center0
                     radius:cornerRadius - borderWidth
                 startAngle:M_PI
                   endAngle:M_PI_2 * 3
                  clockwise:YES];
    
    [fillColor setFill];
    [bPath fill];
    
    [borderColor setStroke];
    bPath.lineWidth = borderWidth;
    [bPath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
