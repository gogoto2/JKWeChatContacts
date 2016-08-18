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

- (void)buildTableWithName:(NSString *)tableName modelClass:(__unsafe_unretained Class)modelClass;

- (void)insetIntoTableWithName:(NSString *)tableName withModels:(NSArray <BaseObjectClass *> *)models result:(void(^)(BOOL ret))result;

- (void)queryContactsWithResult:(JKDataBaseQueryResultBlock)result;
@end
