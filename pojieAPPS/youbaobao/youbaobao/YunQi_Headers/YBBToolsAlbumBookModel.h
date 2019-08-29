//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class NSString;

@interface YBBToolsAlbumBookModel : UIView
{
    _Bool _hasCache;
    long long _pbookId;
    NSString *_pictureUrl;
    NSString *_audioUrl;
    double _createTime;
}

+ (id)getPrimaryKey;
+ (void)initialize;
@property(nonatomic) double createTime; // @synthesize createTime=_createTime;
@property(nonatomic) _Bool hasCache; // @synthesize hasCache=_hasCache;
@property(copy, nonatomic) NSString *audioUrl; // @synthesize audioUrl=_audioUrl;
@property(copy, nonatomic) NSString *pictureUrl; // @synthesize pictureUrl=_pictureUrl;
@property(nonatomic) long long pbookId; // @synthesize pbookId=_pbookId;
- (void).cxx_destruct;
- (_Bool)queryIfCache;

@end
