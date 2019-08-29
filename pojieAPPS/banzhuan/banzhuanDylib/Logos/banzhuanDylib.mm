#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/banzhuan/banzhuanDylib/Logos/banzhuanDylib.xm"


#import <UIKit/UIKit.h>



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

@class NSUserDefaults; @class STool; @class HttpTool; 
static void (*_logos_meta_orig$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, NSString *, NSDictionary *, id, id); static void _logos_meta_method$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, NSString *, NSDictionary *, id, id); static id (*_logos_meta_orig$_ungrouped$STool$md5$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$STool$md5$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$STool$saveObject$forKey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$STool$saveObject$forKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_meta_orig$_ungrouped$STool$showAlertWithMessage$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void _logos_meta_method$_ungrouped$STool$showAlertWithMessage$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$STool$getNewStrWithDictionary$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$STool$getNewStrWithDictionary$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$NSUserDefaults$setObject$forKey$)(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, id, NSString *); static void _logos_method$_ungrouped$NSUserDefaults$setObject$forKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, id, NSString *); static id (*_logos_orig$_ungrouped$NSUserDefaults$objectForKey$)(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); static id _logos_method$_ungrouped$NSUserDefaults$objectForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL (*_logos_orig$_ungrouped$NSUserDefaults$boolForKey$)(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); static BOOL _logos_method$_ungrouped$NSUserDefaults$boolForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * (*_logos_orig$_ungrouped$NSUserDefaults$stringForKey$)(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * _logos_method$_ungrouped$NSUserDefaults$stringForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST, SEL, NSString *); 

#line 6 "/Users/liangze/Documents/Desktop/pojieAPPS/banzhuan/banzhuanDylib/Logos/banzhuanDylib.xm"

static void _logos_meta_method$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id baseurl, NSString * path, NSDictionary * params, id success, id failure){
    HBLogDebug(@"+[<HttpTool: %p> postWithBaseURL:%@ path:%@ params:%@ success:%@ failure:%@]", self, baseurl, path, params, success, failure);







    _logos_meta_orig$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$(self, _cmd, baseurl, path, params, success, failure);

}



static id _logos_meta_method$_ungrouped$STool$md5$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    HBLogDebug(@"+[<STool: %p> md5:%@]", self, arg1);
    id r = _logos_meta_orig$_ungrouped$STool$md5$(self, _cmd, arg1);
    return @"";
}
static void _logos_meta_method$_ungrouped$STool$saveObject$forKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"+[<STool: %p> saveObject:%@ forKey:%@]", self, arg1, arg2); _logos_meta_orig$_ungrouped$STool$saveObject$forKey$(self, _cmd, arg1, arg2); }
static void _logos_meta_method$_ungrouped$STool$showAlertWithMessage$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"+[<STool: %p> showAlertWithMessage:%@]", self, arg1); _logos_meta_orig$_ungrouped$STool$showAlertWithMessage$(self, _cmd, arg1); }
static id _logos_meta_method$_ungrouped$STool$getNewStrWithDictionary$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {















    HBLogDebug(@"+[<STool: %p> getNewStrWithDictionary:%@]", self, arg1);
    id r = _logos_meta_orig$_ungrouped$STool$getNewStrWithDictionary$(self, _cmd, arg1);
    return r;

}











static void _logos_method$_ungrouped$NSUserDefaults$setObject$forKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id value, NSString * defaultName){
    
    if ([defaultName isEqualToString:@"unicode"]){


        NSLog(@"");
    }
    _logos_orig$_ungrouped$NSUserDefaults$setObject$forKey$(self, _cmd, value, defaultName);
}


static id _logos_method$_ungrouped$NSUserDefaults$objectForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * defaultName) {
    if ([defaultName isEqualToString:@"unicode"]){
        NSLog(@"");
    }
    NSLog(@"%s\n%@", __func__, _logos_orig$_ungrouped$NSUserDefaults$objectForKey$(self, _cmd, defaultName));
    return _logos_orig$_ungrouped$NSUserDefaults$objectForKey$(self, _cmd, defaultName);
}


