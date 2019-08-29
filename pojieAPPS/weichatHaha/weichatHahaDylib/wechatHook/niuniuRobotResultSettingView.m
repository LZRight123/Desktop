//
//  niuniuRobotResultSettingView.m
//  wechatHook
//
//  Created by antion on 2017/7/27.
//
//

#import "niuniuRobotResultSettingView.h"
#import "ycButtonView.h"
#import "niuniuSupportDragView.h"
#import "ycFunction.h"
#import "toolManager.h"
#import "ycInputView.h"

static int viewh = 395;
static int infoh = 37;
static int btnh = 46;

@implementation niuniuRobotResultSettingView{
    UIView* mBgView;
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
}

-(id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        mBgView = [[UIView alloc] initWithFrame: self.frame];
        mBgView.backgroundColor = [UIColor clearColor];
        [self addSubview: mBgView];
        [mBgView release];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, infoh)];
        titleLabel.text = @"本局设置";
        titleLabel.textColor = [UIColor yellowColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [mBgView addSubview:titleLabel];
        [titleLabel release];
        
        mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.frame.size.width, viewh-infoh-btnh)];
        mTableView.backgroundColor = [UIColor clearColor];
        mTableView.dataSource = self;
        mTableView.delegate = self;
        [mTableView setSeparatorColor: [UIColor yellowColor]];
        [mBgView addSubview: mTableView];
        [mTableView release];
        
        __weak __typeof(&*self)weakSelf = self;
        ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"返回" func: ^() {
            weakSelf.mBackFunc(false);
        }];
        okBtn.center = CGPointMake(self.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
        [mBgView addSubview: okBtn];
        [okBtn release];
        
        //支持拖动， 单击
        deSupportDrag(self, viewh, infoh, niuniuSupportDragTypeDefault);
        
        mTableViewConfigs = [@{} mutableCopy];
        
        [self loadConfig];
    }
    return self;
}

-(void) loadConfig {
    [mTableViewConfigs removeAllObjects];
    
    //标题, 标题高
    mTableViewConfigs[@"titles"] = @[
                                     @[@"认尾规则", @30],
                                     @[@"其他", @30],
                                     ];
    
    NSMutableArray* row2 = [NSMutableArray array];
    
    NSMutableArray* array = [NSMutableArray array];
    [array addObject: @[@0, @"自定义认尾", @"customAsLastEnable"]];
    if (tmanager.mRobot.mResult.mCustomAsLast[@"enable"] && [tmanager.mRobot.mResult.mCustomAsLast[@"enable"] isEqualToString: @"true"]) {
        [array addObject: @[@0, @"超百注才使用", @"pass100need"]];
        [array addObject: @[@1, @"认尾方式", @"asLastType"]];
        [array addObject: @[@1, @"闲认尾几", @"asLastIndexForPlayer"]];
        [array addObject: @[@1, @"庄认尾几", @"asLastIndexForBanker"]];
        if ([tmanager.mRobot.mResult.mCustomAsLast[@"type"] isEqualToString: @"head"]) {
            [array addObject: @[@1, @"头包点数", @"headNumber"]];
        }
        [array addObject: @[@1, @"尾巴个数", @"lastNumber"]];
        int max = [tmanager.mRobot.mResult.mCustomAsLast[@"max"] intValue];
        for (int i = 0; i < max; ++i) {
            [array addObject: @[@1, deString(@"尾%d点数", i+1), @"setLastAmount", deInt2String(i)]];
        }
    } else {
        for (int i = 0; i < 2; ++i) {
            [array addObject: @[@1, deString(@"尾%d点数", i+1), @"setLastAmount", deInt2String(i)]];
        }
    }

    [row2 addObject: array];
    [row2 addObject: @[
                        @[@0, @"连赢重置", @"serirsWinReset"],
                        @[@0, @"超时无输赢", @"overtime"],
                        @[@0, @"抢包不扣分", @"rob"],
                        @[@1, @"奖池设置", @"bonusPool"],
                        @[@3, @"编码导入", @"import"],
                        ]];
    
    //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
    mTableViewConfigs[@"rows"] = row2;
    
    [mTableView reloadData];
}

-(void) dealloc {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
        mTableViewConfigs = nil;
    }
    self.mBackFunc = nil;
    [super dealloc];
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
    if ([key isEqualToString: @"rob"]) {
        tmanager.mRobot.mResult.mRobNoWin = s.isOn;
    }
    else if ([key isEqualToString: @"overtime"]) {
        tmanager.mRobot.mResult.mOvertimeNoWin = s.isOn;
    }
    else if ([key isEqualToString: @"serirsWinReset"]) {
        tmanager.mRobot.mResult.mResetSeriesWin = s.isOn;
    }
    else if([key isEqualToString: @"customAsLastEnable"]) {
        [tmanager.mRobot.mResult setCustomAsLastEnable: s.isOn];
        [self loadConfig];
    }
    else if([key isEqualToString: @"pass100need"]) {
        [tmanager.mRobot.mResult setPass100Need: s.isOn];
    }
}


