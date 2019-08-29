#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/congmingzhuan/congmingzhuanDylib/Logos/congmingzhuanDylib.xm"


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

@class CTMediator; @class OWRequestEncryptGenerator; @class Target_H5Api; @class FMWKWebViewNativeMessageHandler; @class OWRequestGenerator; @class OWAppContext; @class GMEllipticCurveCrypto; @class EncryptManager; @class FMBaseRequestGenerator; @class ChaCha20ObjC; @class FMBaseApiManager; 
static void (*_logos_orig$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$)(_LOGOS_SELF_TYPE_NORMAL FMWKWebViewNativeMessageHandler* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$(_LOGOS_SELF_TYPE_NORMAL FMWKWebViewNativeMessageHandler* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$)(_LOGOS_SELF_TYPE_NORMAL CTMediator* _LOGOS_SELF_CONST, SEL, NSString *, NSString *, NSDictionary *, BOOL); static id _logos_method$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$(_LOGOS_SELF_TYPE_NORMAL CTMediator* _LOGOS_SELF_CONST, SEL, NSString *, NSString *, NSDictionary *, BOOL); static void (*_logos_orig$_ungrouped$Target_H5Api$Action_post$)(_LOGOS_SELF_TYPE_NORMAL Target_H5Api* _LOGOS_SELF_CONST, SEL, NSDictionary *); static void _logos_method$_ungrouped$Target_H5Api$Action_post$(_LOGOS_SELF_TYPE_NORMAL Target_H5Api* _LOGOS_SELF_CONST, SEL, NSDictionary *); static long long (*_logos_orig$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$)(_LOGOS_SELF_TYPE_NORMAL FMBaseApiManager* _LOGOS_SELF_CONST, SEL, id, id, id); static long long _logos_method$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$(_LOGOS_SELF_TYPE_NORMAL FMBaseApiManager* _LOGOS_SELF_CONST, SEL, id, id, id); static id (*_logos_orig$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$)(_LOGOS_SELF_TYPE_NORMAL OWRequestGenerator* _LOGOS_SELF_CONST, SEL, id, id, id, unsigned long long, unsigned long long); static id _logos_method$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL OWRequestGenerator* _LOGOS_SELF_CONST, SEL, id, id, id, unsigned long long, unsigned long long); static NSMutableURLRequest * (*_logos_orig$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$)(_LOGOS_SELF_TYPE_NORMAL OWRequestEncryptGenerator* _LOGOS_SELF_CONST, SEL, id, id, id, unsigned long long, unsigned long long); static NSMutableURLRequest * _logos_method$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL OWRequestEncryptGenerator* _LOGOS_SELF_CONST, SEL, id, id, id, unsigned long long, unsigned long long); static NSDictionary * (*_logos_orig$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$)(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, NSDictionary *, NSDictionary *); static NSDictionary * _logos_method$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, NSDictionary *, NSDictionary *); static NSString * (*_logos_orig$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$)(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, id, unsigned long long); static NSString * _logos_method$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, id, unsigned long long); static NSMutableURLRequest * (*_logos_orig$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$)(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, NSDictionary *, id, NSString *, int, int); static NSMutableURLRequest * _logos_method$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, NSDictionary *, id, NSString *, int, int); static NSMutableURLRequest * (*_logos_orig$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$)(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, id, id, id); static NSMutableURLRequest * _logos_method$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST, SEL, id, id, id); static void (*_logos_orig$_ungrouped$OWAppContext$setSessionId$)(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$OWAppContext$setSessionId$(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * (*_logos_orig$_ungrouped$OWAppContext$sessionId)(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$OWAppContext$sessionId(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$EncryptManager$setChacha20$)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$EncryptManager$setChacha20$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$EncryptManager$chacha20)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$EncryptManager$chacha20(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$EncryptManager$setCrypto$)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$EncryptManager$setCrypto$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$EncryptManager$crypto)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$EncryptManager$crypto(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$EncryptManager$decrypt$error$)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id, id *); static id _logos_method$_ungrouped$EncryptManager$decrypt$error$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id, id *); static NSData * (*_logos_orig$_ungrouped$EncryptManager$encrypt$error$)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, NSData *, id *); static NSData * _logos_method$_ungrouped$EncryptManager$encrypt$error$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, NSData *, id *); static void (*_logos_orig$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL, id, id); static NSString * (*_logos_orig$_ungrouped$EncryptManager$clientPublicKeyBase64)(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$EncryptManager$clientPublicKeyBase64(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$ChaCha20ObjC$decrypt$error$)(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST, SEL, id, id *); static id _logos_method$_ungrouped$ChaCha20ObjC$decrypt$error$(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST, SEL, id, id *); static id (*_logos_orig$_ungrouped$ChaCha20ObjC$encrypt$error$)(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST, SEL, NSData *, id *); static id _logos_method$_ungrouped$ChaCha20ObjC$encrypt$error$(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST, SEL, NSData *, id *); static id (*_logos_orig$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$)(_LOGOS_SELF_TYPE_INIT id, SEL, NSData *, NSData *, id *) _LOGOS_RETURN_RETAINED; static id _logos_method$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$(_LOGOS_SELF_TYPE_INIT id, SEL, NSData *, NSData *, id *) _LOGOS_RETURN_RETAINED; static id (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, int); static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, int); static NSString * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSData * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKey)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSData * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static NSData * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static id (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, int); static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, int); static id (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static int (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static int _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static int (*_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static int _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static NSData * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKey)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$privateKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, _Bool ); static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, _Bool ); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$name)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$name(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$bits)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int _logos_method$_ungrouped$GMEllipticCurveCrypto$bits(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static void (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSData *); static void (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, NSString *); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static int (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureLength)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int _logos_method$_ungrouped$GMEllipticCurveCrypto$signatureLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashLength)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static int _logos_method$_ungrouped$GMEllipticCurveCrypto$hashLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureForHash$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$signatureForHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL); static GMEllipticCurveCrypto* (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$initWithCurve$)(_LOGOS_SELF_TYPE_INIT GMEllipticCurveCrypto*, SEL, int) _LOGOS_RETURN_RETAINED; static GMEllipticCurveCrypto* _logos_method$_ungrouped$GMEllipticCurveCrypto$initWithCurve$(_LOGOS_SELF_TYPE_INIT GMEllipticCurveCrypto*, SEL, int) _LOGOS_RETURN_RETAINED; static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id); static _Bool (*_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$)(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST, SEL, id, id); 

