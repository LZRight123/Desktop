//
//  AppDelegate.m
//  AntiJailbreak
//
//  Created by 梁泽 on 2019/6/19.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "AppDelegate.h"
#import "HookTool.h"
#import "DataSource.h"
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <objc/runtime.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import <sys/syscall.h> //有500多个系统函数，都有其编号
#pragma mark -
#pragma mark - 调试
#import <unistd.h>
#import <sys/ioctl.h>
#include <mach/mach_init.h>
#include <mach/vm_map.h>
#import <stdlib.h>

#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
#import <sys/types.h>

// For debugger_sysctl
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <stdlib.h>

// For ioctl
#include <termios.h>
#include <sys/ioctl.h>

// For task_get_exception_ports
#include <mach/task.h>
#include <mach/mach_init.h>

#import "SecurityCheck.h"


#pragma mark -
#pragma mark - 防护函数
#pragma mark -
#pragma mark - 检测能否打开特定app
void checkOpenCydia(){
    UIColor *color = randomColor();
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]){
        [DataSourceManager addReason:[Model text:@"[UIApplication sharedApplication]\nUIApplication canOpenURL:@\"cydia://\"" color:color]];
    }
}

#pragma mark -
#pragma mark - 检测文件
static inline void checkFileExistsAtPath() __attribute__ ((always_inline))
{
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"[NSFileManager defaultManager]\nfileExistsAtPath:%@",path] color:color]];
        }
    }
}

void checkfileExistsAtPathIsDirectory(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        BOOL isDirectory;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"[NSFileManager defaultManager]\nfileExistsAtPath:%@:isDirectory",path] color:color]];
        }
    }
}

void checkcontentsAtPath(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        if ([[NSFileManager defaultManager] contentsAtPath:path]) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"[NSFileManager defaultManager]\ncontentsAtPath:%@",path] color:color]];
        }
    }
}

void checkcontentsOfDirectoryAtPath(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        NSError *error;
        if ([[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error]) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"[NSFileManager defaultManager]\ncontentsOfDirectoryAtPath:%@",path] color:color]];
        }
    }
}

void checkfopen(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        const char *__path = [path UTF8String];
        FILE *fp = fopen(__path, "r");
        if(fp != NULL){
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"FILE->fopen\nfopen!=NULL:%@",path] color:color]];
        }
        fclose(fp);
    }
}


#pragma mark -
#pragma mark -  stat 系列函数检测 Cydia等工具
void checkStat(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        const char *__path = [path UTF8String];
        struct stat stat_info;
        if (0 == stat(__path, &stat_info)) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"stat 检测到:%@",path] color:color]];
        }
    }
}

void checklstat(){
    UIColor *color = randomColor();
    for (NSString *path in jailbreakFileAtPath()) {
        const char *__path = [path UTF8String];
        struct stat stat_info;
        int ret = lstat(__path, &stat_info);
        bool isJailbreak = false;
//        if (0 == ret) {
//            isJailbreak = true;
//        }
        if (stat_info.st_mode & S_IFLNK) {
            isJailbreak = true;
        }
        
//        access(<#const char *#>, <#int#>)
        if (isJailbreak) {
            [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"stat 检测到:%@",path] color:color]];
        }
    }
}

void  chekcaccess(){
    for (NSString *path in jailbreakFileAtPath()) {
        int r = access(path.UTF8String, 1);
        NSLog(@"===== %d",r);
    }
}


#pragma mark -
#pragma mark - getenv 查看当前程序运行的环境变量
void checkgetenv(){
    UIColor *color = randomColor();

    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env) {
        assert("DYLD_INSERT_LIBRARIES");
        [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"getenv DYLD_INSERT_LIBRARIES"] color:color]];
    }
}


#pragma mark -
#pragma mark - 检索一下自己的应用程序是否被链接了异常动态库。 列出所有已链接的动态库
void checkDylibs(){
    UIColor *color = randomColor();
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        char * name = _dyld_get_image_name(i);
        NSString *result = [[NSString alloc]initWithUTF8String:name];
        for (NSString *str in jailbreakFileAtPath()){
            if ([result.lowercaseString isEqualToString:str.lowercaseString]){
                result =  [NSString stringWithFormat:@"是想hook '%@' 吗？", result];
                [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"_dyld_get_image_name %@",str] color:color]];
            }
       }
    }
}

