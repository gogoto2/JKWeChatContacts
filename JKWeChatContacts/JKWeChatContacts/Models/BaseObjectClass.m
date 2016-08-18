//
//  BaseObejectClass.m
//  JKWeChatContacts
//
//  Created by iMac1 on 16/2/26.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "BaseObjectClass.h"


@class IMGroupListModel;

@implementation BaseObjectClass

- (NSString *)description{
    NSMutableString * propertyString = [[NSMutableString alloc]initWithString:NSStringFromClass(self.class)];
    [propertyString appendString:@" description:\n"];
    NSDictionary * dict = [self dictionaryFromModel];
    for (NSString * key in dict) {
        [propertyString appendFormat:@"\t%@  :  %@\n",key,dict[key]];
    }
    return [propertyString copy];
}


- (void)setSqLiteID:(NSInteger)sqLiteID{
    _sqLiteID = sqLiteID;
}

- (NSInteger)sqLiteID{
    return _sqLiteID;
}




@end
