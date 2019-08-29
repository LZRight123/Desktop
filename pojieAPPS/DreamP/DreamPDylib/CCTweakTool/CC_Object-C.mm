#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/Qianka/QiankaDylib/CCTweakTool/CC_Object-C.xm"


#import <UIKit/UIKit.h>
#import "CCHelpTool.h"
#import <dlfcn.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class NSMutableURLRequest; @class NSFileManager; @class UIApplication; @class __NSCFConstantString; @class NSJSONSerialization; @class NSBundle; @class UIDevice; @class ASIdentifierManager; @class NSString; @class NSDictionary; @class NSData; @class __NSDictionaryI; 
static NSString * (*_logos_orig$_ungrouped$NSBundle$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$NSBundle$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$NSBundle$objForInfoKey$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * _logos_method$_ungrouped$NSBundle$objForInfoKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static id (*_logos_orig$_ungrouped$NSBundle$valueForKey$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static id _logos_method$_ungrouped$NSBundle$valueForKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static id (*_logos_orig$_ungrouped$NSBundle$objectForInfoDictionaryKey$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static id _logos_method$_ungrouped$NSBundle$objectForInfoDictionaryKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *); static NSDictionary * (*_logos_orig$_ungrouped$NSBundle$infoDictionary)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL); static NSDictionary * _logos_method$_ungrouped$NSBundle$infoDictionary(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL); static NSURL * (*_logos_orig$_ungrouped$NSBundle$URLForResource$withExtension$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSURL * _logos_method$_ungrouped$NSBundle$URLForResource$withExtension$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSString * (*_logos_orig$_ungrouped$NSBundle$pathForResource$ofType$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSString * _logos_method$_ungrouped$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static BOOL (*_logos_orig$_ungrouped$__NSCFConstantString$isEqualToString$)(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$__NSCFConstantString$isEqualToString$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$__NSCFConstantString$containsString$)(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$__NSCFConstantString$containsString$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$)(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *, BOOL, NSStringEncoding, NSError **); static BOOL _logos_method$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST, SEL, NSString *, BOOL, NSStringEncoding, NSError **); static BOOL (*_logos_orig$_ungrouped$NSString$writeToFile$atomically$encoding$error$)(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *, BOOL, NSStringEncoding, NSError **); static BOOL _logos_method$_ungrouped$NSString$writeToFile$atomically$encoding$error$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *, BOOL, NSStringEncoding, NSError **); static BOOL (*_logos_orig$_ungrouped$NSString$isEqualToString$)(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSString$isEqualToString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSString$containsString$)(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSString$containsString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * (*_logos_orig$_ungrouped$NSString$stringByAppendingPathComponent$)(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * _logos_method$_ungrouped$NSString$stringByAppendingPathComponent$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * (*_logos_orig$_ungrouped$NSString$stringByAppendingString$)(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * _logos_method$_ungrouped$NSString$stringByAppendingString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSData$writeToFile$atomically$)(_LOGOS_SELF_TYPE_NORMAL NSData* _LOGOS_SELF_CONST, SEL, NSString *, BOOL); static BOOL _logos_method$_ungrouped$NSData$writeToFile$atomically$(_LOGOS_SELF_TYPE_NORMAL NSData* _LOGOS_SELF_CONST, SEL, NSString *, BOOL); static id (*_logos_orig$_ungrouped$__NSDictionaryI$objectForKey$)(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$__NSDictionaryI$objectForKey$(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$__NSDictionaryI$valueForKey$)(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$__NSDictionaryI$valueForKey$(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$NSDictionary$objectForKey$)(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$NSDictionary$objectForKey$(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$NSDictionary$valueForKey$)(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$NSDictionary$valueForKey$(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$UIApplication$canOpenURL$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL *); static BOOL _logos_method$_ungrouped$UIApplication$canOpenURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL *); static BOOL (*_logos_orig$_ungrouped$UIApplication$openURL$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL*); static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL*); static void (*_logos_orig$_ungrouped$UIApplication$openURL$options$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL*, NSDictionary *, void (^)(BOOL success)); static void _logos_method$_ungrouped$UIApplication$openURL$options$completionHandler$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, NSURL*, NSDictionary *, void (^)(BOOL success)); static NSUUID * (*_logos_orig$_ungrouped$ASIdentifierManager$advertisingIdentifier)(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST, SEL); static NSUUID * _logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$UIDevice$name)(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$UIDevice$name(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NSFileManager$isReadableFileAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$isReadableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$isWritableFileAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$isWritableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$isExecutableFileAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$isExecutableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$isDeletableFileAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$isDeletableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$isUbiquitousItemAtURL$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSURL *); static BOOL _logos_method$_ungrouped$NSFileManager$isUbiquitousItemAtURL$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSURL *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$fileExistsAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, BOOL *); static BOOL _logos_method$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, BOOL *); static BOOL (*_logos_orig$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, void *, long long, NSString *); static BOOL _logos_method$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, void *, long long, NSString *); static NSData * (*_logos_orig$_ungrouped$NSFileManager$contentsAtPath$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static NSData * _logos_method$_ungrouped$NSFileManager$contentsAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *); static NSArray * (*_logos_orig$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, NSError **); static NSArray * _logos_method$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, NSError **); static BOOL (*_logos_orig$_ungrouped$NSFileManager$removeItemAtPath$error$)(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, NSError **); static BOOL _logos_method$_ungrouped$NSFileManager$removeItemAtPath$error$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST, SEL, NSString *, NSError **); static void (*_logos_orig$_ungrouped$NSMutableURLRequest$setHTTPBody$)(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST, SEL, NSData *); static void _logos_method$_ungrouped$NSMutableURLRequest$setHTTPBody$(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST, SEL, NSData *); static NSURL * (*_logos_orig$_ungrouped$NSMutableURLRequest$URL)(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST, SEL); static NSURL * _logos_method$_ungrouped$NSMutableURLRequest$URL(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSJSONReadingOptions, NSError **); static id _logos_meta_method$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSJSONReadingOptions, NSError **); 

