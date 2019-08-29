//
//  main.m
//  ClassDemo
//
//  Created by 梁泽 on 2019/5/26.
//  Copyright © 2019 梁泽. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
//@interface MyClass : NSObject
//@property (nonatomic, strong) NSString *property;//
//@end
//
//@implementation MyClass
//
//- (void)myMethod{}
//
//+ (void)classMethod{}
//
//@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        return 0;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
