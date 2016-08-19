//
//  NSString+JKExtension.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JKExtension)



/**    获取pinyin       */
- (NSString *)pinyin;


/**    计算文字的size    */
- (CGSize)sizeWithFont:(UIFont *)font;



/**    数据库路径    */
+ (NSString *)pathWithDatabaseName:(NSString *)databaseName;
@end
