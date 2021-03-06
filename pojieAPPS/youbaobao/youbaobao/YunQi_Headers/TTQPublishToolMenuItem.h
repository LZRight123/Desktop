//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface TTQPublishToolMenuItem : NSObject
{
    _Bool _origiSelected;
    long long _itemId;
    NSString *_iconFontName;
    NSString *_title;
    NSString *_selectedIconFontName;
    NSString *_selectedTitle;
    CDUnknownBlockType _tapAction;
    id _sender;
}

+ (id)anonymityItem;
+ (id)hotTopicItem;
+ (id)voteItem;
+ (id)cameraItem;
+ (id)emotionItem;
@property(nonatomic) __weak id sender; // @synthesize sender=_sender;
@property(copy, nonatomic) CDUnknownBlockType tapAction; // @synthesize tapAction=_tapAction;
@property(nonatomic) _Bool origiSelected; // @synthesize origiSelected=_origiSelected;
@property(copy, nonatomic) NSString *selectedTitle; // @synthesize selectedTitle=_selectedTitle;
@property(copy, nonatomic) NSString *selectedIconFontName; // @synthesize selectedIconFontName=_selectedIconFontName;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(copy, nonatomic) NSString *iconFontName; // @synthesize iconFontName=_iconFontName;
@property(nonatomic) long long itemId; // @synthesize itemId=_itemId;
- (void).cxx_destruct;
- (CDUnknownBlockType)ItemTapAction;
- (CDUnknownBlockType)ItemSelectedIconFontName;
- (CDUnknownBlockType)ItemSelectedTitle;
- (CDUnknownBlockType)ItemIconFontName;
- (CDUnknownBlockType)ItemTitle;
- (CDUnknownBlockType)ItemOrigiSelected;
- (CDUnknownBlockType)ItemID;

@end

