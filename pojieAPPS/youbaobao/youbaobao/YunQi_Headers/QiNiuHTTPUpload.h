//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface QiNiuHTTPUpload : NSObject
{
    _Bool _ignoreCache;
    NSString *_name;
    id _object;
    NSString *_token;
    NSString *_responseName;
}

@property(nonatomic) _Bool ignoreCache; // @synthesize ignoreCache=_ignoreCache;
@property(retain, nonatomic) NSString *responseName; // @synthesize responseName=_responseName;
@property(retain, nonatomic) NSString *token; // @synthesize token=_token;
@property(retain, nonatomic) id object; // @synthesize object=_object;
@property(retain, nonatomic) NSString *name; // @synthesize name=_name;
- (void).cxx_destruct;

@end
