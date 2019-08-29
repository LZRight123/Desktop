//
//  niuniuRobotTimer.m
//  wechatHook
//
//  Created by antion on 2017/3/10.
//
//

#import "niuniuRobotTimer.h"
#import <UIKit/UIKit.h>
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "niuniu.h"
#import "niuniuRobotMemberDetailView.h"

@implementation niuniuRobotTimer {
    niuniuRobotMemberDetailView* mMemberDetailView;
}

-(id) init {
    if (self = [super init]) {
        self.mIsShowPow = YES;
        self.mIsAutoOpenMemberDetail = YES;
        [NSTimer scheduledTimerWithTimeInterval: .5 target: self selector: @selector(timer_0_5) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(timer_1_0) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval: 2 target: self selector: @selector(timer_2_0) userInfo:nil repeats:YES];
    }
    return self;
}

-(void) timer_0_5 {
    //    [self updateHongbaoUI];
    [self checkMemberDetailView];
    [ycFunction setScreenWillLight: YES];
}

-(void) timer_1_0 {
    [tmanager.mRobot.mSendMsg doFirstTask];
}

-(void) timer_2_0 {
    [tmanager.mRobot.mMembers updateAllName];
    [tmanager.mRobot.mInviteCheck handleTasks];
}

//更新红包界面
-(void) updateHongbaoUI {
    UIViewController* controller =[ycFunction getCurrentVisableVC];
    if (!controller) {
        return;
    }
    NSString* className = NSStringFromClass([controller class]);
    if ([className isEqualToString: @"WCRedEnvelopesRedEnvelopesDetailViewController"]) {
        [self changeHongbaoTime: controller.view];
    }
}

