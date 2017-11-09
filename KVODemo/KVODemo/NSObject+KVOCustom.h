//
//  NSObject+KVOCustom.h
//  KVODemo
//
//  Created by He Bob on 2017/11/7.
//  Copyright © 2017年 He Bob. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ChangeHanlderBlk)(void);

@interface NSObject (KVOCustom)

- (void)KVOCustom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath ChangeHanlder:(ChangeHanlderBlk)handler;

@end
