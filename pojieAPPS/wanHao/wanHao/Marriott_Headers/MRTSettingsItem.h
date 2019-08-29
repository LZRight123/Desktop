//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface MRTSettingsItem : NSObject
{
    _Bool _selectionDisabled;
    NSString *_cellIdentifier;
    NSString *_label;
    NSString *_detailLabel;
    NSString *_subtitleLabel;
    id _target;
    SEL _action;
    CDUnknownBlockType _switchValueBlock;
}

+ (id)itemWithStruct:(CDStruct_cf61f9a5)arg1;
@property(nonatomic, getter=isSelectionDisabled) _Bool selectionDisabled; // @synthesize selectionDisabled=_selectionDisabled;
@property(copy, nonatomic) CDUnknownBlockType switchValueBlock; // @synthesize switchValueBlock=_switchValueBlock;
@property(nonatomic) SEL action; // @synthesize action=_action;
@property(nonatomic) __weak id target; // @synthesize target=_target;
@property(copy, nonatomic) NSString *subtitleLabel; // @synthesize subtitleLabel=_subtitleLabel;
@property(copy, nonatomic) NSString *detailLabel; // @synthesize detailLabel=_detailLabel;
@property(copy, nonatomic) NSString *label; // @synthesize label=_label;
@property(copy, nonatomic) NSString *cellIdentifier; // @synthesize cellIdentifier=_cellIdentifier;
- (void).cxx_destruct;

@end
