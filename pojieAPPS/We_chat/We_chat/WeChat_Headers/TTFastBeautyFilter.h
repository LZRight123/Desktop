//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "TTGPUImageTwoPassFilter.h"

@interface TTFastBeautyFilter : TTGPUImageTwoPassFilter
{
    int gaussTexelWidthUniform;
    int gaussTexelHeightUniform;
    int processWidthUniform;
    int processHeightUniform;
    int processWhitenUniform;
    int processSkinUniform;
    long long _curGaussRadius;
    double _curWhiten;
    double _curSmooth;
    double _curSkin;
}

@property(nonatomic) double curSkin; // @synthesize curSkin=_curSkin;
@property(nonatomic) double curSmooth; // @synthesize curSmooth=_curSmooth;
@property(nonatomic) double curWhiten; // @synthesize curWhiten=_curWhiten;
@property(nonatomic) long long curGaussRadius; // @synthesize curGaussRadius=_curGaussRadius;
- (void)renderToTextureWithVertices:(const float *)arg1 textureCoordinates:(const float *)arg2;
- (id)fragStringWithRadius;
- (void)setSkinFilter:(double)arg1;
- (void)setWhiten:(double)arg1;
@property(nonatomic) double smoothOpacity;
- (void)switchToVertexShader:(id)arg1 fragmentShader:(id)arg2;
- (id)init;

@end