//更改红包时间
-(void) changeHongbaoTime:(UIView*)view {
    if ([NSStringFromClass([view class]) isEqualToString: @"MMTableViewCell"]) {
        UITableViewCell* cell = (UITableViewCell*)view;
        if (cell.subviews.count >= 2) {
            UIView* tmpview = cell.subviews[1];
            if(tmpview.subviews.count >= 1) {
                tmpview = tmpview.subviews[0];
                if (tmpview.subviews.count >= 6) {
                    if ([NSStringFromClass([tmpview.subviews[1] class]) isEqualToString: @"MMUILabel"] && [NSStringFromClass([tmpview.subviews[2] class]) isEqualToString: @"MMUILabel"] && [NSStringFromClass([tmpview.subviews[5] class]) isEqualToString: @"MMUILabel"]) {
                        UILabel* name = tmpview.subviews[1];
                        UILabel* money = tmpview.subviews[2];
                        UILabel* timeLabel = tmpview.subviews[5];
                        if (tmanager.mLastHongbaoDetail[@"record"]) {
                            long long minsecond = -1;
                            if ([tmanager.mLastHongbaoDetail[@"totalNum"] intValue] == [tmanager.mLastHongbaoDetail[@"record"] count]) {
                                for (NSDictionary* one in tmanager.mLastHongbaoDetail[@"record"]) {
                                    long long second = [one[@"receiveTime"] longLongValue];
                                    if (minsecond > second || minsecond == -1) {
                                        minsecond = second;
                                    }
                                }
                            }
                            for (NSDictionary* one in tmanager.mLastHongbaoDetail[@"record"]) {
                                NSString* moneyStr = deString(@"%.2f元", [one[@"receiveAmount"] floatValue]/100);
                                NSString* powStr = @"";
                                int pow = [niuniu amount2pow: [one[@"receiveAmount"] intValue]];
                                if (18 == pow) {
                                    powStr = @"豹子";
                                } else if (15 == pow) {
                                    powStr = @"满牛";
                                } else if (14 == pow) {
                                    powStr = @"顺子";
                                } else if (13 == pow) {
                                    powStr = @"倒顺";
                                } else if (12 == pow) {
                                    powStr = @"对子";
                                } else if (11 == pow) {
                                    powStr = @"金牛";
                                } else if (10 == pow) {
                                    powStr = @"牛牛";
                                } else {
                                    powStr = deString(@"牛%d", pow);
                                }
                                NSString* moneyStr2 = deString(@"%@ | %@", moneyStr, powStr);
                                if ([name.text isEqualToString: one[@"receiveName"]] && ([moneyStr isEqualToString:money.text] || [moneyStr2 isEqualToString: money.text])) {
                                    if (self.mIsShowPow) {
                                        UIColor* color = [UIColor blackColor];
                                        if (pow >= 10) {
                                            color = [UIColor colorWithRed:1 green:0 blue:.5 alpha:1];
                                        } else if(pow >= 6) {
                                            color = [UIColor blueColor];
                                        }
                                        money.text = moneyStr2;
                                        money.textColor = color;
                                    } else {
                                        money.text = moneyStr;
                                        money.textColor = [UIColor blackColor];
                                    }
                                    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                                    money.frame = CGRectMake(width-103, money.frame.origin.y, 100, money.frame.size.height);
                                    
                                    long long second = [one[@"receiveTime"] longLongValue];
                                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
                                    NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                                    [objDateformat setDateFormat:@"HH:mm:ss"];
                                    
                                    NSString* timeStr;
                                    UIColor* timeColor;
                                    if (minsecond > 0) {
                                        long long usetime = second-minsecond;
                                        timeStr = deString(@"%@ | %lld秒", [objDateformat stringFromDate: date], usetime);
                                        timeColor = usetime >= 18 ? [UIColor redColor] : [UIColor colorWithRed:0 green:.5 blue:.25 alpha:1];
                                    } else {
                                        timeStr = [objDateformat stringFromDate: date];
                                        timeColor = [UIColor colorWithRed:0 green:.5 blue:.25 alpha:1];
                                    }
                                    timeLabel.text = timeStr;
                                    timeLabel.textColor = timeColor;
                                    timeLabel.textAlignment = NSTextAlignmentLeft;
                                    timeLabel.frame = CGRectMake(timeLabel.frame.origin.x, timeLabel.frame.origin.y, 200, timeLabel.frame.size.height);
                                    
                                    if (tmpview.subviews.count >= 7 && [NSStringFromClass([tmpview.subviews[6] class]) isEqualToString: @"UIButton"]) {
                                        UIButton* btn = tmpview.subviews[6];
                                        if ([[btn currentTitle] hasPrefix: @"留言"]) {
                                            btn.frame = CGRectMake(70, btn.frame.origin.y, 200, btn.frame.size.height);
                                            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;                                            [btn setTitle: deString(@"留言 | %@", timeStr) forState:UIControlStateNormal];
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if ([[view subviews] count] > 0) {
        for (UIView* subview in [view subviews]) {
            //            NSLog(@"------ %@, %@", NSStringFromClass([[subview superview] class]),   NSStringFromClass([subview class]));
            [self changeHongbaoTime: subview];
        }
    }
}

//检查会员详情界面
-(void) checkMemberDetailView {
    UIViewController* controller =[ycFunction getCurrentVisableVC];
    if (!controller) {
        return;
    }
    NSString* className = NSStringFromClass([controller class]);
    if ([className isEqualToString: @"ContactInfoViewController"]) {
        if (!mMemberDetailView) {
            UIViewController* viewController = [ycFunction getVCWithWindow: tmanager.mWindows];
            if (!viewController) {
                return;
            }
            
            for (UIView* view in [viewController.view subviews]) {
                view.hidden = YES;
            }
            
            id CBaseContact = [ycFunction getVar: controller name: @"m_contact"];
            NSString* m_nsUsrName = [ycFunction getVar:CBaseContact name: @"m_nsUsrName"];
            mMemberDetailView = [[niuniuRobotMemberDetailView alloc] initWithFrame: viewController.view.frame userid: m_nsUsrName hasBtn: NO];
            mMemberDetailView.mSuperViewVC = viewController;
            mMemberDetailView.mBackFunc = ^{
                [mMemberDetailView removeFromSuperview];
                mMemberDetailView = nil;
                for (UIView* view in [viewController.view subviews]) {
                    view.hidden = NO;
                }
            };
            [viewController.view addSubview: mMemberDetailView];
            [mMemberDetailView release];
            
           
        }
    } else {
        if (mMemberDetailView) {
            [mMemberDetailView removeFromSuperview];
            mMemberDetailView = nil;
            UIViewController* viewController = [ycFunction getVCWithWindow: tmanager.mWindows];
            if (!viewController) {
                return;
            }
            for (UIView* view in [viewController.view subviews]) {
                view.hidden = NO;
            }
        }
    }
}



@end
