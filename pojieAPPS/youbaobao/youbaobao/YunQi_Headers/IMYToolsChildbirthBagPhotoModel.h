//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface IMYToolsChildbirthBagPhotoModel : NSObject
{
    _Bool _isNeedUpload;
    NSString *_serviceURL;
    NSString *_localURL;
}

+ (id)getPrimaryKey;
+ (id)getUsingLKDBHelper;
+ (id)getAllNeedSynModels;
+ (void)deleteModelWithUploadSuccess:(id)arg1;
@property(nonatomic) _Bool isNeedUpload; // @synthesize isNeedUpload=_isNeedUpload;
@property(retain, nonatomic) NSString *localURL; // @synthesize localURL=_localURL;
@property(copy, nonatomic) NSString *serviceURL; // @synthesize serviceURL=_serviceURL;
- (void).cxx_destruct;
- (id)init;

@end

