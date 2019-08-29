//
//  Security.h
//  asmuserlogin
//
//  Created by 梁泽 on 2019/5/29.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>

static void checkReCodeSign (void)
{
    NSString *mobileProvisionPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"embedded.mobileprovision"];
    FILE *fp=fopen([mobileProvisionPath UTF8String],"r");
    char ch;
    if(fp==NULL) {
        printf("file cannot be opened/n");
    }
    NSMutableString *str = [NSMutableString string];
    while((ch=fgetc(fp))!=EOF) {
        [str appendFormat:@"%c",ch];
    }
    fclose(fp);
    
    NSString *teamIdentifier = nil;
    NSRange teamIdentifierRange = [str rangeOfString:@"<key>com.apple.developer.team-identifier</key>"];
    if (teamIdentifierRange.location != NSNotFound) {
        NSInteger location = teamIdentifierRange.location + teamIdentifier.length;
        NSInteger length = [str length] - location;
        if (length > 0 && location >= 0) {
            NSString *newStr = [str substringWithRange:NSMakeRange(location, length)];;
            NSArray *val = [newStr componentsSeparatedByString:@"</string>"];
            NSString *v = [val firstObject];
            NSRange startRange = [v rangeOfString:@"<string>"];
            
            NSInteger newLocation = startRange.location + startRange.length;
            NSInteger newLength = [v length] - newLocation;
            if (newLength > 0 && location >= 0) {
                teamIdentifier = [v substringWithRange:NSMakeRange(newLocation, newLength)];
            }
        }
    }
    if (![teamIdentifier isEqualToString:@"58Y74FY8QK"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新到官方版本" message:@"检测到您的应用为非官方版本，请到appstore下载使用" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __asm__(
                        "mov X0, #0\n"
                        "mov w16, #1\n"
                        "svc #0x80\n"
                        );
            });
        });
    }
}

//尝试使用 NSFileManager 判断设备是否安装了如下越狱常用工具：
///Applications/Cydia.app /Library/MobileSubstrate/MobileSubstrate.dylib /bin/bash /usr/sbin/sshd /etc/apt
//但是不要写成 BOOL 开关方法，给攻击者直接锁定目标 hook 绕过的机会
//攻击者可能会改变这些工具的安装路径，躲过你的判断。
static void checkJailbroken1()
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新到官方版本" message:@"检测到您的应用为非官方版本，请到appstore下载使用" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
    }
}

//尝试打开 cydia 应用注册的 URL scheme：
static void checkJailbroken2()
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新到官方版本" message:@"检测到您的应用为非官方版本，请到appstore下载使用" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
    }
}

//但是不是所有的工具都会注册 URL scheme，而且攻击者可以修改任何应用的 URL scheme。
//那么，你可以尝试读取下应用列表，看看有无权限获取
static void checkJailbroken3()
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
//        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
//                                                                               error:nil];
//        NSLog(@"applist = %@",applist);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新到官方版本" message:@"检测到您的应用为非官方版本，请到appstore下载使用" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
    }
}

//回避 NSFileManager，使用 stat 系列函数检测 Cydia 等工具：
static void checkJailbroken4()
{
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        NSLog(@"Device is jailbroken");
    }
}

//攻击者可能会利用 Fishhook 原理 hook 了 stat 。
//那么，你可以看看 stat 是不是出自系统库，有没有被攻击者换掉：

static void checkInject(void)
{
    int ret ;
    Dl_info dylib_info;
    int    (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"lib :%s", dylib_info.dli_fname);
    }
}

//检索一下自己的应用程序是否被链接了异常动态库。 列出所有已链接的动态库
static void checkDylibs()
{
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
        NSLog(@"--%@", name);
    }
}

//通过检测当前程序运行的环境变量：
static void printEnv()
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
}
