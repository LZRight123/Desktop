//
//  CCLog.h
//  HookExampleDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
// 1.本地原始文件修改看项目文件改了 -> 会改变
// 2.项目文件改变，看本地原始文件改变 -> 会改变
// 3.git远端文件改变，pull下来，看项目文件改变 -> ?
// 4.测试新的 push内容
//💊👌🐒🐂👏🏿🌹⬆️㊙️🐱🎩🐂🐲✈️👀🚀🔥🎮💕🏆🎁 💯 🌹
#if false
# define CCLog(fmt, ...) NSLog((@"[文件名:%@]" "[函数名:%s]" "[行号:%d] --- " fmt), [[NSString stringWithUTF8String:__FILE__]componentsSeparatedByString:@"/"].lastObject, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define CCLog(...);
#endif

@interface CCLogTool : NSObject
@property (nonatomic, strong, readonly) NSArray *requestList;//
@property (nonatomic, strong, readonly) NSArray *JSONSerializationList;//
@property (nonatomic, strong, readonly) NSArray *wrietFilePathList;//
@property (nonatomic, strong, readonly) NSArray *containingBundleList;
///类LSApplicationWorkspace.installedPlugins->[LSPlugInKitProxy]->LSApplicationProxy 获取
@property (nonatomic, strong, readonly) NSArray *applicationIdentifierList;

@property (nonatomic, strong, readonly) NSArray *privateApis;//
@property (nonatomic, strong, readonly) NSArray *privateApiDetails;//

#define CCLogManager [CCLogTool manager]
+ (instancetype)manager;
- (void)addLog:(NSString *)log;
/*
 [CCLogManager addRequest:<#name#>]
 po [CCLogTool manager].requestList
 */
- (void)addRequest:(NSString *)req;
/*
 [CCLogManager addJSONSerialization:<#name#>]
 po [CCLogTool manager].JSONSerializationList
 */
- (void)addJSONSerialization:(NSString *)ser;
/*
 [CCLogManager addWriteFilePath:<#name#>]
 po [CCLogTool manager].wrietFilePathList
 */
- (void)addWriteFilePath:(NSString *)path;
/*
 [CCLogManager addContainingBundle:<#name#>]
 po [CCLogTool manager].containingBundleList
 */
- (void)addContainingBundle:(NSString *)arg;
/*
 [CCLogManager addApplicationIdentifier:<#name#>]
 po [CCLogTool manager].applicationIdentifierList
 */
- (void)addApplicationIdentifier:(NSString *)arg;
/*
 [CCLogManager addPrivateApiDetail:<#name#>]
 po [CCLogTool manager].privateApiDetails
 */
- (void)addPrivateApiDetail:(NSString *)arg;
@end

#pragma mark -
#pragma mark - 常量
static NSString * bunlderID = @"com.ozo.money.wall";
static NSString * myDylibName = @"congmingzhuanDylib";
static NSString * teamId = @"58Y74FY8QK";//证书 团队ID
//static NSString * bunlderID = @"app.xianka.com";
//static NSString * myDylibName = @"IdleCommodity_projectDylib";
//static NSString * teamId = @"58Y74FY8QK";//证书 团队ID
static BOOL openAntiAntiNetworkProxy = true;
static BOOL openAntiAntiDebug = false;
static BOOL openAntiAntiJialbreak = true;


