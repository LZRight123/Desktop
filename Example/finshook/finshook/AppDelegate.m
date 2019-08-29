//
//  AppDelegate.m
//  finshook
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "AppDelegate.h"
#import "fishhook.h"
#import <mach-o/loader.h>

static void (*orig_NSLog)(NSString *format, ...);
static void new_NSLog(NSString *format, ...){
    va_list args;
    va_start(args, format);
    NSString *n_format = [NSString stringWithFormat:@"[函数名:%@]" "[行号:%d] --- %@", [[NSString stringWithUTF8String:__FILE__] componentsSeparatedByString:@"/"].lastObject, __LINE__, format];
    orig_NSLog(n_format, args);
    va_end(args);
}
void customFunc(){
    NSLog(@"我是自定义函数");
}
static void(*orig_customFunc)();
static void new_customFunc(){
    NSLog(@"我是替换了自定义函数");
}

static const char *(*orig_strstr)(const char *s1, const char *s2);
static const char *my_strstr(const char *s1, const char *s2){
    return orig_strstr(s1, s2);
}



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    struct segment_command s_c = {};
    
    customFunc();
    rebind_symbols((struct rebinding [1]){
        {"customFunc", new_customFunc, (void *)&orig_customFunc}
    }, 1);
    customFunc();
    
    NSLog(@"我是nslog");
    
    rebind_symbols((struct rebinding [1]){
        {"NSLog", new_NSLog, (void *)&orig_NSLog}
    }, 1);
    
    NSLog(@"我也是nslog");
    
    printf(strstr("one", "oe") != NULL ? strstr("one", "oe") : "null");
    
    rebind_symbols((struct rebinding[1]){
        {"strstr", my_strstr, (void *)&orig_strstr},
    }, 1);

    printf(strstr("two", "w"));

    return YES;
}



@end
