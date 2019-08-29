//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  wexingGitDylib.m
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/19.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import "wexingGitDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import "GlobalHeaderFile.h"
#import <FLEX/FLEX.h>
#import <MDSettingCenter/MDSettingCenter.h>
#import <MDMethodTrace.h>
#import "OCMethodTrace.h"

@interface MDSuspendBallTool: NSObject
+ (instancetype)tool;
@end
@implementation MDSuspendBallTool
+ (instancetype)tool{
    static MDSuspendBallTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MDSuspendBallTool alloc]init];
    });
    return instance;
}

- (void)click{
    FLEXManager *flex = [FLEXManager sharedManager];
    if (flex.isHidden) {
        [flex showExplorer];
    } else {
        [flex hideExplorer];
    }
}

@end

CHConstructor{
    printf(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        MDSuspendBall *btn = [MDSuspendBall sharedInstance];
        [btn removeAllTargets];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = btn.bounds.size.width * 0.5;
        btn.layer.masksToBounds = true;
        [btn setImage:[UIImage imageNamed:@"lztest"] forState:UIControlStateNormal];
        [btn addToWindow:[UIApplication sharedApplication].delegate.window];
        [btn addTarget:[MDSuspendBallTool tool] action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        [[FLEXManager sharedManager] showExplorer];
        
    }];
}


CHDeclareClass(FindFriendEntryViewController);
CHOptimizedMethod1(self, NSInteger, FindFriendEntryViewController, numberOfSectionsInTableView, UITableView *, tableView){
    NSInteger sectionCount = CHSuper1(FindFriendEntryViewController, numberOfSectionsInTableView, tableView);
    return 1 + sectionCount;
};

CHOptimizedMethod2(self, NSInteger, FindFriendEntryViewController, tableView, UITableView *, tableView, numberOfRowsInSection, NSInteger, section){
    if (section == 0) {
        return 3;
    }
    NSInteger row = CHSuper2(FindFriendEntryViewController, tableView, tableView, numberOfRowsInSection, section - 1);
    return row;
}
CHOptimizedMethod2(self, UITableViewCell *, FindFriendEntryViewController, tableView, UITableView *, tableView, cellForRowAtIndexPath, NSIndexPath *, indexPath){
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            SwitchCell *cell = [SwitchCell cellWithTableView:tableView];
            return cell;
        }
        
        ImitateWechatCell *cell = [ImitateWechatCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"zytcellicon"];
            cell.textLabel.text = @"My Git";
            return cell;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"zyttest"];
            cell.textLabel.text = @"智药通设计规范";
        }
        return cell;
    }
    UITableViewCell *cell = CHSuper2(FindFriendEntryViewController, tableView, tableView, cellForRowAtIndexPath, [NSIndexPath indexPathForRow:row inSection:section - 1]);
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
CHOptimizedMethod2(self, void, FindFriendEntryViewController, tableView, UITableView *, tableView, didSelectRowAtIndexPath, NSIndexPath *, indexPath){
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 1) {//git
            LZBaseWebVC *nextVC = [[LZBaseWebVC alloc] init];
            nextVC.title = @"快乐的小梁同学";
            nextVC.url = [NSURL URLWithString:@"https://github.com/LZRight123/ARM"];
            [[(UIViewController *)self navigationController] pushViewController:nextVC animated:true];
        } else if (row == 2) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[(UIViewController *)self view] animated:true];
            hud.label.text = @"以后再搞";
            [hud hideAnimated:true afterDelay:2];
//            LZBaseWebVC *nextVC = [[LZBaseWebVC alloc] init];
//            nextVC.title = @"智药通设计规范";
//            NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zyt_UIKIT" ofType:@"pdf"]];
//            nextVC.url = [NSURL URLWithString:filePath];
//            [[(UIViewController *)self navigationController] pushViewController:nextVC animated:true];
        }
        return ;
    }
    return CHSuper2(FindFriendEntryViewController, tableView, tableView, didSelectRowAtIndexPath, [NSIndexPath indexPathForRow:row inSection:section - 1]);
}



CHConstructor{
//    [[MDMethodTrace sharedInstance] addClassTrace:@"BaseMsgContentViewController"];
//    [[OCMethodTrace sharedInstance] traceMethodWithClass:NSClassFromString(@"EmoticonBoardView") condition:^BOOL(SEL sel) {
//        return true;
//    } before:^(id target, __unsafe_unretained Class cls, SEL sel, NSArray *args, int deep) {
//
//    } after:^(id target, __unsafe_unretained Class cls, SEL sel, id ret, int deep, NSTimeInterval interval) {
//
//    }];
//
    CHLoadLateClass(FindFriendEntryViewController);
    CHHook1(FindFriendEntryViewController, numberOfSectionsInTableView);
    CHHook2(FindFriendEntryViewController, tableView, numberOfRowsInSection);
    CHHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
    CHHook2(FindFriendEntryViewController, tableView, didSelectRowAtIndexPath);
    
    
//    <CEmoticonWrap: self.m_uiType=1, self.m_bCanDelete=1, self.m_uiGameType=1, self.m_nsAppID=(null), self.m_extFlag=0, self.m_nsThumbImgPath=(null), self.m_nsThumbImgUrl=(null), self.m_lastUsedTime=0, self.m_isAsyncUpload=0, self.m_emojiInfo=<EmojiInfoObj: md5=jsb_emoticon_md5, url=(null), thumbUrl=(null), designerId=(null), encryptUrl=(null), aesKey=(null), productId=custom_emoticon_pid, externUrl=(null), externMd5=(null), disableExtern=0, activityId=(null), attachedText=(null), tpurl=(null), tpauthkey=(null), attachedTextColor=(null), lensId=(null)>>
//    <CEmoticonWrap: self.m_uiType=1, self.m_bCanDelete=1, self.m_uiGameType=2, self.m_nsAppID=(null), self.m_extFlag=0, self.m_nsThumbImgPath=(null), self.m_nsThumbImgUrl=(null), self.m_lastUsedTime=0, self.m_isAsyncUpload=0, self.m_emojiInfo=<EmojiInfoObj: md5=dice_emoticon_md5, url=(null), thumbUrl=(null), designerId=(null), encryptUrl=(null), aesKey=(null), productId=custom_emoticon_pid, externUrl=(null), externMd5=(null), disableExtern=0, activityId=(null), attachedText=(null), tpurl=(null), tpauthkey=(null), attachedTextColor=(null), lensId=(null)>>
//
}



CHDeclareClass(CMPedometerData);

CHOptimizedMethod0(self, NSNumber *, CMPedometerData, numberOfSteps) {
    NSNumber *number = CHSuper0(CMPedometerData, numberOfSteps);

    return number;
}

CHConstructor{
    CHLoadLateClass(CMPedometerData);
    CHClassHook0(CMPedometerData, numberOfSteps);
}
