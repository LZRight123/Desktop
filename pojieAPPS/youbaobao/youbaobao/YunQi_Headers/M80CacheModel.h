//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSArray, NSAttributedString;

@interface M80CacheModel : NSObject
{
    NSAttributedString *_showAttributedString;
    NSArray *_attachments;
    NSArray *_linkLocations;
}

@property(retain, nonatomic) NSArray *linkLocations; // @synthesize linkLocations=_linkLocations;
@property(retain, nonatomic) NSArray *attachments; // @synthesize attachments=_attachments;
@property(retain, nonatomic) NSAttributedString *showAttributedString; // @synthesize showAttributedString=_showAttributedString;
- (void).cxx_destruct;

@end

