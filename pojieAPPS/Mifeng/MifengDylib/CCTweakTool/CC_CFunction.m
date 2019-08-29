//
//  CCCFunction.m
//  HookExampleDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "CCHelpTool.h"
#import "fishhook.h"
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
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

struct hook_t{
    void *func_ptr;
    const char *orig_adrr_path;
    const char *func_name;
};

struct hook_t hook_list[] = {// system 没替换
    //反反代理
    {CFNetworkCopyProxiesForURL, "/System/Library/Frameworks/CFNetwork.framework/CFNetwork", "CFNetworkCopyProxiesForURL"}, //0
    {CFNetworkCopySystemProxySettings, "/System/Library/Frameworks/CFNetwork.framework/CFNetwork", "CFNetworkCopySystemProxySettings"}, //1
    //反反调试
    {ptrace, "/usr/lib/system/libsystem_kernel.dylib", "ptrace"}, //2
    {dlsym, "/usr/lib/system/libdyld.dylib", "dlsym"}, //3
    {sysctl, "/usr/lib/system/libsystem_c.dylib", "sysctl"}, //4
    {syscall, "/usr/lib/system/libsystem_kernel.dylib", "syscall"}, //5
    {isatty, "/usr/lib/system/libsystem_c.dylib", "isatty"}, //6
    {ioctl, "/usr/lib/system/libsystem_kernel.dylib", "ioctl"}, //7
    {task_get_exception_ports, "/usr/lib/system/libsystem_kernel.dylib", "task_get_exception_ports"}, //8
    //反反越狱文件权限
    {strstr, "/usr/lib/system/libsystem_platform.dylib", "strstr"}, //9
    {dladdr, "/usr/lib/system/libdyld.dylib", "dladdr"}, //10
    {fopen, "/usr/lib/system/libsystem_c.dylib", "fopen"}, //11
    {open, "/usr/lib/system/libsystem_c.dylib", "open"}, //12
    {access, "/usr/lib/system/libsystem_kernel.dylib", "access"}, //13
    {stat, "/usr/lib/system/libsystem_kernel.dylib", "stat"}, //14
    {lstat, "/usr/lib/system/libsystem_kernel.dylib", "lstat"}, //15
    {getenv, "/usr/lib/system/libsystem_c.dylib", "getenv"}, //16
    {_dyld_image_count, "/usr/lib/system/libdyld.dylib", "_dyld_image_count"}, //17
    {_dyld_get_image_name, "/usr/lib/system/libdyld.dylib", "_dyld_get_image_name"}, //18
    //{system}
    {creat, "/usr/lib/system/libsystem_c.dylib", "creat"}, //19
    {openat, "/usr/lib/system/libsystem_kernel.dylib", "openat"}, //20
    {fork, "/usr/lib/system/libsystem_c.dylib", "fork"}, //21
    {popen, "/usr/lib/system/libsystem_c.dylib", "popen"}, //22
    //有一个注释位
};
static void refreshHook_list(){
    //反反代理
    hook_list[0].func_ptr = CFNetworkCopyProxiesForURL;
    hook_list[1].func_ptr = CFNetworkCopySystemProxySettings;
    //反反调试
    hook_list[2].func_ptr = ptrace;
    hook_list[3].func_ptr = dlsym;
    hook_list[4].func_ptr = sysctl;
    hook_list[5].func_ptr = syscall;
    hook_list[6].func_ptr = isatty;
    hook_list[7].func_ptr = ioctl;
    hook_list[8].func_ptr = task_get_exception_ports;
    //反反越狱文件权限
    hook_list[9].func_ptr = strstr;
    hook_list[10].func_ptr = dladdr;
    hook_list[11].func_ptr = fopen;
    hook_list[12].func_ptr = open;
    hook_list[13].func_ptr = access;
    hook_list[14].func_ptr = stat;
    hook_list[15].func_ptr = lstat;
    hook_list[16].func_ptr = getenv;
    hook_list[17].func_ptr = _dyld_image_count;
    hook_list[18].func_ptr = _dyld_get_image_name;
    //system 没有替换
    hook_list[19].func_ptr = creat;
    hook_list[20].func_ptr = openat;
    hook_list[21].func_ptr = fork;
    hook_list[22].func_ptr = popen;
}

