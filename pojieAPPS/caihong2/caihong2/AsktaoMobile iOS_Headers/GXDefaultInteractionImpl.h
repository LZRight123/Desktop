//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "GXAlertViewDelegate-Protocol.h"
#import "GXInteraction-Protocol.h"

@class NSMutableDictionary, NSString;

@interface GXDefaultInteractionImpl : NSObject <GXInteraction, GXAlertViewDelegate>
{
    NSMutableDictionary *dict;
    CDUnknownBlockType point;
    CDUnknownBlockType notify_callback_;
}

- (void).cxx_destruct;
- (void)alertViewCancel:(id)arg1;
- (void)alertView:(id)arg1 clickedButtonAtIndex:(id)arg2;
- (_Bool)startApp:(id)arg1 extraData:(id)arg2;
- (_Bool)popupWithTitle:(id)arg1 message:(id)arg2 img:(id)arg3 buttons:(id)arg4 callback:(CDUnknownBlockType)arg5;
- (_Bool)notifyWithTitle:(id)arg1 message:(id)arg2 callback:(CDUnknownBlockType)arg3;
- (_Bool)startWeb:(id)arg1;
- (_Bool)onStartUrl:(id)arg1;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

