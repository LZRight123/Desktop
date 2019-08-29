// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>

%hook FMWKWebViewNativeMessageHandler
- (void)userContentController:(id)arg1 didReceiveScriptMessage:(id)arg2 {
//    {
//        data = {
//            showLoading = 1;
//            url = task/getAvailableTaskList;
//            encrypted = 1;
//            params = {
//                wallTaskType = TryTask
//            }
//        };
//        targetName = Api;
//        actionName = post;
//        identifier = -2089227005
//    }
    %log;
    %orig;
}
%end

%hook CTMediator
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    %log;
    id r = %orig;
    return r;
}
%end


%hook Target_H5Api
- (void)Action_post:(NSDictionary *)arg1 {
    %log;
    %orig;
}
%end

%hook FMBaseApiManager
//wallTaskType = TryTask
- (long long)loadRequestWithParams:(id)arg1 successBlock:(id/*block*/)arg2 failBlock:(id/*block*/)arg3 {
    %log;
    long long r = %orig;
    return r;
}
%end

%hook OWRequestGenerator
- (id)requestWithParams:(id)arg1 headers:(id)arg2 serviceName:(id)arg3 requestType:(unsigned long long)arg4 serviceProviderType:(unsigned long long)arg5 {
    %log;
    id r = %orig;
    return r;
}

%end

%hook OWRequestEncryptGenerator
- (NSMutableURLRequest *)requestWithParams:(id)arg1 headers:(id)arg2 serviceName:(id)arg3 requestType:(unsigned long long)arg4 serviceProviderType:(unsigned long long)arg5 {
    %log;
    NSMutableURLRequest *r = %orig; //requestBody在这加的
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;
    
//    {"requestBody":{"wallTaskType":"TryTask"},"requestHeader":{"requestSequence":"01E3273DD021488B9CD9F724BA79732F","requestDate":"20190826","requestTime":"173023"}}
//    nSHeU3r76EjvWxD0OpF5hfZRvyzrImlBdkTXdKgirYKLMPO6BXbPsbknCgN/aWJILDIcpOd5B2YMTZZJlmiynp5FtHpS+9qa/an1o+U8npTVQ98MFT4iYqo953rWU4uQwO7v1uH84pZmjiVi5MjjfcM2iaSY26XhYNgcU8MkjmpkM5QsxlX187ly61kLd4jO2vDqnGS00nAkSeyJ71Xzmos=
}
%end


//-[FMBaseRequestGenerator requestWithParams:headers:serviceName:requestType:serviceProviderType:]
%hook FMBaseRequestGenerator

- (NSDictionary *)mergeDictionary:(NSDictionary *)arg1 intoDictionary:(NSDictionary *)arg2 {
    %log;
    id r = %orig;
    return r;
}
- (NSString *)urlStringByApiName:(id)arg1 serviceProvider:(unsigned long long)arg2 {
    %log;
    NSString *r = %orig;
    return r;
}

- (NSMutableURLRequest *)requestWithParams:(NSDictionary *)params headers:(id)headers serviceName:(NSString *)path requestType:(int)requestType serviceProviderType:(int)serviceProviderType{
    %log;
    NSMutableURLRequest *r = %orig;//sessionid在这加的
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;
}

- (NSMutableURLRequest *)generateRequestWithURL:(id)arg1 params:(id)arg2 method:(id)arg3 {
    %log;
    NSMutableURLRequest *r = %orig;
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;
//    po [r allHTTPHeaderFields]
//    {
//        User-Agent = ZMOfferWall/0.0.8 (iPhone; iOS 12.1.4; Scale/3.00);
//        Content-Type = application/json;
//        Accept-Language = zh-Hans-US;q=1, zh-Hant-US;q=0.9, id-US;q=0.8, en-US;q=0.7
//    }
}

%end


%hook OWAppContext
- (void)setSessionId:(NSString *)sessionId {
    %log;
    %orig;
}
- (NSString *)sessionId {
    %log;
    NSString * r = %orig;
    return r;
}
%end


%hook EncryptManager
//+ (id)defaultManager { %log; id r = %orig; return r; }
- (void)setChacha20:(id)chacha20 {
    %log;
    %orig;
    
}
- (id)chacha20 {
    %log;
    id  r = %orig;
    return r;//<OfferWallBase.ChaCha20ObjC: 0x281019440>
    
}
- (void)setCrypto:(id)crypto {
    %log;
    %orig;
    
}
- (id)crypto {
    %log;
    id r = %orig;//GMEllipticCurveCrypto
    return r;
    
}
- (id)decrypt:(id)arg1 error:(id *)arg2 {
//    %log;
    id r = %orig;
    return r;
    
}
- (NSData *)encrypt:(NSData *)arg1 error:(id *)arg2 {
    %log;
    id r = %orig;//httpbodyt参数
    return r;//请求体在这加密
}
- (void)setServerPublicKeyBase64:(id)arg1 sessionIv:(id)arg2 {
    %log;
    %orig;
    
}
- (NSString *)clientPublicKeyBase64 {
    %log;
    NSString * r = %orig;
    return r;
    
}
%end

%hook ChaCha20ObjC
- (id)decrypt:(id)arg1 error:(id *)arg2 {
//    %log;
    NSString *arg1_base64 = [arg1 base64Encoding];
    NSString *arg1_utf8 = [[NSString alloc] initWithData:arg1 encoding:4];
    id r = %orig;
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
    NSLog(@"快乐的小梁同学 arg1_base64= %@, arg1_utf8 = %@, base64=%@ utf8=%@", arg1_base64,arg1_utf8 , base64, utf8);
    return r;
}
- (id)encrypt:(NSData *)arg1 error:(id *)arg2 {
    %log;
    NSString *body = [[NSString alloc] initWithData:arg1 encoding:4];
    id r = %orig;
    NSString *result = [r base64Encoding];
    NSLog(@"ChaCha20ObjC encrypt:%@, result = %@", body, result);
    return r;
    
}
- (id)initWithKey:(NSData *)arg1 iv:(NSData *)arg2 error:(id *)arg3 {
    %log;
    id r = %orig;
    NSLog(@"ChaCha20ObjC key= %@, iv= %@", [arg1 base64Encoding], [arg2 base64Encoding]);
    return r;
}
%end



