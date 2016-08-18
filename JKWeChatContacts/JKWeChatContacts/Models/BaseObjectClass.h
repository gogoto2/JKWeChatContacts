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


- (void)setSqLiteID:(NSInteger)sqLiteID;
- (NSInteger)sqLiteID;

@end
