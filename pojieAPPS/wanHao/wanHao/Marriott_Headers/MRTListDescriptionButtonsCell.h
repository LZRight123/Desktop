//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class MRTStyledButton, MRTStyledLabel, NSLayoutConstraint;

@interface MRTListDescriptionButtonsCell : UITableViewCell
{
    _Bool _modifyButtonVisible;
    MRTStyledLabel *_headerLabel;
    MRTStyledLabel *_detailLabel;
    MRTStyledButton *_modifyButton;
    NSLayoutConstraint *_firstButtonBottomConstraint;
    NSLayoutConstraint *_detailLabelBottomConstraint;
}

@property(nonatomic) __weak NSLayoutConstraint *detailLabelBottomConstraint; // @synthesize detailLabelBottomConstraint=_detailLabelBottomConstraint;
@property(nonatomic) __weak NSLayoutConstraint *firstButtonBottomConstraint; // @synthesize firstButtonBottomConstraint=_firstButtonBottomConstraint;
@property(nonatomic, getter=ismodifyButtonVisible) _Bool modifyButtonVisible; // @synthesize modifyButtonVisible=_modifyButtonVisible;
@property(nonatomic) __weak MRTStyledButton *modifyButton; // @synthesize modifyButton=_modifyButton;
@property(nonatomic) __weak MRTStyledLabel *detailLabel; // @synthesize detailLabel=_detailLabel;
@property(nonatomic) __weak MRTStyledLabel *headerLabel; // @synthesize headerLabel=_headerLabel;
- (void).cxx_destruct;
- (void)displayNeitherButton;
- (void)displaySingleButton;
- (void)displayBothButtons;
- (void)updateConstraints;
- (void)prepareForReuse;

@end
