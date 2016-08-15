//
//  BaseObejectClass.h
//  JKWeChatContacts
//
//  Created by iMac1 on 16/2/26.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObjectClass : NSObject
{
    NSInteger _sqLiteID;
}
/**    模型转字典    */
@property (nonatomic, strong, readonly) NSDictionary *dictionaryFromModel;

/**    字典转模型(单层，全部转字符串)    */
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

/**    模型所有的属性名(只写setter和getter不会包含)    */
+ (NSArray *)propertyArrayFromModel;

/**    初始化方法    */
+ (instancetype)model;


- (void)setSqLiteID:(NSInteger)sqLiteID;
- (NSInteger)sqLiteID;

@end
