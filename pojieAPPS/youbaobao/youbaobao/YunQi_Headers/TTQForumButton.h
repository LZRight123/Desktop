//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTouchEXButton.h"

@class UIImageView;

@interface TTQForumButton : IMYTouchEXButton
{
    double _titleHeight_Min;
    double _titleHeight;
    double _imageTop;
    double _titleDown;
    double _imageToTitleSpace;
    double _titleMargin;
    UIImageView *_brand_imgView;
    struct CGSize _imageSize;
}

+ (id)recommendForumButton:(id)arg1 imageURL:(id)arg2 frame:(struct CGRect)arg3;
+ (id)createdForumButton:(CDUnknownBlockType)arg1;
@property(retain, nonatomic) UIImageView *brand_imgView; // @synthesize brand_imgView=_brand_imgView;
@property(nonatomic) double titleMargin; // @synthesize titleMargin=_titleMargin;
@property(nonatomic) double imageToTitleSpace; // @synthesize imageToTitleSpace=_imageToTitleSpace;
@property(nonatomic) double titleDown; // @synthesize titleDown=_titleDown;
@property(nonatomic) double imageTop; // @synthesize imageTop=_imageTop;
@property(nonatomic) double titleHeight; // @synthesize titleHeight=_titleHeight;
@property(nonatomic) double titleHeight_Min; // @synthesize titleHeight_Min=_titleHeight_Min;
@property(nonatomic) struct CGSize imageSize; // @synthesize imageSize=_imageSize;
- (void).cxx_destruct;
- (struct CGRect)imageRectForContentRect:(struct CGRect)arg1;
- (struct CGRect)titleRectForContentRect:(struct CGRect)arg1;
- (struct CGRect)contentRectForBounds:(struct CGRect)arg1;
- (CDUnknownBlockType)mc_recalculateHeight;
- (CDUnknownBlockType)mc_setFrameWithH;
- (CDUnknownBlockType)mc_setFrame;
- (CDUnknownBlockType)mc_setImage;
- (CDUnknownBlockType)mc_setImageURL;
- (CDUnknownBlockType)mc_setBrandImageURL;
- (CDUnknownBlockType)mc_setTitle;

@end