#line 5 "/Users/liangze/Documents/Desktop/pojieAPPS/congmingzhuan/congmingzhuanDylib/Logos/congmingzhuanDylib.xm"

static void _logos_method$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$(_LOGOS_SELF_TYPE_NORMAL FMWKWebViewNativeMessageHandler* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {













    HBLogDebug(@"-[<FMWKWebViewNativeMessageHandler: %p> userContentController:%@ didReceiveScriptMessage:%@]", self, arg1, arg2);
    _logos_orig$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$(self, _cmd, arg1, arg2);
}



static id _logos_method$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$(_LOGOS_SELF_TYPE_NORMAL CTMediator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * targetName, NSString * actionName, NSDictionary * params, BOOL shouldCacheTarget){
    HBLogDebug(@"-[<CTMediator: %p> performTarget:%@ action:%@ params:%@ shouldCacheTarget:%d]", self, targetName, actionName, params, shouldCacheTarget);
    id r = _logos_orig$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$(self, _cmd, targetName, actionName, params, shouldCacheTarget);
    return r;
}




static void _logos_method$_ungrouped$Target_H5Api$Action_post$(_LOGOS_SELF_TYPE_NORMAL Target_H5Api* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDictionary * arg1) {
    HBLogDebug(@"-[<Target_H5Api: %p> Action_post:%@]", self, arg1);
    _logos_orig$_ungrouped$Target_H5Api$Action_post$(self, _cmd, arg1);
}




static long long _logos_method$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$(_LOGOS_SELF_TYPE_NORMAL FMBaseApiManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) {
    HBLogDebug(@"-[<FMBaseApiManager: %p> loadRequestWithParams:%@ successBlock:%@ failBlock:%@]", self, arg1, arg2, arg3);
    long long r = _logos_orig$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$(self, _cmd, arg1, arg2, arg3);
    return r;
}



static id _logos_method$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL OWRequestGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, unsigned long long arg4, unsigned long long arg5) {
    HBLogDebug(@"-[<OWRequestGenerator: %p> requestWithParams:%@ headers:%@ serviceName:%@ requestType:%llu serviceProviderType:%llu]", self, arg1, arg2, arg3, arg4, arg5);
    id r = _logos_orig$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(self, _cmd, arg1, arg2, arg3, arg4, arg5);
    return r;
}




