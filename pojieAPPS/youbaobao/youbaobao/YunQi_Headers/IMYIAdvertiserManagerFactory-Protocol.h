//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

@class IMYAdvertiserInfo;
@protocol IMYIAdManager, IMYICollectionAdManager, IMYILaunchAdManager, IMYITableViewAdManager;

@protocol IMYIAdvertiserManagerFactory
- (id <IMYIAdManager>)getPopupAdManagerWithADInfo:(IMYAdvertiserInfo *)arg1;
- (id <IMYICollectionAdManager>)getCollectionViewAdManagerWithADInfo:(IMYAdvertiserInfo *)arg1;
- (id <IMYILaunchAdManager>)getLaunchAdManagerWithADInfo:(IMYAdvertiserInfo *)arg1;
- (id <IMYITableViewAdManager>)getTableViewAdManagerWithADInfo:(IMYAdvertiserInfo *)arg1;
@end

