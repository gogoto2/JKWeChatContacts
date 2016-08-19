//
//  UIImage+JKExtension.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKExtension)
+ (UIImage *)imageWithRGBColor:(UIColor *)color imageSize:(CGSize)size;
+ (UIImage *)roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor
                       cornerRadius:(CGFloat)radius;
+ (UIImage *)roundRectBorderImageWithSize:(CGSize)size
                             cornerRadius:(CGFloat)cornerRadius
                                fillColor:(UIColor *)fillColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth;

- (void)roundImageWithCompletion:(void(^)(UIImage * cornerImage))block;
@end