static NSMutableURLRequest * _logos_method$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL OWRequestEncryptGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, unsigned long long arg4, unsigned long long arg5) {
    HBLogDebug(@"-[<OWRequestEncryptGenerator: %p> requestWithParams:%@ headers:%@ serviceName:%@ requestType:%llu serviceProviderType:%llu]", self, arg1, arg2, arg3, arg4, arg5);
    NSMutableURLRequest *r = _logos_orig$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(self, _cmd, arg1, arg2, arg3, arg4, arg5); 
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;
    


}






static NSDictionary * _logos_method$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDictionary * arg1, NSDictionary * arg2) {
    HBLogDebug(@"-[<FMBaseRequestGenerator: %p> mergeDictionary:%@ intoDictionary:%@]", self, arg1, arg2);
    id r = _logos_orig$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$(self, _cmd, arg1, arg2);
    return r;
}
static NSString * _logos_method$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, unsigned long long arg2) {
    HBLogDebug(@"-[<FMBaseRequestGenerator: %p> urlStringByApiName:%@ serviceProvider:%llu]", self, arg1, arg2);
    NSString *r = _logos_orig$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$(self, _cmd, arg1, arg2);
    return r;
}

static NSMutableURLRequest * _logos_method$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDictionary * params, id headers, NSString * path, int requestType, int serviceProviderType){
    HBLogDebug(@"-[<FMBaseRequestGenerator: %p> requestWithParams:%@ headers:%@ serviceName:%@ requestType:%d serviceProviderType:%d]", self, params, headers, path, requestType, serviceProviderType);
    NSMutableURLRequest *r = _logos_orig$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$(self, _cmd, params, headers, path, requestType, serviceProviderType);
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;
}

static NSMutableURLRequest * _logos_method$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$(_LOGOS_SELF_TYPE_NORMAL FMBaseRequestGenerator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) {
    HBLogDebug(@"-[<FMBaseRequestGenerator: %p> generateRequestWithURL:%@ params:%@ method:%@]", self, arg1, arg2, arg3);
    NSMutableURLRequest *r = _logos_orig$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$(self, _cmd, arg1, arg2, arg3);
    NSString *body = [[NSString alloc] initWithData:[r HTTPBody] encoding:4];
    return r;






}





static void _logos_method$_ungrouped$OWAppContext$setSessionId$(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * sessionId) {
    HBLogDebug(@"-[<OWAppContext: %p> setSessionId:%@]", self, sessionId);
    _logos_orig$_ungrouped$OWAppContext$setSessionId$(self, _cmd, sessionId);
}
static NSString * _logos_method$_ungrouped$OWAppContext$sessionId(_LOGOS_SELF_TYPE_NORMAL OWAppContext* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<OWAppContext: %p> sessionId]", self);
    NSString * r = _logos_orig$_ungrouped$OWAppContext$sessionId(self, _cmd);
    return r;
}