#pragma mark -
#pragma mark - 看函数出自哪个裤
static inline void checkInject(void) __attribute__ ((always_inline));
void checkInject(void)
{
    UIColor *color = randomColor();
    
    CFArrayRef (*func_CFNetworkCopyProxiesForURL)(CFURLRef , CFDictionaryRef) = CFNetworkCopyProxiesForURL;
    CFDictionaryRef (*func_CFNetworkCopySystemProxySettings)() = CFNetworkCopySystemProxySettings;

    int (*func_ptrace)(int ,pid_t , caddr_t ,int ) = ptrace;
    void* (*func_dlsym)(void * , const char* ) = dlsym;
    int (*func_sysctl)(int *,u_int, void*, size_t*,void*, size_t) = sysctl;
    int (*func_syscall)(int, ...) = syscall;
    int (*func_isatty)(int) = isatty;
    int (*func_ioctl)(int, unsigned long, ...) = ioctl;
    kern_return_t (*func_task_get_exception_ports)
    (
     task_inspect_t ,
     exception_mask_t ,
     exception_mask_array_t ,
     mach_msg_type_number_t *,
     exception_handler_array_t ,
     exception_behavior_array_t ,
     exception_flavor_array_t
     ) = task_get_exception_ports;
    
    char *(*func_strstr)(const char *, const char *) = strstr;
    int (*func_dladdr)(const void *, Dl_info *) = dladdr;
    FILE *(*func_fopen)(const char *, const char *) = fopen;
    int (*func_open)(const char *, int, ...) = open;
    int (*func_access)(const char *, int) = access;
    int (*func_stat)(const char *, struct stat *) = stat;
    int (*func_lstat)(const char *, struct stat *) = lstat;
    char *(*func_getenv)(const char *) = getenv;
    uint32_t (*func__dyld_image_count)(void) = _dyld_image_count;
    char *(*func__dyld_get_image_name)(uint32_t) = _dyld_get_image_name;
    //system
    int (*func_creat)(const char *, mode_t) = creat;
    int (*func_openat)(int, const char *, int, ...) = openat;
    pid_t (*func_fork)(void) = fork;
    FILE *(*func_popen)(const char *, const char *) = popen;

    void *arr[] = {
        func_CFNetworkCopyProxiesForURL,
        func_CFNetworkCopySystemProxySettings,
        
        func_ptrace,
        func_dlsym,
        func_sysctl,
        func_syscall,
        func_isatty,
        func_ioctl,
        func_task_get_exception_ports,
        
        func_strstr,
        func_dladdr,
        func_fopen,
        func_open,
        func_access,
        func_stat,
        func_lstat,
        func_getenv,
        func__dyld_image_count,
        func__dyld_get_image_name,
        func_creat,
        func_openat,
        func_fork,
        func_popen
    };
    char *funcs[] = {
        "CFNetworkCopyProxiesForURL",
        "CFNetworkCopySystemProxySettings",
        
        "ptrace",
        "dlsym",
        "sysctl",
        "syscall",
        "isatty",
        "ioctl",
        "task_get_exception_ports",
        
        "strstr",
        "dladdr",
        "fopen",
        "open",
        "access",
        "stat",
        "lstat",
        "getenv",
        "_dyld_image_count",
        "_dyld_get_image_name",
        "creat",
        "openat",
        "fork",
        "popen"
    };
    
    int count = sizeof(arr)/sizeof(arr[0]);
    for (int i = 0; i < count; i++) {
        Dl_info dylib_info;
        dladdr(arr[i], &dylib_info);
        
        [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"%s\n%s",funcs[i] ,dylib_info.dli_fname] color:color]];
        if (strstr(dylib_info.dli_fname, "AntiJailbreak")) {
             [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"%s %s",funcs[i] ,dylib_info.dli_fname] color:color]];
        }
//        if (strstr(dylib_info.dli_fname, "/var/containers/Bundle/Application")) {
        

