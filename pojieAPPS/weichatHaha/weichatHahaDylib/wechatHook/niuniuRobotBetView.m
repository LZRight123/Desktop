//
//  niuniuRobotBetView.m
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import "niuniuRobotBetView.h"
#import "toolManager.h"
#import "niuniuMembersGroupView.h"
#import "ycInputView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycFunction.h"
#import "wxFunction.h"
#import "niuniuRobotFuliBankerSettingView.h"

@implementation niuniuRobotBetView {
    NSMutableDictionary* mTableViewConfigs;
}

-(id) initWithFrame:(CGRect)frame {
    NSLog(@"######## niuniuRobotBetView initWithFrame ");

    if (self = [super initWithFrame:frame]) {
        mTableViewConfigs = [@{} mutableCopy];
        
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"xib", @39, @"robotBetHead"],
                                         @[@"庄家", @30, @"banker"],
                                         @[@"闲家", @30, @"players"],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@5, @"重新获取", @"refresh", @"清空", @"clear"],
                                           @[@3, @"凭单导入", @"import"],
                                           @[@1, @"福利庄", @"fuli"],
                                           @[@5, @"出单", @"showBill", @"报", @"sendLimit"],
                                           @[@5, @"准备", @"ready", @"@无", @"sendNull"],
                                           ],
                                       ];
        
        //代理
        tmanager.mRobot.mBet.mDelegate = self;
    }
    return self;
}

-(void) dealloc {
    NSLog(@"######## niuniuRobotBetView dealloc ");
    tmanager.mRobot.mBet.mDelegate = nil;
    [mTableViewConfigs release];
    [super dealloc];
}