#line 7 "/Users/liangze/Documents/Desktop/pojieAPPS/Qianka/QiankaDylib/CCTweakTool/CC_Object-C.xm"
#pragma mark -
#pragma mark - NSBundle

static NSString * _logos_method$_ungrouped$NSBundle$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if (isCallFromOriginApp()){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return _logos_orig$_ungrouped$NSBundle$bundleIdentifier(self, _cmd);
}

static NSString * _logos_method$_ungrouped$NSBundle$objForInfoKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * key){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$objForInfoKey$(self, _cmd, key); }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    
    return _logos_orig$_ungrouped$NSBundle$objForInfoKey$(self, _cmd, key);
}

static id _logos_method$_ungrouped$NSBundle$valueForKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * key){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$valueForKey$(self, _cmd, key); }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return _logos_orig$_ungrouped$NSBundle$valueForKey$(self, _cmd, key);
}

static id _logos_method$_ungrouped$NSBundle$objectForInfoDictionaryKey$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * key){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$objectForInfoDictionaryKey$(self, _cmd, key); }
    
    if ([key hasPrefix:@"CFBundleIdentifier"]){
        CCLog(@"检测了bundleIdentifier");
        return bunlderID;
    }
    return _logos_orig$_ungrouped$NSBundle$objectForInfoDictionaryKey$(self, _cmd, key);
}

static NSDictionary * _logos_method$_ungrouped$NSBundle$infoDictionary(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$infoDictionary(self, _cmd); }

    CCLog(@"替换了infoDictionary->bundleIdentifier");
    NSMutableDictionary *r = [(NSDictionary *)_logos_orig$_ungrouped$NSBundle$infoDictionary(self, _cmd) mutableCopy];
    r[@"CFBundleIdentifier"] = bunlderID;
    return r;
}

static NSURL * _logos_method$_ungrouped$NSBundle$URLForResource$withExtension$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * name, NSString * ext){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$URLForResource$withExtension$(self, _cmd, name, ext); }

    if ([name hasPrefix:@"embedded"]) {
        CCLog(@"[文件名:CCObject-C.xm][类名:NSBundle][方法名:URLForResource:withExtension:]检测了embedded.mobileprovision");

    }
    return _logos_orig$_ungrouped$NSBundle$URLForResource$withExtension$(self, _cmd, name, ext);
}

