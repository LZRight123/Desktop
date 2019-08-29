// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "LZHelpTool.h"
#import <dlfcn.h>

#pragma mark -
#pragma mark - NSBundle
%hook NSBundle
//- (NSString *)bundleIdentifier{
//    if (isCallFromOriginApp()){
//        LZLog(@"检测了bundleIdentifier");
//        return bunlderID;
//    }
//    return %orig;
//}

- (NSString *)objForInfoKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        LZLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    
    return %orig;
}

- (id)valueForKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        LZLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return %orig;
}

- (id)objectForInfoDictionaryKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        LZLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return %orig;
}

- (NSDictionary *)infoDictionary{
    if (isCallFromOriginApp() == false) { return %orig; }

    LZLog(@"替换了infoDictionary->bundleIdentifier");
    NSMutableDictionary *r = [(NSDictionary *)%orig mutableCopy];
    r[@"CFBundleIdentifier"] = bunlderID;
    return r;
}

- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([name hasPrefix:@"embedded"]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSBundle][方法名:URLForResource:withExtension:]检测了embedded.mobileprovision"];
    }
    return %orig;
}

- (NSString *)pathForResource:(NSString *)name ofType:(NSString *)ext{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([name hasPrefix:@"embedded"]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSBundle][方法名:pathForResource:ofType:]检测了embedded.mobileprovision"];
    }
    return %orig;
}
%end









#pragma mark -
#pragma mark - NSString
%hook __NSCFConstantString
- (BOOL)isEqualToString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aString isEqualToString:teamId]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];

        return true;
    }
    return %orig;
}

- (BOOL)containsString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aString containsString:teamId]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    return %orig;
}

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error{
    [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:writeToFile:]检测了 文件权限"];
    return %orig;
}
%end

%hook NSString
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error{
    [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:writeToFile:]检测了 文件权限"];
    return %orig;
}

- (BOOL)isEqualToString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aString isEqualToString:teamId]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];
        return true;
    }
    return %orig;
}

- (BOOL)containsString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aString containsString:teamId]) {
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    return %orig;
}

- (NSString *)stringByAppendingPathComponent:(NSString *)str{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([str hasPrefix:@"embedded"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:stringByAppendingPathComponent:]检测了embedded.mobileprovision"];
    }
    return %orig;
}
- (NSString *)stringByAppendingString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aString hasPrefix:@"embedded"] || [aString hasPrefix:@"/embedded"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSString][方法名:stringByAppendingString:]检测了embedded.mobileprovision"];
    }
    return %orig;
}
%end


















#pragma mark -
#pragma mark - NSData
%hook NSData
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile{
    [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSData][方法名:writeToFile:]检测了 文件权限"];
    return %orig;
}
%end










#pragma mark -
#pragma mark - NSDictionary
%hook __NSDictionaryI
- (id)objectForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return %orig;
}

- (id)valueForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
    }
    return %orig;
}
%end

%hook NSDictionary
- (id)objectForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return %orig;
}

- (id)valueForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [LZLogManager addLog:@"[文件名:LZObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
    }
    return %orig;
}
%end









#pragma mark -
#pragma mark - UIApplication
%hook UIApplication
- (BOOL)canOpenURL:(NSURL *)url{
    if (isCallFromOriginApp() == false) { return %orig; }

    NSString *tempStr = url.absoluteString.lowercaseString;
    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
        LZLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        LZLog(@"检测了cydia");
        return false;
    }
    return %orig;
}
- (BOOL)openURL:(NSURL*)url{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    NSString *tempStr = url.absoluteString.lowercaseString;
    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
        LZLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        LZLog(@"检测了cydia");
        return false;
    }
    
    return %orig;
}
%end









#pragma mark -
#pragma mark - IDFA ASIdentifierManager
%hook ASIdentifierManager
- (NSUUID *)advertisingIdentifier{
    LZLog(@"检测了IDFA");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *idfa = [userDefaults stringForKey:@"com.unique.idfa"];
    if(!idfa)
    {
        idfa = [NSUUID UUID].UUIDString;
        [userDefaults setObject:idfa forKey:@"com.unique.idfa"];
        [userDefaults synchronize];
    }
    NSUUID *udid = [[NSUUID alloc] initWithUUIDString:idfa];
    return udid;
}
%end









#pragma mark -
#pragma mark - UIDevice
%hook UIDevice
- (NSString *)name{
    return @"iPhone";
}
%end









#pragma mark -
#pragma mark - NSFileManager
%hook NSFileManager
- (BOOL)isReadableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isWritableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isExecutableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isDeletableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (BOOL)isUbiquitousItemAtURL:(NSURL *)url{
    if (isJailbreakPath(url.absoluteString)) {
        LZLog(@"检测了:%@", url.absoluteString);
        return false;
    }
    return %orig;
}

- (BOOL)fileExistsAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (BOOL)getFileSystemRepresentation:(void *)arg1 maxLength:(long long)arg2 withPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (NSData *)contentsAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return nil;
    }
    return %orig;
}

- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
    if (isJailbreakPath(path)) {
        LZLog(@"检测了:%@", path);
        return nil;
    }
    return %orig;
}

%end
