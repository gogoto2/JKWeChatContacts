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
#define NSLog(...) NSLog(@"%s [行数:%d] \n  %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define JKLog(...)
#define NSLog(...)
#endif


#define JSRangeForString(string)        (NSMakeRange(0, (string).length))

static NSString * const kJKContactsTableName = @"JKContacts";

#endif /* JKImportHeader_h */
