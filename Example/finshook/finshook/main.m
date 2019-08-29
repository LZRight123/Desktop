//
//  main.m
//  finshook
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
static __attribute__((constructor))
void my_constructor(){
    printf("aaaa");
    printf("bbbb");
    printf("cccc");

    NSLog(@"constructer 执行了");
    NSLog(@"constructer 执行了2");
    NSLog(@"constructer 执行了3");

}

static __attribute__((destructor))
void my_destructor(){
    NSLog(@"my_dstructor 执行了");
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