static void _logos_method$_ungrouped$EncryptManager$setChacha20$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id chacha20) {
    HBLogDebug(@"-[<EncryptManager: %p> setChacha20:%@]", self, chacha20);
    _logos_orig$_ungrouped$EncryptManager$setChacha20$(self, _cmd, chacha20);
    
}
static id _logos_method$_ungrouped$EncryptManager$chacha20(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<EncryptManager: %p> chacha20]", self);
    id  r = _logos_orig$_ungrouped$EncryptManager$chacha20(self, _cmd);
    return r;
    
}
static void _logos_method$_ungrouped$EncryptManager$setCrypto$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id crypto) {
    HBLogDebug(@"-[<EncryptManager: %p> setCrypto:%@]", self, crypto);
    _logos_orig$_ungrouped$EncryptManager$setCrypto$(self, _cmd, crypto);
    
}
static id _logos_method$_ungrouped$EncryptManager$crypto(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<EncryptManager: %p> crypto]", self);
    id r = _logos_orig$_ungrouped$EncryptManager$crypto(self, _cmd);
    return r;
    
}
static id _logos_method$_ungrouped$EncryptManager$decrypt$error$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id * arg2) {

    id r = _logos_orig$_ungrouped$EncryptManager$decrypt$error$(self, _cmd, arg1, arg2);
    return r;
    
}
static NSData * _logos_method$_ungrouped$EncryptManager$encrypt$error$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1, id * arg2) {
    HBLogDebug(@"-[<EncryptManager: %p> encrypt:%@ error:%p]", self, arg1, arg2);
    id r = _logos_orig$_ungrouped$EncryptManager$encrypt$error$(self, _cmd, arg1, arg2);
    return r;
}
static void _logos_method$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    HBLogDebug(@"-[<EncryptManager: %p> setServerPublicKeyBase64:%@ sessionIv:%@]", self, arg1, arg2);
    _logos_orig$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$(self, _cmd, arg1, arg2);
    
}
static NSString * _logos_method$_ungrouped$EncryptManager$clientPublicKeyBase64(_LOGOS_SELF_TYPE_NORMAL EncryptManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<EncryptManager: %p> clientPublicKeyBase64]", self);
    NSString * r = _logos_orig$_ungrouped$EncryptManager$clientPublicKeyBase64(self, _cmd);
    return r;
    
}



static id _logos_method$_ungrouped$ChaCha20ObjC$decrypt$error$(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id * arg2) {

    NSString *arg1_base64 = [arg1 base64Encoding];
    NSString *arg1_utf8 = [[NSString alloc] initWithData:arg1 encoding:4];
    id r = _logos_orig$_ungrouped$ChaCha20ObjC$decrypt$error$(self, _cmd, arg1, arg2);
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
    NSLog(@"快乐的小梁同学 arg1_base64= %@, arg1_utf8 = %@, base64=%@ utf8=%@", arg1_base64,arg1_utf8 , base64, utf8);
    return r;
}
static id _logos_method$_ungrouped$ChaCha20ObjC$encrypt$error$(_LOGOS_SELF_TYPE_NORMAL id _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1, id * arg2) {
    HBLogDebug(@"-[<ChaCha20ObjC: %p> encrypt:%@ error:%p]", self, arg1, arg2);
    NSString *body = [[NSString alloc] initWithData:arg1 encoding:4];
    id r = _logos_orig$_ungrouped$ChaCha20ObjC$encrypt$error$(self, _cmd, arg1, arg2);
    NSString *result = [r base64Encoding];
    NSLog(@"ChaCha20ObjC encrypt:%@, result = %@", body, result);
    return r;
    
}
static id _logos_method$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$(_LOGOS_SELF_TYPE_INIT id __unused self, SEL __unused _cmd, NSData * arg1, NSData * arg2, id * arg3) _LOGOS_RETURN_RETAINED {
    HBLogDebug(@"-[<ChaCha20ObjC: %p> initWithKey:%@ iv:%@ error:%p]", self, arg1, arg2, arg3);
    id r = _logos_orig$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$(self, _cmd, arg1, arg2, arg3);
    NSLog(@"ChaCha20ObjC key= %@, iv= %@", [arg1 base64Encoding], [arg2 base64Encoding]);
    return r;
}






