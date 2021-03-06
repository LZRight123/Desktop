//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

@class IMYButton, IMYTLCBFamilyMangeResultModel, IMYTLCBSeleteFamilyView, NSString, UIView;

@interface IMYTLCBFamilyChangeRelationVC : IMYPublicBaseViewController
{
    CDUnknownBlockType _seletedCompletion;
    long long _babyId;
    long long _userId;
    NSString *_defaultFamilyName;
    UIView *_headerView;
    IMYTLCBSeleteFamilyView *_selectView;
    NSString *_selectedNickName;
    long long _selectedID;
    IMYTLCBFamilyMangeResultModel *_relationModel;
    IMYButton *_doneBtn;
}

@property(retain, nonatomic) IMYButton *doneBtn; // @synthesize doneBtn=_doneBtn;
@property(retain, nonatomic) IMYTLCBFamilyMangeResultModel *relationModel; // @synthesize relationModel=_relationModel;
@property(nonatomic) long long selectedID; // @synthesize selectedID=_selectedID;
@property(retain, nonatomic) NSString *selectedNickName; // @synthesize selectedNickName=_selectedNickName;
@property(retain, nonatomic) IMYTLCBSeleteFamilyView *selectView; // @synthesize selectView=_selectView;
@property(retain, nonatomic) UIView *headerView; // @synthesize headerView=_headerView;
@property(retain, nonatomic) NSString *defaultFamilyName; // @synthesize defaultFamilyName=_defaultFamilyName;
@property(nonatomic) long long userId; // @synthesize userId=_userId;
@property(nonatomic) long long babyId; // @synthesize babyId=_babyId;
@property(copy, nonatomic) CDUnknownBlockType seletedCompletion; // @synthesize seletedCompletion=_seletedCompletion;
- (void).cxx_destruct;
- (void)didReceiveMemoryWarning;
- (void)doneBtnAction:(id)arg1;
- (void)setupDoneButton;
- (void)updateSetDefaultFamilyName;
- (void)viewDidLoad;
- (id)initWithRelation:(id)arg1;
- (id)initWithBabyId:(long long)arg1 userId:(long long)arg2 defaultFamilyName:(id)arg3;

@end

