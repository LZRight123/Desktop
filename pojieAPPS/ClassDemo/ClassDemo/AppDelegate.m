//
//  AppDelegate.m
//  ClassDemo
//
//  Created by 梁泽 on 2019/5/26.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
@interface AppDelegate ()

@end


@interface MyClass : NSObject
@property (nonatomic, strong) NSString *property;//
@end

@implementation MyClass

- (void)myMethod{}

+ (void)classMethod{}

@end

void PrintMetaClass(Class aClass){
    NSLog(@"%@->%p",aClass, aClass);
    
    Class metaClass = object_getClass(aClass);
    
    if (metaClass != aClass) {
        PrintMetaClass(metaClass);
    }
    
}

@implementation AppDelegate



/*
 (lldb) p self
 (AppDelegate *) $0 = 0x00006000026f95c0
 (lldb) p sizeof(self)
 (unsigned long) $1 = 8
 (lldb) p sizeof(void *)
 (unsigned long) $2 = 8
 (lldb) p (int)class_getInstanceSize([AppDelegate class])
 (int) $3 = 24
 (lldb) memory read/3wg $0
 0x6000026f95c0: 0x0000000109acfd08 0x0000000000000000
 0x6000026f95d0: 0x00007fc9e3507360
 (lldb) p 0x0000000109acfd08
 (long) $4 = 4457299208
 (lldb) p (Class)0x0000000109acfd08 // isa
 (Class) $5 = AppDelegate          //isa = class
 (lldb) po 0x0000000000000000
 <nil>
 (lldb) po  0x00007fc9e3507360 //说明appdelaget有两个可用的成员变量
 <UIWindow: 0x7fc9e3507360; frame = (0 0; 375 812); hidden = YES; gestureRecognizers = <NSArray: 0x6000028bcf00>; layer = <UIWindowLayer: 0x6000026c3e60>>
 (lldb) x/3wg self    // memory read 命令的简写 x 
 0x6000026f95c0: 0x0000000109acfd08 0x0000000000000000
 0x6000026f95d0: 0x00007fc9e3507360
 (lldb) x/3wg $0
 0x6000026f95c0: 0x0000000109acfd08 0x0000000000000000
 0x6000026f95d0: 0x00007fc9e3507360

*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    PrintMetaClass([MyClass class]);
    // Override point for customization after application launch.


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
