//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "PBCoding-Protocol.h"

@class MMDiskUsageScanStat, MMFolderWrap, NSString;

@interface MMDiskUsageScanData : NSObject <PBCoding>
{
    MMDiskUsageScanStat *m_stat;
    MMFolderWrap *m_rootFolder;
}

+ (id)LoadDataFromFile:(id)arg1;
+ (id)loadDiskUsageScanData;
+ (id)getNewDiskUsageScanData;
+ (id)scanRootDir;
+ (void)initialize;
@property(retain, nonatomic) MMFolderWrap *m_rootFolder; // @synthesize m_rootFolder;
@property(retain, nonatomic) MMDiskUsageScanStat *m_stat; // @synthesize m_stat;
- (void).cxx_destruct;
- (_Bool)SaveDataToFile:(id)arg1;
- (const map_f8690629 *)getValueTagIndexMap;
- (id)getValueTypeTable;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
