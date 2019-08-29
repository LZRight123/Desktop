#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/caihong2/caihong2Dylib/Logos/caihong2Dylib.xm"


#import <UIKit/UIKit.h>
#import "caihong2Dylib.h"


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

@class LTHTTPSessionManager; 
static id (*_logos_meta_orig$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, id , id ); static id _logos_meta_method$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, id , id ); static id (*_logos_meta_orig$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, id , id ); static id _logos_meta_method$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, id , id ); 

#line 6 "/Users/liangze/Documents/Desktop/pojieAPPS/caihong2/caihong2Dylib/Logos/caihong2Dylib.xm"

static id _logos_meta_method$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, id arg2, id  arg3, id  arg4) {



    HBLogDebug(@"+[<LTHTTPSessionManager: %p> getData:%@ withParameter:%@ success:%@ fail:%@]", self, path, arg2, arg3, arg4);
    NSString *newPath = newpathWith(path);
    id r = _logos_meta_orig$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$(self, _cmd, newPath, arg2, arg3, arg4);
    return r;
}
static id _logos_meta_method$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, id arg2, id  arg3, id  arg4) {

    HBLogDebug(@"+[<LTHTTPSessionManager: %p> postData:%@ withParameter:%@ success:%@ fail:%@]", self, path, arg2, arg3, arg4);
    NSString *newPath = newpathWith(path);
    id r = _logos_meta_orig$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$(self, _cmd, newPath, arg2, arg3, arg4);
    return r;
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$LTHTTPSessionManager = objc_getClass("LTHTTPSessionManager"); Class _logos_metaclass$_ungrouped$LTHTTPSessionManager = object_getClass(_logos_class$_ungrouped$LTHTTPSessionManager); MSHookMessageEx(_logos_metaclass$_ungrouped$LTHTTPSessionManager, @selector(getData:withParameter:success:fail:), (IMP)&_logos_meta_method$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$, (IMP*)&_logos_meta_orig$_ungrouped$LTHTTPSessionManager$getData$withParameter$success$fail$);MSHookMessageEx(_logos_metaclass$_ungrouped$LTHTTPSessionManager, @selector(postData:withParameter:success:fail:), (IMP)&_logos_meta_method$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$, (IMP*)&_logos_meta_orig$_ungrouped$LTHTTPSessionManager$postData$withParameter$success$fail$);} }
#line 26 "/Users/liangze/Documents/Desktop/pojieAPPS/caihong2/caihong2Dylib/Logos/caihong2Dylib.xm"
