//
//  niuniuRobotResultView.m
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import "niuniuRobotResultView.h"
#import "toolManager.h"
#import "ycFunction.h"
#import "niuniuRobot.h"
#import "niuniuRobotResult.h"
#import "wxFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycInputView.h"
#import "niuniuRobotResultSettingView.h"

@implementation niuniuRobotResultView {
    NSMutableDictionary* mTableViewConfigs;
    NSMutableArray* mOpenSections;
}

-(id) initWithFrame:(CGRect)frame {
    NSLog(@"######## niuniuRobotResultView initWithFrame ");

    if (self = [super initWithFrame:frame]) {
        mTableViewConfigs = [@{} mutableCopy];
        mOpenSections = [@[] mutableCopy];

        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"操作", @30],
                                         @[@"庄", @30, @"banker"],
                                         @[@"无包", @30, @"null"],
                                         @[@"抢包", @30, @"rob"],
                                         @[@"超时", @30, @"overtime"],
                                         @[@"闲", @30, @"normal"],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@5, @"自动获取", @"autoQueryHongbao", @"导入", @"hongbao"],
                                           @[@2, @"本局设置", @"setting"],
                                           @[@4, @"结算", @"showResult"],
                                           ],
                                       ];
        
        tmanager.mRobot.mResult.mDelegate = self;
        [self reloadAll];
    }
    return self;
}

-(void) dealloc {
    NSLog(@"######## niuniuRobotResultView dealloc ");

    tmanager.mRobot.mResult.mDelegate = nil;
    [mTableViewConfigs release];
    [mOpenSections release];
    [super dealloc];
}

-(void) reloadAll {
    [mOpenSections removeAllObjects];
    for (NSArray* arr in mTableViewConfigs[@"titles"]) {
        if ([arr count] > 2) {
            NSArray* data = [self datasWithKey: arr[2]];
            if (data && [data count] > 0) {
                [mOpenSections addObject: arr[2]];
            }
        }
    }
    [self reloadData];
}

-(NSArray*) tileWithSection:(NSInteger)section {
    if (0 == section) {
        return mTableViewConfigs[@"titles"][0];
    }
    if ([mOpenSections count] > section-1) {
        NSString* key = mOpenSections[section-1];
        for (NSArray* arr in mTableViewConfigs[@"titles"]) {
            if ([arr count] > 2 && [arr[2] isEqualToString: key]) {
                return arr;
            }
        }
    }
    return nil;
}

-(NSArray*) datasWithKey:(NSString*)text {
    if ([text isEqualToString: @"null"]) {
        return tmanager.mRobot.mResult.mNullHongbao;
    }
    else if ([text isEqualToString: @"rob"]) {
        return tmanager.mRobot.mResult.mRobHongbao;
    }
    else if ([text isEqualToString: @"overtime"]) {
        return tmanager.mRobot.mResult.mTimeover;
    }
    else if ([text isEqualToString: @"banker"]) {
        return tmanager.mRobot.mResult.mBanker;
    }
    else if ([text isEqualToString: @"normal"]) {
        return tmanager.mRobot.mResult.mNormal;
    }
    return nil;
}

