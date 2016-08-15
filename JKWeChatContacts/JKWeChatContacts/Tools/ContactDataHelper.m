//
//  ContactDataHelper.m
//  JKWeChatContacts
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "ContactDataHelper.h"
#import "JKContactsModel.h"
#import <UIKit/UIKit.h>

@implementation ContactDataHelper

+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    // 排序
    NSArray *serializeArray = [(NSArray *)array sortedArrayUsingComparator:^NSComparisonResult(JKContactsModel * obj1, JKContactsModel * obj2) {//排序
        NSString *strA = obj1.pinyin;
        NSString *strB = obj2.pinyin;
        
        for (int index = 0; index < MIN(strA.length, strB.length); index ++) {
            char a = [strA characterAtIndex:index];
            char b = [strB characterAtIndex:index];
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;// 上升
            } else if (a < b) {
                return (NSComparisonResult)NSOrderedAscending;// 下降
            }
        }
        
        if (strA.length == strB.length) {
            return (NSComparisonResult)NSOrderedSame;
        }else if (strA.length < strB.length){
            return (NSComparisonResult)NSOrderedAscending;
        }else{
            return (NSComparisonResult)NSOrderedDescending;
        }
    }];
    
    char lastC = '1';
    NSMutableArray *datas;
    NSMutableArray *other = [[NSMutableArray alloc] init];
    for (JKContactsModel * user in serializeArray) {
        char c = [user.pinyin characterAtIndex:0];
        if (!isalpha(c)) {
            [other addObject:user];
        } else if (c != lastC){
            lastC = c;
            if (datas && datas.count > 0) {
                [result addObject:datas];
            }
            
            datas = [[NSMutableArray alloc] init];
            [datas addObject:user];
        } else {
            [datas addObject:user];
        }
    }
    
    if (datas && datas.count > 0) {
        [result addObject:datas];
    }
    if (other.count > 0) {
        [result addObject:other];
    }
    return result;
}

+ (NSMutableArray *)getFriendListSectionBy:(NSMutableArray *)array addSearchFlag:(BOOL)searchFlag{
    NSMutableArray *section = [[NSMutableArray alloc] init];
    if (searchFlag) {
        [section addObject:UITableViewIndexSearch];
    }
    
    for (int index = 0; index < array.count; index ++) {
        NSArray * item = array[index];
        JKContactsModel * user = [item objectAtIndex:0];
        char c = [user.pinyin characterAtIndex:0];
        
        if (!isalpha(c)) {
            c = '#';
        }
        [section addObject:[NSString stringWithFormat:@"%c", toupper(c)]];
    }
    return section;
}


@end
