//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString, NTESLoginData;

@interface NTESLoginManager : NSObject
{
    NTESLoginData *_currentLoginData;
    NSString *_filepath;
}

+ (id)sharedManager;
@property(copy, nonatomic) NSString *filepath; // @synthesize filepath=_filepath;
@property(retain, nonatomic) NTESLoginData *currentLoginData; // @synthesize currentLoginData=_currentLoginData;
- (void).cxx_destruct;
- (void)saveData;
- (void)readData;
- (id)initWithPath:(id)arg1;

@end

