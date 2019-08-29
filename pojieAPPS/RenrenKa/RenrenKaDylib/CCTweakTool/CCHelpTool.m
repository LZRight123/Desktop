//
//  CCLog.m
//  HookExampleDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "CCHelpTool.h"


@interface CCLogTool()
@property (nonatomic, strong) NSMutableArray *__requestList;//
@property (nonatomic, strong) NSMutableArray *__JSONSerializationList;//
@property (nonatomic, strong) NSMutableArray *__wrietFilePathList;//
@property (nonatomic, strong) NSMutableSet *__containingBundleList;//
@property (nonatomic, strong) NSMutableSet *__applicationIdentifierList;
@property (nonatomic, strong) NSMutableSet *__privateApiDetails;//


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableSet *loglist;//
@end
@implementation CCLogTool
+ (instancetype)manager{
    static CCLogTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
        tool.loglist = [NSMutableSet set];
        tool.__requestList = [NSMutableArray array];
        tool.__JSONSerializationList = [NSMutableArray array];
        tool.__wrietFilePathList = @[].mutableCopy;
        tool.__containingBundleList = [NSMutableSet set];
        tool.__applicationIdentifierList = [NSMutableSet set];
        tool.__privateApiDetails = [NSMutableSet set];
    });
    return tool;
}

- (void)addLog:(NSString *)log{
    [self.loglist addObject:log];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:true];
    }
}

- (void)addRequest:(NSString *)req{
    if (!req) {
        return;
    }
    [self.__requestList addObject:req];
}

- (void)addJSONSerialization:(NSString *)ser{
    if (!ser) {
        return;
    }
    [self.__JSONSerializationList addObject:ser];
}

- (void)addWriteFilePath:(NSString *)arg{
    if (!arg) {
        return;
    }
    [self.__wrietFilePathList addObject:arg];
}

- (void)addContainingBundle:(NSString *)arg{
    if (!arg) {
        return;
    }
    [self.__containingBundleList addObject:arg];
}

- (void)addApplicationIdentifier:(NSString *)arg{
    if (!arg) {
        return;
    }
    [self.__applicationIdentifierList addObject:arg];
}

- (void)addPrivateApiDetail:(NSString *)arg{
    if (!arg) {
        return;
    }
    [self.__privateApiDetails addObject:arg];
}

- (void)fire{
    NSString *log = [self.loglist.allObjects componentsJoinedByString:@",\n"];
    NSLog(@"对方正在检测🔥🔥🔥🔥🔥🔥🔥🔥\n(\n%@\n)", log);
}

#pragma mark -
#pragma mark - getter
- (NSArray *)requestList{
    return self.__requestList.copy;
}

- (NSArray *)JSONSerializationList{
    return self.__JSONSerializationList.copy;
}

- (NSArray *)wrietFilePathList{
    return self.__wrietFilePathList.copy;
}

- (NSArray *)containingBundleList{
    return self.__containingBundleList.allObjects;
}

- (NSArray *)applicationIdentifierList{
    return self.__applicationIdentifierList.allObjects;
}

- (NSArray *)privateApiDetails{
    return self.__privateApiDetails.allObjects;
}

#pragma mark -
#pragma mark - help getter
- (NSArray *)privateApis{
    return @[
             @"registeredDate",
             @"com.apple.mobilesafari",
             @"containerWithIdentifier:error:",
             @"defaultWorkspace",
             @"applicationProxyForIdentifier:",
             @"isPurchasedReDownload",
             @"allInstalledApplications",
             @"openSensitiveURL:withOptions:",
             @"installedPlugins",
             @"applicationDSID",
             @"LSApplicationRestrictionsManager",
             @"MCMAppContainer",
             @"Prefs:root=Privacy&path=ADVERTISING",
             @"appleIDClientIdentifier",
             @"/System/Library/PrivateFrameworks/AppleAccount.framework",
             @"setWhitelistedBundleIDs:",
             @"containingBundle",
             @"applicationIdentifier",
             @"LSApplicationWorkspace",
             @"sharedInstance",
             @"LSApplicationProxy",
             @"itemID",
             @"AADeviceInfo",
             @"openApplicationWithBundleID:",
             @"/System/Library/PrivateFrameworks/MobileContainerManager.framework",
             @"openSensitiveURL:withOptions:",
             @"shortVersionString",
             ];
}

@end


#pragma mark -
#pragma mark - 控制台中文输出

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"{\n"];
    NSArray *allKey = self.allKeys;
    for (int i = 0; i < allKey.count; i++) {
        id value = self[allKey[i]];
        NSString *lastSymbol = (allKey.count == i + 1) ? @"":@";";
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
            
        } else {
            
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],value,lastSymbol];
            
        }
    }
    [mStr appendFormat:@"%@}",tab];
    return mStr;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"(\n"];
    for (int i = 0; i < self.count; i++) {
        NSString *lastSymbol = (self.count == i + 1) ? @"":@",";
        id value = self[i];
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@%@\n",tab,[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
        } else {
            [mStr appendFormat:@"\t%@%@%@\n",tab,value,lastSymbol];
        }
    }
    [mStr appendFormat:@"%@)",tab];
    return mStr;
    
}

@end