static NSArray *jailbreakFileAtPath(){
    return @[
             myDylibName,
             @"cydia",
             @"Cydia",
             @"zebra",
             @"zbra",
             @"sileo",
             @"TweakInject",
             @"Cephei",
             @"Substrate",
             @"substitute",
             @"substrate",
             @"applist",
             @"electra/",
             @"/Library/LaunchDaemons",
             @"etc/hosts.thireus",
             @"System/Library/hosts.lmb",
             @"/.installed_unc0ver",
             @"/var/tmp/cydia",
             @"var/tmp/sileo",
             @"rocketbootstrap",
             @"colorpicker",
             @"usr/lib/TweakInject",
             @"/var/mobile/Library/SB",
             @"/Applications/Sileo.app",
             @"/Applications/Zebra.app",
             @"/Applications/Cydia.app/Cydia",
             @"/Applications/Cydia.app",
             @"Applications/Cydia.app",
             @"/Applications/FakeCarrier.app",
             @"/Applications/Icy.app",
             @"/Applications/Iny.app",
             @"/Applications/iFile.app",
             @"/Applications/Activator.app",
             @"/Applications/IntelliScreen.app",
             @"/Applications/MxTube.app",
             @"/Applications/RockApp.app",
             @"/Applications/SBSettings.app",
             @"/Applications/blackra1n.app",
             @"/User/Applications/",
             @"/Library/Activator",
             @"/Library/Flipswitch",
             @"/Library/Frameworks/CydiaSubstrate.framework",
             @"/Library/MobileSubstrate",
             @"/Library/MobileSubstrate/DynamicLibraries",
             @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
             @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
             @"/Library/MobileSubstrate/MobileSubstrate.dylib",
             @"/Library/MobileSubstrateMobileSubstrate.dylib",
             @"/Library/Switchs",
             @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
             @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
             @"/bin/bash",
             @"/bin/sh",
             @"/bin/su",
             @"/etc/apt",
             @"/etc/apt/",
             @"/etc/clutch.conf",
             @"/etc/clutch_cracked.plist",
             @"/etc/ssh/sshd_config",
             @"/private/vstb_writable_check",
             @"/private/etc/fstab",
             @"/private/Miitomo",
             @"/private/var/lib/apt",
             @"/private/var/lib/apt/",
             @"/private/var/lib/cydia/",
             @"/var/lib/cydia/",
             @"/private/var/tmp/cydia.log",
             @"/private/var/mobile/Library/SBSettings/Themes",
             @"/private/var/mobileLibrary/SBSettingsThemes/",
             @"/private/var/stash",
             @"/private/var/stash/",
             @"/private/var/tmp/Cydia.log",
             @"/usr/arm-apple-darwin9",
             @"/usr/bin/ssh",
             @"/usr/bin/sshd",
             @"/usr/binsshd",
             @"/usr/sbinsshd",
             @"/usr/lib/pam",
             @"/usr/lib/python2.5",
             @"/usr/libexec/cydia",
             @"/usr/libexec/cydia/",
             @"/usr/libexec/sftp-server",
             @"/usr/libexec/ssh-keysign",
             @"/usr/libexec/ssh",
             @"/usr/sbin/sshd",
             @"/var/cache/apt",
             @"/var/cache/apt/",
             @"/var/cache/clutch.plist",
             @"/var/cache/clutch_cracked.plist",
             @"/var/lib/apt",
             @"/var/lib/apt/",
             @"/var/lib/clutch/overdrive.dylib",
             @"/var/lib/cydia",
             @"/var/lib/dpkg/info",
             @"/var/log/syslog",
             @"/var/root/Documents/Cracked/",
             @"/var/tmp/cydia.log",
             @"/var/stash/Library/Ringstones",
             @"/var/stash/Library/Wallpaper",
             @"/var/stash/usr/include",
             @"/var/stash/usr/libexec",
             @"/var/stash/usr/share",
             @"/Systetem/Library/LaunchDaemons/com.ikey.bbot.plist",
             @"/System/Library/LaunchDaemons/com.saurik.Cy@dia.Startup.plist",
             @"/Library/MobileSubstrate/MobileSubstrate.dylib",
             @"/var/cache/apt/",
             @"/var/lib/apt/",
             @"/var/log/syslog",
             @"/bin/bash",
             @"/bin/sh",
             @"/etc/apt/",
             @"/etc/ssh/sshd_config",
             @"/usr/libexec/ssh-keysign",
             @"/Library/MobileSubstrate/MobileSubstrate.dylib",
             @"/var/cache/apt",
             @"/var/log/syslog",
             @"/var/tmp/cydia.log",
             @"/bin/bash",
             @"/bin/sh",
             @"/usr/sbin/sshd",
             @"/etc/apt",
             @"/var/root/.tastest",
             @"/Library/Preferences/com.apple.security.plist",
             @"/private/var/mobile/home/duh",
             @"/etc/rel",
             @"/System/Library/LaunchDaemons/com.apple.period.plist",
             @"/System/Library/LaunchDaemons/com.apple.ksyslog.plist",
             @"/private/var/mobile/home/syslog",
             @"/private/var/mobile/home/sshd",
             @"/Library/MobileSubstrate/DynamicLibraries/sfbase.dylib",
             @"/usr/lib/libsubstrate.dylib",
             @"/boot",
             @"/library/MobileSubstrate/MobileSubstrate.dylib",
             @"/mnt",
             //             @"/lib",
             @"/panguaxe",
             @"/panguaxe.installed",
             @"/private/",
             @"/private/var/mobile/Media/panguaxe.installed",
             @"/private/var/lib/dpkg/info/io.pangu.axe7.list",
             @"/private/var/lib/dpkg/info/io.pangu.axe7.prerm",
             @"/System/Library/LaunchDaemons/io.pangu.axe.untether.plist",
             @"/private/var/lib/dpkg/info/taiguntether83x.extrainst_",
             @"/private/var/lib/dpkg/info/taiguntether83x.list",
             @"/private/var/lib/dpkg/info/taiguntether83x.preinst",
             @"/private/var/lib/dpkg/info/taiguntether83x.prerm",
             @"/taig/",
             @"/taig/taig",
             @"/private/var/lib/dpkg/info/io.pangu.fuxiqin9.list",
             @"/private/var/lib/dpkg/info/io.pangu.fuxiqin9.prerm",
             @"/pguntether",
             @"/var/stash/",
             @"/var/stash",
             @"/private/var/cache/apt/",
             @"/private/var/log/syslog",
             @"/private/etc/apt/",
             @"/private/etc/ssh/sshd_config",
             @"/var/mobile/Library/Application Support/Flex3/patches.plist",
             @"/private/etc/dpkg/origins/debian",
             @"/bin/gunzip",
             @"/bin/gzip",
             @"/bin/tar",
             @"/Library/MobileSubstrate/DynamicLibraries/",
             @"/private/var/cache/apt",
             @"/etc/fstab",
             @"/bin/ps",
             @"/Systetem/Library/LaunchDaemons/com.ikey.bbot.plist",
             @"/Library/MobileSubstrate/DynamicLibraries/xCon.dylib",
             @"/usr/lib/TsProtePass.dylib",
             @"/var/stash/Library/Ringtones",
             @"/var/stash/usr/arm-apple-darwin9",
             @"/private/masbog.txt",
             @"/usr/bin/cycript",
             @"/usr/bin/cynject",
             @"/usr/sbin/frida-server",
             @"/private/var/db/stash/",
             @"/var/tmp//ct.shutdown",
             @"/var/tmp/ct.shutdown",
             @"/var/tmp//cydia.log",
             @"/var/tmp//pgloader",
             @"/var/tmp/pgloader",
             @"/var/tmp//.pangu93loaded",
             @"/var/tmp/.pangu93loaded",
             @"/var/tmp//RestoreFromBackupLock",
             @"/var/tmp/RestoreFromBackupLock",
             @"/Library/LaunchDaemons/com.openssh.sshd.plist",
             @"/private/var/db/stash",
             @"/bin/mv",
             @"/private/jailbreak.txt",
             @"/Library/MobileSubstrate/",
             @"var/lib/apt",
             @"var/lib/sileo",
             @"/private/var/TestPB16.file",
             @"/etc/TestPB16.file",
             @"/Applications/TestPB16.file",
             @"/System/Library/Caches/com.apple.dyld/enable-dylibs-to-override-cache",
             //             @"/usr/lib/libmis.dylib", iOS代码签名有关
             @"/usr/lib/pangu_xpcd.dylib",
             @"/System/Library/LaunchDaemons/io.pangu.untether.plist",
             @"/xuanyuansword",
             @"/xuanyuansword.installed",
             @"/evasi0n7",
             @"/System/Library/LaunchDaemons/com.evad3rs.evasi0n7.untether.plist",
             @"/usr/lib/libpatcyh.dylib",
             @"/usr/share/bigboss/icons/bigboss.png",
             @"/Library/MobileSubstrate/DynamicLibraries/tsProtector.dylib",
             @"/Library/PreferenceBundles/tsProtectorSettings.bundle",
             @"/Library/PreferenceLoader/Preferences/tsProtectorSettings.plist",
             @"/private/var/lib/xcon",
             @"/Library/MobileSubstrate/DynamicLibraries/MobileSafety.dylib",
             @"/.cydia_no_stash",
             @"/.installed_yaluX",
             @"/private/var/log/apt/term.log",
             @"/Library/LaunchDaemons/re.frida.server.plist",
             @"/usr/sbin/frida-server",
             @"/sbin/reboot",
             @"/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate",
             @"/etc/ssh",
             @"Library/MobileSubstrate",
             @"Library/MobileSubstrate/DynamicLibraries",
             @"/private/var/lib",
             @"/private/var/mobile/Library/SBSettings",
             @"/var/cache",
             @"/var/lib",
             @"/etc/ssh",
             @"/User/Library/Cydia",
             @"/private/var/evasi0n", //238
             ];
}


