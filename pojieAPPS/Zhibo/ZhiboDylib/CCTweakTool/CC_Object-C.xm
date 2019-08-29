// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "CCHelpTool.h"
#import <dlfcn.h>

#pragma mark -
#pragma mark - NSBundle
%hook NSBundle
- (NSString *)bundleIdentifier{
    if (isCallFromOriginApp()){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return %orig;
}

- (NSString *)objForInfoKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    
    return %orig;
}

- (id)valueForKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return %orig;
}

- (id)objectForInfoDictionaryKey:(NSString *)key{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return %orig;
}

- (NSDictionary *)infoDictionary{
    if (isCallFromOriginApp() == false) { return %orig; }

    CCLog(@"替换了infoDictionary->bundleIdentifier");
    NSMutableDictionary *r = [(NSDictionary *)%orig mutableCopy];
    r[@"CFBundleIdentifier"] = bunlderID;
    r[@"CFBundleShortVersionString"] = @"1.7.9";
    return r;
}

- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([name hasPrefix:@"embedded"]) {
        CCLog(@"[文件名:CCObject-C.xm][类名:NSBundle][方法名:URLForResource:withExtension:]检测了embedded.mobileprovision");
//        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSBundle][方法名:URLForResource:withExtension:]检测了embedded.mobileprovision"];
    }
    return %orig;
}

- (NSString *)pathForResource:(NSString *)name ofType:(NSString *)ext{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([name hasPrefix:@"embedded"]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSBundle][方法名:pathForResource:ofType:]检测了embedded.mobileprovision"];
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
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];

        return true;
    }
    return %orig;
}

- (BOOL)containsString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aString containsString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    
    return %orig;
}

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error{
    if ([path hasPrefix:@"/private"]){
        if (error != nil) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:513 userInfo:@{}];
        }
        CCLog(@"检测了文件权限 writeToFile: %@", path);
        return false;
    }
    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSString][方法名:writeToFile:%@]检测了 文件权限", path]];
        [CCLogManager addWriteFilePath:path];
    }
    
    
    return %orig;
}
%end

%hook NSString
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error{
    if ([path hasPrefix:@"/private"]){
        CCLog(@"检测了文件权限 writeToFile: %@", path);
        if (error != nil) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:513 userInfo:@{}];
        }
        return false;
    }
    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSString][方法名:writeToFile:%@]检测了 文件权限", path]];
        [CCLogManager addWriteFilePath:path];
    }
    
    return %orig;
}

- (BOOL)isEqualToString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aString isEqualToString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];
        return true;
    }
    return %orig;
}

- (BOOL)containsString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aString containsString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    return %orig;
}

- (NSString *)stringByAppendingPathComponent:(NSString *)str{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([str hasPrefix:@"embedded"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:stringByAppendingPathComponent:]检测了embedded.mobileprovision"];
    }
    return %orig;
}
- (NSString *)stringByAppendingString:(NSString *)aString{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aString hasPrefix:@"embedded"] || [aString hasPrefix:@"/embedded"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:stringByAppendingString:]检测了embedded.mobileprovision"];
    }
    return %orig;
}
%end


















#pragma mark -
#pragma mark - NSData
%hook NSData
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile{
    if ([path hasPrefix:@"/private"]){
        return false;
    }
    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSString][方法名:writeToFile:%@]检测了 文件权限", path]];
        [CCLogManager addWriteFilePath:path];
    }
    
    return %orig;
}
%end












#pragma mark -
#pragma mark - NSDictionary
%hook __NSDictionaryI
- (id)objectForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return %orig;
}

- (id)valueForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
    }
    return %orig;
}
%end

%hook NSDictionary
- (id)objectForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }

    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return %orig;
}

- (id)valueForKey:(id)aKey{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
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
        CCLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        CCLog(@"检测了cydia");
        return false;
    }
    return %orig;
}
- (BOOL)openURL:(NSURL*)url{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    NSString *tempStr = url.absoluteString.lowercaseString;
    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
        CCLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        CCLog(@"检测了cydia");
        return false;
    }
    
    return %orig;
}
%end









#pragma mark -
#pragma mark - IDFA ASIdentifierManager
%hook ASIdentifierManager
- (NSUUID *)advertisingIdentifier{
    CCLog(@"检测了IDFA");
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
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isWritableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isExecutableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)isDeletableFileAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (BOOL)isUbiquitousItemAtURL:(NSURL *)url{
    if (isJailbreakPath(url.absoluteString)) {
        CCLog(@"检测了:%@", url.absoluteString);
        return false;
    }
    return %orig;
}

- (BOOL)fileExistsAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        if (strstr(path.UTF8String, "/private/var/lib/apt/")) {
            CCLog(@"检测了:%@", path);
        }
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}
- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (BOOL)getFileSystemRepresentation:(void *)arg1 maxLength:(long long)arg2 withPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return %orig;
}

- (NSData *)contentsAtPath:(NSString *)path{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return nil;
    }
    return %orig;
}

- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return nil;
    }
    return %orig;
}

- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error{
    if ([path hasPrefix:@"/private"]){
        if (error != nil) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:513 userInfo:@{}];
        }
        CCLog(@"检测了文件权限 removeItemAtPath: %@", path);

        return false;
    }
    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSFileManager][方法名:removeItemAtPath:%@]检测了 文件权限", path]];
        [CCLogManager addWriteFilePath:path];
    }
    return %orig;
}

%end










#pragma mark -
#pragma mark - 网络请求 NSMutableURLRequest
%hook NSMutableURLRequest
- (void)setHTTPBody:(NSData *)data{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    %orig;
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *logstr = [NSString stringWithFormat:@"发生了网络请求 url: %@?%@", self.URL.absoluteString, jsonString];
    [CCLogManager addRequest:logstr];
    
}

- (NSURL *)URL{
    if (isCallFromOriginApp() == false) { return %orig; }
    
    NSURL *url = %orig;
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:url.absoluteString];
    NSString *logstr = [NSString stringWithFormat:@"发生了网络请求 NSMutableURLRequest.URL: %@",str];

    [CCLogManager addRequest:logstr];
    
    return url;
}

%end











#pragma mark -
#pragma mark - 数据解析NSJSONSerialization
%hook NSJSONSerialization
+ (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error{
    if (isCallFromOriginApp() == false) { return %orig; }

    id result = %orig(data, opt, error);
    
    NSString *logstr = [NSString stringWithFormat:@"解析数据 JSONObjectWithData: %@",result];
    [CCLogManager addJSONSerialization:logstr];
    CCLog(@"解析数据 JSONObjectWithData %@",result);
    
    return result;
}
%end
