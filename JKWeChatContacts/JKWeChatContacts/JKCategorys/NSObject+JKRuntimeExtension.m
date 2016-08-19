//
//  NSObject+JKRuntimeExtension.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/16.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "NSObject+JKRuntimeExtension.h"
#import "BaseObjectClass.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (JKRuntimeExtension)

- (NSDictionary *)dictionaryFromModel{
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
    free(properties);//class_copyPropertyList一定要释放
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
    free(properties);//class_copyPropertyList一定要释放
    return [propertyArray copy];
}


+ (instancetype)model{
    return [[self alloc]init];
}


#pragma mark - 方法转换

+ (void)exchangeMethodForCurrentClassWithOriginalSEL:(SEL)originalSEL replaceSEL:(SEL)replaceSEL{
    Method originalMethod = class_getInstanceMethod(self, originalSEL);
    Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
    
    // 将customMethod的实现添加到systemMethod中，如果返回YES，说明没有实现customMethod，返回NO，已经实现了该方法
    BOOL add = class_addMethod(self, originalSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
    if (add) {
        // 没有实现customMethod,则需要将customMethod的实现指针换回systemMethod的
        class_replaceMethod(self, replaceSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        // 已经实现customMethod，则对systemMethod和customMethod的实现指针IMP进行交换
        // 交换一次就行，多次交换会出现混乱
        method_exchangeImplementations(originalMethod, replaceMethod);
    }
}



- (NSString *)sqlStringForInsertDatabaseWithTableName:(NSString *)tableName{
    NSDictionary * modelDict = [self dictionaryFromModel];
    NSMutableString * excuteString = [[NSMutableString alloc]initWithString:@"insert into "];
    [excuteString appendFormat:@"%@ (",tableName];
    
    NSMutableString * subString = [NSMutableString stringWithFormat:@"("];
    for (NSString * key in modelDict) {
        [excuteString appendFormat:@"%@,",key];
        [subString appendFormat:@"'%@',",modelDict[key]];
    }
    
    [excuteString deleteCharactersInRange:NSMakeRange(JSRangeForString(excuteString).length-1, 1)];
    [excuteString appendFormat:@") values "];
    [subString deleteCharactersInRange:NSMakeRange(JSRangeForString(subString).length-1, 1)];
    [subString appendFormat:@")"];
    [excuteString appendFormat:@"%@",subString];
    return excuteString.copy;
}





















/** 有BUG，不要用
 *  Tips：用于A-B 2个类之间替换方法，在自定义的替换方法replaceSEL实现中，self是targetClass对象，并不是当前类对象。所以要用当前类的对象调用originalSEL。建议放在+(void)load方法或者单例Block中使用
 *
 *  @param targetClass 被替换方法的类
 *  @param originalSEL 被替换的目标SEL
 *  @param replaceSEL  用于替换的自定义SEL
 */
//+ (void)exchangeMethodBetweenCurrentClassAndAnotherClass:(Class)targetClass originalSEL:(SEL)originalSEL replaceSEL:(SEL)replaceSEL{
//    Method originalMethod = class_getInstanceMethod(targetClass, originalSEL);
//    Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
//
//    BOOL add = class_addMethod(targetClass, originalSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
//    if (add) {
//        class_replaceMethod(targetClass, replaceSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    }else{
//        method_exchangeImplementations(originalMethod, replaceMethod);
//    }
//}
//- (BOOL)jk_prefersStatusBarHidden{
//    // 这里面的self = IMChatViewController对象，无法调用JKPhotoManager里面的方法
//    if ([JKPhotoManager sharedPhoneManager].exchangeMethod) {
//        return [JKPhotoManager sharedPhoneManager].hidesStatusBar;
//    }else{
//        if ([self respondsToSelector:@selector(jk_prefersStatusBarHidden)]) {
//            return [self jk_prefersStatusBarHidden];
//        }else {
//            return [[JKPhotoManager sharedPhoneManager] jk_prefersStatusBarHidden];
//        }
//    }
//}
@end