#pragma mark -
#pragma mark - 函数
static BOOL isCallFromOriginApp(){
    NSArray *address = [NSThread callStackReturnAddresses];
    Dl_info temp_info = {0};
    dladdr((void *)[address[1] longLongValue], &temp_info);
        
    Dl_info info = {0};
    if(dladdr((void *)[address[2] longLongValue], &info) == 0) return NO;
    NSString *path = [NSString stringWithUTF8String:info.dli_fname];
    if (strstr(path.UTF8String, NSBundle.mainBundle.bundlePath.UTF8String)) {
        //二进制来自 ipa 包内
        if (strstr(path.lastPathComponent.lowercaseString.UTF8String , myDylibName.lowercaseString.UTF8String)) {
            // 二进制是插件本身
            return NO;
        } else {
            //    二进制是原始app
            return YES;
        }
    } else {
        //    二进制是系统或者越狱插件
        return NO;
    }
}

static BOOL isJailbreakPath(NSString *path){
    for (NSString *str in jailbreakFileAtPath()) {
        if ([path.lowercaseString isEqualToString:str.lowercaseString]){
            return true;
        }
    }
    return false;
}

static BOOL isJailbreakUTF8Path(const char *path){
    return isJailbreakPath([NSString stringWithUTF8String:path]);
}


#pragma mark -
#pragma mark - 临时声明
extern int ptrace(int request, pid_t pid, caddr_t addr, int data);

//extern int system(const char *s1);




