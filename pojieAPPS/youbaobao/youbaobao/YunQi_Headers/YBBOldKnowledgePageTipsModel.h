//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "YBBOldKnowledgePageBaseModel.h"

@class NSString;

@interface YBBOldKnowledgePageTipsModel : YBBOldKnowledgePageBaseModel
{
    unsigned long long _choicenessId;
    NSString *_title;
    NSString *_introduction;
    NSString *_thumbnails;
    NSString *_mavinName;
    NSString *_mavinTitle;
    NSString *_mavinPhoto;
    NSString *_categoryStr;
    NSString *_sourceName;
    long long _browse;
    NSString *_url;
}

+ (void)initialize;
@property(copy, nonatomic) NSString *url; // @synthesize url=_url;
@property(nonatomic) long long browse; // @synthesize browse=_browse;
@property(copy, nonatomic) NSString *sourceName; // @synthesize sourceName=_sourceName;
@property(copy, nonatomic) NSString *categoryStr; // @synthesize categoryStr=_categoryStr;
@property(copy, nonatomic) NSString *mavinPhoto; // @synthesize mavinPhoto=_mavinPhoto;
@property(copy, nonatomic) NSString *mavinTitle; // @synthesize mavinTitle=_mavinTitle;
@property(copy, nonatomic) NSString *mavinName; // @synthesize mavinName=_mavinName;
@property(copy, nonatomic) NSString *thumbnails; // @synthesize thumbnails=_thumbnails;
@property(copy, nonatomic) NSString *introduction; // @synthesize introduction=_introduction;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(nonatomic) unsigned long long choicenessId; // @synthesize choicenessId=_choicenessId;
- (void).cxx_destruct;
- (id)init;

@end

