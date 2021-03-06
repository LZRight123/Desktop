//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "AVCaptureMetadataOutputObjectsDelegate-Protocol.h"
#import "UIImagePickerControllerDelegate-Protocol.h"
#import "UINavigationControllerDelegate-Protocol.h"

@class AVCaptureSession, CALayer, NSString, UILabel, UIView;

@interface IMYTLQRCodeScanVC : IMYPublicBaseViewController <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    _Bool _isFromQuickSetting;
    _Bool _followSuccessChangeToFriendVer;
    _Bool _enableCapture;
    _Bool _enableCamera;
    UIView *_scanAreaView;
    UIView *_backgroundview;
    UILabel *_tipLabel;
    UIView *_scanBgView;
    CALayer *_scanLineLayer;
    CDUnknownBlockType _scanResultBlock;
    AVCaptureSession *_session;
    CALayer *_bgLayer;
    NSString *_inviteCode;
    NSString *_cameraString;
}

@property(retain, nonatomic) NSString *cameraString; // @synthesize cameraString=_cameraString;
@property(retain, nonatomic) NSString *inviteCode; // @synthesize inviteCode=_inviteCode;
@property(retain, nonatomic) CALayer *bgLayer; // @synthesize bgLayer=_bgLayer;
@property(nonatomic) _Bool enableCamera; // @synthesize enableCamera=_enableCamera;
@property(retain, nonatomic) AVCaptureSession *session; // @synthesize session=_session;
@property(nonatomic) _Bool enableCapture; // @synthesize enableCapture=_enableCapture;
@property(nonatomic) _Bool followSuccessChangeToFriendVer; // @synthesize followSuccessChangeToFriendVer=_followSuccessChangeToFriendVer;
@property(nonatomic) _Bool isFromQuickSetting; // @synthesize isFromQuickSetting=_isFromQuickSetting;
@property(copy, nonatomic) CDUnknownBlockType scanResultBlock; // @synthesize scanResultBlock=_scanResultBlock;
@property(retain, nonatomic) CALayer *scanLineLayer; // @synthesize scanLineLayer=_scanLineLayer;
@property(nonatomic) __weak UIView *scanBgView; // @synthesize scanBgView=_scanBgView;
@property(nonatomic) __weak UILabel *tipLabel; // @synthesize tipLabel=_tipLabel;
@property(nonatomic) __weak UIView *backgroundview; // @synthesize backgroundview=_backgroundview;
@property(nonatomic) __weak UIView *scanAreaView; // @synthesize scanAreaView=_scanAreaView;
- (void).cxx_destruct;
- (void)didReceiveMemoryWarning;
- (void)dealloc;
- (void)albumButtonAction:(id)arg1;
- (void)imagePickerControllerDidCancel:(id)arg1;
- (void)startFollowAction:(long long)arg1;
- (void)backToHome;
- (void)imagePickerController:(id)arg1 didFinishPickingMediaWithInfo:(id)arg2;
- (void)captureOutput:(id)arg1 didOutputMetadataObjects:(id)arg2 fromConnection:(id)arg3;
- (id)parseInviteCode:(id)arg1;
- (void)startCapture;
- (void)prepareForScan;
- (void)showRightDeniedAlertView;
- (void)viewWillAppear:(_Bool)arg1;
- (void)setRightButton;
- (void)stopScanAnimation;
- (void)showScanAnimation;
- (void)setupScanLine;
- (id)scanAreaMask;
- (id)backgrondviewMask;
- (void)setUI;
- (void)updateSubviewFrame;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

