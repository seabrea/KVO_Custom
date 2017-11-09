//
//  ViewController.m
//  KVODemo
//
//  Created by He Bob on 2017/11/7.
//  Copyright © 2017年 He Bob. All rights reserved.
//

#import "ViewController.h"
#import "TestObj.h"
#import "NSObject+KVOCustom.h"

static int recordValue = 0;

@interface ViewController ()
@property (strong ,nonatomic) TestObj *testObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testObj = [[TestObj alloc] init];
    [self.testObj KVOCustom_addObserver:self forKeyPath:@"name" ChangeHanlder:^{
        NSLog(@"233");
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ++recordValue;
    NSLog(@"recordValue = %d",recordValue);
    self.testObj.name = [NSString stringWithFormat:@"%d",recordValue];
    NSLog(@"self.testObj.name = %@",self.testObj.name);
}

@end
