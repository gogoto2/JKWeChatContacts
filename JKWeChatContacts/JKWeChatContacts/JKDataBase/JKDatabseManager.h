//
//  JKDatabseManager.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/12.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "BaseObjectClass.h"

typedef void (^JKDataBaseQueryResultBlock)(NSMutableArray * dataArray);




@interface JKDatabseManager : NSObject
+ (instancetype)sharedManager;


/**    根据Model建表，model的属性对应表中的字段    */
- (void)buildTableWithName:(NSString *)tableName modelClass:(__unsafe_unretained Class)modelClass;


/**    插入数据，传model数组,先删除再插入    */
- (void)insertIntoTableWithName:(NSString *)tableName withModels:(NSArray <BaseObjectClass *> *)models result:(void(^)(BOOL ret))result;


/**    查询所有的联系人，返回model数组    */
- (void)queryContactsWithResult:(JKDataBaseQueryResultBlock)result;


/**    模糊查询(name/pinyin/phone/count)    */
- (void)fuzzyQueryFriendListWithKeyWord:(NSString *)keyword result:(JKDataBaseQueryResultBlock)result;
@end
