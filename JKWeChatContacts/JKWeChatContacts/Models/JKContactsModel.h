//
//  JKContactsModel.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "BaseObjectClass.h"

@interface JKContactsModel : BaseObjectClass

/**    名字    */
@property (nonatomic, copy) NSString * name;
/**    拼音    */
@property (nonatomic, copy) NSString * pinyin;
/**    头像    */
@property (nonatomic, copy) NSString * face;
/**    关键字（没啥用）    */
@property (nonatomic, copy) NSString * keywords;
/**    号码（随机数）    */
@property (nonatomic, copy) NSString * phone;
/**    数量（当账号用）    */
@property (nonatomic, copy) NSString * count;

+ (NSMutableArray *)loadMyContacts;


@end