static NSString * _logos_method$_ungrouped$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * name, NSString * ext){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSBundle$pathForResource$ofType$(self, _cmd, name, ext); }

    if ([name hasPrefix:@"embedded"]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSBundle][方法名:pathForResource:ofType:]检测了embedded.mobileprovision"];
    }
    
    return _logos_orig$_ungrouped$NSBundle$pathForResource$ofType$(self, _cmd, name, ext);
}










#pragma mark -
#pragma mark - NSString

static BOOL _logos_method$_ungrouped$__NSCFConstantString$isEqualToString$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * aString){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$__NSCFConstantString$isEqualToString$(self, _cmd, aString); }
    
    if ([aString isEqualToString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];

        return true;
    }
    return _logos_orig$_ungrouped$__NSCFConstantString$isEqualToString$(self, _cmd, aString);
}

static BOOL _logos_method$_ungrouped$__NSCFConstantString$containsString$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * aString){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$__NSCFConstantString$containsString$(self, _cmd, aString); }
    
    if ([aString containsString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    
    return _logos_orig$_ungrouped$__NSCFConstantString$containsString$(self, _cmd, aString);
}

static BOOL _logos_method$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$(_LOGOS_SELF_TYPE_NORMAL __NSCFConstantString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, BOOL useAuxiliaryFile, NSStringEncoding enc, NSError ** error){
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
    
    
    return _logos_orig$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$(self, _cmd, path, useAuxiliaryFile, enc, error);
}



static BOOL _logos_method$_ungrouped$NSString$writeToFile$atomically$encoding$error$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, BOOL useAuxiliaryFile, NSStringEncoding enc, NSError ** error){
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
    
    return _logos_orig$_ungrouped$NSString$writeToFile$atomically$encoding$error$(self, _cmd, path, useAuxiliaryFile, enc, error);
}

static BOOL _logos_method$_ungrouped$NSString$isEqualToString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * aString){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSString$isEqualToString$(self, _cmd, aString); }

    if ([aString isEqualToString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:isEqualToString:]检测了 团队ID"];
        return true;
    }
    return _logos_orig$_ungrouped$NSString$isEqualToString$(self, _cmd, aString);
}

static BOOL _logos_method$_ungrouped$NSString$containsString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * aString){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSString$containsString$(self, _cmd, aString); }
    
    if ([aString containsString:teamId]) {
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:containsString:]检测了 团队ID"];
        
        return true;
    }
    return _logos_orig$_ungrouped$NSString$containsString$(self, _cmd, aString);
}

static NSString * _logos_method$_ungrouped$NSString$stringByAppendingPathComponent$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * str){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSString$stringByAppendingPathComponent$(self, _cmd, str); }

    if ([str hasPrefix:@"embedded"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:stringByAppendingPathComponent:]检测了embedded.mobileprovision"];
    }
    return _logos_orig$_ungrouped$NSString$stringByAppendingPathComponent$(self, _cmd, str);
}
static NSString * _logos_method$_ungrouped$NSString$stringByAppendingString$(_LOGOS_SELF_TYPE_NORMAL NSString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * aString){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSString$stringByAppendingString$(self, _cmd, aString); }

    if ([aString hasPrefix:@"embedded"] || [aString hasPrefix:@"/embedded"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSString][方法名:stringByAppendingString:]检测了embedded.mobileprovision"];
    }
    return _logos_orig$_ungrouped$NSString$stringByAppendingString$(self, _cmd, aString);
}



















#pragma mark -
#pragma mark - NSData

static BOOL _logos_method$_ungrouped$NSData$writeToFile$atomically$(_LOGOS_SELF_TYPE_NORMAL NSData* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, BOOL useAuxiliaryFile){
    if ([path hasPrefix:@"/private"]){
        return false;
    }
    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSString][方法名:writeToFile:%@]检测了 文件权限", path]];
        [CCLogManager addWriteFilePath:path];
    }
    
    return _logos_orig$_ungrouped$NSData$writeToFile$atomically$(self, _cmd, path, useAuxiliaryFile);
}













#pragma mark -
#pragma mark - NSDictionary

static id _logos_method$_ungrouped$__NSDictionaryI$objectForKey$(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id aKey){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$__NSDictionaryI$objectForKey$(self, _cmd, aKey); }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return _logos_orig$_ungrouped$__NSDictionaryI$objectForKey$(self, _cmd, aKey);
}

