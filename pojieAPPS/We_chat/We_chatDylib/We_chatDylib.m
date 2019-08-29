//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  We_chatDylib.m
//  We_chatDylib
//
//  Created by 梁泽 on 2019/8/4.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import "We_chatDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import "OCMethodTrace.h"


CHConstructor{
    printf(INSERT_SUCCESS_WELCOME);
    [@"" containsString:@""];
//    OCMethodTrace *trace = [OCMethodTrace sharedInstance];
//    [trace traceMethodWithClass:NSClassFromString(@"NSFileManager") condition:^BOOL(SEL sel) {
//        return true;
//    } before:^(id target, __unsafe_unretained Class cls, SEL sel, NSArray *args, int deep) {
//        NSLog(@"trace before");
//    } after:^(id target, __unsafe_unretained Class cls, SEL sel, id ret, int deep, NSTimeInterval interval) {
//        NSLog(@"trace after");
//    }];
}

