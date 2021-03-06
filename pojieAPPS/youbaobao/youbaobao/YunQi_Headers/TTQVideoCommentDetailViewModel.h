//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "TTQViewModel.h"

@class NSIndexPath, RACCommand, TTQCommentModel;

@interface TTQVideoCommentDetailViewModel : TTQViewModel
{
    _Bool _sendCommented;
    long long _forum_id;
    long long _topic_id;
    NSIndexPath *_selectedReplyIndex;
    RACCommand *_reportCommand;
    long long _referenced_id;
    long long _parent_referenced_id;
    long long _gotoID;
    unsigned long long _topicUserID;
    TTQCommentModel *_commentModel;
}

@property(nonatomic) __weak TTQCommentModel *commentModel; // @synthesize commentModel=_commentModel;
@property(nonatomic) _Bool sendCommented; // @synthesize sendCommented=_sendCommented;
@property(nonatomic) unsigned long long topicUserID; // @synthesize topicUserID=_topicUserID;
@property(nonatomic) long long gotoID; // @synthesize gotoID=_gotoID;
@property(nonatomic) long long parent_referenced_id; // @synthesize parent_referenced_id=_parent_referenced_id;
@property(nonatomic) long long referenced_id; // @synthesize referenced_id=_referenced_id;
@property(retain, nonatomic) RACCommand *reportCommand; // @synthesize reportCommand=_reportCommand;
@property(retain, nonatomic) NSIndexPath *selectedReplyIndex; // @synthesize selectedReplyIndex=_selectedReplyIndex;
@property(nonatomic) long long topic_id; // @synthesize topic_id=_topic_id;
@property(nonatomic) long long forum_id; // @synthesize forum_id=_forum_id;
- (void).cxx_destruct;
- (id)deleteCommentWithID:(long long)arg1;
- (void)reportAction:(id)arg1;
- (id)identifierRowAtIndexPath:(id)arg1;
- (id)tableCellModelAtIndexPath:(id)arg1;
- (long long)numberOfRowsInSection:(long long)arg1;
- (long long)numberOfSections;
- (void)insertNewComment:(id)arg1;
- (id)requestRemoteDataForType:(long long)arg1 params:(id)arg2;
- (id)initWithTopicID:(long long)arg1 referencedId:(long long)arg2;

@end

