////
////  HookTool.m
////  AntiJailbreak
////
////  Created by 梁泽 on 2019/6/19.
////  Copyright © 2019 梁泽. All rights reserved.
////
//#if TARGET_OS_SIMULATOR
//#error Do not support the simulator, please use the real iPhone Device.
//#endif
//
//#import "HookTool.h"
//#import <UIKit/UIKit.h>
#import "CaptainHook.h"
//#import "fishhook/fishhook.h"
//#import <sys/stat.h>
//#import <dlfcn.h>
//#import <mach-o/dyld.h>
//#import <sys/sysctl.h>
//#pragma mark - 调试
//#import <unistd.h>
//#import <sys/ioctl.h>
//#if true
//# define LZLog(fmt, ...) NSLog((@"[函数名:%s]" "[行号:%d] --- " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//# define LZLog(...);
//#endif
//
//
//struct hook_t{
//    void *func_ptr;
//    const char *orig_adrr_path;
//    const char *func_name;
//};
////stat, //  /usr/lib/system/libsystem_kernel.dylib
////lstat,//  /usr/lib/system/libsystem_kernel.dylib
////fopen,//   /usr/lib/system/libsystem_c.dylib
////open,//    /usr/lib/system/libsystem_kernel.dylib
////getenv,//   /usr/lib/system/libsystem_c.dylib
////_dyld_get_image_name,//   /usr/lib/system/libdyld.dylib
////_dyld_image_count,//  /usr/lib/system/libdyld.dylib
////dladdr,//  /usr/lib/system/libdyld.dylib
////CFNetworkCopyProxiesForURL,// /System/Library/Frameworks/CFNetwork.framework/CFNetwork
////dlsym,  //   /usr/lib/system/libdyld.dylib
//#pragma mark - 调试
////syscall,//   /usr/lib/system/libsystem_kernel.dylib
////sysctl,//    /usr/lib/system/libsystem_c.dylib
////isatty, //  /usr/lib/system/libsystem_c.dylib
////ioctl, //  /usr/lib/system/libsystem_c.dylib
////ptrace,// /usr/lib/system/libsystem_c.dylib 没有找到。。。
////access,//   /usr/lib/system/libsystem_kernel.dylib
//struct hook_t hook_list[] = {
//    {stat ,"/usr/lib/system/libsystem_kernel.dylib" ,"stat"}, //0
//    {lstat ,"/usr/lib/system/libsystem_kernel.dylib" ,"lstat"},//1
//    {fopen ,"/usr/lib/system/libsystem_c.dylib" ,"fopen"},//2
//    {open ,"/usr/lib/system/libsystem_kernel.dylib" ,"open"},//3
//    {getenv ,"/usr/lib/system/libsystem_c.dylib" ,"getenv"},//4
//    {_dyld_get_image_name ,"/usr/lib/system/libdyld.dylib" ,"_dyld_get_image_name"},//5
//    {dladdr ,"/usr/lib/system/libdyld.dylib" ,"dladdr"},//6
//    {CFNetworkCopyProxiesForURL ,"/System/Library/Frameworks/CFNetwork.framework/CFNetwork" ,"CFNetworkCopyProxiesForURL"},//7
//    {dlsym ,"/usr/lib/system/libdyld.dylib", "dlsym"},//8
//    {syscall, "/usr/lib/system/libsystem_kernel.dylib", "syscall"},//9
//    {sysctl, "/usr/lib/system/libsystem_c.dylib", "sysctl"},//10
//    {isatty, "/usr/lib/system/libsystem_c.dylib", "isatty"},//11
//    {ioctl, "/usr/lib/system/libsystem_c.dylib", "ioctl"},//12
//    {ptrace, "/usr/lib/system/libsystem_c.dylib", "ptrace"},//13
//    {access, "/usr/lib/system/libsystem_kernel.dylib", "access"},//14
//};
//void refreshHook_list(){
//    hook_list[0].func_ptr = stat;
//    hook_list[1].func_ptr = lstat;
//    hook_list[2].func_ptr = fopen;
//    hook_list[3].func_ptr = open;
//    hook_list[4].func_ptr = getenv;
//    hook_list[5].func_ptr = _dyld_get_image_name;
//    hook_list[6].func_ptr = dladdr;
//    hook_list[7].func_ptr = CFNetworkCopyProxiesForURL;
//    hook_list[8].func_ptr = dlsym;
//    hook_list[9].func_ptr = syscall;
//    hook_list[10].func_ptr = sysctl;
//    hook_list[11].func_ptr = isatty;
//    hook_list[12].func_ptr = ioctl;
//    hook_list[13].func_ptr = ptrace;
//    hook_list[14].func_ptr = access;
//}
//
//#pragma mark -
//#pragma mark - bundleIdentifier & embedded.mobileprovision &
//CHDeclareClass(NSBundle)
//CHOptimizedMethod0(self, NSString *, NSBundle, bundleIdentifier) {
//    NSArray *address = [NSThread callStackReturnAddresses];
//    Dl_info info = {0};
//    if(dladdr((void *)[address[2] longLongValue], &info) == 0) {
//        return CHSuper(0, NSBundle, bundleIdentifier);
//    }
//    NSString *path = [NSString stringWithUTF8String:info.dli_fname];
//    if ([path hasPrefix:NSBundle.mainBundle.bundlePath]) {
//        return bunlderID;
//    } else {
//        return CHSuper(0, NSBundle, bundleIdentifier);
//    }
//
//
//    NSString *name = @"";
//    if ([name hasPrefix:@"embedded"]) {
//
//    }
//}
//CHDeclareClass(NSString)
//CHOptimizedMethod1(self, NSString *, NSString, stringByAppendingPathComponent, NSString *, component){
//    if ([self hasPrefix:NSBundle.mainBundle.bundlePath] && [component containsString:@"mobileprovisi"]){
//        assert("检测mobileprovision了,需要自行处理逻辑吗？");
//    }
//    return CHSuper1(NSString, stringByAppendingPathComponent, component);
//}
//
//CHConstructor {
//    CHLoadLateClass(NSBundle);
//    CHClassHook0(NSBundle, bundleIdentifier);
//
//    CHLoadLateClass(NSString);
//    CHHook1(NSString, stringByAppendingPathComponent);
//}
//
//#pragma mark -
//#pragma mark - AntiAntiDebug
//typedef int (*ptrace_ptr_t)(int _request,pid_t _pid, caddr_t _addr,int _data);
//typedef void* (*dlsym_ptr_t)(void * __handle, const char* __symbol);
//typedef int (*syscall_ptr_t)(int, ...);
//typedef int (*sysctl_ptr_t)(int *,u_int, void*, size_t*,void*, size_t);
//
//
//static ptrace_ptr_t orig_ptrace = NULL;
//static dlsym_ptr_t orig_dlsym = NULL;
//static sysctl_ptr_t orig_sysctl = NULL;
//static syscall_ptr_t orig_syscall = NULL;
//
//int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);
//void* my_dlsym(void* __handle, const char* __symbol);
//int my_sysctl(int * name, u_int namelen, void * info, size_t * infosize, void * newinfo, size_t newinfosize);
//int my_syscall(int code, va_list args);
//
//int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data){
//    if(_request != 31){
//        return orig_ptrace(_request,_pid,_addr,_data);
//    }
//
//    NSLog(@"[AntiAntiDebug] - ptrace request is PT_DENY_ATTACH");
//
//    return 0;
//}
//
//void* my_dlsym(void* __handle, const char* __symbol){
//    printf("my_dlsym => %s\n",__symbol);
//
//    if (strcmp(__symbol, "MSHookFunction") == 0 && __handle) {
//        return NULL;
//    }
//    if(strcmp(__symbol, "ptrace") != 0){
//        return orig_dlsym(__handle, __symbol);
//    }
//
//    NSLog(@"[AntiAntiDebug] - dlsym get ptrace symbol");
//
//    return my_ptrace;
//}
//
//typedef struct kinfo_proc _kinfo_proc;
//
//int my_sysctl(int * name, u_int namelen, void * info, size_t * infosize, void * newinfo, size_t newinfosize){
//    if(namelen == 4 && name[0] == CTL_KERN && name[1] == KERN_PROC && name[2] == KERN_PROC_PID && info && infosize && ((int)*infosize == sizeof(_kinfo_proc))){
//        int ret = orig_sysctl(name, namelen, info, infosize, newinfo, newinfosize);
//        struct kinfo_proc *info_ptr = (struct kinfo_proc *)info;
//        if(info_ptr && (info_ptr->kp_proc.p_flag & P_TRACED) != 0){
//            NSLog(@"[AntiAntiDebug] - sysctl query trace status.");
//            info_ptr->kp_proc.p_flag ^= P_TRACED;
//            if((info_ptr->kp_proc.p_flag & P_TRACED) == 0){
//                NSLog(@"trace status reomve success!");
//            }
//        }
//        return ret;
//    }
//    return orig_sysctl(name, namelen, info, infosize, newinfo, newinfosize);
//}
//
//int my_syscall(int code, va_list args){
//    int request;
//    va_list newArgs;
//    va_copy(newArgs, args);
//    if(code == 26){
//#ifdef __LP64__
//        __asm__(
//                "ldr %w[result], [fp, #0x10]\n"
//                : [result] "=r" (request)
//                :
//                :
//                );
//#else
//        request = va_arg(args, int);
//#endif
//        if(request == 31){
//            NSLog(@"[AntiAntiDebug] - syscall call ptrace, and request is PT_DENY_ATTACH");
//            return 0;
//        }
//    }
//    return orig_syscall(code, newArgs);
//}
//#pragma mark - isatty
//static int (*orig_isatty)(int);
//static int new_isatty(int i){
//    int r = orig_isatty(i);
//    if (i == 1 && r) {
//        return 0;
//    }
//    return r;
//}
//
//#pragma mark - ioctl
//int (*orig_ioctl)(int, unsigned long, ...);
//static int new_ioctl(int arg1, unsigned long arg2, ...){
//    if (arg1 == 1 && arg2 == TIOCGWINSZ) {
//        NSLog(@"[AntiAntiDebug] - ioctl symbol");
//        return 1;
//    }
//    va_list args;
//    va_start(args, arg2);
//    int r = orig_ioctl(arg1, arg2, args);
//    va_end(args);
//    return r ;
//}
//
//
//__attribute__((constructor)) static void entry(){
//    rebind_symbols((struct rebinding[1]){{"ptrace", my_ptrace, (void*)&orig_ptrace}},1);
//
//    rebind_symbols((struct rebinding[1]){{"dlsym", my_dlsym, (void*)&orig_dlsym}},1);
//
//    //some app will crash with _dyld_debugger_notification
//    rebind_symbols((struct rebinding[1]){{"sysctl", my_sysctl, (void*)&orig_sysctl}},1);
//
//    rebind_symbols((struct rebinding[1]){{"syscall", my_syscall, (void*)&orig_syscall}},1);
//
//    rebind_symbols((struct rebinding[1]){{"isatty", new_isatty, (void*)&orig_isatty}},1);
//
//    rebind_symbols((struct rebinding[1]){{"ioctl", new_ioctl, (void*)&orig_ioctl}},1);
//}
//
//
//#pragma mark -
//#pragma mark - AntiAntiProxy
//static CFArrayRef (*origCFNetworkCopyProxiesForURL) (CFURLRef url, CFDictionaryRef proxySettings);
//static CFArrayRef newCFNetworkCopyProxiesForURL (CFURLRef url, CFDictionaryRef proxySettings){
//    //    CFArrayRef a = orgCFNetworkCopyProxiesForURL(url,proxySettings);
//    NSMutableArray *arr = @[].mutableCopy;
//    NSDictionary *dic = @{
//                          (NSString *)kCFProxyTypeKey : (NSString *)kCFProxyTypeNone
//                          };
//    [arr addObject:dic];
//    return (CFArrayRef)CFBridgingRetain(arr);
//}
//CHConstructor{
//    rebind_symbols((struct rebinding[1]){{"CFNetworkCopyProxiesForURL", newCFNetworkCopyProxiesForURL, (void*)&origCFNetworkCopyProxiesForURL}},1);
//}
//
//#pragma mark -
//#pragma mark - UIApplication canOpenURL; openURL;
//CHDeclareClass(UIApplication)
//CHOptimizedMethod1(self, BOOL, UIApplication, canOpenURL, NSURL *, url){
//    LZLog(@"UIApplication call  canOpenURL");
//
//    NSString *tempStr = url.absoluteString.lowercaseString;
//    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
//        //检测是否安装了 第三方应用平台
//        return false;
//    }
//    if ([tempStr containsString:@"cydia"]){
//        return false;
//    }
//    return CHSuper1(UIApplication, canOpenURL, url);
//}
//
//CHOptimizedMethod1(self, BOOL, UIApplication, openURL, NSURL *, url){
//    return CHSuper1(UIApplication, openURL, url);
//}
//
//typedef void(^OpenurlBlock)(BOOL success);
//CHOptimizedMethod3(self, void, UIApplication, openURL, NSURL *, url, options, NSDictionary *, options, completionHandler, OpenurlBlock, completion){
//    CHSuper3(UIApplication, openURL, url, options, options, completionHandler, completion);
//}
//
//CHConstructor{
//    CHLoadLateClass(UIApplication);
//    CHHook1(UIApplication, canOpenURL);
//    CHHook1(UIApplication, openURL);
//    CHHook3(UIApplication, openURL, options, completionHandler);
//}
//
//
//#pragma mark -
//#pragma mark - FileManager
//#pragma mark -
//#pragma mark - NSFileManager 越狱检测文件
////[NSFileManager fileExistsAtPath:/Applications/Cydia.app ]
////[NSFileManager  getFileSystemRepresentation: maxLength:1026 withPath:/Applications/Cydia.app ]
//CHDeclareClass(NSFileManager)
//CHOptimizedMethod1(self, BOOL, NSFileManager, fileExistsAtPath, NSString *, path){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
//            LZLog(@"检测了fileExistsAtPath:%@", path);
//            return false;
//        }
//    }
//    BOOL result = CHSuper1(NSFileManager, fileExistsAtPath, path);
//    return result;
//}
//CHOptimizedMethod2(self, BOOL, NSFileManager, fileExistsAtPath, NSString *, path, isDirectory, BOOL *, arg2){
//    NSString *tempPath = path.lowercaseString;
//    for (NSString *str in jailbreakFileAtPath()) {
//        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
//            LZLog(@"检测了fileExistsAtPath:isDirectory:%@", tempPath);
//            return false;
//        }
//    }
//    BOOL result = CHSuper2(NSFileManager, fileExistsAtPath, path, isDirectory, arg2);
//    return result;
//}
//CHOptimizedMethod3(self, BOOL, NSFileManager, getFileSystemRepresentation, void *, arg1, maxLength, long long, arg2, withPath, NSString *, path){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
//            LZLog(@"检测了 getFileSystemRepresentation:%@", path);
//            return false;
//        }
//    }
//    return CHSuper3(NSFileManager, getFileSystemRepresentation, arg1, maxLength, arg2, withPath, path);
//}
//
//CHOptimizedMethod1(self, NSData *, NSFileManager, contentsAtPath, NSString *, path){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
//            LZLog(@"检测了 contentsAtPath%@", path);
//            return nil;
//        }
//    }
//    NSData *result = CHSuper1(NSFileManager, contentsAtPath, path);
//    return result;
//}
//CHOptimizedMethod2(self, NSArray *, NSFileManager, contentsOfDirectoryAtPath, NSString *, path, error, NSError **, error){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
//            LZLog(@"检测了 contentsOfDirectoryAtPath:%@, error", path);
//            return nil;
//        }
//    }
//    NSArray *result = CHSuper2(NSFileManager, contentsOfDirectoryAtPath, path, error, error);
//    return result;
//}
//CHConstructor{
//    CHLoadLateClass(NSFileManager);
//    CHHook1(NSFileManager, fileExistsAtPath);
//    CHHook2(NSFileManager, fileExistsAtPath, isDirectory);
//    CHHook3(NSFileManager, getFileSystemRepresentation, maxLength, withPath);
//    CHHook1(NSFileManager, contentsAtPath);
//    CHHook2(NSFileManager, contentsOfDirectoryAtPath, error);
//}
//
//
//#pragma mark -
//#pragma mark - C函数
//#pragma mark -
//#pragma mark - 看文件是可以打开
//static FILE *(*orig_fopen)(const char *, const char * );
//static FILE *new_fopen(const char * __restrict path, const char * __restrict mode){
//    // /private/71E710D2-2BEF-4CCE-9A85-E4BB4E63C8CC
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strstr(path, str.UTF8String) != NULL){
//            LZLog(@"C函数反越狱1 fopen ===> %s", path);
//            return NULL;
//        }
//    }
//    return orig_fopen(path, mode);
//}
////int open(const char *, int, ...)
//static int (*orig_open)(const char *, int, ...);
//static int new_open(const char * path, int mode, ...){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strstr(path, str.UTF8String) != NULL){
//            LZLog(@"C函数反越狱1.1 open ===> %s", path);
//            return -1;
//        }
//    }
//    int r = orig_open(path, mode);
//    return r;
//}
//
////int access(const char *, int)
//static int (*orig_access)(const char *, int);
//static int new_access(const char *path, int mode){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strstr(path, str.UTF8String) != NULL) {
//            LZLog(@"C函数反越狱1.3 access ===> %s", path);
//            return -1;
//        }
//    }
//    int r = orig_access(path, mode);
//    return r;
//}
//#pragma mark -
//#pragma mark - anti stat 系列函数检测 Cydia 等工具
//static int (*orig_stat)(const char *, struct stat *);
//static int new_stat(const char * path, struct stat * info){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strstr(path, str.UTF8String) != NULL){
//            //            info->st_size =
//            LZLog(@"C函数反越狱2 stat ===> %@", str);
//            return -1;
//        }
//    }
//    int result = orig_stat(path, info);
//    return result;
//}
//
//static int (*orig_lstat)(const char *, struct stat *);
//static int new_lstat(const char * path, struct stat * info){
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strstr(path, str.UTF8String) != NULL){
//            //            info->st_mode ^= S_IFLNK;
//            LZLog(@"C函数反越狱2.1 lstat ===> %@", str);
//            return -1;
//        }
//    }
//    int result = orig_lstat(path, info);
//    return result;
//}
//
//#pragma mark -
//#pragma mark - getenv 查看当前程序运行的环境变量
//static char *(*orig_getenv)(const char *);
//static char *new_getenv(const char *s1){
//    if (strcmp(s1, "DYLD_INSERT_LIBRARIES") == 0) {
//        LZLog(@"C函数反越狱3 getenv:%s",s1);
//        return NULL;
//    }
//    return orig_getenv(s1);
//}
//
//#pragma mark -
//#pragma mark - 检索一下自应用程序是否被链接了异常动态库。 列出所有已链接的动态库
//// const char* _dyld_get_image_name(uint32_t image_index)
//static char *(*orig__dyld_get_image_name)(uint32_t);
//static char *new__dyld_get_image_name(uint32_t image_index){
//    char *r = orig__dyld_get_image_name(image_index);
//    for (NSString *str in jailbreakFileAtPath()) {
//        if (strcmp(r, str.UTF8String) == 0){
//            LZLog(@"C函数反越狱4.1 _dyld_get_image_name ===> %@", str);
//            return "/MrLiang";
//        }
//    }
//    return r;
//}
//
//#pragma mark -
//#pragma mark - 看函数出自哪个裤
//static int (*orig_dladdr)(const void *, Dl_info *);
//static int new_dladdr(const void * func_ptr, Dl_info * dylib_info){
//    int reuslt = orig_dladdr(func_ptr, dylib_info);
//    for (int i = 0; i < sizeof(hook_list)/sizeof(hook_list[0]); i ++){
//        struct hook_t hook = hook_list[i];
//        if (func_ptr == hook.func_ptr) {
//            const char *orig_path = dylib_info->dli_fname;
//            dylib_info->dli_fname = hook.orig_adrr_path;
//            LZLog(@"C函数反越狱5 dladdr ===> name=%s, origpath =%s, newpath=%s", hook.func_name  , orig_path,dylib_info->dli_fname);
//        }
//    }
//    return reuslt;
//}
//
//#pragma mark -
//#pragma mark - strstr 打印
//static char *(*orig_strstr)(const char *, const char *);
//static char *new_strstr(const char *s1, const char *s2){
//    if (s1 == NULL) {
//        return NULL;
//    }
//    //    printf("__s1 = %s, __s2 = %s\n", __s1, __s2);
//    return orig_strstr(s1, s2);
//}
//
//
//#pragma mark - task_get_exception_ports
//static kern_return_t (*orig_task_get_exception_ports)
//(
// task_inspect_t task,
// exception_mask_t exception_mask,
// exception_mask_array_t masks,
// mach_msg_type_number_t *masksCnt,
// exception_handler_array_t old_handlers,
// exception_behavior_array_t old_behaviors,
// exception_flavor_array_t old_flavors
// );
//static kern_return_t my_task_get_exception_ports
//(
// task_inspect_t task,
// exception_mask_t exception_mask,
// exception_mask_array_t masks,
// mach_msg_type_number_t *masksCnt,
// exception_handler_array_t old_handlers,
// exception_behavior_array_t old_behaviors,
// exception_flavor_array_t old_flavors
// ){
//    kern_return_t r = orig_task_get_exception_ports(task, exception_mask, masks, masksCnt, old_handlers, old_behaviors, old_flavors);
////    if (info->ports[i] !=0 || info->flavors[i] == THREAD_STATE_NONE)
//    for (int i = 0; i < *masksCnt; i++)
//    {
//        if (old_handlers[i] != 0) {
//            old_handlers[i] = 0;
//        }
//        if (old_flavors[i]  == THREAD_STATE_NONE) {
//            old_flavors[i] = ARM_EXCEPTION_STATE;
//        }
//    }
//    
//    return r;
//}
//
//CHConstructor{
//    rebind_symbols((struct rebinding[1]){{"task_get_exception_ports", my_task_get_exception_ports, (void*)&orig_task_get_exception_ports}},1);
//
//    
//    rebind_symbols((struct rebinding[1]){{"fopen", new_fopen, (void*)&orig_fopen}},1);
//    rebind_symbols((struct rebinding[1]){{"open", new_open, (void*)&orig_open}},1);
//
//    rebind_symbols((struct rebinding[1]){{"stat", new_stat, (void*)&orig_stat}},1);
//    rebind_symbols((struct rebinding[1]){{"lstat", new_lstat, (void*)&orig_lstat}},1);
//
//    rebind_symbols((struct rebinding[1]){{"getenv", new_getenv, (void*)&orig_getenv}},1);
//
//    rebind_symbols((struct rebinding[1]){{"_dyld_get_image_name", new__dyld_get_image_name, (void*)&orig__dyld_get_image_name}},1);
//
//    rebind_symbols((struct rebinding[1]){{"dladdr", new_dladdr, (void*)&orig_dladdr}},1);
//
//    rebind_symbols((struct rebinding[1]){{"access", new_access, (void*)&orig_access}},1);
//
//    rebind_symbols((struct rebinding[1]){{"strstr", new_strstr, (void*)&orig_strstr}},1);
//
//    refreshHook_list();
//}


CHDeclareClass(AADeviceInfo)

CHOptimizedMethod0(self, id, AADeviceInfo, appleIDClientIdentifier){
    id r = CHSuper0(AADeviceInfo, appleIDClientIdentifier);
    return r;
}

//CHOptimizedClassMethod1(self, id, AADeviceInfo, valueForKey, NSString *, key){
//    id r = CHSuper1(AADeviceInfo, valueForKey, key);
//    NSLog(@"key = %@, value = %@", key, r);
//    return r;
//}

CHOptimizedMethod1(self, id, AADeviceInfo, valueForKey, NSString *, key){
    id r = CHSuper1(AADeviceInfo, valueForKey, key);
    NSLog(@"key = %@, value = %@", key, r);
    return r;
}
//CHOptimizedMethod0(self, id, AADeviceInfo, appleIDClientIdentifier){
//    id r = CHSuper0(AADeviceInfo, appleIDClientIdentifier);
//    return r;
//}


CHConstructor{
    CHLoadLateClass(AADeviceInfo);
    
//    CHHook0(AADeviceInfo, appleIDClientIdentifier);
    CHClassHook0(AADeviceInfo, appleIDClientIdentifier);
    
//    CHHook1(AADeviceInfo, valueForKey);
    CHClassHook1(AADeviceInfo, valueForKey);

}
