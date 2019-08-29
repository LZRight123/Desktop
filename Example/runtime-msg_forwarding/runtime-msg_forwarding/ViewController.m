//
//  ViewController.m
//  runtime-msg_forwarding
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "MyClass.h"
@interface ViewController ()
//
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[MyClass new] sendMessage:@"liangze"];
    ((void(*)(id, SEL, id))(void *)objc_msgSend)([MyClass new], sel_registerName("sendMessage:"), @"liangze");
}


@end
