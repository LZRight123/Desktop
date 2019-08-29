//
//  MyClass.m
//  runtime-msg_forwarding
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "MyClass.h"
#import <objc/message.h>
#import "forwardingClass.h"
@implementation MyClass

void send_msg(id self, SEL _cmd, NSString *msg){
    NSLog(@"hello %@",msg);
}

//一， 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"一， 动态方法解析");
//    1,匹配方法
//    const char * s = sel_getName(sel);
//    if (strcmp(s, "sendMessage:") == 0) {
//         BOOL r = class_addMethod(self, sel, (IMP)send_msg, "v@:@");
//        return r;
//    }
    return [super respondsToSelector:sel];
}

//二， 快速转发 ，找备用接收者
- (id)forwardingTargetForSelector:(SEL)sel{
    NSLog(@"二， 快速转发");
    //1,匹配方法
//    const char * s = sel_getName(sel);
//    if (strcmp(s, "sendMessage:") == 0){
//        return [forwardingClass new];
//    }
    return [super forwardingTargetForSelector:sel];
}

//三，慢速转发  越靠后 系统开销越大
//1,方法签名  把当前方法的具体信息 保存起来
//2，消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSLog(@"准备慢速转发");
    const char * s = sel_getName(sel);
    if (strcmp(s, "sendMessage:") == 0){
        NSMethodSignature *r =  [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return r;
    }

    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"开始慢速转发");
//    SEL sel = anInvocation.selector;
//    forwardingClass *tempobj = [forwardingClass new];
//    if ([tempobj respondsToSelector:sel_registerName("sendMessage:")]) {
//        [anInvocation invokeWithTarget:tempobj];
//    }
    [super forwardInvocation:anInvocation];
}

//都没处理掉的话会调用
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"找不到方法 不让崩溃");
}



@end
