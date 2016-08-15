//
//  ContactDataHelper.h
//  JKWeChatContacts
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContactDataHelper : NSObject


+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array;
+ (NSMutableArray *)getFriendListSectionBy:(NSMutableArray *)array addSearchFlag:(BOOL)searchFlag;

@end
