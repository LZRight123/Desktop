//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIButton.h>

@interface EmoticonTabBarButton : UIButton
{
    _Bool _layoutIgnoreContentRect;
    double _space;
}

@property(nonatomic) _Bool layoutIgnoreContentRect; // @synthesize layoutIgnoreContentRect=_layoutIgnoreContentRect;
@property(nonatomic) double space; // @synthesize space=_space;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;
- (struct CGRect)imageRectForContentRect:(struct CGRect)arg1;
- (struct CGRect)titleRectForContentRect:(struct CGRect)arg1;

@end
