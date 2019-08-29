#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/wanHao/wanHaoDylib/Logos/wanHaoDylib.xm"


#import <UIKit/UIKit.h>
#import "GTMBase64.h"
@interface AGStatusBlock : NSObject
@property unsigned short triggerType;
@property unsigned short code;



@end
@interface AGStateBlock : NSObject
@property(readonly, nonatomic) NSDate *lastSuccessTime; 
@property(readonly, nonatomic) NSData *skey; 
@property(readonly, nonatomic) NSData *uuid; 








@end



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

@class AGNetworkManager; @class NSURLSession; @class AGStateBlock; @class AGConfig; @class AGUtils; @class AGStatusBlock; 
static void (*_logos_orig$_ungrouped$AGNetworkManager$transformRequest$)(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSMutableURLRequest *); static void _logos_method$_ungrouped$AGNetworkManager$transformRequest$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSMutableURLRequest *); static id (*_logos_orig$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$)(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSURL *, id); static id _logos_method$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSURL *, id); static AGStateBlock * (*_logos_orig$_ungrouped$AGNetworkManager$stateblock)(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL); static AGStateBlock * _logos_method$_ungrouped$AGNetworkManager$stateblock(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$AGNetworkManager$addXCbtExtension$)(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSString *); static id _logos_method$_ungrouped$AGNetworkManager$addXCbtExtension$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL, NSString *); static id (*_logos_orig$_ungrouped$AGNetworkManager$getXCbtExtension)(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGNetworkManager$getXCbtExtension(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$AGStatusBlock$serialize)(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGStatusBlock$serialize(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST, SEL); static AGStatusBlock* (*_logos_orig$_ungrouped$AGStatusBlock$init)(_LOGOS_SELF_TYPE_INIT AGStatusBlock*, SEL) _LOGOS_RETURN_RETAINED; static AGStatusBlock* _logos_method$_ungrouped$AGStatusBlock$init(_LOGOS_SELF_TYPE_INIT AGStatusBlock*, SEL) _LOGOS_RETURN_RETAINED; static id (*_logos_orig$_ungrouped$AGStatusBlock$getId)(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGStatusBlock$getId(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST, SEL); static AGStateBlock* (*_logos_orig$_ungrouped$AGStateBlock$initWithProperties$keyData$)(_LOGOS_SELF_TYPE_INIT AGStateBlock*, SEL, id, id) _LOGOS_RETURN_RETAINED; static AGStateBlock* _logos_method$_ungrouped$AGStateBlock$initWithProperties$keyData$(_LOGOS_SELF_TYPE_INIT AGStateBlock*, SEL, id, id) _LOGOS_RETURN_RETAINED; static AGStateBlock* (*_logos_orig$_ungrouped$AGStateBlock$init)(_LOGOS_SELF_TYPE_INIT AGStateBlock*, SEL) _LOGOS_RETURN_RETAINED; static AGStateBlock* _logos_method$_ungrouped$AGStateBlock$init(_LOGOS_SELF_TYPE_INIT AGStateBlock*, SEL) _LOGOS_RETURN_RETAINED; static NSDate * (*_logos_orig$_ungrouped$AGStateBlock$lastSuccessTime)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSDate * _logos_method$_ungrouped$AGStateBlock$lastSuccessTime(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSData * (*_logos_orig$_ungrouped$AGStateBlock$skey)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSData * _logos_method$_ungrouped$AGStateBlock$skey(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSData * (*_logos_orig$_ungrouped$AGStateBlock$uuid)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSData * _logos_method$_ungrouped$AGStateBlock$uuid(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$_ungrouped$AGStateBlock$isValid)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$_ungrouped$AGStateBlock$isValid(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$AGStateBlock$setSkey$)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL, NSData *); static void _logos_method$_ungrouped$AGStateBlock$setSkey$(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL, NSData *); static void (*_logos_orig$_ungrouped$AGStateBlock$setUuid$)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL, NSData *); static void _logos_method$_ungrouped$AGStateBlock$setUuid$(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL, NSData *); static id (*_logos_orig$_ungrouped$AGStateBlock$getLastSuccessTime)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGStateBlock$getLastSuccessTime(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$AGStateBlock$getId)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGStateBlock$getId(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$AGStateBlock$getKey)(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$AGStateBlock$getKey(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_meta_orig$_ungrouped$AGUtils$computeSignature$uuid$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *); static NSString * _logos_meta_method$_ungrouped$AGUtils$computeSignature$uuid$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *); static NSString * (*_logos_meta_orig$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *, NSData *); static NSString * _logos_meta_method$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *, NSData *); static NSData * (*_logos_meta_orig$_ungrouped$AGUtils$hmacFromData$secret$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *); static NSData * _logos_meta_method$_ungrouped$AGUtils$hmacFromData$secret$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *, NSData *); static BOOL (*_logos_meta_orig$_ungrouped$AGUtils$isStateBlockCacheAvail)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static BOOL _logos_meta_method$_ungrouped$AGUtils$isStateBlockCacheAvail(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static int (*_logos_orig$_ungrouped$AGConfig$stateBlockCacheLifespan)(_LOGOS_SELF_TYPE_NORMAL AGConfig* _LOGOS_SELF_CONST, SEL); static int _logos_method$_ungrouped$AGConfig$stateBlockCacheLifespan(_LOGOS_SELF_TYPE_NORMAL AGConfig* _LOGOS_SELF_CONST, SEL); static NSURLSessionDataTask * (*_logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest *, void (^)(NSData * data, NSURLResponse * response, NSError * error)); static NSURLSessionDataTask * _logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest *, void (^)(NSData * data, NSURLResponse * response, NSError * error)); 

#line 27 "/Users/liangze/Documents/Desktop/pojieAPPS/wanHao/wanHaoDylib/Logos/wanHaoDylib.xm"


static void _logos_method$_ungrouped$AGNetworkManager$transformRequest$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSMutableURLRequest * arg1) {
    ;
    _logos_orig$_ungrouped$AGNetworkManager$transformRequest$(self, _cmd, arg1);
}

