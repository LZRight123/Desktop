//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIViewController.h>

#import "EKEventEditViewDelegate-Protocol.h"
#import "MRTFixedSizeGridViewDataSource-Protocol.h"
#import "PKAddPassesViewControllerDelegate-Protocol.h"

@class MRTFixedSizeGridView, MRTReservation, NSArray, NSString;

@interface MRTReservationIconsViewController : UIViewController <MRTFixedSizeGridViewDataSource, EKEventEditViewDelegate, PKAddPassesViewControllerDelegate>
{
    MRTReservation *_reservation;
    NSArray *_displayedIconTypes;
    NSString *_analyticsPageName;
    MRTFixedSizeGridView *_gridView;
}

@property(retain, nonatomic) MRTFixedSizeGridView *gridView; // @synthesize gridView=_gridView;
@property(copy, nonatomic) NSString *analyticsPageName; // @synthesize analyticsPageName=_analyticsPageName;
@property(retain, nonatomic) NSArray *displayedIconTypes; // @synthesize displayedIconTypes=_displayedIconTypes;
@property(retain, nonatomic) MRTReservation *reservation; // @synthesize reservation=_reservation;
- (void).cxx_destruct;
- (id)signReservationPassErrorText;
- (id)saveHotelButtonTitle;
- (id)savedHotelButtonTitle;
- (id)viewInWalletText;
- (id)addToWalletText;
- (id)shareReservationText;
- (id)addToCalendarText;
- (void)apiDidSignReservationPass:(id)arg1;
- (void)addPassToWallet:(id)arg1;
- (void)viewPassInWallet:(id)arg1;
- (id)reservationPass;
- (void)setupShareReservationIcon:(id)arg1;
- (void)setupCalendarIcon:(id)arg1;
- (void)setupWalletIcon:(id)arg1;
- (id)createIcon;
- (void)addPassesViewControllerDidFinish:(id)arg1;
- (void)eventEditViewController:(id)arg1 didCompleteWithAction:(long long)arg2;
- (id)fixedSizeGridView:(id)arg1 cellAtIndex:(long long)arg2;
- (long long)numberOfItemsInFixedSizeGridView:(id)arg1;
- (void)updateFavoriteButton:(id)arg1;
- (void)saveHotelButtonTapped:(id)arg1;
- (void)shareReservationButtonTapped:(id)arg1;
- (void)addToCalendarButtonTapped:(id)arg1;
- (void)walletButtonTapped:(id)arg1;
- (void)loadView;
- (id)initWithReservation:(id)arg1 iconTypes:(id)arg2 analyticsPageName:(id)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
