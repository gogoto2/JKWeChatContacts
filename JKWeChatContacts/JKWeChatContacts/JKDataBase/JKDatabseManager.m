//
//  JKDatabseManager.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/12.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKDatabseManager.h"

@interface JKDatabseManager ()



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


@end
