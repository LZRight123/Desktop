//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYCellModel.h"

@interface IMYSimpleCellModel : IMYCellModel
{
    double _c_padding;
    double _c_iconSize;
    double _c_horizontalOffset;
}

+ (id)modelWithTitle:(id)arg1 content:(id)arg2 icon:(id)arg3;
+ (id)modelWithTitle:(id)arg1 content:(id)arg2;
@property double c_horizontalOffset; // @synthesize c_horizontalOffset=_c_horizontalOffset;
@property double c_iconSize; // @synthesize c_iconSize=_c_iconSize;
@property double c_padding; // @synthesize c_padding=_c_padding;
- (void)setType:(long long)arg1;
- (id)init;

@end

