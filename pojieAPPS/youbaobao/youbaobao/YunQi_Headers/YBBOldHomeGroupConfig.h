//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface YBBOldHomeGroupConfig : NSObject
{
    _Bool _separatedLineHidden;
    _Bool _sectionTitleHidden;
    long long _itemId;
    NSString *_name;
    NSString *_module;
}

+ (void)initialize;
@property(nonatomic) _Bool sectionTitleHidden; // @synthesize sectionTitleHidden=_sectionTitleHidden;
@property(nonatomic) _Bool separatedLineHidden; // @synthesize separatedLineHidden=_separatedLineHidden;
@property(copy, nonatomic) NSString *module; // @synthesize module=_module;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(nonatomic) long long itemId; // @synthesize itemId=_itemId;
- (void).cxx_destruct;

@end