static BOOL _logos_method$_ungrouped$NSUserDefaults$boolForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * defaultName) {
    BOOL a = _logos_orig$_ungrouped$NSUserDefaults$boolForKey$(self, _cmd, defaultName);
    BOOL system = ([defaultName containsString:@"UI"] || [defaultName containsString:@"NS"] || [defaultName containsString:@"Kit"]);
    if (system) {return a;}
    HBLogDebug(@"-[<NSUserDefaults: %p> boolForKey:%@]", self, defaultName);
    NSLog(@"defaultName == %@ %d", defaultName, a);
    
    return _logos_orig$_ungrouped$NSUserDefaults$boolForKey$(self, _cmd, defaultName);
}


static NSString * _logos_method$_ungrouped$NSUserDefaults$stringForKey$(_LOGOS_SELF_TYPE_NORMAL NSUserDefaults* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * defaultName) {
    if ([defaultName isEqualToString:@"unicode"]){
        NSLog(@"");
    }
    HBLogDebug(@"-[<NSUserDefaults: %p> stringForKey:%@]", self, defaultName);
    return _logos_orig$_ungrouped$NSUserDefaults$stringForKey$(self, _cmd, defaultName);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$HttpTool = objc_getClass("HttpTool"); Class _logos_metaclass$_ungrouped$HttpTool = object_getClass(_logos_class$_ungrouped$HttpTool); MSHookMessageEx(_logos_metaclass$_ungrouped$HttpTool, @selector(postWithBaseURL:path:params:success:failure:), (IMP)&_logos_meta_method$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$, (IMP*)&_logos_meta_orig$_ungrouped$HttpTool$postWithBaseURL$path$params$success$failure$);Class _logos_class$_ungrouped$STool = objc_getClass("STool"); Class _logos_metaclass$_ungrouped$STool = object_getClass(_logos_class$_ungrouped$STool); MSHookMessageEx(_logos_metaclass$_ungrouped$STool, @selector(md5:), (IMP)&_logos_meta_method$_ungrouped$STool$md5$, (IMP*)&_logos_meta_orig$_ungrouped$STool$md5$);MSHookMessageEx(_logos_metaclass$_ungrouped$STool, @selector(saveObject:forKey:), (IMP)&_logos_meta_method$_ungrouped$STool$saveObject$forKey$, (IMP*)&_logos_meta_orig$_ungrouped$STool$saveObject$forKey$);MSHookMessageEx(_logos_metaclass$_ungrouped$STool, @selector(showAlertWithMessage:), (IMP)&_logos_meta_method$_ungrouped$STool$showAlertWithMessage$, (IMP*)&_logos_meta_orig$_ungrouped$STool$showAlertWithMessage$);MSHookMessageEx(_logos_metaclass$_ungrouped$STool, @selector(getNewStrWithDictionary:), (IMP)&_logos_meta_method$_ungrouped$STool$getNewStrWithDictionary$, (IMP*)&_logos_meta_orig$_ungrouped$STool$getNewStrWithDictionary$);Class _logos_class$_ungrouped$NSUserDefaults = objc_getClass("NSUserDefaults"); MSHookMessageEx(_logos_class$_ungrouped$NSUserDefaults, @selector(setObject:forKey:), (IMP)&_logos_method$_ungrouped$NSUserDefaults$setObject$forKey$, (IMP*)&_logos_orig$_ungrouped$NSUserDefaults$setObject$forKey$);MSHookMessageEx(_logos_class$_ungrouped$NSUserDefaults, @selector(objectForKey:), (IMP)&_logos_method$_ungrouped$NSUserDefaults$objectForKey$, (IMP*)&_logos_orig$_ungrouped$NSUserDefaults$objectForKey$);MSHookMessageEx(_logos_class$_ungrouped$NSUserDefaults, @selector(boolForKey:), (IMP)&_logos_method$_ungrouped$NSUserDefaults$boolForKey$, (IMP*)&_logos_orig$_ungrouped$NSUserDefaults$boolForKey$);MSHookMessageEx(_logos_class$_ungrouped$NSUserDefaults, @selector(stringForKey:), (IMP)&_logos_method$_ungrouped$NSUserDefaults$stringForKey$, (IMP*)&_logos_orig$_ungrouped$NSUserDefaults$stringForKey$);} }
#line 101 "/Users/liangze/Documents/Desktop/pojieAPPS/banzhuan/banzhuanDylib/Logos/banzhuanDylib.xm"
