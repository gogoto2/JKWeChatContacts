//
//  JKImportHeader.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#ifndef JKImportHeader_h
#define JKImportHeader_h


#pragma mark - Log打印[宏]

#ifdef  DEBUG
#define JKLog(...) NSLog(@"%s [行数:%d] \n  %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define JKLog(...)
#define NSLog(...)
#endif



#define JKThemeColor [UIColor colorWithRed:12/255.0 green:196/255.0 blue:120/255.0 alpha:1]
#define JKScreenWidth       [UIScreen mainScreen].bounds.size.width

#define WEAK(objct) typeof(objct) __weak weak##objct = objct
#define STRONG(objct) typeof(weak##objct) __strong objct = weak##objct
#define JSRangeForString(string)        (NSMakeRange(0, (string).length))





static NSString * const kJKContactsTableName = @"JKContacts";

#endif /* JKImportHeader_h */