static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
    HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> generateKeyPairForCurve:%d]", self, arg1);
    id r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$(self, _cmd, arg1);

    return r;
    
}



static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> publicKeyBase64]", self);
    NSString * r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64(self, _cmd);

    return r;
}

static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> publicKey]", self);
    NSData * r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKey(self, _cmd);
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];

    return r;
}

static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> privateKeyBase64]", self);
    NSString * r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64(self, _cmd);

    return r;
}

static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
    HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> sharedSecretForPublicKeyBase64:%@]", self, arg1);
    NSData *r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$(self, _cmd, arg1);
    
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];

    return r;
}

static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * arg1) {
    HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> sharedSecretForPublicKey:%@]", self, arg1);
    id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$(self, _cmd, arg1);
    NSString *base64 = [r base64Encoding];
    NSString *utf8 = [[NSString alloc] initWithData:r encoding:4];
    

    return r;
}





static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) { HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> cryptoForCurve:%d]", self, arg1); id r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$(self, _cmd, arg1); return r; }
static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> cryptoForKeyBase64:%@]", self, arg1); id r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$(self, _cmd, arg1); return r; }
static id _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> cryptoForKey:%@]", self, arg1); id r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$(self, _cmd, arg1); return r; }
static int _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> curveForKeyBase64:%@]", self, arg1); int r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$(self, _cmd, arg1); return r; }
static int _logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"+[<GMEllipticCurveCrypto: %p> curveForKey:%@]", self, arg1); int r = _logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKey$(self, _cmd, arg1); return r; }
static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * privateKey) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> setPrivateKey:%@]", self, privateKey); _logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$(self, _cmd, privateKey); }
static NSData * _logos_method$_ungrouped$GMEllipticCurveCrypto$privateKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> privateKey]", self); NSData * r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKey(self, _cmd); return r; }
static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool  compressedPublicKey) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> setCompressedPublicKey:%d]", self, compressedPublicKey); _logos_orig$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$(self, _cmd, compressedPublicKey); }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> compressedPublicKey]", self); _Bool  r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey(self, _cmd); return r; }
static NSString * _logos_method$_ungrouped$GMEllipticCurveCrypto$name(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> name]", self); NSString * r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$name(self, _cmd); return r; }
static int _logos_method$_ungrouped$GMEllipticCurveCrypto$bits(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> bits]", self); int  r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$bits(self, _cmd); return r; }
static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * publicKeyBase64) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> setPublicKeyBase64:%@]", self, publicKeyBase64); _logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$(self, _cmd, publicKeyBase64); }


static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * publicKey) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> setPublicKey:%@]", self, publicKey); _logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKey$(self, _cmd, publicKey); }
static void _logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * privateKeyBase64) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> setPrivateKeyBase64:%@]", self, privateKeyBase64); _logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$(self, _cmd, privateKeyBase64); }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> decompressPublicKey:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$(self, _cmd, arg1); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> compressPublicKey:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$(self, _cmd, arg1); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> publicKeyForPrivateKey:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$(self, _cmd, arg1); return r; }
static int _logos_method$_ungrouped$GMEllipticCurveCrypto$signatureLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> signatureLength]", self); int  r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureLength(self, _cmd); return r; }
static int _logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> sharedSecretLength]", self); int  r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength(self, _cmd); return r; }
static int _logos_method$_ungrouped$GMEllipticCurveCrypto$hashLength(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashLength]", self); int  r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashLength(self, _cmd); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> verifySignature:%@ forHash:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$(self, _cmd, arg1, arg2); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$signatureForHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> signatureForHash:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureForHash$(self, _cmd, arg1); return r; }


