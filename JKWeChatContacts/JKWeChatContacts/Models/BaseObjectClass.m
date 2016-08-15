//
//  BaseObejectClass.m
//  JKWeChatContacts
//
//  Created by iMac1 on 16/2/26.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "BaseObjectClass.h"
#import <objc/runtime.h>
#import <objc/message.h>

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



- (NSDictionary *)dictionaryFromModel {
    NSMutableDictionary * mutDict = [[NSMutableDictionary alloc]init];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //id value = [self valueForKey:name];
        
        SEL getter = NSSelectorFromString(name);
        if ([self respondsToSelector:getter]) {
            //id value = [self performSelector:getter];
            id value = [self valueForKey:name];
            if (value) {
                [mutDict setObject:value forKey:name];
            }
        }
    }
    free(properties);
    return [mutDict copy];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict{
    BaseObjectClass * object = [[self alloc]init];
    for (NSString * key in [dict allKeys]) {
        SEL getter = NSSelectorFromString(key);
        if ([object respondsToSelector:getter]) {
            
            id value = dict[key];
            
            if ([value isKindOfClass:[NSNumber class]]) {
                [object setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
                
            }else {
                [object setValue:value forKey:key];
            }
        }
    }
    return object;
}


+ (NSArray *)propertyArrayFromModel{
    NSMutableArray * propertyArray = [[NSMutableArray alloc]init];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        [propertyArray addObject:name];
    }
    free(properties);
    return [propertyArray copy];
}

- (void)setSqLiteID:(NSInteger)sqLiteID{
    _sqLiteID = sqLiteID;
}

- (NSInteger)sqLiteID{
    return _sqLiteID;
}

+ (instancetype)model{
    return [[self alloc]init];
}


@end
