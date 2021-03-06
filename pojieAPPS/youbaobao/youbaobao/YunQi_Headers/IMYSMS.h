//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYAuthBase.h"

#import "IMYIShareInterface-Protocol.h"
#import "MFMessageComposeViewControllerDelegate-Protocol.h"

@class NSString;

@interface IMYSMS : IMYAuthBase <MFMessageComposeViewControllerDelegate, IMYIShareInterface>
{
    CDUnknownBlockType _shareCompletion;
}

+ (_Bool)isAppInstalled;
@property(copy, nonatomic) CDUnknownBlockType shareCompletion; // @synthesize shareCompletion=_shareCompletion;
- (void).cxx_destruct;
- (void)messageComposeViewController:(id)arg1 didFinishWithResult:(long long)arg2;
- (id)getPresentingController;
- (void)getUserInfoWithAuthOptions:(id)arg1 completion:(CDUnknownBlockType)arg2;
- (void)shareContent:(id)arg1 shareType:(long long)arg2 completion:(CDUnknownBlockType)arg3;
- (_Bool)handleOpenURL:(id)arg1;
- (_Bool)canHandleURL:(id)arg1;
- (void)registerApp:(id)arg1 appSecret:(id)arg2 redirectUri:(id)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

