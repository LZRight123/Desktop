//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDictionary, NSString;

@interface YSFBotFormCell : NSObject
{
    _Bool _required;
    NSString *_label;
    NSString *_value;
    NSDictionary *_imageValue;
    NSString *_type;
    NSString *_id;
}

+ (id)objectByDict:(id)arg1;
@property(copy, nonatomic) NSString *id; // @synthesize id=_id;
@property(copy, nonatomic) NSString *type; // @synthesize type=_type;
@property(nonatomic) _Bool required; // @synthesize required=_required;
@property(copy, nonatomic) NSDictionary *imageValue; // @synthesize imageValue=_imageValue;
@property(copy, nonatomic) NSString *value; // @synthesize value=_value;
@property(copy, nonatomic) NSString *label; // @synthesize label=_label;
- (void).cxx_destruct;
@property(readonly, nonatomic) long long imageFileSize;
@property(readonly, copy, nonatomic) NSString *imageName;
@property(readonly, copy, nonatomic) NSString *imageUrl;
- (id)encodeAttachment;

@end
