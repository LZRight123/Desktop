//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class IMYEBPageController, UIViewController;

@protocol IMYEBPageControllerDelegate <NSObject>

@optional
- (void)pageController:(IMYEBPageController *)arg1 viewDidDisappear:(UIViewController *)arg2 forIndex:(long long)arg3;
- (void)pageController:(IMYEBPageController *)arg1 viewWillDisappear:(UIViewController *)arg2 forIndex:(long long)arg3;
- (void)pageController:(IMYEBPageController *)arg1 viewDidAppear:(UIViewController *)arg2 forIndex:(long long)arg3;
- (void)pageController:(IMYEBPageController *)arg1 viewWillAppear:(UIViewController *)arg2 forIndex:(long long)arg3;
- (void)pageController:(IMYEBPageController *)arg1 transitionFromIndex:(long long)arg2 toIndex:(long long)arg3 progress:(double)arg4;
- (void)pageController:(IMYEBPageController *)arg1 transitionFromIndex:(long long)arg2 toIndex:(long long)arg3 animated:(_Bool)arg4;
@end
