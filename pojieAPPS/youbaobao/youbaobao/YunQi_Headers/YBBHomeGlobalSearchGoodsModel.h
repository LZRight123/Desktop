//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface YBBHomeGlobalSearchGoodsModel : NSObject
{
    float _original_price;
    float _vip_price;
    long long _item_id;
    NSString *_name;
    long long _brand_area_id;
    NSString *_redirect_url;
    NSString *_picture;
    NSString *_promotion_text;
    NSString *_purchase_btn;
}

@property(copy, nonatomic) NSString *purchase_btn; // @synthesize purchase_btn=_purchase_btn;
@property(copy, nonatomic) NSString *promotion_text; // @synthesize promotion_text=_promotion_text;
@property(nonatomic) float vip_price; // @synthesize vip_price=_vip_price;
@property(copy, nonatomic) NSString *picture; // @synthesize picture=_picture;
@property(copy, nonatomic) NSString *redirect_url; // @synthesize redirect_url=_redirect_url;
@property(nonatomic) float original_price; // @synthesize original_price=_original_price;
@property(nonatomic) long long brand_area_id; // @synthesize brand_area_id=_brand_area_id;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(nonatomic) long long item_id; // @synthesize item_id=_item_id;
- (void).cxx_destruct;

@end