static id _logos_method$_ungrouped$__NSDictionaryI$valueForKey$(_LOGOS_SELF_TYPE_NORMAL __NSDictionaryI* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id aKey){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$__NSDictionaryI$valueForKey$(self, _cmd, aKey); }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
    }
    return _logos_orig$_ungrouped$__NSDictionaryI$valueForKey$(self, _cmd, aKey);
}



static id _logos_method$_ungrouped$NSDictionary$objectForKey$(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id aKey){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSDictionary$objectForKey$(self, _cmd, aKey); }

    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:objectForKey:]检测了SignerIdentity"];
    }
    return _logos_orig$_ungrouped$NSDictionary$objectForKey$(self, _cmd, aKey);
}

static id _logos_method$_ungrouped$NSDictionary$valueForKey$(_LOGOS_SELF_TYPE_NORMAL NSDictionary* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id aKey){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSDictionary$valueForKey$(self, _cmd, aKey); }
    
    if ([aKey isKindOfClass:NSString.class] && [aKey isEqualToString:@"SignerIdentity"]){
        [CCLogManager addLog:@"[文件名:CCObject-C.xm][类名:NSDictionary][方法名:valueForKey:]检测了SignerIdentity"];
    }
    return _logos_orig$_ungrouped$NSDictionary$valueForKey$(self, _cmd, aKey);
}










#pragma mark -
#pragma mark - UIApplication

static BOOL _logos_method$_ungrouped$UIApplication$canOpenURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * url){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$UIApplication$canOpenURL$(self, _cmd, url); }

    NSString *tempStr = url.absoluteString.lowercaseString;
    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
        CCLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        CCLog(@"检测了cydia");
        return false;
    }
    return _logos_orig$_ungrouped$UIApplication$canOpenURL$(self, _cmd, url);
}
static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL* url){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, url); }
    
    NSString *tempStr = url.absoluteString.lowercaseString;
    if ([tempStr hasPrefix:@"ppappinstall://"] || [url.absoluteString hasPrefix:@"i4Tool4008227229://"] || [url.absoluteString hasPrefix:@"tbtui://"] || [url.absoluteString hasPrefix:@"itools://"] || [url.absoluteString hasPrefix:@"transmitinfo://"] || [url.absoluteString hasPrefix:@"haima://"]){
        CCLog(@"检测了是否安装了 第三方应用平台");
        return false;
    }
    if ([tempStr containsString:@"cydia"]){
        CCLog(@"检测了cydia");
        return false;
    }
    
    return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, url);
}

static void _logos_method$_ungrouped$UIApplication$openURL$options$completionHandler$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL* url, NSDictionary * options, void (^completion)(BOOL success)){
    _logos_orig$_ungrouped$UIApplication$openURL$options$completionHandler$(self, _cmd, url, options, completion);
}










#pragma mark -
#pragma mark - IDFA ASIdentifierManager

static NSUUID * _logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
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










#pragma mark -
#pragma mark - UIDevice

static NSString * _logos_method$_ungrouped$UIDevice$name(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    return @"iPhone";
}










#pragma mark -
#pragma mark - NSFileManager

static BOOL _logos_method$_ungrouped$NSFileManager$isReadableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$isReadableFileAtPath$(self, _cmd, path);
}
static BOOL _logos_method$_ungrouped$NSFileManager$isWritableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$isWritableFileAtPath$(self, _cmd, path);
}
static BOOL _logos_method$_ungrouped$NSFileManager$isExecutableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$isExecutableFileAtPath$(self, _cmd, path);
}
static BOOL _logos_method$_ungrouped$NSFileManager$isDeletableFileAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$isDeletableFileAtPath$(self, _cmd, path);
}

static BOOL _logos_method$_ungrouped$NSFileManager$isUbiquitousItemAtURL$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * url){
    if (isJailbreakPath(url.absoluteString)) {
        CCLog(@"检测了:%@", url.absoluteString);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$isUbiquitousItemAtURL$(self, _cmd, url);
}

static BOOL _logos_method$_ungrouped$NSFileManager$fileExistsAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        if (strstr(path.UTF8String, "/private/var/lib/apt/")) {
            CCLog(@"检测了:%@", path);
        }
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$(self, _cmd, path);
}
static BOOL _logos_method$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, BOOL * isDirectory){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$(self, _cmd, path, isDirectory);
}