%hook GMEllipticCurveCrypto

+ (id)generateKeyPairForCurve:(int)arg1 {
    %log;
    id r = %orig;
//    NSLog(@"快乐的小梁同学 GMEllipticCurveCrypto = %@", r);
    return r;
    
}



- (NSString *)publicKeyBase64 {
    %log;
    NSString * r = %orig;
//    NSLog(@"快乐的小梁同学 publicKeyBase64 = %@", r);
    return r;//AqgAcpftjR0T11zYxsxRfb0EsmGhvF+Dn7ROlDaz+Aup
}

- (NSData *)publicKey {
    %log;
    NSData * r = %orig;
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
//    NSLog(@"快乐的小梁同学 publicKey=%@ base64=%@ utf8=%@", r, base64, utf8);
    return r;//<02a80072 97ed8d1d 13d75cd8 c6cc517d bd04b261 a1bc5f83 9fb44e94 36b3f80b a9>
}

- (NSString *)privateKeyBase64 {
    %log;
    NSString * r = %orig;
//    NSLog(@"快乐的小梁同学 privateKeyBase64 = %@", r);
    return r;
}

- (NSData *)sharedSecretForPublicKeyBase64:(NSString *)arg1 {
    %log;
    NSData *r = %orig;
    // r 就是 chacha20 的 key
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
//    NSLog(@"快乐的小梁同学 sharedSecretForPublicKeyBase64=%@ base64=%@ utf8=%@", r, base64, utf8);
    return r;
}

- (NSData *)sharedSecretForPublicKey:(NSData *)arg1 {
    %log;
    id r = %orig;
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
    // r 就是 chacha20 的 key
//    NSLog(@"快乐的小梁同学 sharedSecretForPublicKey=%@ base64=%@ utf8=%@", r, base64, utf8);
    return r;
}





+ (id)cryptoForCurve:(int)arg1 { %log; id r = %orig; return r; }
+ (id)cryptoForKeyBase64:(id)arg1 { %log; id r = %orig; return r; }
+ (id)cryptoForKey:(id)arg1 { %log; id r = %orig; return r; }
+ (int)curveForKeyBase64:(id)arg1 { %log; int r = %orig; return r; }
+ (int)curveForKey:(id)arg1 { %log; int r = %orig; return r; }
- (void)setPrivateKey:(NSData *)privateKey { %log; %orig; }
- (NSData *)privateKey { %log; NSData * r = %orig; return r; }
- (void)setCompressedPublicKey:(_Bool )compressedPublicKey { %log; %orig; }
- (_Bool )compressedPublicKey { %log; _Bool  r = %orig; return r; }
- (NSString *)name { %log; NSString * r = %orig; return r; }
- (int )bits { %log; int  r = %orig; return r; }
- (void)setPublicKeyBase64:(NSString *)publicKeyBase64 { %log; %orig; }


- (void)setPublicKey:(NSData *)publicKey { %log; %orig; }
- (void)setPrivateKeyBase64:(NSString *)privateKeyBase64 { %log; %orig; }
- (id)decompressPublicKey:(id)arg1 { %log; id r = %orig; return r; }
- (id)compressPublicKey:(id)arg1 { %log; id r = %orig; return r; }
- (id)publicKeyForPrivateKey:(id)arg1 { %log; id r = %orig; return r; }
- (int )signatureLength { %log; int  r = %orig; return r; }
- (int )sharedSecretLength { %log; int  r = %orig; return r; }
- (int )hashLength { %log; int  r = %orig; return r; }
- (_Bool)verifySignature:(id)arg1 forHash:(id)arg2 { %log; _Bool r = %orig; return r; }
- (id)signatureForHash:(id)arg1 { %log; id r = %orig; return r; }


- (_Bool)generateNewKeyPair { %log; _Bool r = %orig; return r; }
- (id)initWithCurve:(int)arg1 { %log; id r = %orig; return r; }
- (_Bool)hashSHA384AndVerifyEncodedSignature:(id)arg1 forData:(id)arg2 { %log; _Bool r = %orig; return r; }
- (_Bool)hashSHA256AndVerifyEncodedSignature:(id)arg1 forData:(id)arg2 { %log; _Bool r = %orig; return r; }
- (_Bool)verifyEncodedSignature:(id)arg1 forHash:(id)arg2 { %log; _Bool r = %orig; return r; }
- (id)hashSHA384AndSignDataEncoded:(id)arg1 { %log; id r = %orig; return r; }
- (id)hashSHA256AndSignDataEncoded:(id)arg1 { %log; id r = %orig; return r; }
- (id)encodedSignatureForHash:(id)arg1 { %log; id r = %orig; return r; }
- (id)hashSHA384AndSignData:(id)arg1 { %log; id r = %orig; return r; }
- (_Bool)hashSHA384AndVerifySignature:(id)arg1 forData:(id)arg2 { %log; _Bool r = %orig; return r; }
- (id)hashSHA256AndSignData:(id)arg1 { %log; id r = %orig; return r; }
- (_Bool)hashSHA256AndVerifySignature:(id)arg1 forData:(id)arg2 { %log; _Bool r = %orig; return r; }
%end





%ctor {
    %init(ChaCha20ObjC=objc_getClass("OfferWallBase.ChaCha20ObjC"));
}
