//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface IMYTLHucaiPrintUserEidtDataModel : NSObject
{
    _Bool _hasShowDpiTooLowTip;
    _Bool _dpiIsTooLow;
    _Bool _hasEidt;
    long long _modelId;
    NSString *_imgUrl;
    NSString *_phLocalIdentity;
    NSString *_imgName;
    NSString *_story;
    NSString *_title;
    double _taken_date;
    double _taken_at;
    NSString *_userStory;
    double _imageScale;
    double _zoomScale;
    double _downImageScale;
    NSString *_downImageUrl;
    double _orignalPhotoWidth;
    double _orignalPhotoHeight;
    long long _orderIndex;
    unsigned long long _type;
    NSString *_babyId;
    unsigned long long _imageStatus;
    struct CGPoint _contentOff;
    struct CGPoint _dpiTooLowShowCenter;
}

+ (id)getTableName;
+ (id)copyUserEidtDataModel:(id)arg1;
+ (void)initialize;
@property(nonatomic) _Bool hasEidt; // @synthesize hasEidt=_hasEidt;
@property(nonatomic) unsigned long long imageStatus; // @synthesize imageStatus=_imageStatus;
@property(retain, nonatomic) NSString *babyId; // @synthesize babyId=_babyId;
@property(nonatomic) unsigned long long type; // @synthesize type=_type;
@property(nonatomic) long long orderIndex; // @synthesize orderIndex=_orderIndex;
@property(nonatomic) double orignalPhotoHeight; // @synthesize orignalPhotoHeight=_orignalPhotoHeight;
@property(nonatomic) double orignalPhotoWidth; // @synthesize orignalPhotoWidth=_orignalPhotoWidth;
@property(nonatomic) struct CGPoint dpiTooLowShowCenter; // @synthesize dpiTooLowShowCenter=_dpiTooLowShowCenter;
@property(nonatomic) _Bool dpiIsTooLow; // @synthesize dpiIsTooLow=_dpiIsTooLow;
@property(nonatomic) _Bool hasShowDpiTooLowTip; // @synthesize hasShowDpiTooLowTip=_hasShowDpiTooLowTip;
@property(retain, nonatomic) NSString *downImageUrl; // @synthesize downImageUrl=_downImageUrl;
@property(nonatomic) double downImageScale; // @synthesize downImageScale=_downImageScale;
@property(nonatomic) struct CGPoint contentOff; // @synthesize contentOff=_contentOff;
@property(nonatomic) double zoomScale; // @synthesize zoomScale=_zoomScale;
@property(nonatomic) double imageScale; // @synthesize imageScale=_imageScale;
@property(retain, nonatomic) NSString *userStory; // @synthesize userStory=_userStory;
@property(nonatomic) double taken_at; // @synthesize taken_at=_taken_at;
@property(nonatomic) double taken_date; // @synthesize taken_date=_taken_date;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSString *story; // @synthesize story=_story;
@property(retain, nonatomic) NSString *imgName; // @synthesize imgName=_imgName;
@property(retain, nonatomic) NSString *phLocalIdentity; // @synthesize phLocalIdentity=_phLocalIdentity;
@property(retain, nonatomic) NSString *imgUrl; // @synthesize imgUrl=_imgUrl;
@property(nonatomic) long long modelId; // @synthesize modelId=_modelId;
- (void).cxx_destruct;
- (id)description;
- (id)getImageName;
- (_Bool)isPortraitImage;
- (id)init;

@end