static BOOL _logos_method$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, void * arg1, long long arg2, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return false;
    }
    return _logos_orig$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$(self, _cmd, arg1, arg2, path);
}

static NSData * _logos_method$_ungrouped$NSFileManager$contentsAtPath$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return nil;
    }
    return _logos_orig$_ungrouped$NSFileManager$contentsAtPath$(self, _cmd, path);
}

static NSArray * _logos_method$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, NSError ** error){
    if (isJailbreakPath(path)) {
        CCLog(@"检测了:%@", path);
        return nil;
    }
    return _logos_orig$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$(self, _cmd, path, error);
}

static BOOL _logos_method$_ungrouped$NSFileManager$removeItemAtPath$error$(_LOGOS_SELF_TYPE_NORMAL NSFileManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, NSError ** error){
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
    return _logos_orig$_ungrouped$NSFileManager$removeItemAtPath$error$(self, _cmd, path, error);
}












#pragma mark -
#pragma mark - 网络请求 NSMutableURLRequest

static void _logos_method$_ungrouped$NSMutableURLRequest$setHTTPBody$(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * data){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSMutableURLRequest$setHTTPBody$(self, _cmd, data); }
    
    _logos_orig$_ungrouped$NSMutableURLRequest$setHTTPBody$(self, _cmd, data);
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *logstr = [NSString stringWithFormat:@"发生了网络请求 url: %@?%@", self.URL.absoluteString, jsonString];
    [CCLogManager addRequest:logstr];
    
}

static NSURL * _logos_method$_ungrouped$NSMutableURLRequest$URL(_LOGOS_SELF_TYPE_NORMAL NSMutableURLRequest* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if (isCallFromOriginApp() == false) { return _logos_orig$_ungrouped$NSMutableURLRequest$URL(self, _cmd); }
    
    NSURL *url = _logos_orig$_ungrouped$NSMutableURLRequest$URL(self, _cmd);
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:url.absoluteString];
    NSString *logstr = [NSString stringWithFormat:@"发生了网络请求 NSMutableURLRequest.URL: %@",str];

    [CCLogManager addRequest:logstr];
    
    return url;
}













#pragma mark -
#pragma mark - 数据解析NSJSONSerialization

