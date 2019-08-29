//
//  AppDelegate.m
//  EmptyTest
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "AppDelegate.h"
int global_array[3];

@interface AppDelegate ()

@end

struct Custom_struct{
    int age;
    char *sex;
    char *description;
    char *tizhong;
    NSString *shenggao;
};

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *arr = @[@"value1", @"value2", @"value3", @"value4"];
    NSString *text = arr[3];
    
    NSDictionary *dic = @{
                          @"key1" : @"value1",
                           @"key2" : @"value2",
                           @"key3" : @"value3",
                           @"key4" : @"value4",
                          };
    NSString *text2 = dic[@"key2"];
    
    struct Custom_struct a;
    a.age = 30;
    a.sex = "男";
    a.description = "是个好人";
    a.tizhong = "60";
    a.shenggao = @"170";
    printf(a.description);
    
    
    // Override point for customization after application launch.
    return YES;
}




- (void)ida_chart8_arr{
    int arr_demo[100];
    
    int bytes = 100 * sizeof(int);
    
    arr_demo[20] = 15;
    for (int i = 0; i< 100; i++) {
        arr_demo[i] = i;
    }
    
    int idx = 2;
    global_array[0] = 10;
    global_array[1] = 20;
    global_array[2] = 30;
    global_array[idx] = 40;

}

@end
