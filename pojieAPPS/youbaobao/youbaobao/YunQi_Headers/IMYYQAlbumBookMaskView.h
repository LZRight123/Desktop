//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "YBBToolsAlbumBookControlView.h"

@class YBBToolsYQAlbumBookButton;

@interface IMYYQAlbumBookMaskView : YBBToolsAlbumBookControlView
{
    YBBToolsYQAlbumBookButton *_previousButton;
    YBBToolsYQAlbumBookButton *_doubleButton;
    YBBToolsYQAlbumBookButton *_nextButton;
}

@property(retain, nonatomic) YBBToolsYQAlbumBookButton *nextButton; // @synthesize nextButton=_nextButton;
@property(retain, nonatomic) YBBToolsYQAlbumBookButton *doubleButton; // @synthesize doubleButton=_doubleButton;
@property(retain, nonatomic) YBBToolsYQAlbumBookButton *previousButton; // @synthesize previousButton=_previousButton;
- (void).cxx_destruct;
- (id)titleLabelFont;
- (double)offset;
- (void)layoutForOrientation:(long long)arg1;
- (void)initUI;
- (id)initWithFrame:(struct CGRect)arg1;

@end