//扩展按钮回调
-(funcEnd) getBtnFunc: (NSString*)key {
    __weak __typeof(&*self)weakSelf = self;

    funcEnd ret = nil;
    if ([key isEqualToString: @"hongbao"]) {
        ret = ^{
//            if ([tmanager.mLastHongbaoDetail[@"totalNum"] intValue] != [tmanager.mLastHongbaoDetail[@"record"] count]) {
//                [ycFunction showMsg: @"红包未获取完整" msg:nil vc:self.mSuperViewVC];
//                return;
//            }
            [tmanager.mRobot.mResult setHongbaoData: tmanager.mLastHongbaoDetail];
            [weakSelf reloadAll];
        };
    }
    return ret ? [[ret copy] autorelease] : nil;
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;

}

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    __weak __typeof(&*self)weakSelf = self;
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if (section == 0) {//第一组
        NSArray* arr = mTableViewConfigs[@"rows"][section][row];
        int type = [arr[0] intValue];
        if (type == 0) {//开关
            return;
        }
        NSString* key = arr[2];
        if([key isEqualToString: @"showResult"]) {
            NSString* errMsg = [tmanager.mRobot.mResult genReport];
            if (errMsg && ![errMsg isEqualToString: @""]) {
                [ycFunction showMsg: errMsg msg:nil vc:self.mSuperViewVC];
            }
            [weakSelf reloadData];
        }
        else if([key isEqualToString: @"nextRound"]) {
            if (tmanager.mRobot.mResult.mReport[@"report"]) {
                [tmanager.mRobot changeStatus: eNiuniuRobotStatusNone];
                [self.mSuperViewVC updateTableView: 2];
            } else {
                [ycFunction showMsg: @"账单未生成" msg:nil vc:self.mSuperViewVC];
            }
        }
        else if([key isEqualToString: @"autoQueryHongbao"]) {
            [tmanager.mRobot.mResult setIsAutoQueryHongbao: !tmanager.mRobot.mResult.mEnableAutoQueryHongbao];
            [weakSelf reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
        else if([key isEqualToString: @"setting"]) {
            niuniuRobotResultSettingView* view = [[niuniuRobotResultSettingView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame];
            view.mSuperViewVC = self.mSuperViewVC;
            view.mBackFunc = ^(BOOL isReloadAll){
                weakSelf.mSuperViewVC.mBgView.hidden = NO;
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: view dur: .2 completion:^(BOOL b) {
                    [view removeFromSuperview];
                }];
                if (isReloadAll) {
                    [weakSelf reloadAll];
                } else {
                    [weakSelf reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                }
            };
            view.hidden = YES;
            [self.mSuperViewVC.view addSubview: view];
            [view release];
            dispatch_async(deMainQueue, ^{
                view.hidden = NO;
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: view dur: .2 completion:^(BOOL b){
                    if (b) {
                        weakSelf.mSuperViewVC.mBgView.hidden = YES;
                    }
                }];
            });
        }
    } else {
        NSString* key = mOpenSections[indexPath.section-1];
        NSArray* datas = [self datasWithKey: key];
        NSMutableDictionary* dic = datas[indexPath.row];
        NSString* name = dic[@"name"];
        NSString* resultText = dic[@"amount"] ? dic[@"amount"] : @"";
        ycInputView* contentView = [[ycInputView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame title: deString(@"设置点数(%@)", name) text:resultText];
        contentView.mFunc = ^(BOOL b, NSString* text) {
            [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:^(BOOL b) {
                [contentView removeFromSuperview];
                [contentView release];
            }];
            
            if (b && [ycFunction isInt: text]) {
                if (tmanager.mRobot.mResult.mHasHongbaoData && [resultText intValue] != [text intValue]) {
                    [tmanager.mRobot.mRework addReworkRecord: @{
                                                          @"type" : @"amountChange",
                                                          @"userid" : dic[@"userid"],
                                                          @"oldAmount" : deString(@"%.2f", [resultText intValue]/100.0),
                                                          @"newAmount" : deString(@"%.2f", [text intValue]/100.0),
                                                          }];
                }
                NSString* oldHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
                [tmanager.mRobot.mResult setResultHandle: dic type: @"normal"];
                [tmanager.mRobot.mResult setMount: dic mount: [text intValue]];
                [weakSelf reloadData];
                
                NSString* newHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
                if (![oldHandle isEqualToString: newHandle]) {
                    [tmanager.mRobot.mRework addReworkRecord: @{
                                                          @"type" : @"resultChange",
                                                          @"userid" : dic[@"userid"],
                                                          @"oldResult" : oldHandle,
                                                          @"newResult" : newHandle,
                                                          }];
                }
            }
        };
        [self.mSuperViewVC.view addSubview: contentView];
        dispatch_async(deMainQueue, ^{
            [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:nil];
        });
    }
}

#pragma mark- UITableViewDataSource

//组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [mOpenSections count]+1;
}
    
//标题高
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section {
    NSArray* titleData = [self tileWithSection: section];
    return [titleData[1] intValue];
}
    
//标题视图
- (UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray* titleData = [self tileWithSection: section];
    NSString* text = titleData[0];
    int titleh = [titleData[1] intValue];
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text = text;
    [myView addSubview:titleLabel];
    [titleLabel release];
    if ([titleData count] > 2 && ![titleData[2] isEqualToString: @"banker"]) {
        NSArray* datas = [self datasWithKey: titleData[2]];
        if (datas) {
            titleLabel.text = deString(@"%@(%d)", text, (int)[datas count]);
        }
    }
    
    if (0 == section) {
        __weak __typeof(&*self)weakSelf = self;
        ycButtonView* clearBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"重置" func: ^() {
            [tmanager.mRobot.mResult setHongbaoData: nil];
            [weakSelf reloadAll];
        }];
        [clearBtn setBtnColor: [UIColor colorWithRed:.5 green:.5 blue:0 alpha:1] isSelected:NO];
        clearBtn.center = CGPointMake(weakSelf.frame.size.width-30, 30/2);
        [myView addSubview: clearBtn];
        [clearBtn release];
    }
    return myView;
}
    
    //组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}
    
