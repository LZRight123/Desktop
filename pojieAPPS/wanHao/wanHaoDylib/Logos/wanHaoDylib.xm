// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "GTMBase64.h"
@interface AGStatusBlock : NSObject
@property unsigned short triggerType;
@property unsigned short code;
//- (id)serialize;
//- (id)init;

@end
@interface AGStateBlock : NSObject
@property(readonly, nonatomic) NSDate *lastSuccessTime; // @synthesize lastSuccessTime=_lastSuccessTime;
@property(readonly, nonatomic) NSData *skey; // @synthesize skey=_skey;
@property(readonly, nonatomic) NSData *uuid; // @synthesize uuid=_uuid;
//- (void)encodeWithCoder:(id)arg1;
//- (id)initWithCoder:(id)arg1;
//- (_Bool)isValid;
//- (id)getLastSuccessTime;
//- (id)getId;
//- (id)getKey;
//- (id)initWithProperties:(id)arg1 keyData:(id)arg2;
//- (id)init;
@end


%hook AGNetworkManager

- (void)transformRequest:(NSMutableURLRequest *)arg1 {
    /*%log*/;
    %orig;// po [arg1 HTTPBody]
}

- (id)getHeaderWithRequestBody:(NSURL *)arg1 data:(id)arg2 { //上面的arg1的httpbody
    /*%log*/;
    id r = %orig;
    return r;
}



- (AGStateBlock *)stateblock {
    /*%log*/;
    AGStateBlock * r = %orig;
    NSLog(@"老子的结果:%@", r);
    return r;
}



- (id)addXCbtExtension:(NSString *)arg1 {
    /*%log*/;
    id r = %orig;
    return r;
}

- (id)getXCbtExtension {
    /*%log*/;
    id r = %orig;
    return r;
}
//- (id)getHeaderWithRequestUrl:(id)arg1 {
//    /*%log*/;
//    id r = %orig;
//    return r;
//}

%end

%hook AGStatusBlock
- (id)serialize { /*%log*/; id r = %orig; return r; }
- (id)init { /*%log*/; id r = %orig; return r; }
- (id)getId{
    /*%log*/; id r = %orig; return r;
}
%end
%hook AGStateBlock
- (id)initWithProperties:(id)arg1 keyData:(id)arg2 {
    /*%log*/;
    id r = %orig;
    return r;
    
}
- (id)init {
    /*%log*/;
    id r = %orig;
    return r;
}
- (NSDate *)lastSuccessTime {
    /*%log*/;
    NSDate * r = %orig;
    return r; }
- (NSData *)skey { /*%log*/; NSData * r = %orig; return r; }
- (NSData *)uuid { /*%log*/; NSData * r = %orig; return r; }
- (_Bool)isValid {
    /*%log*/;
    _Bool r = %orig;
    return r;
}

- (void)setSkey:(NSData *)data{
    /*%log*/;
    %orig;
}

- (void)setUuid:(NSData *)data{
    /*%log*/;
    %orig;
}
- (id)getLastSuccessTime { /*%log*/; id r = %orig; return r; }
- (id)getId {
    /*%log*/;
    id r = %orig;
    return r;
    
}
- (id)getKey {
    /*%log*/;
    id r = %orig;
    return r;
    
}
%end


%hook AGUtils
+ (NSString *)computeSignature:(NSData *)arg1 uuid:(NSData *)arg2 {
    /*%log*/; //arg1 = <e1192b77 72db0d4f 3d4d183a 52a3ddc7 9ffaf54c a522ebd7 484f1a80> hmac后的
    id r = %orig;// arg1 appendData:arg2 => base64. '/' 用替换 "_" "+" 替换 "-"
    NSString *s1 = [GTMBase64 stringByEncodingData:arg1] ;
    NSString *s2 = [GTMBase64 stringByEncodingData:arg2] ;
    NSString *result = r;

    s1 =[[NSString alloc] initWithData:arg1 encoding:4] ? : [GTMBase64 stringByEncodingData:arg1];
    s2 =[[NSString alloc] initWithData:arg2 encoding:4] ? : [GTMBase64 stringByEncodingData:arg2];
    NSLog(@"=======>[AGUtils computeSignature:%@ uuid:%@] = %@", s1, s2, result);
    return r;
}

+ (NSString *)computeHashWithData:(NSData *)arg1 hashKey:(NSData *)arg2 uuid:(NSData *)arg3 {
    /*%log*/;
    id r = %orig;
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

+ (NSData *)hmacFromData:(NSData *)arg1 secret:(NSData *)arg2 {// skey  // 入参加hashkey
    id r = %orig;

    NSString *s1 = [GTMBase64 stringByEncodingData:arg1];
    NSString *s2 = [GTMBase64 stringByEncodingData:arg2];
    NSString *result = [GTMBase64 stringByEncodingData:r];
    
//    NSData *data = [[NSData alloc] initWithBase64EncodedString:s1 options:0];
    s1 =[[NSString alloc] initWithData:arg1 encoding:4] ? : [GTMBase64 stringByEncodingData:arg1];
    s2 =[[NSString alloc] initWithData:arg2 encoding:4] ?: [GTMBase64 stringByEncodingData:arg2];
    result = [[NSString alloc] initWithData:r encoding:4] ? : [GTMBase64 stringByEncodingData:r];

    NSLog(@"=======>[AGUtils hmacFromData:%@ secret:%@] = %@", s1, s2, result);
    return r;
}

+ (BOOL)isStateBlockCacheAvail {
    /*%log*/;
    BOOL r = %orig;
    return r;
}

%end


%hook AGConfig
- (int )stateBlockCacheLifespan { /*%log*/; int  r = %orig;
    return r;
}


%end
//signat wQD9D5uDFTHfL3VAVIpZSeDXVAqgPBPLqmG1MAB6sN11bAEAAFXo09rrq8aPmbAKzwzScbqpLJDXfibkKgcf4cc5yYzAuSje3A==
//

%hook NSURLSession
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler{
    __block BOOL isUrl = false;
    void (^newBlock)(NSData * , NSURLResponse * , NSError *) = ^(NSData * data, NSURLResponse * response, NSError * error) {
        if (isUrl){
            NSLog(@"%@", data);

        }
        if (completionHandler != nil){
            completionHandler(data, response, error);
        }
    };
    
    NSURLSessionDataTask * r = %orig(request, newBlock);
    NSLog(@"请求的url是 %@",[[r currentRequest] URL]);
    if ([[[[r currentRequest] URL] absoluteString] containsString:@"https://gatewaydsapprd.marriott.com/v1/native-app/initialize"]){
        isUrl = true;
    }
    return r;
//   po [[r currentRequest] URL]
}
%end
;
