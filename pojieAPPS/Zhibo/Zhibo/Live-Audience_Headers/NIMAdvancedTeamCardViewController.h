//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIViewController.h>

#import "NIMAdvancedTeamCardHeaderViewDelegate-Protocol.h"
#import "NIMAdvancedTeamMemberCellActionDelegate-Protocol.h"
#import "NIMContactSelectDelegate-Protocol.h"
#import "NIMTeamManagerDelegate-Protocol.h"
#import "NIMTeamSwitchProtocol-Protocol.h"
#import "UIActionSheetDelegate-Protocol.h"
#import "UIImagePickerControllerDelegate-Protocol.h"
#import "UINavigationControllerDelegate-Protocol.h"
#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class NIMTeam, NIMTeamMember, NSArray, NSString, UIActionSheet, UIAlertView, UITableView;

@interface NIMAdvancedTeamCardViewController : UIViewController <NIMAdvancedTeamMemberCellActionDelegate, NIMContactSelectDelegate, NIMTeamSwitchProtocol, NIMAdvancedTeamCardHeaderViewDelegate, NIMTeamManagerDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIAlertView *_updateTeamNameAlertView;
    UIAlertView *_updateTeamNickAlertView;
    UIAlertView *_updateTeamIntroAlertView;
    UIAlertView *_quitTeamAlertView;
    UIAlertView *_dismissTeamAlertView;
    UIActionSheet *_moreActionSheet;
    UIActionSheet *_authActionSheet;
    UIActionSheet *_inviteActionSheet;
    UIActionSheet *_beInviteActionSheet;
    UIActionSheet *_updateInfoActionSheet;
    UIActionSheet *_avatarActionSheet;
    UIActionSheet *_banChatActionSheet;
    UITableView *_tableView;
    NIMTeam *_team;
    NIMTeamMember *_myTeamInfo;
    NSArray *_bodyData;
    NSArray *_memberData;
}

@property(copy, nonatomic) NSArray *memberData; // @synthesize memberData=_memberData;
@property(copy, nonatomic) NSArray *bodyData; // @synthesize bodyData=_bodyData;
@property(retain, nonatomic) NIMTeamMember *myTeamInfo; // @synthesize myTeamInfo=_myTeamInfo;
@property(retain, nonatomic) NIMTeam *team; // @synthesize team=_team;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
- (void).cxx_destruct;
- (void)viewWillTransitionToSize:(struct CGSize)arg1 withTransitionCoordinator:(id)arg2;
- (void)didRotateFromInterfaceOrientation:(long long)arg1;
- (void)uploadImage:(id)arg1;
- (void)imagePickerControllerDidCancel:(id)arg1;
- (void)imagePickerController:(id)arg1 didFinishPickingMediaWithInfo:(id)arg2;
- (void)onBeInviteActionSheet:(id)arg1 index:(long long)arg2;
- (void)onUpdateInfoActionSheet:(id)arg1 index:(long long)arg2;
- (void)onInviteActionSheet:(id)arg1 index:(long long)arg2;
- (void)onAuthActionSheet:(id)arg1 index:(long long)arg2;
- (void)ontransferActionSheet:(id)arg1 index:(long long)arg2;
- (void)showImagePicker:(long long)arg1;
- (void)onBanChatActionSheet:(id)arg1 index:(long long)arg2;
- (void)onAvatarActionSheet:(id)arg1 index:(long long)arg2;
- (void)actionSheet:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)dismissTeamAlert:(long long)arg1;
- (void)quitTeamAlert:(long long)arg1;
- (void)updateTeamIntroAlert:(long long)arg1;
- (void)updateTeamNickAlert:(long long)arg1;
- (void)updateTeamNameAlert:(long long)arg1;
- (void)alertView:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)didCancelledSelect;
- (void)didFinishedSelect:(id)arg1;
- (void)didSelectAddOpeartor;
- (void)onStateChanged:(_Bool)arg1;
- (void)enterMemberCard;
- (id)beInviteModeText:(long long)arg1;
- (id)updateInfoModeText:(long long)arg1;
- (id)banChatText:(_Bool)arg1;
- (id)inviteModeText:(long long)arg1;
- (id)joinModeText:(long long)arg1;
- (void)changeBeInviteMode;
- (void)changeUpdateInfoMode;
- (void)changeInviteMode;
- (void)changeAuthMode;
- (void)dismissTeam;
- (void)quitTeam;
- (void)updateTeamAnnouncement;
- (void)updateTeamIntro;
- (void)updateTeamNotify;
- (void)banChat;
- (void)updateTeamNick;
- (void)updateTeamName;
- (void)onTouchAvatar:(id)arg1;
- (void)onMore:(id)arg1;
- (id)buildTeamSwitchCell:(id)arg1;
- (id)builidTeamMemberCell:(id)arg1;
- (id)builidRedButtonCell:(id)arg1;
- (id)builidCommonCell:(id)arg1;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)onTeamMemberChanged:(id)arg1;
- (id)cellIndexPathByTitle:(id)arg1;
- (id)bodyDataAtIndexPath:(id)arg1;
- (void)buildBodyData;
- (void)requestData:(CDUnknownBlockType)arg1;
- (void)reloadData;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (void)dealloc;
- (id)initWithTeam:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