//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return [mTableViewConfigs[@"rows"][section] count];
    }
    return [[self datasWithKey: mOpenSections[section-1]] count];
}
    
//消除cell选择痕迹
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    [self clickLine: indexPath];
}
    
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];

    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if(0 == section) {
        NSArray* arr = mTableViewConfigs[@"rows"][section][row];
        int celltype = [arr[0] intValue];
        NSString* title = arr[1];
        UIColor* titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
        NSString* key = arr[2];
        
        if ([key isEqualToString: @"autoQueryHongbao"]) {
            if (tmanager.mRobot.mResult.mEnableAutoQueryHongbao) {
                title = @"获取中..";
                titleColor = [UIColor greenColor];
            } else {
                title = @"自动获取";
                titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
            }
        }
        
        if (0 == celltype) {
            UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
            switchview.tag = key;
            [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchview;
        } else if(1 == celltype) {
            NSString* rightText = @"";
            if ([arr[2] isEqualToString: @""]) {
            }
            UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
            [ycFunction cellAddRightText: cell text: rightText color: rightTextColor size: 16 offset:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(2 == celltype) {
            NSString* detailStr = @"";
            if ([arr[2] isEqualToString: @"setting"]) {
                if ([tmanager.mRobot.mResult.mLastAmounts count] == 0) {
                    detailStr = @"尾巴未知";
                } else {
                    detailStr = deString(@"尾%@", [tmanager.mRobot.mResult.mLastAmounts componentsJoinedByString:@"/"]);
                }
            }
            cell.detailTextLabel.text = detailStr;
            cell.detailTextLabel.textColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(3 == celltype) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(4 == celltype) {
            
        } else if(5 == celltype) {
            NSString* text = arr[3];
            ycButtonView* btn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 64, 32) text:text func: [self getBtnFunc: arr[4]]];
            [btn setScrollView: tableView];
            btn.center = CGPointMake(cell.contentView.frame.size.width-135, cell.contentView.frame.size.height/2);
            [cell.contentView addSubview:btn];
            [btn release];
            
            if ([arr count] >= 7) {
                ycButtonView* btn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 64, 32) text:arr[5] func: [self getBtnFunc: arr[6]]];
                [btn setScrollView: tableView];
                btn.center = CGPointMake(cell.contentView.frame.size.width-135-64-4, cell.contentView.frame.size.height/2);
                [cell.contentView addSubview:btn];
                [btn release];
            }
        }
        
        cell.textLabel.text = title;
        cell.textLabel.textColor = titleColor;
    } else {
        if (section-1 >= [mOpenSections count]) {
            return cell;
        }
        NSArray* datas = [self datasWithKey: mOpenSections[section-1]];
        if (!datas) {
            return cell;
        }
        NSDictionary* dic = datas[row];
        if (dic) {
            int score = [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]];
            UIColor* color = [UIColor whiteColor];
            cell.textLabel.text = dic[@"remarkName"] ? dic[@"remarkName"] : dic[@"name"];
            cell.textLabel.textColor = color;
            if (score >= 0) {
                NSString* text;
                if (dic[@"valuesStr"]) {
                    text = deString(@"%d#%@", score, dic[@"valuesStr"]);
                }
                else if (dic[@"num"]) {
                    BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
                    BOOL mianyong = [dic[@"mianyong"] isEqualToString: @"true"];
                    BOOL yibi = [dic[@"yibi"] isEqualToString: @"true"];
                    text = deString(@"积分%d%@%@", score, mianyong ? @"免" : yibi ? @"一比" : suoha ? @"梭" : @"下", dic[@"num"]);
                } else {
                    text = deString(@"积分%d", score);
                }
                cell.detailTextLabel.text = text;
                cell.detailTextLabel.textColor = color;
            }
            NSString* righttext = nil;
            UIColor* rightcolor = nil;
            if ([dic[@"resultHandle"] isEqualToString: @"overtime"]) {
                righttext = @"超时";
                rightcolor = [UIColor redColor];
            } else if ([dic[@"resultHandle"] isEqualToString: @"asLast"]) {
                righttext = @"认尾";
                rightcolor = [UIColor greenColor];
            }
            else if ([dic[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                righttext = @"平赔";
                rightcolor = [UIColor colorWithRed: 1 green:0 blue:1 alpha:1];
            }
            else if ([dic[@"resultHandle"] isEqualToString: @"noWin"]) {
                righttext = @"无输赢";
                rightcolor = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
            }
            else if([dic[@"resultHandle"] isEqualToString: @"normal"]) {
                righttext = dic[@"amount"];
                rightcolor = [UIColor whiteColor];
            } else {
                righttext = @"未知";
                rightcolor = [UIColor yellowColor];
            }
            [ycFunction cellAddRightText: cell text: righttext color: rightcolor size: 15 offset:20];
            UIImage* icon = [wxFunction getHead: dic[@"userid"]];
            cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
        }
    }
    return cell;
}
    
