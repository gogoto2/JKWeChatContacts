//
//  JKDatabseManager.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/12.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKDatabseManager.h"

@interface JKDatabseManager ()

@property (nonatomic, strong)FMDatabaseQueue * databaseQueue;

@end

@implementation JKDatabseManager

+ (instancetype)sharedManager{
    static JKDatabseManager * manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[JKDatabseManager alloc]init];
    });
    return manager;
}
- (id)copy{
    return [JKDatabseManager sharedManager];
}
- (id)mutableCopy{
    return [JKDatabseManager sharedManager];
}


- (void)buildTableWithName:(NSString *)tableName modelClass:(__unsafe_unretained Class)modelClass{
    [self.databaseQueue inDatabase:^(FMDatabase *dataBase) {
        NSArray * propertyArray = [modelClass propertyArrayFromModel];
        NSMutableString * excuteString = [[NSMutableString alloc]initWithString:@"create table if not exists "];
        [excuteString appendFormat:@"%@(id INTEGER PRIMARY KEY AUTOINCREMENT",tableName];
        for (NSInteger index = 0; index < propertyArray.count; index ++) {
            NSString * key = propertyArray[index];
            [excuteString appendFormat:@", %@ text",key];//ivar_getTypeEncoding
        }
        [excuteString appendFormat:@")"];
        
        BOOL result = [dataBase executeUpdate:excuteString];
        if (!result) {
            NSLog(@"创建表失败 %@",tableName);
        }
        
    }];
}


- (void)insertIntoTableWithName:(NSString *)tableName withModels:(NSArray <BaseObjectClass *> *)models result:(void(^)(BOOL ret))result{
    dispatch_queue_t insertDatasQueue = dispatch_queue_create("JK.Database.InsertDatasQueue.SerialQueue",DISPATCH_QUEUE_SERIAL);
    dispatch_async(insertDatasQueue, ^{
        [self.databaseQueue inDatabase:^(FMDatabase *dataBase) {
            
            if (![dataBase executeUpdate:[NSString stringWithFormat:@"delete from %@",tableName]]) {
                JKLog(@"删除表所有数据失败");
            }
            BOOL ret = NO;
            
            for (NSInteger index = 0; index < models.count; index ++) {
                @autoreleasepool {
                    BaseObjectClass * model = models[index];
                    NSString * excuteString = [model sqlStringForInsertDatabaseWithTableName:tableName];
                    
                    ret = [dataBase executeUpdate:excuteString];
                    if (!ret) {
                        JKLog(@"2.插入表%@失败，model:%@",tableName, model);
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    result(ret);
                }
            });
        }];
    });
}


- (void)queryContactsWithResult:(JKDataBaseQueryResultBlock)result{
    dispatch_queue_t mySerialQueue = dispatch_queue_create("JK.Database.ContactsQuery.SerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(mySerialQueue, ^{
        typeof(self) weakself = self;
        [self.databaseQueue inDatabase:^(FMDatabase *database) {
            NSString * query = [NSString stringWithFormat:@"select * from %@ ",kJKContactsTableName];
            [weakself queryInDatabase:database queryString:query resultModelClass:JKContactsModel.class resultBlock:result];
        }];
    });
}

- (void)queryInDatabase:(FMDatabase *)database queryString:(NSString *)query resultModelClass:(Class)aClass resultBlock:(JKDataBaseQueryResultBlock)result{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
    FMResultSet * resultSet = [database executeQuery:query];
    NSError * error = nil;
    while ([resultSet nextWithError:&error]) {
        BaseObjectClass * model = [[[aClass class] alloc]init];
        NSInteger sqliteid = (NSInteger)[resultSet longLongIntForColumn:@"id"];
        model.sqLiteID = sqliteid;
        NSArray * propertys = [aClass propertyArrayFromModel];
        
        for (NSString * key in propertys) {
            [model setValue:[resultSet stringForColumn:key] forKey:key];
        }
        [dataArray addObject:model];
    }
    if (error) {
        JKLog(@"数据库查询出错  %@",error);
    }
    [resultSet close];
    if ([NSThread currentThread] == [NSThread mainThread]) {
        result(dataArray);
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            result(dataArray);
        });
    }
}



- (void)fuzzyQueryFriendListWithKeyWord:(NSString *)keyword result:(JKDataBaseQueryResultBlock)result{
    dispatch_queue_t fuzzyQueryQueue = dispatch_queue_create("JK.Database.FuzzyQueryContacts.SerialQueue",DISPATCH_QUEUE_SERIAL);
    dispatch_async(fuzzyQueryQueue, ^{
        WEAK(self);
        [self.databaseQueue inDatabase:^(FMDatabase *database) {
            NSString * query = [NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' or pinyin like '%%%@%%' or phone like '%%%@%%' or count like '%%%@%%'",kJKContactsTableName,keyword,keyword,keyword,keyword];
            [weakself queryInDatabase:database queryString:query resultModelClass:[JKContactsModel class] resultBlock:result];
        }];
    });
}


#pragma mark - 懒加载
- (FMDatabaseQueue *)databaseQueue{
    if (!_databaseQueue) {
        NSString * path = [NSString pathWithDatabaseName:[NSString stringWithFormat:@"JKDatabase%zd",2016]];
        _databaseQueue = [[FMDatabaseQueue alloc]initWithPath:path];
    }
    return _databaseQueue;
}
@end
