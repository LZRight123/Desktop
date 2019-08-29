//
//  Person.m
//  runtime-custom_kvo
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
@implementation Person
const char *key = "ss";
void setterMethod(id self, SEL _cmd, NSString *name){
    //1.调用基类方法
    
    //2.通知观察者调通 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class]),
    };
    ((void(*)(id, SEL, id))objc_msgSendSuper)((__bridge id)(&superClass), _cmd, name);
    
    id observer = objc_getAssociatedObject(self, &key);
    //通知改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = @"";
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key:name}, nil);
    
    
}
NSString *getValueKey(NSString *setter){
    NSRange range = NSMakeRange(3, setter.length  - 4);
    NSString *key = [setter substringWithRange:range];
    NSString *letter = [[key substringFromIndex:1] lowercaseString];
    
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}

- (void)lz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //创建一个类
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@", oldName];
    
    Class  customClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
    objc_registerClassPair(customClass);
    
    //2.修改isa指针
    object_setClass(self, customClass);
    
    //重写set方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:", keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
    
    objc_setAssociatedObject(self, &key, observer,  OBJC_ASSOCIATION_ASSIGN);
}
@end
