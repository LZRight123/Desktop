//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  TestImonDylib.m
//  TestImonDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import "TestImonDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import "LZHelpTool.h"
#import "fishhook.h"

static void (*orig_checkInject)();
static void my_checkInject(){
    
}


CHConstructor{
    rebind_symbols((struct rebinding[1]){{"checkInject", my_checkInject, &orig_checkInject}}, 1);
}