NSMutableArray *dyldArray;
BOOL bypassDyldArray;








#pragma mark -
#pragma mark -NSLogc
static void (*orig_NSLog)(NSString *, ...);
static void my_NSLog(NSString *format, ...){
    va_list args;
    if(format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        if (isCallFromOriginApp()) {
            orig_NSLog(@"原始输出:%@", message);
        } else {
            orig_NSLog(@"我的输出:%@", message);
        }
        va_end(args);
    }
}









#pragma mark -
#pragma mark - 反反代理
static CFArrayRef (*orig_CFNetworkCopyProxiesForURL) (CFURLRef url, CFDictionaryRef proxySettings);
static CFArrayRef my_CFNetworkCopyProxiesForURL (CFURLRef url, CFDictionaryRef proxySettings){
    CFArrayRef a = orig_CFNetworkCopyProxiesForURL(url,proxySettings);
    NSArray *origArr = (__bridge NSArray*)a;
    NSMutableArray *arr = @[].mutableCopy;
    NSDictionary *dic = @{
                          (NSString *)kCFProxyTypeKey : (NSString *)kCFProxyTypeNone
                          };
    [arr addObject:dic];
    return (CFArrayRef)CFBridgingRetain(arr);
}

static CFDictionaryRef (*orig_CFNetworkCopySystemProxySettings)();
static CFDictionaryRef my_CFNetworkCopySystemProxySettings(){
    CFDictionaryRef r = orig_CFNetworkCopySystemProxySettings();
    [CCLogManager addLog:@"[文件名:CC_CFunction.m][类名:反反代理][方法名:my_CFNetworkCopyProxiesForURL]检测了代理"];
    return r;
}








#pragma mark -
#pragma mark - 反反调试
typedef int (*ptrace_ptr_t)(int _request,pid_t _pid, caddr_t _addr,int _data);
typedef void* (*dlsym_ptr_t)(void * __handle, const char* __symbol);
typedef int (*syscall_ptr_t)(int, ...);
typedef int (*sysctl_ptr_t)(int *,u_int, void*, size_t*,void*, size_t);

static ptrace_ptr_t orig_ptrace = NULL;
static dlsym_ptr_t orig_dlsym = NULL;
static sysctl_ptr_t orig_sysctl = NULL;
static syscall_ptr_t orig_syscall = NULL;

int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);
void* my_dlsym(void* __handle, const char* __symbol);
int my_sysctl(int * name, u_int namelen, void * info, size_t * infosize, void * newinfo, size_t newinfosize);
int my_syscall(int code, va_list args);

int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data){
    if(_request != 31){
        return orig_ptrace(_request,_pid,_addr,_data);
    }
    
    CCLog(@"[AntiAntiDebug] - ptrace request is PT_DENY_ATTACH");
    
    return 0;
}

void* my_dlsym(void* __handle, const char* __symbol){
    CCLog(@"通过dlsym调用 - dlsym get symbol %s",__symbol);
    
    if (strcmp(__symbol, "MSHookFunction") == 0 && __handle) {
        return NULL;
    }
    if(strcmp(__symbol, "ptrace") != 0){
        return orig_dlsym(__handle, __symbol);
    }
    
    
    return my_ptrace;
}

typedef struct kinfo_proc _kinfo_proc;
int my_sysctl(int * name, u_int namelen, void * info, size_t * infosize, void * newinfo, size_t newinfosize){
    if(namelen == 4 && name[0] == CTL_KERN && name[1] == KERN_PROC && name[2] == KERN_PROC_PID && info && infosize && ((int)*infosize == sizeof(_kinfo_proc))){
        int ret = orig_sysctl(name, namelen, info, infosize, newinfo, newinfosize);
        struct kinfo_proc *info_ptr = (struct kinfo_proc *)info;
        if(info_ptr && (info_ptr->kp_proc.p_flag & P_TRACED) != 0){
            CCLog(@"[AntiAntiDebug] - sysctl query trace status.");
            info_ptr->kp_proc.p_flag ^= P_TRACED;
            if((info_ptr->kp_proc.p_flag & P_TRACED) == 0){
                CCLog(@"trace status reomve success!");
            }
        }
        return ret;
    }
    return orig_sysctl(name, namelen, info, infosize, newinfo, newinfosize);
}

