//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTTQVCommentBaseVC.h"

#import "UITableViewDelegate-Protocol.h"

@class IMYCaptionView, IMYSimpleTableView, IMYTTQVCommentView, IMYTTQVDetailCommentVM, NSString;

@interface IMYTTQVDetailCommentVC : IMYTTQVCommentBaseVC <UITableViewDelegate>
{
    _Bool _isNoReference;
    _Bool _isHideMainComment;
    _Bool _becomeFirstResponder;
    _Bool _disableHeadRefresh;
    _Bool _isChildVC;
    NSString *_referencedName;
    long long _reviewId;
    long long _gotoId;
    long long _newsId;
    long long _type;
    long long _position;
    CDUnknownBlockType _onViewWillDisappearBlock;
    IMYSimpleTableView *_tableView;
    IMYCaptionView *_captionView;
    IMYTTQVDetailCommentVM *_viewModel;
    IMYTTQVCommentView *_commentView;
}

@property(retain, nonatomic) IMYTTQVCommentView *commentView; // @synthesize commentView=_commentView;
@property(retain, nonatomic) IMYTTQVDetailCommentVM *viewModel; // @synthesize viewModel=_viewModel;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) IMYSimpleTableView *tableView; // @synthesize tableView=_tableView;
@property(copy, nonatomic) CDUnknownBlockType onViewWillDisappearBlock; // @synthesize onViewWillDisappearBlock=_onViewWillDisappearBlock;
@property(nonatomic) long long position; // @synthesize position=_position;
@property(nonatomic) long long type; // @synthesize type=_type;
@property(nonatomic) _Bool isChildVC; // @synthesize isChildVC=_isChildVC;
@property(nonatomic) _Bool disableHeadRefresh; // @synthesize disableHeadRefresh=_disableHeadRefresh;
@property(nonatomic) _Bool becomeFirstResponder; // @synthesize becomeFirstResponder=_becomeFirstResponder;
@property(nonatomic) _Bool isHideMainComment; // @synthesize isHideMainComment=_isHideMainComment;
@property(nonatomic) _Bool isNoReference; // @synthesize isNoReference=_isNoReference;
@property(nonatomic) long long newsId; // @synthesize newsId=_newsId;
@property(nonatomic) long long gotoId; // @synthesize gotoId=_gotoId;
@property(nonatomic) long long reviewId; // @synthesize reviewId=_reviewId;
@property(copy, nonatomic) NSString *referencedName; // @synthesize referencedName=_referencedName;
- (void).cxx_destruct;
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (void)initViews;
- (void)endFooterRefreshWithMore:(_Bool)arg1;
- (_Bool)showCommentViewWithReviewId:(unsigned long long)arg1 referencedId:(unsigned long long)arg2 referencedName:(id)arg3;
- (void)commentButtonPressed:(id)arg1;
- (id)replyBarView;
- (void)viewDidLayoutSubviews;
- (void)viewWillLayoutSubviews;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)initWithReviewId:(long long)arg1 gotoId:(long long)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
