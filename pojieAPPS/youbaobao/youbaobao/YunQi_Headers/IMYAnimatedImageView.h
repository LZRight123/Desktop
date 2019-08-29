//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "FLAnimatedImageView.h"

#import "IMYRM80AttributedLabelAttributedViewProtocol-Protocol.h"

@class FLAnimatedImage, NSString;

@interface IMYAnimatedImageView : FLAnimatedImageView <IMYRM80AttributedLabelAttributedViewProtocol>
{
    _Bool _shouldStartAnimating;
    NSString *_animatedImageKey;
    FLAnimatedImage *_innerAnimatedImage;
}

@property(retain, nonatomic) FLAnimatedImage *innerAnimatedImage; // @synthesize innerAnimatedImage=_innerAnimatedImage;
@property(nonatomic) _Bool shouldStartAnimating; // @synthesize shouldStartAnimating=_shouldStartAnimating;
@property(copy, nonatomic) NSString *animatedImageKey; // @synthesize animatedImageKey=_animatedImageKey;
- (void).cxx_destruct;
- (void)startDownloadWithURL:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (void)setAnimatedImageWithURL:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (void)setAnimatedImageWithURL:(id)arg1;
- (void)startAnimating;
- (void)initialize;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)init;
- (id)initWithCoder:(id)arg1;
- (_Bool)m80CanBeTapped;
@property(nonatomic) long long imyr_id;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