int my_syscall(int code, va_list args){
    int request;
    va_list newArgs;
    va_copy(newArgs, args);
    if(code == 26){
#ifdef __LP64__
        __asm__(
                "ldr %w[result], [fp, #0x10]\n"
                : [result] "=r" (request)
                :
                :
                );
#else
        request = va_arg(args, int);
#endif
        if(request == 31){
            CCLog(@"[AntiAntiDebug] - syscall call ptrace, and request is PT_DENY_ATTACH");
            return 0;
        }
    }
    return orig_syscall(code, newArgs);
}

static int (*orig_isatty)(int);
static int my_isatty(int i){
    int r = orig_isatty(i);
    if (i == 1 && r) {
        CCLog(@"[AntiAntiDebug] - isatty symbol");
        return 0;
    }
    return r;
}

int (*orig_ioctl)(int, unsigned long, ...);
static int my_ioctl(int arg1, unsigned long arg2, ...){
    if (arg1 == 1 && arg2 == TIOCGWINSZ) {
        CCLog(@"[AntiAntiDebug] - ioctl symbol");
        return 1;
    }
    va_list args;
    va_start(args, arg2);
    int r = orig_ioctl(arg1, arg2, args);
    va_end(args);
    return r ;
}









#pragma mark - task_get_exception_ports
static kern_return_t (*orig_task_get_exception_ports)
(
 task_inspect_t task,
 exception_mask_t exception_mask,
 exception_mask_array_t masks,
 mach_msg_type_number_t *masksCnt,
 exception_handler_array_t old_handlers,
 exception_behavior_array_t old_behaviors,
 exception_flavor_array_t old_flavors
 );
static kern_return_t my_task_get_exception_ports
(
 task_inspect_t task,
 exception_mask_t exception_mask,
 exception_mask_array_t masks,
 mach_msg_type_number_t *masksCnt,
 exception_handler_array_t old_handlers,
 exception_behavior_array_t old_behaviors,
 exception_flavor_array_t old_flavors
 ){
    kern_return_t r = orig_task_get_exception_ports(task, exception_mask, masks, masksCnt, old_handlers, old_behaviors, old_flavors);
    //    if (info->ports[i] !=0 || info->flavors[i] == THREAD_STATE_NONE)
    for (int i = 0; i < *masksCnt; i++)
    {
        if (old_handlers[i] != 0) {
            old_handlers[i] = 0;
        }
        if (old_flavors[i]  == THREAD_STATE_NONE) {
            old_flavors[i] = ARM_EXCEPTION_STATE;
        }
    }
    
    return r;
}












#pragma mark -
#pragma mark - 反反越狱检测
#pragma mark -
#pragma mark - strstr 打印
static char *(*orig_strstr)(const char *, const char *);
static char *my_strstr(const char *s1, const char *s2){
    if (s1 == NULL || s2 == NULL) {
        return NULL;
    }
    return orig_strstr(s1, s2);
}








#pragma mark - 看函数出自哪个裤
static int (*orig_dladdr)(const void *, Dl_info *);
static int my_dladdr(const void * func_ptr, Dl_info * dylib_info){
    int reuslt = orig_dladdr(func_ptr, dylib_info);
    for (int i = 0; i < sizeof(hook_list)/sizeof(hook_list[0]); i ++){
        struct hook_t hook = hook_list[i];
        if (func_ptr == hook.func_ptr) {
            const char *orig_path = dylib_info->dli_fname;
            dylib_info->dli_fname = hook.orig_adrr_path;
            CCLog(@"C函数反越狱5 dladdr ===> name=%s, origpath =%s, newpath=%s", hook.func_name  , orig_path,dylib_info->dli_fname);
        }
    }
    return reuslt;
}
//








