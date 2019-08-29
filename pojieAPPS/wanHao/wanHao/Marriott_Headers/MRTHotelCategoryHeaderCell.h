//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class MRTStyledLabel, MRTTitleSegmentedControl;
@protocol MRTHotelCategorySegmentDelegate;

@interface MRTHotelCategoryHeaderCell : UITableViewCell
{
    id <MRTHotelCategorySegmentDelegate> _delegate;
    MRTTitleSegmentedControl *_segmentControl;
    MRTStyledLabel *_headerLabel;
    MRTStyledLabel *_descriptionLabel;
    MRTStyledLabel *_pointsRewardLabel;
}

@property(nonatomic) __weak MRTStyledLabel *pointsRewardLabel; // @synthesize pointsRewardLabel=_pointsRewardLabel;
@property(nonatomic) __weak MRTStyledLabel *descriptionLabel; // @synthesize descriptionLabel=_descriptionLabel;
@property(nonatomic) __weak MRTStyledLabel *headerLabel; // @synthesize headerLabel=_headerLabel;
@property(nonatomic) __weak MRTTitleSegmentedControl *segmentControl; // @synthesize segmentControl=_segmentControl;
@property __weak id <MRTHotelCategorySegmentDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)segmentControlSelectedValueChanged:(id)arg1;

@end
