//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface ADBMobileIdentities : NSObject
{
}

+ (void)resetOsIdentifiers;
+ (void)resetAnalyticsIdentifiers;
+ (id)getUserIdsObjectWithNamespace:(id)arg1 value:(id)arg2 type:(id)arg3;
+ (id)getVisitorIdServiceIdentifiers;
+ (id)getTargetIdentifiers;
+ (id)getOsIdentifiers;
+ (id)getAudienceIdentifiers;
+ (id)getAnalyticsIdentifiers;
+ (id)getCompanyContexts;
+ (void)resetAllIdentifiers;
+ (id)getAllIdentifiers;

@end

