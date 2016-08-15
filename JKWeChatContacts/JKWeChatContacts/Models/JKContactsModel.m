//
//  JKContactsModel.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKContactsModel.h"
#import "NSString+JKExtension.h"

@implementation JKContactsModel

+ (NSMutableArray *)loadMyContacts{
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"TempContacts" ofType:@"plist"];
    NSArray * array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSMutableArray * modelsArray = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        JKContactsModel * model = [JKContactsModel modelWithDictionary:dict];
        model.pinyin = model.name.pinyin;
        [modelsArray addObject:model];
    }
    return modelsArray;
}

@end
