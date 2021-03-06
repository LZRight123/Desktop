//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "IMYTimerRuningProtocol-Protocol.h"

@class IMYEBPromotionTagModel, NSArray, NSString;
@protocol IMYEBPromotionTagModel, IMYEBSessionDetailModel;

@interface IMYEBBrandItemModel : NSObject <IMYTimerRuningProtocol>
{
    _Bool _is_liked;
    _Bool _is_show_sub_title;
    NSString *_picture;
    NSString *_name;
    long long _id;
    long long _brand_id;
    NSString *_item_id;
    NSString *_open_id;
    NSString *_brand_area_name;
    long long _brand_area_id;
    long long _activity_id;
    long long _redirect_brand_area_id;
    NSString *_start_at;
    NSString *_end_at;
    long long _tag_icon;
    NSString *_promotion_ids;
    NSString *_purchase_btn;
    long long _shop_type;
    long long _redirect_type;
    NSString *_redirect_url;
    long long _link_type;
    NSString *_link_value;
    double _coin_amount;
    double _purchase_price;
    long long _stock;
    NSString *_updated_at;
    NSString *_original_price;
    NSString *_vip_price;
    NSString *_sttag_text;
    long long _sttag_type;
    NSArray *_promotion_text_arr;
    long long _down_count;
    long long _timer_type;
    long long _promotion_type;
    NSString *_specs;
    NSString *_promotion_name;
    NSString *_item_count_msg;
    long long _itemAtAllIndex;
    NSString *_promotion_tag;
    NSString *_promotion_image;
    long long _style_type;
    NSString *_main_title;
    NSString *_sub_title;
    NSString *_item_text;
    NSString *_sub_name;
    long long _title_tag;
    NSString *_picture_tag;
    long long _coupon_id;
    NSString *_coupon_url;
    NSString *_coupon_start_at;
    NSString *_coupon_end_at;
    long long _coupon_type;
    NSString *_sub_title_icon;
    long long _sub_item_total;
    NSArray<IMYEBSessionDetailModel> *_sub_item_list;
    NSString *_discount;
    NSString *_btn_text;
    NSString *_sub_title_tag;
    NSString *_adv_picture;
    NSString *_price_text;
    NSArray<IMYEBPromotionTagModel> *_promotion_voarr;
    NSString *_brand_picture_new;
    NSString *_vip_price_writing;
    NSString *_original_price_writing;
    NSString *_promotion_lab;
    IMYEBPromotionTagModel *_sec_kill;
    IMYEBPromotionTagModel *_promotion;
    NSArray<IMYEBPromotionTagModel> *_one_style_promotion_tag_arr;
    NSArray<IMYEBPromotionTagModel> *_two_style_promotion_tag_arr;
}