//扩展按钮回调
-(funcEnd) getBtnFunc: (NSString*)key {
    __weak __typeof(&*self)weakSelf = self;

    funcEnd ret = nil;
    if ([key isEqualToString: @"clear"]) {
        ret = ^{
            [tmanager.mRobot.mBet clearBetData: NO];
            [weakSelf reloadData];
        };
    }
    else if([key isEqualToString: @"sendLimit"]) {
        ret = ^{
            if ([tmanager.mRobot.mBet.mPlayerBets count] > 0) {
                [ycFunction showMsg: @"要先清空" msg: nil vc: weakSelf.mSuperViewVC];
            } else {
                [tmanager.mRobot.mBet sendLimit];
                [tmanager.mRobot.mResult clearHongbaoMsg];
            }
        };
    }
    else if([key isEqualToString: @"sendNull"]) {
        ret = ^{
            [tmanager.mRobot.mBet atInvalid];
        };
    }
    return ret ? [[ret copy] autorelease] : nil;
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
    if ([key isEqualToString: @"isRatio"]) {
        [tmanager.mRobot.mBet setIsRatio: s.isOn];
    }
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
        if([key isEqualToString: @"refresh"]) {//重新获取
            if ([tmanager.mRobot.mBet reloadBetList]) {
                [self reloadData];
            } else {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"提示" message: @"需要在绑定的群里获取" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                [self.mSuperViewVC presentViewController:alert animated:YES completion:nil];
            }
        }
        else if([key isEqualToString: @"showBill"]) {//出押注单
            [tmanager.mRobot.mBet showBill];
            [self reloadData];
        }
        else if([key isEqualToString: @"ready"]) {//准备
            if ([tmanager.mRobot.mBet ready]) {
                [self.mSuperViewVC updateTableView: 1];
                {//连赢提醒
                    if ([tmanager.mRobot.mData.mRounds count] > 0) {
                        NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                        [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                        NSDateFormatter* dayDateformat = [[[NSDateFormatter alloc] init] autorelease];
                        [dayDateformat setDateFormat:@"dd"];
                        NSDictionary* dic = [tmanager.mRobot.mData.mRounds lastObject];
                        NSDate* date1 = [objDateformat dateFromString:dic[@"date"]];
                        NSDate* date2 = [NSDate date];
                        if (![[dayDateformat stringFromDate:date1] isEqualToString: [dayDateformat stringFromDate:date2]]) {
                            [ycFunction showMsg: nil msg: @"检测到当前是凌晨后的第一把，提醒下可能需要设置连赢重置！" vc: self.mSuperViewVC];
                        } else {
                            NSDateFormatter *hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
                            [hourDateformat setDateFormat:@"HH"];
                            int hour1 = [[hourDateformat stringFromDate:date1] intValue];
                            int hour2 = [[hourDateformat stringFromDate:date2] intValue];
                            if (hour2 > hour1+3) {
                                [ycFunction showMsg: nil msg: @"检测到距离上一把已经超过3小时，提醒下可能需要设置连赢重置！" vc: self.mSuperViewVC];
                            }
                        }
                    }
                }
            }
        }
        else if([key isEqualToString: @"import"]) {//导入
            ycInputView* contentView = [[ycInputView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame title: @"请粘贴押注单到输入框上" text: @"" useTextView: YES];
            contentView.mFunc = ^(BOOL b, NSString* text) {
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:^(BOOL b) {
                    [contentView removeFromSuperview];
                    [contentView release];
                }];
                
                if (b) {
                    NSString* msg = [tmanager.mRobot.mBet importPlayers: text];
                    [ycFunction showMsg: msg msg: nil vc: weakSelf.mSuperViewVC];
                    [weakSelf reloadData];
                    [tmanager.mRobot.mRework addReworkRecord: @{
                                                          @"type" : @"betImport",
                                                          @"msg" : msg
                                                          }];
                }
            };
            [self.mSuperViewVC.view addSubview: contentView];
            dispatch_async(deMainQueue, ^{
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:nil];
            });
        }
        else if([key isEqualToString: @"fuli"]) {//福利庄
            niuniuRobotFuliBankerSettingView* settingView = [[niuniuRobotFuliBankerSettingView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame];
            settingView.mSuperViewVC = self.mSuperViewVC;
            settingView.mBackFunc = ^{
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: settingView dur: .2 completion:^(BOOL b) {
                    [settingView removeFromSuperview];
                }];
                [weakSelf reloadData];
            };
            [self.mSuperViewVC.view addSubview: settingView];
            [settingView release];
            dispatch_async(deMainQueue, ^{
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: settingView dur: .2 completion:nil];
            });
        }
    }

    if (section == 1) {//庄
        if (row == 0) {
            niuniuMembersGroupView* friendView = [[niuniuMembersGroupView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame];
            friendView.mSuperViewVC = self.mSuperViewVC;
            friendView.mBackFunc = ^{
                weakSelf.mSuperViewVC.mBgView.hidden = NO;
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: friendView dur: .2 completion:^(BOOL b) {
                    [friendView removeFromSuperview];
                }];
            };
            friendView.mChooseFunc = ^(NSDictionary* dic) {
                if ([tmanager.mRobot.mBet.mBankers count] > 0) {
                    [ycFunction showMsg: @"庄已添加过, 请先删除原来的庄！" msg:nil vc: weakSelf.mSuperViewVC];
                    return;
                }
                [tmanager.mRobot.mBet addBanker:dic[@"userid"] name:dic[@"name"]];
                NSMutableDictionary* banker = [tmanager.mRobot.mBet getBanker:dic[@"userid"]];
                if (banker) {
                    [tmanager.mRobot.mBet setBankerFee: banker num: [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]]];
                }
            };
            friendView.mTitle.text = @"添加庄";
            friendView.mTitle.textColor = [UIColor yellowColor];
            friendView.hidden = YES;
            [self.mSuperViewVC.view addSubview: friendView];
            [friendView release];
            dispatch_async(deMainQueue, ^{
                friendView.hidden = NO;
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: friendView dur: .2 completion:^(BOOL b){
                    if (b) {
                        weakSelf.mSuperViewVC.mBgView.hidden = YES;
                    }
                }];
            });
        } else {
            NSMutableDictionary* dic = tmanager.mRobot.mBet.mBankers[row-1];
            NSString* title = deString(@"设置庄费(%@)", dic[@"name"]);
            ycInputView* contentView = [[ycInputView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame title: title text: dic[@"num"]];
            contentView.mFunc = ^(BOOL b, NSString* text) {
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:^(BOOL b) {
                    [contentView removeFromSuperview];
                    [contentView release];
                }];
                
                if (b && [ycFunction isInt: text]) {
                    [tmanager.mRobot.mBet setBankerFee: dic num: [text intValue]];
                }
            };
            [self.mSuperViewVC.view addSubview: contentView];
            dispatch_async(deMainQueue, ^{
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:nil];
            });
        }
    }
    else if(section == 2) {//闲
        if (row == 0) {
            niuniuMembersGroupView* friendView = [[niuniuMembersGroupView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame];
            friendView.mSuperViewVC = self.mSuperViewVC;
            friendView.mBackFunc = ^{
                weakSelf.mSuperViewVC.mBgView.hidden = NO;
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: friendView dur: .2 completion:^(BOOL b) {
                    [friendView removeFromSuperview];
                }];
            };
            friendView.mChooseFunc = ^(NSDictionary* dic) {
                [tmanager.mRobot.mBet playerBet:dic[@"name"] userid:dic[@"userid"] num:0 values: nil content:@"#手动添加#" from: @"manual"];
            };
            friendView.mTitle.text = @"添加闲";
            friendView.mTitle.textColor = [UIColor yellowColor];
            friendView.hidden = YES;
            [self.mSuperViewVC.view addSubview: friendView];
            [friendView release];
            dispatch_async(deMainQueue, ^{
                friendView.hidden = NO;
                [ycFunction pushView: weakSelf.mSuperViewVC.mBgView view: friendView dur: .2 completion:^(BOOL b){
                    if (b) {
                        weakSelf.mSuperViewVC.mBgView.hidden = YES;
                    }
                }];
            });
        } else {
            NSMutableDictionary* dic = tmanager.mRobot.mBet.mPlayerBets[row-1];
            NSString* title = deString(@"设置押注(%@)", dic[@"name"]);
            ycInputView* contentView = [[ycInputView alloc] initWithFrame: self.mSuperViewVC.mBgView.frame title: title text: @""];
            contentView.mFunc = ^(BOOL b, NSString* text) {
                [ycFunction popView: weakSelf.mSuperViewVC.mBgView view: contentView dur: .2 completion:^(BOOL b) {
                    [contentView removeFromSuperview];
                    [contentView release];
                }];
                
                NSString* oldValuesStr = [NSString stringWithString:dic[@"valuesStr"] ? dic[@"valuesStr"] : @"无"];
                int num;
                NSArray* values = nil;
                if (b && [tmanager.mRobot parseBet:dic[@"userid"] content:text outBetCount:&num outValues:&values]) {
                    [tmanager.mRobot.mBet setBetNum: dic num: num values: values];
                    NSString* newValuesStr = [NSString stringWithString:dic[@"valuesStr"] ? dic[@"valuesStr"] : @"无"];
                    if (![oldValuesStr isEqualToString:newValuesStr]) {
                        [tmanager.mRobot.mRework addReworkRecord: @{
                                                              @"type" : @"betChange",
                                                              @"userid" : dic[@"userid"],
                                                              @"oldBet" : oldValuesStr,
                                                              @"newBet" : newValuesStr
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
}

-(void) updateHeadInfo: (UIView*)view {
    if (!view) {
        view = [self viewWithTag: 100];
    }
    if (!view) {
        return;
    }
    int tuoCount = [tmanager.mRobot.mBet getTuoBetCount];
    NSArray* data = @[
                      @[@101, deString(@"第%d局", tmanager.mRobot.mNumber)],
                      @[@102, deInt2String((int)tmanager.mRobot.mBet.mBetScoreCount)],
                      @[@103, deInt2String((int)tmanager.mRobot.mBet.mBetRecordCount-tuoCount)],
                      @[@104, deInt2String(tuoCount)],
                      ];
    for (NSArray* arr in data) {
        UILabel* label = [view viewWithTag: [arr[0] intValue]];
        if (label) {
            label.text = arr[1];
        }
    }
}

#pragma mark- UITableViewDataSource

//组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [mTableViewConfigs[@"titles"] count];
}

//标题高
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section {
    return [mTableViewConfigs[@"titles"][section][1] intValue];
}

//标题视图
- (UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    NSString* text = mTableViewConfigs[@"titles"][section][0];
    if ([text isEqualToString: @"xib"]) {
        NSString* key = mTableViewConfigs[@"titles"][section][2];
        if ([key isEqualToString: @"robotBetHead"]) {
            NSArray* nib = [[NSBundle mainBundle]loadNibNamed:@"robotBetHead" owner:nil options:nil];
            UIView* view = [nib lastObject];
            view.tag = 100;
            [self updateHeadInfo: view];
            return view;
        }
        return nil;
    }
    
    int titleh = [mTableViewConfigs[@"titles"][section][1] intValue];
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text = text;
    [myView addSubview:titleLabel];
    [titleLabel release];
    
    NSString* other = nil;
    if ([mTableViewConfigs[@"titles"][section] count] > 2) {
        other = mTableViewConfigs[@"titles"][section][2];
    }
    if (other) {
        NSString* text = @"";
        if ([other isEqualToString: @"players"]) {
            text = deString(@"%d个下注", (int)[tmanager.mRobot.mBet.mPlayerBets count]);
        } else if([other isEqualToString: @"banker"]) {
            text = deString(@"庄费%d", [tmanager.mRobot.mBet getAllBankerFee]);
        }
        UILabel* rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-10, 22)];
        rightLabel.center = CGPointMake(tableView.frame.size.width/2-5, titleh/2);
        rightLabel.textColor=[UIColor whiteColor];
        rightLabel.text = text;
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.font = [UIFont systemFontOfSize: 14];
        [myView addSubview:rightLabel];
        [rightLabel release];
    }
    return myView;
}

//组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [tmanager.mRobot.mBet.mBankers count]+1;
    }
    else if(section == 2) {
        return [tmanager.mRobot.mBet.mPlayerBets count]+1;
    }
    return [mTableViewConfigs[@"rows"][section] count];
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
        NSString* subtitle = nil;
        
        if (0 == celltype) {
            UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
            switchview.tag = key;
            [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchview;
        } else if(1 == celltype) {
            NSString* rightText = @"";
            if ([key isEqualToString: @"fuli"]) {
                if (tmanager.mRobot.mBet.mFuliSetting[@"enable"] && [tmanager.mRobot.mBet.mFuliSetting[@"enable"] isEqualToString: @"true"]) {
                    rightText = @"开";
                } else {
                    rightText = @"关";
                }
            }
            UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
            [ycFunction cellAddRightText: cell text: rightText color: rightTextColor size: 18 offset:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(2 == celltype) {
        } else if(3 == celltype) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(4 == celltype) {
            
        } else if(5 == celltype) {
            ycButtonView* btn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 64, 32) text:arr[3] func: [self getBtnFunc: arr[4]]];
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
    }
    else if (section == 1) {
        if (row > 0) {
            NSDictionary* dic = tmanager.mRobot.mBet.mBankers[row-1];
            UIColor* color = [UIColor whiteColor];
            if ([dic[@"num"] intValue] <= 0) {
                color = [UIColor yellowColor];
            }
            else if([dic[@"isMain"] isEqualToString: @"false"]) {//副庄蓝色
                color = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
            }
            cell.textLabel.text = dic[@"remarkName"] ? dic[@"remarkName"] : dic[@"name"];
            cell.textLabel.textColor = color;
            cell.detailTextLabel.text = deString(@"积分: %d", [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]]);
            cell.detailTextLabel.textColor = color;
            [ycFunction cellAddRightText: cell text: dic[@"num"] color: color size: 15 offset:20];
            UIImage* icon = [wxFunction getHead: dic[@"userid"]];
            cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
        } else {
            cell.textLabel.text = @"添加";
            cell.textLabel.textColor = [UIColor greenColor];
            
            [ycFunction cellAddRightText: cell text: @"抽水" color: [UIColor whiteColor] size: 16 offset:-43];
            
            UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
            switchview.tag = @"isRatio";
            [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            [switchview setOn: tmanager.mRobot.mBet.mIsRatio];
            cell.accessoryView = switchview;
        }
        return cell;
    }
    else if(section == 2) {
        if (row > 0) {
            NSDictionary* dic = tmanager.mRobot.mBet.mPlayerBets[row-1];
            UIColor* color = [UIColor whiteColor];
            if (![dic[@"valid"] isEqualToString: @"true"]) {//无效
                color = [UIColor redColor];
            }
            else if(![dic[@"hasScore"] isEqualToString: @"true"]) {//玩家剩余分小于最低押注
                color = [UIColor colorWithRed:1 green:0 blue:1 alpha:1];
            }
            else if(![dic[@"numValid"] isEqualToString: @"true"]) {//玩家押注小于最低押注
                color = [UIColor yellowColor];
            }
            else if([dic[@"repeat"] isEqualToString: @"true"]) {//重复下注
                color = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
            }
            cell.textLabel.text = dic[@"remarkName"] ? dic[@"remarkName"] : dic[@"name"];
            cell.textLabel.textColor = color;
            cell.detailTextLabel.text = dic[@"valuesStr"];
            cell.detailTextLabel.textColor = color;
            int score = [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]];
            [ycFunction cellAddRightText: cell text: deInt2String(score) color: [UIColor greenColor] size: 15 offset:20];
            UIImage* icon = [wxFunction getHead: dic[@"userid"]];
            cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
        } else {
            cell.textLabel.text = @"添加";
            cell.textLabel.textColor = [UIColor greenColor];
        }
        
        return cell;
    }
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {//庄家
        __weak __typeof(&*self)weakSelf = self;
        NSMutableDictionary* dic = tmanager.mRobot.mBet.mBankers[indexPath.row-1];
        UITableViewRowActionStyle style = UITableViewRowActionStyleNormal;
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: style title:@"设主" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tmanager.mRobot.mBet setMainBanker: dic];
        }];
        UITableViewRowAction *btn2 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tmanager.mRobot.mBet removeBankerWithIndex: (int)indexPath.row-1];
        }];
        return @[btn1, btn2];
    } else if(indexPath.section == 2) {//闲家
        NSMutableDictionary* dic = tmanager.mRobot.mBet.mPlayerBets[indexPath.row-1];
        BOOL valid = [dic[@"valid"] isEqualToString: @"true"];
        UITableViewRowActionStyle style = UITableViewRowActionStyleNormal;
        NSString* text = @"无效";
        if (!valid) {
            text = @"有效";
        }
        __weak __typeof(&*self)weakSelf = self;
        UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: style title:text handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tmanager.mRobot.mBet setBetValid:(int)indexPath.row-1 valid: !valid];
        }];
        UITableViewRowAction *btn2 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [weakSelf reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tmanager.mRobot.mBet removeBetWithIndex: (int)indexPath.row-1];
        }];
        return @[btn1, btn2];
    }
    return nil;
}
             
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {//庄家
        return indexPath.row > 0;
    }
    else if (indexPath.section == 2) {//庄家
        return indexPath.row > 0;
    }
    return NO;
}
         
#pragma mark- niuniuRobotDelegate
         
-(void) hasPlayerBet {
    [self reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateHeadInfo: nil];
}

-(void) hasBetRemoved {
    [self reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateHeadInfo: nil];
}

-(void) betHasChanged:(NSString*)userid {
    [self updateHeadInfo: nil];
    NSArray* indexs = [tmanager.mRobot.mBet betIndexs: userid];
    NSMutableArray* array = [NSMutableArray array];
    for (NSString* i in indexs) {
        [array addObject: [NSIndexPath indexPathForRow:[i intValue]+1 inSection:2]];
    }
    [self reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void) bankerInfoChanged {
    [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void) headInfoChanged {
    [self updateHeadInfo: nil];
}


@end
