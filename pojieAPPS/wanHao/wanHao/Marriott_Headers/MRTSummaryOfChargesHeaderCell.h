//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTReviewReservationTableCell.h"

@class MRTStyledLabel, NSLayoutConstraint;

@interface MRTSummaryOfChargesHeaderCell : MRTReviewReservationTableCell
{
    MRTStyledLabel *_summaryOfChargesHeaderLabel;
    NSLayoutConstraint *_headerLabelTopConstraint;
}

@property(nonatomic) __weak NSLayoutConstraint *headerLabelTopConstraint; // @synthesize headerLabelTopConstraint=_headerLabelTopConstraint;
@property(nonatomic) __weak MRTStyledLabel *summaryOfChargesHeaderLabel; // @synthesize summaryOfChargesHeaderLabel=_summaryOfChargesHeaderLabel;
- (void).cxx_destruct;
- (void)updateAccessibility;
- (void)layoutSubviews;

@end

