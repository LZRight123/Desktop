//
//  LZRedPageManager.h
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZRedPageModel.h"
#import "WeChatClassDumpHelp.h"
#import <HBLog.h>

@interface LZRedPageManager : NSObject
@property (nonatomic, assign) BOOL isAutoRed;
@property (nonatomic, weak  ) CMessageWrap *emoticon;//
#define RedPageManager [LZRedPageManager sharedInstance]
+(instancetype)sharedInstance;
-(void)addRedModel:(LZRedPageModel *)model;
- (LZRedPageModel *)getModel:(NSString *) sendId;
@end