//        }
    }
    
    //打印 hook_list[] 代码
    printf("\n\n\n hook_list[] 代码代码如下: \n");
    for (int i = 0; i < count; i++) {
        Dl_info dylib_info;
        dladdr(arr[i], &dylib_info);
        
        const char * funcname = funcs[i];
        if (strcmp(funcname, "CFNetworkCopyProxiesForURL") == 0) {
            printf("//反反代理\n");
        }
        if (strcmp(funcname, "ptrace") == 0) {
            printf("//反反调试\n");
        }
        if (strcmp(funcname, "strstr") == 0) {
            printf("//反反越狱文件权限\n");
        }
        if (strcmp(funcname, "creat") == 0) {
            printf("//{system}\n");
        }
        printf("{%s, \"%s\", \"%s\"}, //%d\n", funcname, dylib_info.dli_fname, funcname, i);
        if (count - 1 == i) {
            printf("//有一个注释位\n");
        }
    }
    
    
    //打印 refreshHook_list 代码
    printf("\n\n\n refreshHook_list代码如下: \n");
    for (int i = 0; i < count; i++) {
        Dl_info dylib_info;
        dladdr(arr[i], &dylib_info);
        
        const char * funcname = funcs[i];
        if (strcmp(funcname, "CFNetworkCopyProxiesForURL") == 0) {
            printf("//反反代理\n");
        }
        if (strcmp(funcname, "ptrace") == 0) {
            printf("//反反调试\n");
        }
        if (strcmp(funcname, "strstr") == 0) {
            printf("//反反越狱文件权限\n");
        }
        if (strcmp(funcname, "creat") == 0) {
            printf("//system 没有替换\n");
        }
        printf("hook_list[%d].func_ptr = %s;\n", i, funcname);
        if (count - 1 == i) {
            printf("以上是refreshHook_list代码\n");
        }
    }
    
    
   
}

//沙盒完整性校验
//根据fork()的返回值判断创建子进程是否成功
//（1）返回－1，表示没有创建新的进程
//（2）在子进程中，返回0
//（3）在父进程中，返回子进程的PID
//沙盒如何被破坏，则fork的返回值为大于等于0.
//好像不能用来判断
void checkfork() {
    UIColor *color = randomColor();

    int result = fork();
    if (!result){
        [DataSourceManager addReason:[Model text:@"checkfork" color:color]];
    }
    struct stat s;
    if (lstat("/Applications", &s)!=0) {
        if (s.st_mode & S_IFLNK) {
            /* Device is jailbroken */
            [DataSourceManager addReason:[Model text:@"/Applications" color:color]];
        }
    }
    
    void *mem = malloc(getpagesize() + 15);
    void *ptr = (void *)(((uintptr_t)mem+15) & ~ 0x0F);
    vm_address_t pagePtr = (uintptr_t)ptr / getpagesize() * getpagesize();
    int is_jailbroken = vm_protect(mach_task_self(),
                                   (vm_address_t) pagePtr, getpagesize(), FALSE,
                                   VM_PROT_READ | VM_PROT_WRITE | VM_PROT_EXECUTE) == 0;
    if (is_jailbroken) {
        [DataSourceManager addReason:[Model text:@"lstat Applications" color:color]];
    }
    struct stat s2;
    stat("/etc/fstab", &s2);
    [DataSourceManager addReason:[Model text:[NSString stringWithFormat:@"%ld", s2.st_size] color:color]];

    printf("%d",result);
}


#pragma mark -
#pragma mark - debugger
#pragma mark -
#pragma mark - SIGSTOP(当检测到有断点触发时停止调试)
void checkSIGSTOP(){
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGSTOP, 0, dispatch_get_main_queue());
    UIColor *color = randomColor();

    dispatch_source_set_event_handler(source, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [DataSourceManager addReason:[Model text:@"SIGSTOP(当检测到有断点触发时停止调试)" color:color]];
        });
    });
    dispatch_resume(source);
}


void checkIsatty(){
    UIColor *color = randomColor();

    if (isatty(1)) {
        [DataSourceManager addReason:[Model text:@"isatty调试" color:color]];
    }
}

void checkioctl() __attribute__((inline)){
    UIColor *color = randomColor();

    if (!ioctl(1, TIOCGWINSZ)) {
        [DataSourceManager addReason:[Model text:@"ioctl调试" color:color]];
    }
}


static void checkSysctl() __attribute__((optnone)){
    UIColor *color = randomColor();

    int name[4];//里面放字节码。查询的信息
    name[0] = CTL_KERN;//内核查询
    name[1] = KERN_PROC;//查询进程
    name[2] = KERN_PROC_PID;//传递的参数是进程的ID
    name[3] = getpid();//PID的值
    
    struct kinfo_proc info;//接受查询结果的结构体
    size_t info_size = sizeof(info);
    if(sysctl(name, 4, &info, &info_size, 0, 0)){
        NSLog(@"查询失败");
    }
    //看info.kp_proc.p_flag 的第12位。如果为1，表示调试状态。
    //(info.kp_proc.p_flag & P_TRACED)
    if ((info.kp_proc.p_flag & P_TRACED) != 0) {
        [DataSourceManager addReason:[Model text:@"Sysctl调试" color:color]];
    }
}


typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif
static void cehckPtrace() __attribute__((optnone)) {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

void checkAsmPtrace() {
#ifdef __arm64__
    __asm__ volatile(
                 "mov x0,#31\n"
                 "mov x1,#0\n"
                 "mov x2,#0\n"
                 "mov x3,#0\n"
                 "mov x16,#26\n"//中断根据x16 里面的值，跳转ptrace
                 "svc #0x80\n"//这条指令就是触发中断（系统级别的跳转！）
                 );
#endif
}



struct Book_t{
    int key1;
    char * key2;
    struct Book_description{
        int status;
        char * desc;
    } *desc;
} book;






#pragma mark -
#pragma mark - AppDelegate
@implementation AppDelegate
#pragma mark -
#pragma mark - 私有api
- (NSString *)getDeviceIdentifier {
    NSBundle *privatePath = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AppleAccount.framework"];
    if([privatePath load]){
        Class AADeviceInfo = NSClassFromString(@"AADeviceInfo");
        
        [AADeviceInfo valueForKey:@"productVersion"];
        [AADeviceInfo valueForKey:@"userAgentHeader"];
        id r = [AADeviceInfo valueForKey:@"appleIDClientIdentifier"];
        [AADeviceInfo valueForKey:@"apnsToken"];
        [AADeviceInfo valueForKey:@"serialNumber"];
        [AADeviceInfo valueForKey:@"osVersion"];
        [AADeviceInfo valueForKey:@"udid"];
        [AADeviceInfo valueForKey:@"infoDictionary"];
      
        if (r) {
            return r;
        }
        
    }
    return @"";
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void)installedApplications
{
    
    NSMethodSignature *methodSignature = [NSClassFromString(@"LSApplicationWorkspace") methodSignatureForSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invoke setSelector:NSSelectorFromString(@"defaultWorkspace")];
    [invoke setTarget:NSClassFromString(@"LSApplicationWorkspace")];
    
    [invoke invoke];
    NSObject * objc;
    [invoke getReturnValue:&objc];
    
    
    NSMethodSignature *installedPluginsmethodSignature = [NSClassFromString(@"LSApplicationWorkspace") instanceMethodSignatureForSelector:NSSelectorFromString(@"allInstalledApplications")];
    NSInvocation *installed = [NSInvocation invocationWithMethodSignature:installedPluginsmethodSignature];
    [installed setSelector:NSSelectorFromString(@"allInstalledApplications")];
    [installed setTarget:objc];
    
    [installed invoke];
    NSArray * apps;
    [installed getReturnValue:&apps];
    
    Class LSApplicationProxy_class = objc_getClass("LSApplicationProxy");
    for (int i = 0; i < apps.count; i++) {
        NSObject *temp = apps[i];
        if ([temp isKindOfClass:LSApplicationProxy_class]) {
            //应用的bundleId
            NSString *appBundleId = [temp performSelector:NSSelectorFromString(@"applicationIdentifier")];
            //应用的名称
            NSString *appName = [temp performSelector:NSSelectorFromString(@"localizedName")];
            //应用的类型是系统的应用还是第三方的应用
            NSString * type = [temp performSelector:NSSelectorFromString(@"applicationType")];
            //应用的版本
            NSString * shortVersionString = [temp performSelector:NSSelectorFromString(@"shortVersionString")];
            
            NSString * resourcesDirectoryURL = [temp performSelector:NSSelectorFromString(@"containerURL")];
            
            NSLog(@"类型=%@应用的BundleId=%@ ++++应用的名称=%@版本号=%@\n%@",type,appBundleId,appName,shortVersionString,resourcesDirectoryURL);
            
        }
    }
}
#pragma clang diagnostic pop    // -Wundeclared-selector
#pragma clang diagnostic pop    // -Warc-performSelector-leaks

- (void)installedPlugins{
    NSMethodSignature *methodSignature = [NSClassFromString(@"LSApplicationWorkspace") methodSignatureForSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invoke setSelector:NSSelectorFromString(@"defaultWorkspace")];
    [invoke setTarget:NSClassFromString(@"LSApplicationWorkspace")];
    
    [invoke invoke];
    NSObject * objc;
    [invoke getReturnValue:&objc];
    
    
    NSMethodSignature *installedPluginsmethodSignature = [NSClassFromString(@"LSApplicationWorkspace") instanceMethodSignatureForSelector:NSSelectorFromString(@"installedPlugins")];
    NSInvocation *installed = [NSInvocation invocationWithMethodSignature:installedPluginsmethodSignature];
    [installed setSelector:NSSelectorFromString(@"installedPlugins")];
    [installed setTarget:objc];
    
    [installed invoke];
    NSObject * arr;
    [installed getReturnValue:&arr];
   
    
    
    for (NSObject *objc in arr) {
        
        NSMethodSignature *installedPluginsmethodSignature = [NSClassFromString(@"LSPlugInKitProxy") instanceMethodSignatureForSelector:NSSelectorFromString(@"containingBundle")];
        NSInvocation *installed = [NSInvocation invocationWithMethodSignature:installedPluginsmethodSignature];
        [installed setSelector:NSSelectorFromString(@"containingBundle")];
        [installed setTarget:objc];
        
        [installed invoke];
        NSObject * app;
        [installed getReturnValue:&app];
        NSLog(@"%@",app);
    }
}

#pragma mark -
#pragma mark - delegate 方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self  getDeviceIdentifier];
    [self installedApplications];
    [self installedPlugins];
//    NSError *error;
//    [@"UMJailbreak test string" writeToFile:@"/private/umTest_Jailbreak.txt" atomically:true encoding:(NSUTF8StringEncoding) error:&error];
//    if (error) {
//        [NSError errorWithDomain:NSCocoaErrorDomain code:513 userInfo:@{}];
//        NSLog(@"sss");
//    } else {
//        NSLog(@"ss");
//    }
    
//    checkFileExistsAtPath();
//    checkInject();

    // Override point for customization after application launch.
//    cehckPtrace();
//    checkSysctl();
//    checkSIGSTOP();
//    checkIsatty();
//    checkioctl();
////    checkAsmPtrace();
//    
//    checkOpenCydia();
//    checkFileExistsAtPath();
//    checkfileExistsAtPathIsDirectory();
//    checkcontentsAtPath();
//    checkfopen();
//    checkStat();
//    checklstat();
//    checkgetenv();
//    checkDylibs();
//    checkInject();
//    checkfork();
//    chekcaccess();
    
    
    
    
    // Ref: https://reverse.put.as/wp-content/uploads/2012/07/Secuinside-2012-Presentation.pdf
//    struct ios_execp_info
//    {
//        exception_mask_t masks[EXC_TYPES_COUNT];
//        mach_port_t ports[EXC_TYPES_COUNT];
//        exception_behavior_t behaviors[EXC_TYPES_COUNT];
//        thread_state_flavor_t flavors[EXC_TYPES_COUNT];
//        mach_msg_type_number_t count;
//    };
//    struct ios_execp_info *info = malloc(sizeof(struct ios_execp_info));
//    kern_return_t kr = task_get_exception_ports(mach_task_self(), EXC_MASK_ALL, info->masks, &info->count, info->ports, info->behaviors, info->flavors);
//
//    for (int i = 0; i < info->count; i++)
//    {
//        if (info->ports[i] !=0 || info->flavors[i] == THREAD_STATE_NONE)
//        {
//            NSLog(@"Being debugged... task_get_exception_ports");
//        } else {
//            NSLog(@"task_get_exception_ports bypassed");
//        }
//    }
    
 
    
    
    // Everything above relies on libraries. It is easy enough to hook these libraries and return the required
    // result to bypass those checks. So here it is implemented in ARM assembly. Not very fun to bypass these.
//#ifdef __arm__
//    asm volatile (
//                  "mov r0, #31\n"
//                  "mov r1, #0\n"
//                  "mov r2, #0\n"
//                  "mov r12, #26\n"
//                  "svc #80\n"
//                  );
//    NSLog(@"Bypassed syscall() ASM");
//#endif
//#ifdef __arm64__
//    asm volatile (
//                  "mov x0, #26\n"
//                  "mov x1, #31\n"
//                  "mov x2, #0\n"
//                  "mov x3, #0\n"
//                  "mov x16, #0\n"
////                  "svc #128\n"
//                  );
//    NSLog(@"Bypassed syscall() ASM64");
//#endif
//
//    dispatch_block_t chkCallback  = ^{
//
//        NSLog(@"sss");
//    };
//
//    checkFork(chkCallback);
//    checkFiles(chkCallback);
//    checkLinks(chkCallback);
//
//    dbgStop;
//
//
//    dispatch_queue_t  _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER , 0 , 0 ,_queue);
//    dispatch_source_set_timer(_timer  ,dispatch_time(DISPATCH_TIME_NOW, 0) ,1.0 * NSEC_PER_SEC  ,0.0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(_timer, ^{
//        NSLog(@"sss");
//    });
//    dispatch_resume(_timer);
    return YES;
}

@end