static id _logos_method$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * arg1, id arg2) { 
    ;
    id r = _logos_orig$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$(self, _cmd, arg1, arg2);
    return r;
}



static AGStateBlock * _logos_method$_ungrouped$AGNetworkManager$stateblock(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    AGStateBlock * r = _logos_orig$_ungrouped$AGNetworkManager$stateblock(self, _cmd);
    NSLog(@"老子的结果:%@", r);
    return r;
}



static id _logos_method$_ungrouped$AGNetworkManager$addXCbtExtension$(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
    ;
    id r = _logos_orig$_ungrouped$AGNetworkManager$addXCbtExtension$(self, _cmd, arg1);
    return r;
}

static id _logos_method$_ungrouped$AGNetworkManager$getXCbtExtension(_LOGOS_SELF_TYPE_NORMAL AGNetworkManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    id r = _logos_orig$_ungrouped$AGNetworkManager$getXCbtExtension(self, _cmd);
    return r;
}









static id _logos_method$_ungrouped$AGStatusBlock$serialize(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { ; id r = _logos_orig$_ungrouped$AGStatusBlock$serialize(self, _cmd); return r; }
static AGStatusBlock* _logos_method$_ungrouped$AGStatusBlock$init(_LOGOS_SELF_TYPE_INIT AGStatusBlock* __unused self, SEL __unused _cmd) _LOGOS_RETURN_RETAINED { ; id r = _logos_orig$_ungrouped$AGStatusBlock$init(self, _cmd); return r; }
static id _logos_method$_ungrouped$AGStatusBlock$getId(_LOGOS_SELF_TYPE_NORMAL AGStatusBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    ; id r = _logos_orig$_ungrouped$AGStatusBlock$getId(self, _cmd); return r;
}


static AGStateBlock* _logos_method$_ungrouped$AGStateBlock$initWithProperties$keyData$(_LOGOS_SELF_TYPE_INIT AGStateBlock* __unused self, SEL __unused _cmd, id arg1, id arg2) _LOGOS_RETURN_RETAINED {
    ;
    id r = _logos_orig$_ungrouped$AGStateBlock$initWithProperties$keyData$(self, _cmd, arg1, arg2);
    return r;
    
}
static AGStateBlock* _logos_method$_ungrouped$AGStateBlock$init(_LOGOS_SELF_TYPE_INIT AGStateBlock* __unused self, SEL __unused _cmd) _LOGOS_RETURN_RETAINED {
    ;
    id r = _logos_orig$_ungrouped$AGStateBlock$init(self, _cmd);
    return r;
}
static NSDate * _logos_method$_ungrouped$AGStateBlock$lastSuccessTime(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    NSDate * r = _logos_orig$_ungrouped$AGStateBlock$lastSuccessTime(self, _cmd);
    return r; }
static NSData * _logos_method$_ungrouped$AGStateBlock$skey(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { ; NSData * r = _logos_orig$_ungrouped$AGStateBlock$skey(self, _cmd); return r; }
static NSData * _logos_method$_ungrouped$AGStateBlock$uuid(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { ; NSData * r = _logos_orig$_ungrouped$AGStateBlock$uuid(self, _cmd); return r; }
static _Bool _logos_method$_ungrouped$AGStateBlock$isValid(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    _Bool r = _logos_orig$_ungrouped$AGStateBlock$isValid(self, _cmd);
    return r;
}

static void _logos_method$_ungrouped$AGStateBlock$setSkey$(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * data){
    ;
    _logos_orig$_ungrouped$AGStateBlock$setSkey$(self, _cmd, data);
}

static void _logos_method$_ungrouped$AGStateBlock$setUuid$(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * data){
    ;
    _logos_orig$_ungrouped$AGStateBlock$setUuid$(self, _cmd, data);
}
static id _logos_method$_ungrouped$AGStateBlock$getLastSuccessTime(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { ; id r = _logos_orig$_ungrouped$AGStateBlock$getLastSuccessTime(self, _cmd); return r; }
static id _logos_method$_ungrouped$AGStateBlock$getId(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    id r = _logos_orig$_ungrouped$AGStateBlock$getId(self, _cmd);
    return r;
    
}
static id _logos_method$_ungrouped$AGStateBlock$getKey(_LOGOS_SELF_TYPE_NORMAL AGStateBlock* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    id r = _logos_orig$_ungrouped$AGStateBlock$getKey(self, _cmd);
    return r;
    
}




static NSString * _logos_meta_method$_ungrouped$AGUtils$computeSignature$uuid$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1, NSData * arg2) {
    ; 
    id r = _logos_meta_orig$_ungrouped$AGUtils$computeSignature$uuid$(self, _cmd, arg1, arg2);
    NSString *s1 = [GTMBase64 stringByEncodingData:arg1] ;
    NSString *s2 = [GTMBase64 stringByEncodingData:arg2] ;
    NSString *result = r;

    s1 =[[NSString alloc] initWithData:arg1 encoding:4] ? : [GTMBase64 stringByEncodingData:arg1];
    s2 =[[NSString alloc] initWithData:arg2 encoding:4] ? : [GTMBase64 stringByEncodingData:arg2];
    NSLog(@"=======>[AGUtils computeSignature:%@ uuid:%@] = %@", s1, s2, result);
    return r;
}

static NSString * _logos_meta_method$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1, NSData * arg2, NSData * arg3) {
    ;
    id r = _logos_meta_orig$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$(self, _cmd, arg1, arg2, arg3);
    NSString *s1 = [GTMBase64 stringByEncodingData:arg1];
    NSString *s2 = [GTMBase64 stringByEncodingData:arg2];
    NSString *s3 = [GTMBase64 stringByEncodingData:arg3];

    NSString *result = r;
    
    s1 =[[NSString alloc] initWithData:arg1 encoding:4] ? : [GTMBase64 stringByEncodingData:arg1];
    s2 =[[NSString alloc] initWithData:arg2 encoding:4] ? : [GTMBase64 stringByEncodingData:arg2];
    s3 =[[NSString alloc] initWithData:arg3 encoding:4] ? : [GTMBase64 stringByEncodingData:arg3];


    NSLog(@"=======>[AGUtils computeHashWithData:%@ hashKey:%@ uuid:%@] = %@", s1, s2, s3, r);

    return r;
}

static NSData * _logos_meta_method$_ungrouped$AGUtils$hmacFromData$secret$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1, NSData * arg2) {
    id r = _logos_meta_orig$_ungrouped$AGUtils$hmacFromData$secret$(self, _cmd, arg1, arg2);

    NSString *s1 = [GTMBase64 stringByEncodingData:arg1];
    NSString *s2 = [GTMBase64 stringByEncodingData:arg2];
    NSString *result = [GTMBase64 stringByEncodingData:r];
    

    s1 =[[NSString alloc] initWithData:arg1 encoding:4] ? : [GTMBase64 stringByEncodingData:arg1];
    s2 =[[NSString alloc] initWithData:arg2 encoding:4] ?: [GTMBase64 stringByEncodingData:arg2];
    result = [[NSString alloc] initWithData:r encoding:4] ? : [GTMBase64 stringByEncodingData:r];

    NSLog(@"=======>[AGUtils hmacFromData:%@ secret:%@] = %@", s1, s2, result);
    return r;
}

static BOOL _logos_meta_method$_ungrouped$AGUtils$isStateBlockCacheAvail(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    ;
    BOOL r = _logos_meta_orig$_ungrouped$AGUtils$isStateBlockCacheAvail(self, _cmd);
    return r;
}





static int _logos_method$_ungrouped$AGConfig$stateBlockCacheLifespan(_LOGOS_SELF_TYPE_NORMAL AGConfig* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { ; int  r = _logos_orig$_ungrouped$AGConfig$stateBlockCacheLifespan(self, _cmd);
    return r;
}







static NSURLSessionDataTask * _logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURLRequest * request, void (^completionHandler)(NSData * data, NSURLResponse * response, NSError * error)){
    __block BOOL isUrl = false;
    void (^newBlock)(NSData * , NSURLResponse * , NSError *) = ^(NSData * data, NSURLResponse * response, NSError * error) {
        if (isUrl){
            NSLog(@"%@", data);

        }
        if (completionHandler != nil){
            completionHandler(data, response, error);
        }
    };
    
    NSURLSessionDataTask * r = _logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(self, _cmd, request, newBlock);
    NSLog(@"请求的url是 %@",[[r currentRequest] URL]);
    if ([[[[r currentRequest] URL] absoluteString] containsString:@"https://gatewaydsapprd.marriott.com/v1/native-app/initialize"]){
        isUrl = true;
    }
    return r;

}

;
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$AGNetworkManager = objc_getClass("AGNetworkManager"); MSHookMessageEx(_logos_class$_ungrouped$AGNetworkManager, @selector(transformRequest:), (IMP)&_logos_method$_ungrouped$AGNetworkManager$transformRequest$, (IMP*)&_logos_orig$_ungrouped$AGNetworkManager$transformRequest$);MSHookMessageEx(_logos_class$_ungrouped$AGNetworkManager, @selector(getHeaderWithRequestBody:data:), (IMP)&_logos_method$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$, (IMP*)&_logos_orig$_ungrouped$AGNetworkManager$getHeaderWithRequestBody$data$);MSHookMessageEx(_logos_class$_ungrouped$AGNetworkManager, @selector(stateblock), (IMP)&_logos_method$_ungrouped$AGNetworkManager$stateblock, (IMP*)&_logos_orig$_ungrouped$AGNetworkManager$stateblock);MSHookMessageEx(_logos_class$_ungrouped$AGNetworkManager, @selector(addXCbtExtension:), (IMP)&_logos_method$_ungrouped$AGNetworkManager$addXCbtExtension$, (IMP*)&_logos_orig$_ungrouped$AGNetworkManager$addXCbtExtension$);MSHookMessageEx(_logos_class$_ungrouped$AGNetworkManager, @selector(getXCbtExtension), (IMP)&_logos_method$_ungrouped$AGNetworkManager$getXCbtExtension, (IMP*)&_logos_orig$_ungrouped$AGNetworkManager$getXCbtExtension);Class _logos_class$_ungrouped$AGStatusBlock = objc_getClass("AGStatusBlock"); MSHookMessageEx(_logos_class$_ungrouped$AGStatusBlock, @selector(serialize), (IMP)&_logos_method$_ungrouped$AGStatusBlock$serialize, (IMP*)&_logos_orig$_ungrouped$AGStatusBlock$serialize);MSHookMessageEx(_logos_class$_ungrouped$AGStatusBlock, @selector(init), (IMP)&_logos_method$_ungrouped$AGStatusBlock$init, (IMP*)&_logos_orig$_ungrouped$AGStatusBlock$init);MSHookMessageEx(_logos_class$_ungrouped$AGStatusBlock, @selector(getId), (IMP)&_logos_method$_ungrouped$AGStatusBlock$getId, (IMP*)&_logos_orig$_ungrouped$AGStatusBlock$getId);Class _logos_class$_ungrouped$AGStateBlock = objc_getClass("AGStateBlock"); MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(initWithProperties:keyData:), (IMP)&_logos_method$_ungrouped$AGStateBlock$initWithProperties$keyData$, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$initWithProperties$keyData$);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(init), (IMP)&_logos_method$_ungrouped$AGStateBlock$init, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$init);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(lastSuccessTime), (IMP)&_logos_method$_ungrouped$AGStateBlock$lastSuccessTime, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$lastSuccessTime);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(skey), (IMP)&_logos_method$_ungrouped$AGStateBlock$skey, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$skey);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(uuid), (IMP)&_logos_method$_ungrouped$AGStateBlock$uuid, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$uuid);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(isValid), (IMP)&_logos_method$_ungrouped$AGStateBlock$isValid, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$isValid);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(setSkey:), (IMP)&_logos_method$_ungrouped$AGStateBlock$setSkey$, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$setSkey$);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(setUuid:), (IMP)&_logos_method$_ungrouped$AGStateBlock$setUuid$, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$setUuid$);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(getLastSuccessTime), (IMP)&_logos_method$_ungrouped$AGStateBlock$getLastSuccessTime, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$getLastSuccessTime);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(getId), (IMP)&_logos_method$_ungrouped$AGStateBlock$getId, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$getId);MSHookMessageEx(_logos_class$_ungrouped$AGStateBlock, @selector(getKey), (IMP)&_logos_method$_ungrouped$AGStateBlock$getKey, (IMP*)&_logos_orig$_ungrouped$AGStateBlock$getKey);Class _logos_class$_ungrouped$AGUtils = objc_getClass("AGUtils"); Class _logos_metaclass$_ungrouped$AGUtils = object_getClass(_logos_class$_ungrouped$AGUtils); MSHookMessageEx(_logos_metaclass$_ungrouped$AGUtils, @selector(computeSignature:uuid:), (IMP)&_logos_meta_method$_ungrouped$AGUtils$computeSignature$uuid$, (IMP*)&_logos_meta_orig$_ungrouped$AGUtils$computeSignature$uuid$);MSHookMessageEx(_logos_metaclass$_ungrouped$AGUtils, @selector(computeHashWithData:hashKey:uuid:), (IMP)&_logos_meta_method$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$, (IMP*)&_logos_meta_orig$_ungrouped$AGUtils$computeHashWithData$hashKey$uuid$);MSHookMessageEx(_logos_metaclass$_ungrouped$AGUtils, @selector(hmacFromData:secret:), (IMP)&_logos_meta_method$_ungrouped$AGUtils$hmacFromData$secret$, (IMP*)&_logos_meta_orig$_ungrouped$AGUtils$hmacFromData$secret$);MSHookMessageEx(_logos_metaclass$_ungrouped$AGUtils, @selector(isStateBlockCacheAvail), (IMP)&_logos_meta_method$_ungrouped$AGUtils$isStateBlockCacheAvail, (IMP*)&_logos_meta_orig$_ungrouped$AGUtils$isStateBlockCacheAvail);Class _logos_class$_ungrouped$AGConfig = objc_getClass("AGConfig"); MSHookMessageEx(_logos_class$_ungrouped$AGConfig, @selector(stateBlockCacheLifespan), (IMP)&_logos_method$_ungrouped$AGConfig$stateBlockCacheLifespan, (IMP*)&_logos_orig$_ungrouped$AGConfig$stateBlockCacheLifespan);Class _logos_class$_ungrouped$NSURLSession = objc_getClass("NSURLSession"); MSHookMessageEx(_logos_class$_ungrouped$NSURLSession, @selector(dataTaskWithRequest:completionHandler:), (IMP)&_logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$, (IMP*)&_logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$);} }
#line 217 "/Users/liangze/Documents/Desktop/pojieAPPS/wanHao/wanHaoDylib/Logos/wanHaoDylib.xm"