static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> generateNewKeyPair]", self); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair(self, _cmd); return r; }
static GMEllipticCurveCrypto* _logos_method$_ungrouped$GMEllipticCurveCrypto$initWithCurve$(_LOGOS_SELF_TYPE_INIT GMEllipticCurveCrypto* __unused self, SEL __unused _cmd, int arg1) _LOGOS_RETURN_RETAINED { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> initWithCurve:%d]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$initWithCurve$(self, _cmd, arg1); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA384AndVerifyEncodedSignature:%@ forData:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$(self, _cmd, arg1, arg2); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA256AndVerifyEncodedSignature:%@ forData:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$(self, _cmd, arg1, arg2); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> verifyEncodedSignature:%@ forHash:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$(self, _cmd, arg1, arg2); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA384AndSignDataEncoded:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$(self, _cmd, arg1); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA256AndSignDataEncoded:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$(self, _cmd, arg1); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> encodedSignatureForHash:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$(self, _cmd, arg1); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA384AndSignData:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$(self, _cmd, arg1); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA384AndVerifySignature:%@ forData:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$(self, _cmd, arg1, arg2); return r; }
static id _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA256AndSignData:%@]", self, arg1); id r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$(self, _cmd, arg1); return r; }
static _Bool _logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$(_LOGOS_SELF_TYPE_NORMAL GMEllipticCurveCrypto* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) { HBLogDebug(@"-[<GMEllipticCurveCrypto: %p> hashSHA256AndVerifySignature:%@ forData:%@]", self, arg1, arg2); _Bool r = _logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$(self, _cmd, arg1, arg2); return r; }






