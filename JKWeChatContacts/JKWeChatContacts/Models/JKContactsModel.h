//
//  JKContactsModel.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "BaseObjectClass.h"

@interface JKContactsModel : BaseObjectClass

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * pinyin;
@property (nonatomic, copy) NSString * face;
@property (nonatomic, copy) NSString * keywords;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * count;

+ (NSMutableArray *)loadMyContacts;


@end