#pragma mark - 看文件是可以打开
static FILE *(*orig_fopen)(const char *, const char * );
static FILE *my_fopen(const char * __restrict path, const char * __restrict mode){
    // /private/71E710D2-2BEF-4CCE-9A85-E4BB4E63C8CC
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测1.1 fopen ===> %s", path);
        return NULL;
    }
    
    return orig_fopen(path, mode);
}
//int open(const char *, int, ...)
static int (*orig_open)(const char *, int, ...);
static int my_open(const char * path, int oflag, ...){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测1.2 open ===> %s", path);
        return -1;
    }
    
    va_list args = {0};
    mode_t mode = 0;
    
    if ((oflag & O_CREAT) != 0) {
        // mode only applies to O_CREAT
        va_start(args, oflag);
        mode = va_arg(args, int);
        va_end(args);
        return orig_open(path, oflag, mode);
    } else {
        return orig_open(path, oflag, mode);
    }
}
//int access(const char *, int)
static int (*orig_access)(const char *, int);
static int my_access(const char *path, int mode){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测1.3 access ===> %s", path);
        return -1;
    }
    int r = orig_access(path, mode);
    return r;
}
#pragma mark - anti stat 系列函数检测 Cydia 等工具
static int (*orig_stat)(const char *, struct stat *);
static int my_stat(const char * path, struct stat * info){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测2 stat ===> %s", path);
        return -1;
    }
    int result = orig_stat(path, info);
    return result;
}

static int (*orig_lstat)(const char *, struct stat *);
static int my_lstat(const char * path, struct stat * info){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测2.1 lstat ===> %s", path);
        return -1;
    }
    
    int result = orig_lstat(path, info);
    return result;
}

#pragma mark - getenv 查看当前程序运行的环境变量
static char *(*orig_getenv)(const char *);
static char *my_getenv(const char *s1){
    if (strcmp(s1, "DYLD_INSERT_LIBRARIES") == 0 || [[NSString stringWithUTF8String:s1] hasPrefix:@"_"]) {
        CCLog(@"C函数反越狱3 getenv:%s",s1);
        return NULL;
    }
    
    return orig_getenv(s1);
}

#pragma mark - 检索一下自应用程序是否被链接了异常动态库。 列出所有已链接的动态库
static uint32_t (*orig__dyld_image_count)(void);
static uint32_t my__dyld_image_count(void){
    if (!dyldArray) {
        dyldArray = @[].mutableCopy;
        
        bypassDyldArray = true;
        
        uint32_t orig_count = orig__dyld_image_count();
        uint32_t count = 0;
        
        while (count < orig_count) {
            const char *image_name = _dyld_get_image_name(count);
            if (image_name && !isJailbreakUTF8Path(image_name)) {
                CCLog(@"C函数 越狱检测4.1 orig__dyld_image_count ===> %s", image_name);
                [dyldArray addObject:[NSString stringWithUTF8String:image_name]];
            }
            ++count;
        }
        
        bypassDyldArray = false;
    }
    
    return (uint32_t)[dyldArray count];
}

static char *(*orig__dyld_get_image_name)(uint32_t);
static char *my__dyld_get_image_name(uint32_t image_index){
    if (bypassDyldArray) {
        return orig__dyld_get_image_name(image_index);
    }
    
    if (dyldArray.count < image_index) {
        return NULL;
    }
    
    return (const char *)[dyldArray[image_index] UTF8String];
}



#pragma mark - system
static int (*orig_system)(const char *);
static int my_system(const char *s1){
    return -1;
}













#pragma mark - creat
static int (*orig_creat)(const char *, mode_t);
static int my_creat(const char *path, mode_t m){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测 creat ===> %s", path);
        return -1;
    }
    
    int result = orig_creat(path, m);
    return result;
}









#pragma mark - openat
static int (*orig_openat)(int, const char *, int, ...);
static int my_openat(int arg1, const char * path, int arg3, ...){
    if (isJailbreakUTF8Path(path)) {
        CCLog(@"C函数 越狱检测 creat ===> %s", path);
        return -1;
    }
    
    
    va_list args;
    va_start(args, arg3);
    int result = orig_openat(arg1, path, arg3,args);
    va_end(args);
    return result;
}