static __attribute__((constructor)) void _logosLocalCtor_8da82e12(int __unused argc, char __unused **argv, char __unused **envp) {
    {Class _logos_class$_ungrouped$FMWKWebViewNativeMessageHandler = objc_getClass("FMWKWebViewNativeMessageHandler"); MSHookMessageEx(_logos_class$_ungrouped$FMWKWebViewNativeMessageHandler, @selector(userContentController:didReceiveScriptMessage:), (IMP)&_logos_method$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$, (IMP*)&_logos_orig$_ungrouped$FMWKWebViewNativeMessageHandler$userContentController$didReceiveScriptMessage$);Class _logos_class$_ungrouped$CTMediator = objc_getClass("CTMediator"); MSHookMessageEx(_logos_class$_ungrouped$CTMediator, @selector(performTarget:action:params:shouldCacheTarget:), (IMP)&_logos_method$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$, (IMP*)&_logos_orig$_ungrouped$CTMediator$performTarget$action$params$shouldCacheTarget$);Class _logos_class$_ungrouped$Target_H5Api = objc_getClass("Target_H5Api"); MSHookMessageEx(_logos_class$_ungrouped$Target_H5Api, @selector(Action_post:), (IMP)&_logos_method$_ungrouped$Target_H5Api$Action_post$, (IMP*)&_logos_orig$_ungrouped$Target_H5Api$Action_post$);Class _logos_class$_ungrouped$FMBaseApiManager = objc_getClass("FMBaseApiManager"); MSHookMessageEx(_logos_class$_ungrouped$FMBaseApiManager, @selector(loadRequestWithParams:successBlock:failBlock:), (IMP)&_logos_method$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$, (IMP*)&_logos_orig$_ungrouped$FMBaseApiManager$loadRequestWithParams$successBlock$failBlock$);Class _logos_class$_ungrouped$OWRequestGenerator = objc_getClass("OWRequestGenerator"); MSHookMessageEx(_logos_class$_ungrouped$OWRequestGenerator, @selector(requestWithParams:headers:serviceName:requestType:serviceProviderType:), (IMP)&_logos_method$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$, (IMP*)&_logos_orig$_ungrouped$OWRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$);Class _logos_class$_ungrouped$OWRequestEncryptGenerator = objc_getClass("OWRequestEncryptGenerator"); MSHookMessageEx(_logos_class$_ungrouped$OWRequestEncryptGenerator, @selector(requestWithParams:headers:serviceName:requestType:serviceProviderType:), (IMP)&_logos_method$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$, (IMP*)&_logos_orig$_ungrouped$OWRequestEncryptGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$);Class _logos_class$_ungrouped$FMBaseRequestGenerator = objc_getClass("FMBaseRequestGenerator"); MSHookMessageEx(_logos_class$_ungrouped$FMBaseRequestGenerator, @selector(mergeDictionary:intoDictionary:), (IMP)&_logos_method$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$, (IMP*)&_logos_orig$_ungrouped$FMBaseRequestGenerator$mergeDictionary$intoDictionary$);MSHookMessageEx(_logos_class$_ungrouped$FMBaseRequestGenerator, @selector(urlStringByApiName:serviceProvider:), (IMP)&_logos_method$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$, (IMP*)&_logos_orig$_ungrouped$FMBaseRequestGenerator$urlStringByApiName$serviceProvider$);MSHookMessageEx(_logos_class$_ungrouped$FMBaseRequestGenerator, @selector(requestWithParams:headers:serviceName:requestType:serviceProviderType:), (IMP)&_logos_method$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$, (IMP*)&_logos_orig$_ungrouped$FMBaseRequestGenerator$requestWithParams$headers$serviceName$requestType$serviceProviderType$);MSHookMessageEx(_logos_class$_ungrouped$FMBaseRequestGenerator, @selector(generateRequestWithURL:params:method:), (IMP)&_logos_method$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$, (IMP*)&_logos_orig$_ungrouped$FMBaseRequestGenerator$generateRequestWithURL$params$method$);Class _logos_class$_ungrouped$OWAppContext = objc_getClass("OWAppContext"); MSHookMessageEx(_logos_class$_ungrouped$OWAppContext, @selector(setSessionId:), (IMP)&_logos_method$_ungrouped$OWAppContext$setSessionId$, (IMP*)&_logos_orig$_ungrouped$OWAppContext$setSessionId$);MSHookMessageEx(_logos_class$_ungrouped$OWAppContext, @selector(sessionId), (IMP)&_logos_method$_ungrouped$OWAppContext$sessionId, (IMP*)&_logos_orig$_ungrouped$OWAppContext$sessionId);Class _logos_class$_ungrouped$EncryptManager = objc_getClass("EncryptManager"); MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(setChacha20:), (IMP)&_logos_method$_ungrouped$EncryptManager$setChacha20$, (IMP*)&_logos_orig$_ungrouped$EncryptManager$setChacha20$);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(chacha20), (IMP)&_logos_method$_ungrouped$EncryptManager$chacha20, (IMP*)&_logos_orig$_ungrouped$EncryptManager$chacha20);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(setCrypto:), (IMP)&_logos_method$_ungrouped$EncryptManager$setCrypto$, (IMP*)&_logos_orig$_ungrouped$EncryptManager$setCrypto$);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(crypto), (IMP)&_logos_method$_ungrouped$EncryptManager$crypto, (IMP*)&_logos_orig$_ungrouped$EncryptManager$crypto);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(decrypt:error:), (IMP)&_logos_method$_ungrouped$EncryptManager$decrypt$error$, (IMP*)&_logos_orig$_ungrouped$EncryptManager$decrypt$error$);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(encrypt:error:), (IMP)&_logos_method$_ungrouped$EncryptManager$encrypt$error$, (IMP*)&_logos_orig$_ungrouped$EncryptManager$encrypt$error$);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(setServerPublicKeyBase64:sessionIv:), (IMP)&_logos_method$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$, (IMP*)&_logos_orig$_ungrouped$EncryptManager$setServerPublicKeyBase64$sessionIv$);MSHookMessageEx(_logos_class$_ungrouped$EncryptManager, @selector(clientPublicKeyBase64), (IMP)&_logos_method$_ungrouped$EncryptManager$clientPublicKeyBase64, (IMP*)&_logos_orig$_ungrouped$EncryptManager$clientPublicKeyBase64);Class _logos_class$_ungrouped$ChaCha20ObjC = objc_getClass("OfferWallBase.ChaCha20ObjC"); MSHookMessageEx(_logos_class$_ungrouped$ChaCha20ObjC, @selector(decrypt:error:), (IMP)&_logos_method$_ungrouped$ChaCha20ObjC$decrypt$error$, (IMP*)&_logos_orig$_ungrouped$ChaCha20ObjC$decrypt$error$);MSHookMessageEx(_logos_class$_ungrouped$ChaCha20ObjC, @selector(encrypt:error:), (IMP)&_logos_method$_ungrouped$ChaCha20ObjC$encrypt$error$, (IMP*)&_logos_orig$_ungrouped$ChaCha20ObjC$encrypt$error$);MSHookMessageEx(_logos_class$_ungrouped$ChaCha20ObjC, @selector(initWithKey:iv:error:), (IMP)&_logos_method$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$, (IMP*)&_logos_orig$_ungrouped$ChaCha20ObjC$initWithKey$iv$error$);Class _logos_class$_ungrouped$GMEllipticCurveCrypto = objc_getClass("GMEllipticCurveCrypto"); Class _logos_metaclass$_ungrouped$GMEllipticCurveCrypto = object_getClass(_logos_class$_ungrouped$GMEllipticCurveCrypto); MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(generateKeyPairForCurve:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$generateKeyPairForCurve$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(publicKeyBase64), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyBase64);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(publicKey), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$publicKey, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKey);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(privateKeyBase64), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKeyBase64);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(sharedSecretForPublicKeyBase64:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKeyBase64$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(sharedSecretForPublicKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretForPublicKey$);MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(cryptoForCurve:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForCurve$);MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(cryptoForKeyBase64:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKeyBase64$);MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(cryptoForKey:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$cryptoForKey$);MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(curveForKeyBase64:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKeyBase64$);MSHookMessageEx(_logos_metaclass$_ungrouped$GMEllipticCurveCrypto, @selector(curveForKey:), (IMP)&_logos_meta_method$_ungrouped$GMEllipticCurveCrypto$curveForKey$, (IMP*)&_logos_meta_orig$_ungrouped$GMEllipticCurveCrypto$curveForKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(setPrivateKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(privateKey), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$privateKey, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$privateKey);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(setCompressedPublicKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$setCompressedPublicKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(compressedPublicKey), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$compressedPublicKey);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(name), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$name, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$name);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(bits), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$bits, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$bits);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(setPublicKeyBase64:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKeyBase64$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(setPublicKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$setPublicKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPublicKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(setPrivateKeyBase64:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$setPrivateKeyBase64$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(decompressPublicKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$decompressPublicKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(compressPublicKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$compressPublicKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(publicKeyForPrivateKey:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$publicKeyForPrivateKey$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(signatureLength), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$signatureLength, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureLength);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(sharedSecretLength), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$sharedSecretLength);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashLength), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashLength, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashLength);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(verifySignature:forHash:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$verifySignature$forHash$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(signatureForHash:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$signatureForHash$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$signatureForHash$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(generateNewKeyPair), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$generateNewKeyPair);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(initWithCurve:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$initWithCurve$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$initWithCurve$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA384AndVerifyEncodedSignature:forData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifyEncodedSignature$forData$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA256AndVerifyEncodedSignature:forData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifyEncodedSignature$forData$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(verifyEncodedSignature:forHash:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$verifyEncodedSignature$forHash$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA384AndSignDataEncoded:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignDataEncoded$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA256AndSignDataEncoded:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignDataEncoded$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(encodedSignatureForHash:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$encodedSignatureForHash$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA384AndSignData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndSignData$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA384AndVerifySignature:forData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA384AndVerifySignature$forData$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA256AndSignData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndSignData$);MSHookMessageEx(_logos_class$_ungrouped$GMEllipticCurveCrypto, @selector(hashSHA256AndVerifySignature:forData:), (IMP)&_logos_method$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$, (IMP*)&_logos_orig$_ungrouped$GMEllipticCurveCrypto$hashSHA256AndVerifySignature$forData$);}
}