-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self)weakSelf = self;

    NSMutableArray* ret = [NSMutableArray array];
    NSString* key = mOpenSections[indexPath.section-1];
    NSArray* datas = [self datasWithKey: key];
    NSMutableDictionary* dic = datas[indexPath.row];
    {
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"超时" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSString* oldHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            [tmanager.mRobot.mResult setResultHandle: dic type: @"overtime"];
//            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf reloadData];
            NSString* newHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            if (![oldHandle isEqualToString: newHandle]) {
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"resultChange",
                                                      @"userid" : dic[@"userid"],
                                                      @"oldResult" : oldHandle,
                                                      @"newResult" : newHandle,
                                                      }];
            }
        }];
        btn1.backgroundColor = [UIColor redColor];
        [ret addObject: btn1];
    }
    {
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"认尾" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSString* oldHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            [tmanager.mRobot.mResult setResultHandle: dic type: @"asLast"];
//            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf reloadData];
            NSString* newHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            if (![oldHandle isEqualToString: newHandle]) {
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"resultChange",
                                                      @"userid" : dic[@"userid"],
                                                      @"oldResult" : oldHandle,
                                                      @"newResult" : newHandle,
                                                      }];
            }

        }];
        btn1.backgroundColor = [UIColor colorWithRed:0 green:.7 blue:0 alpha:1];
        [ret addObject: btn1];
    }
    if ([key isEqualToString: @"banker"]) {
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"平赔" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSString* oldHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            [tmanager.mRobot.mResult setResultHandle: dic type: @"bankerHead"];
//            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf reloadData];
            NSString* newHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            if (![oldHandle isEqualToString: newHandle]) {
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"resultChange",
                                                      @"userid" : dic[@"userid"],
                                                      @"oldResult" : oldHandle,
                                                      @"newResult" : newHandle,
                                                      }];
            }

        }];
        btn1.backgroundColor = [UIColor colorWithRed: 1 green:0 blue:1 alpha:1];
        [ret addObject: btn1];
    } else {
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"无输赢" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSString* oldHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            [tmanager.mRobot.mResult setResultHandle: dic type: @"noWin"];
//            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf reloadData];
            NSString* newHandle = [NSString stringWithString:dic[@"resultHandle"] ? dic[@"resultHandle"] : @"无"];
            if (![oldHandle isEqualToString: newHandle]) {
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"resultChange",
                                                      @"userid" : dic[@"userid"],
                                                      @"oldResult" : oldHandle,
                                                      @"newResult" : newHandle,
                                                      }];
            }

        }];
        btn1.backgroundColor = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
        [ret addObject: btn1];
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section > 0;
}

#pragma mark- niuniuRobotResultDelegate

-(void) resultSaved {
    [tmanager.mRobot savedResult];
    [self.mSuperViewVC updateTableView: 3];
}

-(void) autoQueryHongbaoEnd {
    if ([tmanager.mLastHongbaoDetail[@"totalNum"] intValue] != [tmanager.mLastHongbaoDetail[@"record"] count]) {
        [ycFunction showMsg: @"红包未获取完整" msg:nil vc:self.mSuperViewVC];
        return;
    }
    [tmanager.mRobot.mResult setHongbaoData: tmanager.mLastHongbaoDetail];
    [self reloadAll];
    NSString* errMsg = [tmanager.mRobot.mResult genReport];
    if (errMsg && ![errMsg isEqualToString: @""]) {
        [ycFunction showMsg: errMsg msg:nil vc:self.mSuperViewVC];
    }
    [self reloadData];
}

-(void) stopAutoQueryHongbao {
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

@end