+ (id)modelCustomPropertyMapper;
@property(copy, nonatomic) NSArray<IMYEBPromotionTagModel> *two_style_promotion_tag_arr; // @synthesize two_style_promotion_tag_arr=_two_style_promotion_tag_arr;
@property(copy, nonatomic) NSArray<IMYEBPromotionTagModel> *one_style_promotion_tag_arr; // @synthesize one_style_promotion_tag_arr=_one_style_promotion_tag_arr;
@property(retain, nonatomic) IMYEBPromotionTagModel *promotion; // @synthesize promotion=_promotion;
@property(retain, nonatomic) IMYEBPromotionTagModel *sec_kill; // @synthesize sec_kill=_sec_kill;
@property(copy, nonatomic) NSString *promotion_lab; // @synthesize promotion_lab=_promotion_lab;
@property(copy, nonatomic) NSString *original_price_writing; // @synthesize original_price_writing=_original_price_writing;
@property(copy, nonatomic) NSString *vip_price_writing; // @synthesize vip_price_writing=_vip_price_writing;
@property(copy, nonatomic) NSString *brand_picture_new; // @synthesize brand_picture_new=_brand_picture_new;
@property(retain, nonatomic) NSArray<IMYEBPromotionTagModel> *promotion_voarr; // @synthesize promotion_voarr=_promotion_voarr;
@property(copy, nonatomic) NSString *price_text; // @synthesize price_text=_price_text;
@property(copy, nonatomic) NSString *adv_picture; // @synthesize adv_picture=_adv_picture;
@property(copy, nonatomic) NSString *sub_title_tag; // @synthesize sub_title_tag=_sub_title_tag;
@property(copy, nonatomic) NSString *btn_text; // @synthesize btn_text=_btn_text;
@property(copy, nonatomic) NSString *discount; // @synthesize discount=_discount;
@property(retain, nonatomic) NSArray<IMYEBSessionDetailModel> *sub_item_list; // @synthesize sub_item_list=_sub_item_list;
@property(nonatomic) long long sub_item_total; // @synthesize sub_item_total=_sub_item_total;
@property(copy, nonatomic) NSString *sub_title_icon; // @synthesize sub_title_icon=_sub_title_icon;
@property(nonatomic) _Bool is_show_sub_title; // @synthesize is_show_sub_title=_is_show_sub_title;
@property(nonatomic) long long coupon_type; // @synthesize coupon_type=_coupon_type;
@property(copy, nonatomic) NSString *coupon_end_at; // @synthesize coupon_end_at=_coupon_end_at;
@property(copy, nonatomic) NSString *coupon_start_at; // @synthesize coupon_start_at=_coupon_start_at;
@property(copy, nonatomic) NSString *coupon_url; // @synthesize coupon_url=_coupon_url;
@property(nonatomic) long long coupon_id; // @synthesize coupon_id=_coupon_id;
@property(copy, nonatomic) NSString *picture_tag; // @synthesize picture_tag=_picture_tag;
@property(nonatomic) long long title_tag; // @synthesize title_tag=_title_tag;
@property(copy, nonatomic) NSString *sub_name; // @synthesize sub_name=_sub_name;
@property(copy, nonatomic) NSString *item_text; // @synthesize item_text=_item_text;
@property(copy, nonatomic) NSString *sub_title; // @synthesize sub_title=_sub_title;
@property(copy, nonatomic) NSString *main_title; // @synthesize main_title=_main_title;
@property(nonatomic) long long style_type; // @synthesize style_type=_style_type;
@property(copy, nonatomic) NSString *promotion_image; // @synthesize promotion_image=_promotion_image;
@property(copy, nonatomic) NSString *promotion_tag; // @synthesize promotion_tag=_promotion_tag;
@property(nonatomic) long long itemAtAllIndex; // @synthesize itemAtAllIndex=_itemAtAllIndex;
@property(copy, nonatomic) NSString *item_count_msg; // @synthesize item_count_msg=_item_count_msg;
@property(retain, nonatomic) NSString *promotion_name; // @synthesize promotion_name=_promotion_name;
@property(copy, nonatomic) NSString *specs; // @synthesize specs=_specs;
@property(nonatomic) long long promotion_type; // @synthesize promotion_type=_promotion_type;
@property(nonatomic) long long timer_type; // @synthesize timer_type=_timer_type;
@property(nonatomic) long long down_count; // @synthesize down_count=_down_count;
@property(nonatomic) _Bool is_liked; // @synthesize is_liked=_is_liked;
@property(retain, nonatomic) NSArray *promotion_text_arr; // @synthesize promotion_text_arr=_promotion_text_arr;
@property(nonatomic) long long sttag_type; // @synthesize sttag_type=_sttag_type;
@property(copy, nonatomic) NSString *sttag_text; // @synthesize sttag_text=_sttag_text;
@property(copy, nonatomic) NSString *vip_price; // @synthesize vip_price=_vip_price;
@property(copy, nonatomic) NSString *original_price; // @synthesize original_price=_original_price;
@property(copy, nonatomic) NSString *updated_at; // @synthesize updated_at=_updated_at;
@property(nonatomic) long long stock; // @synthesize stock=_stock;
@property(nonatomic) double purchase_price; // @synthesize purchase_price=_purchase_price;
@property(nonatomic) double coin_amount; // @synthesize coin_amount=_coin_amount;
@property(copy, nonatomic) NSString *link_value; // @synthesize link_value=_link_value;
@property(nonatomic) long long link_type; // @synthesize link_type=_link_type;
@property(copy, nonatomic) NSString *redirect_url; // @synthesize redirect_url=_redirect_url;
@property(nonatomic) long long redirect_type; // @synthesize redirect_type=_redirect_type;
@property(nonatomic) long long shop_type; // @synthesize shop_type=_shop_type;
@property(copy, nonatomic) NSString *purchase_btn; // @synthesize purchase_btn=_purchase_btn;
@property(copy, nonatomic) NSString *promotion_ids; // @synthesize promotion_ids=_promotion_ids;
@property(nonatomic) long long tag_icon; // @synthesize tag_icon=_tag_icon;
@property(copy, nonatomic) NSString *end_at; // @synthesize end_at=_end_at;
@property(copy, nonatomic) NSString *start_at; // @synthesize start_at=_start_at;
@property(nonatomic) long long redirect_brand_area_id; // @synthesize redirect_brand_area_id=_redirect_brand_area_id;
@property(nonatomic) long long activity_id; // @synthesize activity_id=_activity_id;
@property(nonatomic) long long brand_area_id; // @synthesize brand_area_id=_brand_area_id;
@property(copy, nonatomic) NSString *brand_area_name; // @synthesize brand_area_name=_brand_area_name;
@property(copy, nonatomic) NSString *open_id; // @synthesize open_id=_open_id;
@property(copy, nonatomic) NSString *item_id; // @synthesize item_id=_item_id;
@property(nonatomic) long long brand_id; // @synthesize brand_id=_brand_id;
@property(nonatomic) long long id; // @synthesize id=_id;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(copy, nonatomic) NSString *picture; // @synthesize picture=_picture;
- (void).cxx_destruct;
- (id)orig_item_id;
- (void)imy_timerRuning;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