//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* arr = mTableViewConfigs[@"rows"][section][row];
    int type = [arr[0] intValue];
    if (type == 0) {//开关
        return;
    }
    
    NSString* key = arr[2];
    if ([key isEqualToString: @"setLastAmount"]) {
        int index = [arr[3] intValue];
        NSString* text = deString(@"请输入尾%d点数, 不用带小数点, 例如: 117", index+1);
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: text preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            [tmanager.mRobot.mResult setLastAmount:[textField.text intValue] index:index];
            [mTableView reloadData];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"headNumber"]) {
        NSString* text = deString(@"请输入头包点数, 不用带小数点, 例如: 117");
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: text preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            [tmanager.mRobot.mResult setCustomHeadAmount:[textField.text intValue]];
            [mTableView reloadData];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"asLastIndexForBanker"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"设置庄认尾几?" message: nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            int index = [textField.text intValue];
            if (index < 1) {
                [ycFunction showMsg: nil msg: @"最少不能小于1!" vc: weakSelf.mSuperViewVC];
                return;
            }
            if (index > [tmanager.mRobot.mResult.mCustomAsLast[@"max"] intValue]) {
                [ycFunction showMsg: nil msg: @"超出尾巴个数!" vc: weakSelf.mSuperViewVC];
                return;
            }
            [tmanager.mRobot.mResult setCustomAsLastBankerIndex: index];
            [mTableView reloadData];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"asLastIndexForPlayer"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"设置闲认尾几?" message: nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            int index = [textField.text intValue];
            if (index < 1) {
                [ycFunction showMsg: nil msg: @"最少不能小于1!" vc: weakSelf.mSuperViewVC];
                return;
            }
            if (index > [tmanager.mRobot.mResult.mCustomAsLast[@"max"] intValue]) {
                [ycFunction showMsg: nil msg: @"超出尾巴个数!" vc: weakSelf.mSuperViewVC];
                return;
            }
            [tmanager.mRobot.mResult setCustomAsLastPlayerIndex: index];
            if (index+1 <= [tmanager.mRobot.mResult.mCustomAsLast[@"max"] intValue]) {
                [tmanager.mRobot.mResult setCustomAsLastBankerIndex: index+1];
            }
            [mTableView reloadData];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"lastNumber"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"设置尾巴个数" message: nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            int num = [textField.text intValue];
            if (num < 2 || num > 20) {
                [ycFunction showMsg: nil msg: @"只能输入2~20!" vc: weakSelf.mSuperViewVC];
                return;
            }
            [tmanager.mRobot.mResult setCustomAsLastMax: num];
            [weakSelf loadConfig];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"asLastType"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"认尾方式" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"手动设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tmanager.mRobot.mResult setCustomAsLastType: @"default"];
            [weakSelf loadConfig];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"头包尾数认尾" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tmanager.mRobot.mResult setCustomAsLastType: @"head"];
            [weakSelf loadConfig];
        }]];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if ([key isEqualToString: @"bonusPool"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: @"请输入奖池金额, 输入-1代表读取上把奖池数据" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if (![ycFunction isInt: textField.text]) {
                [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                return;
            }
            tmanager.mRobot.mResult.mResetBonusPool = [textField.text intValue];
            [mTableView reloadData];
        }]];
        [alertController addTextFieldWithConfigurationHandler:nil];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if([key isEqualToString: @"import"]) {
        __weak __typeof(&*self)weakSelf = self;
        ycInputView* contentView = [[ycInputView alloc] initWithFrame: mBgView.frame title: @"请粘贴红包数据到输入框上" text: @"" useTextView: YES];
        contentView.mFunc = ^(BOOL b, NSString* text) {
            [ycFunction popView: mBgView view: contentView dur: .2 completion:^(BOOL b) {
                [contentView removeFromSuperview];
                [contentView release];
            }];
            
            if (b) {
                NSMutableDictionary* dic = [NSMutableDictionary dictionary];
                NSArray* lines = [text componentsSeparatedByString: @"\n"];
                if ([lines count] > 2) {
                    dic[@"totalAmount"] = lines[0];
                    dic[@"record"] = [NSMutableArray array];
                    for (int i = 1; i < [lines count]; ++i) {
                        NSArray* data = [lines[i] componentsSeparatedByString: @","];
                        if ([data count] >= 3) {
                            [dic[@"record"] addObject: @{
                                                         @"userName":data[0],
                                                         @"receiveAmount":data[1],
                                                         @"receiveTime":data[2],
                                                         }];
                        }
                    }
                }
                if (dic[@"record"] && [dic[@"record"] count] > 0) {
                    [ycFunction showMsg:@"导入成功" msg:nil vc: weakSelf.mSuperViewVC];
                    [tmanager.mRobot.mResult setHongbaoData: dic];
                    weakSelf.mBackFunc(true);
                } else {
                    [ycFunction showMsg:@"无效的红包数据" msg:nil vc: weakSelf.mSuperViewVC];
                    weakSelf.mBackFunc(false);
                }
            }
        };
        [self addSubview: contentView];
        dispatch_async(deMainQueue, ^{
            [ycFunction pushView: mBgView view: contentView dur: .2 completion:nil];
        });
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
    int titleh = [mTableViewConfigs[@"titles"][section][1] intValue];
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text = mTableViewConfigs[@"titles"][section][0];
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}

