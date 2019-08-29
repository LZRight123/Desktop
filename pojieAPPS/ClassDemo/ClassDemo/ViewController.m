//
//  ViewController.m
//  ClassDemo
//
//  Created by 梁泽 on 2019/5/26.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()

@end

@class MyClass;

static void showHello(char *arg[]){
    printf("hellow %s",arg);
}

static void *funcs[] = {
    (void *)&showHello,
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    object_getClass(self);
    showHello("liangze");
//    class_createInstance(<#Class  _Nullable __unsafe_unretained cls#>, <#size_t extraBytes#>)
    ((void(*)(char *))funcs[0])("liangze2");
    void *func1 = funcs[0];
    ((void(*)(char *))func1)("liangze3");
    
//    MyClass *my = ((MyClass *(*)(id, SEL)(void *)objc_msgSend)((id)((MyClass *(*)(id, SEL)(void *)objc_msgsend)((id)objc_getClass("MyClass"), sel_registerName("alloc")), sel_registerName("init")));
//    MyClass *my = ((MyClass *(*)(id, SEL))(void *)objc_msgSend)((id)((MyClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("MyClass"), sel_registerName("alloc")), sel_registerName("init"));
//    MyClass *m2 = ((MyClass *(*)(id, SEL))objc_msgSend)((id)objc_getClass("MyClass"), sel_registerName("alloc"));
}


@end