static id _logos_meta_method$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * data, NSJSONReadingOptions opt, NSError ** error){
    if (isCallFromOriginApp() == false) { return _logos_meta_orig$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$(self, _cmd, data, opt, error); }

    id result = _logos_meta_orig$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$(self, _cmd, data, opt, error);
    
    NSString *logstr = [NSString stringWithFormat:@"解析数据 JSONObjectWithData: %@",result];
    [CCLogManager addJSONSerialization:logstr];
    CCLog(@"解析数据 JSONObjectWithData %@",result);
    
    return result;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$NSBundle = objc_getClass("NSBundle"); MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(bundleIdentifier), (IMP)&_logos_method$_ungrouped$NSBundle$bundleIdentifier, (IMP*)&_logos_orig$_ungrouped$NSBundle$bundleIdentifier);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(objForInfoKey:), (IMP)&_logos_method$_ungrouped$NSBundle$objForInfoKey$, (IMP*)&_logos_orig$_ungrouped$NSBundle$objForInfoKey$);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(valueForKey:), (IMP)&_logos_method$_ungrouped$NSBundle$valueForKey$, (IMP*)&_logos_orig$_ungrouped$NSBundle$valueForKey$);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(objectForInfoDictionaryKey:), (IMP)&_logos_method$_ungrouped$NSBundle$objectForInfoDictionaryKey$, (IMP*)&_logos_orig$_ungrouped$NSBundle$objectForInfoDictionaryKey$);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(infoDictionary), (IMP)&_logos_method$_ungrouped$NSBundle$infoDictionary, (IMP*)&_logos_orig$_ungrouped$NSBundle$infoDictionary);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(URLForResource:withExtension:), (IMP)&_logos_method$_ungrouped$NSBundle$URLForResource$withExtension$, (IMP*)&_logos_orig$_ungrouped$NSBundle$URLForResource$withExtension$);MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(pathForResource:ofType:), (IMP)&_logos_method$_ungrouped$NSBundle$pathForResource$ofType$, (IMP*)&_logos_orig$_ungrouped$NSBundle$pathForResource$ofType$);Class _logos_class$_ungrouped$__NSCFConstantString = objc_getClass("__NSCFConstantString"); MSHookMessageEx(_logos_class$_ungrouped$__NSCFConstantString, @selector(isEqualToString:), (IMP)&_logos_method$_ungrouped$__NSCFConstantString$isEqualToString$, (IMP*)&_logos_orig$_ungrouped$__NSCFConstantString$isEqualToString$);MSHookMessageEx(_logos_class$_ungrouped$__NSCFConstantString, @selector(containsString:), (IMP)&_logos_method$_ungrouped$__NSCFConstantString$containsString$, (IMP*)&_logos_orig$_ungrouped$__NSCFConstantString$containsString$);MSHookMessageEx(_logos_class$_ungrouped$__NSCFConstantString, @selector(writeToFile:atomically:encoding:error:), (IMP)&_logos_method$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$, (IMP*)&_logos_orig$_ungrouped$__NSCFConstantString$writeToFile$atomically$encoding$error$);Class _logos_class$_ungrouped$NSString = objc_getClass("NSString"); MSHookMessageEx(_logos_class$_ungrouped$NSString, @selector(writeToFile:atomically:encoding:error:), (IMP)&_logos_method$_ungrouped$NSString$writeToFile$atomically$encoding$error$, (IMP*)&_logos_orig$_ungrouped$NSString$writeToFile$atomically$encoding$error$);MSHookMessageEx(_logos_class$_ungrouped$NSString, @selector(isEqualToString:), (IMP)&_logos_method$_ungrouped$NSString$isEqualToString$, (IMP*)&_logos_orig$_ungrouped$NSString$isEqualToString$);MSHookMessageEx(_logos_class$_ungrouped$NSString, @selector(containsString:), (IMP)&_logos_method$_ungrouped$NSString$containsString$, (IMP*)&_logos_orig$_ungrouped$NSString$containsString$);MSHookMessageEx(_logos_class$_ungrouped$NSString, @selector(stringByAppendingPathComponent:), (IMP)&_logos_method$_ungrouped$NSString$stringByAppendingPathComponent$, (IMP*)&_logos_orig$_ungrouped$NSString$stringByAppendingPathComponent$);MSHookMessageEx(_logos_class$_ungrouped$NSString, @selector(stringByAppendingString:), (IMP)&_logos_method$_ungrouped$NSString$stringByAppendingString$, (IMP*)&_logos_orig$_ungrouped$NSString$stringByAppendingString$);Class _logos_class$_ungrouped$NSData = objc_getClass("NSData"); MSHookMessageEx(_logos_class$_ungrouped$NSData, @selector(writeToFile:atomically:), (IMP)&_logos_method$_ungrouped$NSData$writeToFile$atomically$, (IMP*)&_logos_orig$_ungrouped$NSData$writeToFile$atomically$);Class _logos_class$_ungrouped$__NSDictionaryI = objc_getClass("__NSDictionaryI"); MSHookMessageEx(_logos_class$_ungrouped$__NSDictionaryI, @selector(objectForKey:), (IMP)&_logos_method$_ungrouped$__NSDictionaryI$objectForKey$, (IMP*)&_logos_orig$_ungrouped$__NSDictionaryI$objectForKey$);MSHookMessageEx(_logos_class$_ungrouped$__NSDictionaryI, @selector(valueForKey:), (IMP)&_logos_method$_ungrouped$__NSDictionaryI$valueForKey$, (IMP*)&_logos_orig$_ungrouped$__NSDictionaryI$valueForKey$);Class _logos_class$_ungrouped$NSDictionary = objc_getClass("NSDictionary"); MSHookMessageEx(_logos_class$_ungrouped$NSDictionary, @selector(objectForKey:), (IMP)&_logos_method$_ungrouped$NSDictionary$objectForKey$, (IMP*)&_logos_orig$_ungrouped$NSDictionary$objectForKey$);MSHookMessageEx(_logos_class$_ungrouped$NSDictionary, @selector(valueForKey:), (IMP)&_logos_method$_ungrouped$NSDictionary$valueForKey$, (IMP*)&_logos_orig$_ungrouped$NSDictionary$valueForKey$);Class _logos_class$_ungrouped$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(canOpenURL:), (IMP)&_logos_method$_ungrouped$UIApplication$canOpenURL$, (IMP*)&_logos_orig$_ungrouped$UIApplication$canOpenURL$);MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(openURL:), (IMP)&_logos_method$_ungrouped$UIApplication$openURL$, (IMP*)&_logos_orig$_ungrouped$UIApplication$openURL$);MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(openURL:options:completionHandler:), (IMP)&_logos_method$_ungrouped$UIApplication$openURL$options$completionHandler$, (IMP*)&_logos_orig$_ungrouped$UIApplication$openURL$options$completionHandler$);Class _logos_class$_ungrouped$ASIdentifierManager = objc_getClass("ASIdentifierManager"); MSHookMessageEx(_logos_class$_ungrouped$ASIdentifierManager, @selector(advertisingIdentifier), (IMP)&_logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier, (IMP*)&_logos_orig$_ungrouped$ASIdentifierManager$advertisingIdentifier);Class _logos_class$_ungrouped$UIDevice = objc_getClass("UIDevice"); MSHookMessageEx(_logos_class$_ungrouped$UIDevice, @selector(name), (IMP)&_logos_method$_ungrouped$UIDevice$name, (IMP*)&_logos_orig$_ungrouped$UIDevice$name);Class _logos_class$_ungrouped$NSFileManager = objc_getClass("NSFileManager"); MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(isReadableFileAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$isReadableFileAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$isReadableFileAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(isWritableFileAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$isWritableFileAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$isWritableFileAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(isExecutableFileAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$isExecutableFileAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$isExecutableFileAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(isDeletableFileAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$isDeletableFileAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$isDeletableFileAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(isUbiquitousItemAtURL:), (IMP)&_logos_method$_ungrouped$NSFileManager$isUbiquitousItemAtURL$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$isUbiquitousItemAtURL$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(fileExistsAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$fileExistsAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(fileExistsAtPath:isDirectory:), (IMP)&_logos_method$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$fileExistsAtPath$isDirectory$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(getFileSystemRepresentation:maxLength:withPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$getFileSystemRepresentation$maxLength$withPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(contentsAtPath:), (IMP)&_logos_method$_ungrouped$NSFileManager$contentsAtPath$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$contentsAtPath$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(contentsOfDirectoryAtPath:error:), (IMP)&_logos_method$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$contentsOfDirectoryAtPath$error$);MSHookMessageEx(_logos_class$_ungrouped$NSFileManager, @selector(removeItemAtPath:error:), (IMP)&_logos_method$_ungrouped$NSFileManager$removeItemAtPath$error$, (IMP*)&_logos_orig$_ungrouped$NSFileManager$removeItemAtPath$error$);Class _logos_class$_ungrouped$NSMutableURLRequest = objc_getClass("NSMutableURLRequest"); MSHookMessageEx(_logos_class$_ungrouped$NSMutableURLRequest, @selector(setHTTPBody:), (IMP)&_logos_method$_ungrouped$NSMutableURLRequest$setHTTPBody$, (IMP*)&_logos_orig$_ungrouped$NSMutableURLRequest$setHTTPBody$);MSHookMessageEx(_logos_class$_ungrouped$NSMutableURLRequest, @selector(URL), (IMP)&_logos_method$_ungrouped$NSMutableURLRequest$URL, (IMP*)&_logos_orig$_ungrouped$NSMutableURLRequest$URL);Class _logos_class$_ungrouped$NSJSONSerialization = objc_getClass("NSJSONSerialization"); Class _logos_metaclass$_ungrouped$NSJSONSerialization = object_getClass(_logos_class$_ungrouped$NSJSONSerialization); MSHookMessageEx(_logos_metaclass$_ungrouped$NSJSONSerialization, @selector(JSONObjectWithData:options:error:), (IMP)&_logos_meta_method$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$, (IMP*)&_logos_meta_orig$_ungrouped$NSJSONSerialization$JSONObjectWithData$options$error$);} }
#line 531 "/Users/liangze/Documents/Desktop/pojieAPPS/Qianka/QiankaDylib/CCTweakTool/CC_Object-C.xm"
