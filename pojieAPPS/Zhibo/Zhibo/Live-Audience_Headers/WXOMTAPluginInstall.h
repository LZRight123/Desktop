//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@protocol WXOMTAInstallProtocol;

@interface WXOMTAPluginInstall : NSObject
{
    id <WXOMTAInstallProtocol> _delegate;
}

+ (id)getInstance;
@property(nonatomic) __weak id <WXOMTAInstallProtocol> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;

@end
