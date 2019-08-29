//
//  CustomProxy.m
//  NSTimer
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "CustomProxy.h"
@interface CustomProxy()
@property (nonatomic, weak  ) id target;
@end

@implementation CustomProxy
- (instancetype)initWithTarget:(id)target{
    self.target = target;
    return self;
}
+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}


@end
