//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYRecommendBaseModel.h"

#import "YYJSONHelperProtocol-Protocol.h"

@class IMYNewsBiUrlModel, IMYNewsFocuseShareBodyModel, IMYNewsOriginalAuthorModel, NSArray, NSString;
@protocol IMYNewsRootUserModel;

@interface IMYNewsFocuseInfoModel : IMYRecommendBaseModel <YYJSONHelperProtocol>
{
    _Bool _allow_operate;
    _Bool _feedBack;
    unsigned long long _focuse_type;
    unsigned long long _original_id;
    NSString *_words;
    long long _comment_num;
    long long _shared_num;
    NSString *_created_time;
    long long _isvip;
    long long _user_type;
    NSString *_r_redirect_url;
    NSString *_additional_redirect_url;
    NSArray<IMYNewsRootUserModel> *_user_info;
    IMYNewsOriginalAuthorModel *_original_author;
    double _titleHeight;
    NSString *_video_time;
    double _shareContentHeight;
    IMYNewsBiUrlModel *_bi_redirect_url;
}

+ (id)modelContainerPropertyGenericClass;
+ (void)initialize;
@property(retain, nonatomic) IMYNewsBiUrlModel *bi_redirect_url; // @synthesize bi_redirect_url=_bi_redirect_url;
@property(nonatomic) double shareContentHeight; // @synthesize shareContentHeight=_shareContentHeight;
@property(copy, nonatomic) NSString *video_time; // @synthesize video_time=_video_time;
@property(nonatomic) _Bool feedBack; // @synthesize feedBack=_feedBack;
@property(nonatomic) double titleHeight; // @synthesize titleHeight=_titleHeight;
@property(retain, nonatomic) IMYNewsOriginalAuthorModel *original_author; // @synthesize original_author=_original_author;
@property(retain, nonatomic) NSArray<IMYNewsRootUserModel> *user_info; // @synthesize user_info=_user_info;
@property(copy, nonatomic) NSString *additional_redirect_url; // @synthesize additional_redirect_url=_additional_redirect_url;
@property(copy, nonatomic) NSString *r_redirect_url; // @synthesize r_redirect_url=_r_redirect_url;
@property(nonatomic) long long user_type; // @synthesize user_type=_user_type;
@property(nonatomic) long long isvip; // @synthesize isvip=_isvip;
@property(nonatomic) _Bool allow_operate; // @synthesize allow_operate=_allow_operate;
@property(copy, nonatomic) NSString *created_time; // @synthesize created_time=_created_time;
@property(nonatomic) long long shared_num; // @synthesize shared_num=_shared_num;
@property(nonatomic) long long comment_num; // @synthesize comment_num=_comment_num;
@property(copy, nonatomic) NSString *words; // @synthesize words=_words;
@property(nonatomic) unsigned long long original_id; // @synthesize original_id=_original_id;
@property(nonatomic) unsigned long long focuse_type; // @synthesize focuse_type=_focuse_type;
- (void).cxx_destruct;
- (id)init;
@property(readonly, copy, nonatomic) NSString *showWords;
@property(readonly, copy, nonatomic) NSString *showTitle;

// Remaining properties
@property(nonatomic) long long is_praise;
@property(nonatomic) long long praise_num;
@property(retain, nonatomic) IMYNewsFocuseShareBodyModel *share_body;

@end