#pragma mark - fork
static pid_t (*orig_fork)(void);
static pid_t my_fork(void){
    return -1;
}











#pragma mark - popen
static FILE *(*orig_popen)(const char *, const char *);
static FILE *my_popen(const char *s1, const char *s2){
    return NULL;
}








#pragma mark -
#pragma mark - 入口
__attribute__((constructor)) static void entry(){
    rebind_symbols((struct rebinding[1]){{"NSLog", my_NSLog, (void *)&orig_NSLog}}, 1);

    if (openAntiAntiNetworkProxy) {
        rebind_symbols((struct rebinding[1]){{"CFNetworkCopyProxiesForURL", my_CFNetworkCopyProxiesForURL, (void*)&orig_CFNetworkCopyProxiesForURL}}, 1);
        rebind_symbols((struct rebinding[1]){{"CFNetworkCopySystemProxySettings", my_CFNetworkCopySystemProxySettings, (void *)&orig_CFNetworkCopySystemProxySettings}}, 1);
    }
    
    if (openAntiAntiDebug) {
        //        rebind_symbols((struct rebinding[1]){{"ptrace", my_ptrace, (void*)&orig_ptrace}},1);
        //        rebind_symbols((struct rebinding[1]){{"dlsym", my_dlsym, (void*)&orig_dlsym}},1);
        //        rebind_symbols((struct rebinding[1]){{"syscall", my_syscall, (void*)&orig_syscall}},1);
        //        rebind_symbols((struct rebinding[1]){{"isatty", my_isatty, (void*)&orig_isatty}},1);
        //        rebind_symbols((struct rebinding[1]){{"ioctl", my_ioctl, (void*)&orig_ioctl}},1);
        
        //some app will crash with _dyld_debugger_notification
        rebind_symbols((struct rebinding[1]){{"sysctl", my_sysctl, (void*)&orig_sysctl}},1);
        
        rebind_symbols((struct rebinding [5]) {
            {"ptrace", my_ptrace, (void*)&orig_ptrace},
            {"dlsym", my_dlsym, (void*)&orig_dlsym},
            {"syscall", my_syscall, (void*)&orig_syscall},
            {"isatty", my_isatty, (void*)&orig_isatty},
            {"ioctl", my_ioctl, (void*)&orig_ioctl},
        }, 5);
        
        rebind_symbols((struct rebinding[1]){{"task_get_exception_ports", my_task_get_exception_ports, (void*)&orig_task_get_exception_ports}},1);
    }
    
    if (openAntiAntiJialbreak) {
        rebind_symbols((struct rebinding[7]){
            {"fopen", my_fopen, (void*)&orig_fopen},
            {"stat", my_stat, (void*)&orig_stat},
            {"lstat", my_lstat, (void*)&orig_lstat},
            {"getenv", my_getenv, (void*)&orig_getenv},
            {"_dyld_get_image_name", my__dyld_get_image_name, (void*)&orig__dyld_get_image_name},
            {"access", my_access, (void*)&orig_access},
            {"_dyld_image_count", my__dyld_image_count, (void*)&orig__dyld_image_count}
        },7);
        rebind_symbols((struct rebinding[1]){{"open", my_open, (void*)&orig_open}}, 1);
        
        rebind_symbols((struct rebinding[1]){{"system", my_system, (void*)&orig_system}}, 1);
        
        rebind_symbols((struct rebinding[1]){{"creat", my_creat, (void*)&orig_creat}}, 1);
        
        rebind_symbols((struct rebinding[1]){{"openat", my_openat, (void*)&orig_openat}}, 1);
        
        rebind_symbols((struct rebinding[1]){{"fork", my_fork, (void*)&orig_fork}}, 1);
        
        rebind_symbols((struct rebinding[1]){{"popen", my_popen, (void*)&orig_popen}}, 1);
    }
    
    rebind_symbols((struct rebinding[1]){{"strstr", my_strstr, (void*)&orig_strstr}},1);
    rebind_symbols((struct rebinding[1]){{"dladdr", my_dladdr, (void*)&orig_dladdr}},1);
    refreshHook_list();
    
    //fork creat popen system _dyld_image_count
}


