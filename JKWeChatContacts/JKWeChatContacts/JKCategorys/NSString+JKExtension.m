//
//  NSString+JKExtension.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "NSString+JKExtension.h"



@implementation NSString (JKExtension)
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

- (CGSize)sizeWithFont:(UIFont *)font{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
