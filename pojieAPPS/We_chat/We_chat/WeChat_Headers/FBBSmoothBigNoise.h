//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MultiFilterConnect.h"

@class DirectionFilterP, FBB, FBBBilateralOneDim;

@interface FBBSmoothBigNoise : MultiFilterConnect
{
    FBBBilateralOneDim *bilateral_H;
    FBBBilateralOneDim *bilateral_V;
    DirectionFilterP *sobel;
    FBB *fbb;
    FBBBilateralOneDim *bilateral_H2;
    FBBBilateralOneDim *bilateral_V2;
    DirectionFilterP *sobel2;
    FBB *fbb2;
    int rotate;
    int flag;
}

- (void).cxx_destruct;
- (void)NewFilter;
- (void)setParam:(float)arg1 sigmaFlat:(float)arg2 sigmaEdge:(float)arg3 sigmaFlat2:(float)arg4 radius:(int)arg5 bStep1:(int)arg6 bStep2:(int)arg7;
- (id)init;
- (id)init:(int)arg1 flag:(int)arg2;

@end
