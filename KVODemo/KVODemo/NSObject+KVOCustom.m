//
//  NSObject+KVOCustom.m
//  KVODemo
//
//  Created by He Bob on 2017/11/7.
//  Copyright © 2017年 He Bob. All rights reserved.
//

#import "NSObject+KVOCustom.h"
#import <objc/message.h>

@implementation NSObject (KVOCustom)

- (void)KVOCustom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath ChangeHanlder:(ChangeHanlderBlk)handler {
    
    SEL keyPathSel = NSSelectorFromString([self setterForGetter:keyPath]);
    Method keyPathMethod = class_getInstanceMethod([self class], keyPathSel);
    if(!keyPathMethod) {
        @throw [NSException exceptionWithName:@"keyPathMethodNill" reason:@"set方法不存在" userInfo:nil];
    }
    
    Class selfClass = object_getClass(self);
    NSString *newClassNamee = [NSString stringWithFormat:@"%@_KVOCustomNotifier",NSStringFromClass(selfClass)];
    Class newClass = objc_allocateClassPair([self class], [newClassNamee UTF8String], 0);
    class_addMethod(newClass, @selector(setName:), (IMP)setName, "");
    objc_registerClassPair(newClass);
    object_setClass(self, newClass);
}

void setName(id self, SEL _cmd, id newValue) {
    Class myclass = [self class];
    object_setClass(self, class_getSuperclass([self class]));
    objc_msgSend(self, @selector(setName:),newValue);
    object_setClass(self, myclass);
}

- (NSString *)setterForGetter:(NSString *)getter {
    NSMutableString *setterString = [getter mutableCopy];
    NSString *firstCharacter = [[getter substringToIndex:1] capitalizedString];
    [setterString replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter];
    [setterString insertString:@"set" atIndex:0];
    [setterString appendString:@":"];
    return setterString;
}

@end