//组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    NSArray* arr = mTableViewConfigs[@"rows"][section][row];
    int celltype = [arr[0] intValue];
    NSString* title = arr[1];
    UIColor* titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    NSString* key = arr[2];
    
    if (0 == celltype) {
        UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
        switchview.tag = key;
        [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchview;
        
        if ([key isEqualToString: @"rob"]) {
            [switchview setOn:tmanager.mRobot.mResult.mRobNoWin];
        } else if ([key isEqualToString: @"overtime"]) {
            [switchview setOn:tmanager.mRobot.mResult.mOvertimeNoWin];
        } else if ([key isEqualToString: @"serirsWinReset"]) {
            [switchview setOn:tmanager.mRobot.mResult.mResetSeriesWin];
        } else if([key isEqualToString: @"customAsLastEnable"]) {
            [switchview setOn:tmanager.mRobot.mResult.mCustomAsLast[@"enable"] && [tmanager.mRobot.mResult.mCustomAsLast[@"enable"] isEqualToString:@"true"]];
        } else if([key isEqualToString: @"pass100need"]) {
            [switchview setOn:tmanager.mRobot.mResult.mCustomAsLast[@"pass100need"] && [tmanager.mRobot.mResult.mCustomAsLast[@"pass100need"] isEqualToString:@"true"]];
        }
        
    } else if(1 == celltype) {
        NSString* rightText = @"";
        if ([arr[2] isEqualToString: @"setLastAmount"]) {
            int index = [arr[3] intValue];
            if ([tmanager.mRobot.mResult.mLastAmounts count] > index) {
                rightText = deString(@"%.2f", [tmanager.mRobot.mResult.mLastAmounts[index] floatValue]/100);
            } else {
                rightText = @"无";
            }
        }
        else if([arr[2] isEqualToString: @"asLastIndexForBanker"]) {
            rightText = tmanager.mRobot.mResult.mCustomAsLast[@"bankerIndex"];
        }
        else if([arr[2] isEqualToString: @"asLastIndexForPlayer"]) {
            rightText = tmanager.mRobot.mResult.mCustomAsLast[@"playerIndex"];
        }
        else if([arr[2] isEqualToString: @"lastNumber"]) {
            rightText = tmanager.mRobot.mResult.mCustomAsLast[@"max"];
        }
        else if([arr[2] isEqualToString: @"headNumber"]) {
            rightText = deString(@"%.2f", [tmanager.mRobot.mResult.mCustomAsLast[@"headAmount"] floatValue]/100);
        }
        else if([arr[2] isEqualToString: @"asLastType"]) {
            if ([tmanager.mRobot.mResult.mCustomAsLast[@"type"] isEqualToString: @"default"]) {
                rightText = @"手动设置";
            }
            else if ([tmanager.mRobot.mResult.mCustomAsLast[@"type"] isEqualToString: @"head"]) {
                rightText = @"头包尾数认尾";
            }
        }
        else if([arr[2] isEqualToString: @"bonusPool"]) {
            if (tmanager.mRobot.mResult.mResetBonusPool < 0) {
                if ([tmanager.mRobot.mData.mRounds count] > 0) {
                    NSDictionary* lastRound = [tmanager.mRobot.mData.mRounds lastObject];
                    rightText = lastRound[@"otherInfo"][@"bonusPoolTotal"];
                } else {
                    rightText = @"0";
                }
            } else {
                rightText = deInt2String(tmanager.mRobot.mResult.mResetBonusPool);
            }
        }
        UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
        [ycFunction cellAddRightText: cell text: rightText color: rightTextColor size: 16 offset:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if(3 == celltype) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}

@end
