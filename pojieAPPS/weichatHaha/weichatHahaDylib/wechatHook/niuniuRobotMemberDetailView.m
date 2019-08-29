//
//  niuniuRobotMemberDetailView.m
//  wechatHook
//
//  Created by antion on 2017/3/10.
//
//

#import "niuniuRobotMemberDetailView.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycButtonView.h"
#import "niuniuSupportDragView.h"

static int viewh = 395;
static int infoh = 37;
static int btnh = 46;

@implementation niuniuRobotMemberDetailView{
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSDictionary* mMemberData;
    NSDictionary* mUserData;
}

-(id) initWithFrame:(CGRect)frame userid: (NSString*)userid hasBtn:(BOOL)hasBtn {
    if (self = [super initWithFrame: frame]) {
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, infoh)];
        titleLabel.text = @"玩家详情";
        titleLabel.textColor = [UIColor yellowColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel release];
        
        mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.frame.size.width, viewh-infoh-(hasBtn? btnh : 0))];
        mTableView.backgroundColor = [UIColor clearColor];
        mTableView.dataSource = self;
        mTableView.delegate = self;
        [mTableView setSeparatorColor: [UIColor yellowColor]];
        [self addSubview: mTableView];
        [mTableView release];
        
        if (hasBtn) {
            __weak __typeof(&*self)weakSelf = self;
            ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"返回" func: ^() {
                weakSelf.mBackFunc();
            }];
            okBtn.center = CGPointMake(self.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
            [self addSubview: okBtn];
            [okBtn release];
        }
        
        //支持拖动， 单击
        deSupportDrag(self, viewh, infoh, niuniuSupportDragTypeDefault);
        
        [self loadWithUserid: userid];
    }
    return self;
}

-(void) dealloc {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
        mTableViewConfigs = nil;
    }
    if (mMemberData) {
        [mMemberData release];
        mMemberData = nil;
    }
    if (mUserData) {
        [mUserData release];
        mUserData = nil;
    }
    self.mBackFunc = nil;
    self.mAlertFrameText = nil;
    [super dealloc];
}

-(void) loadWithUserid: (NSString*)userid {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
        mTableViewConfigs = nil;
    }
    if (mMemberData) {
        [mMemberData release];
        mMemberData = nil;
    }
    if (mUserData) {
        [mUserData release];
        mUserData = nil;
    }
    
    mTableViewConfigs = [@{} mutableCopy];
    mMemberData = [tmanager.mRobot.mMembers getMember: userid];
    if (!mMemberData) {
        mMemberData = [tmanager.mRobot.mMembers getMemberWithEncodeUserid: userid];
    }
    if (!mMemberData) {
        id CBaseContact = [wxFunction getContact: userid];
        if (!CBaseContact) {
            //标题, 标题高
            mTableViewConfigs[@"titles"] = @[
                                             @[@"提示", @30],
                                             ];
            //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
            mTableViewConfigs[@"rows"] = @[
                                           @[
                                               @[@4, @"获取用户信息失败"],
                                               ],
                                           ];
        } else {
            //标题, 标题高
            mTableViewConfigs[@"titles"] = @[
                                             @[@"基本", @30],
                                             ];
            //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
            mTableViewConfigs[@"rows"] = @[
                                           @[
                                               @[@7, @"头像、名字、微信号", @"baseinfo"],
                                               @[@3, @"添加会员", @"addMember"],
                                               
                                               ],
                                           ];
            NSString* m_nsUsrName = [ycFunction getVar:CBaseContact name: @"m_nsUsrName"];
            NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
            mUserData = [@{
                           @"userid" : m_nsUsrName,
                           @"name" : m_nsNickName
                           } retain];
            
        }
    } else {
        [mMemberData retain];
        
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"身份", @30],
                                         @[@"查询", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮, 6:文字+下文字 7: 自定义), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@7, @"头像、名字、微信号", @"baseinfo"],
                                           @[@7, @"备注名字", @"remarkName"],
                                           @[@7, @"分数", @"score"],
                                           @[@3, @"上分", @"upScore"],
                                           @[@3, @"下分", @"downScore"],
                                           @[@4, @"分数清零", @"allDownScore"],
                                           ],
                                       
                                       @[
                                           @[@0, @"管理员", @"isAdmin"],
                                           @[@0, @"托", @"isTuo"],
                                           @[@0, @"拉手", @"isLashou"],
                                           @[@0, @"拉手团长", @"isLashouHead"],
                                           @[@1, @"归属拉手", @"lashouMember"],
                                       ],
                                       
                                       @[
                                           @[@3, @"查统计", @"chatongji"],
                                           @[@3, @"查领包", @"chalingbao"],
                                           @[@3, @"查上下分", @"chashangxiafen"],
                                           @[@3, @"查明细", @"chamingxi"],
                                           ],
                                       ];
    }
    [mTableView reloadData];
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
    if ([key isEqualToString: @"isLashou"]) {
        if (s.isOn) {
            [tmanager.mRobot.mLashous addLashou: mMemberData[@"userid"]];
        } else {
            [s setOn: YES];
            __weak __typeof(&*self)weakSelf = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定删除拉手身份?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [s setOn: NO];
                [tmanager.mRobot.mLashous delLashou: mMemberData[@"userid"]];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
    }
    if ([key isEqualToString: @"isLashouHead"]) {
        if (s.isOn) {
            [tmanager.mRobot.mLashouHeads addLashouHead: mMemberData[@"userid"]];
        } else {
            [s setOn: YES];
            __weak __typeof(&*self)weakSelf = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定删除拉手团长身份?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [s setOn: NO];
                [tmanager.mRobot.mLashouHeads delLashouHead: mMemberData[@"userid"]];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if ([key isEqualToString: @"isAdmin"]) {
        if (s.isOn) {
            [tmanager.mRobot.mAdmins addAdmin: mMemberData[@"userid"]];
        } else {
            [tmanager.mRobot.mAdmins delAdmin: mMemberData[@"userid"]];
        }
    }
    else if ([key isEqualToString: @"isTuo"]) {
        if (s.isOn) {
            NSString* errMsg = [tmanager.mRobot.mTuos addTuo: mMemberData[@"userid"]];
            if (errMsg) {
                [ycFunction showMsg: errMsg msg:nil vc:nil];
                [mTableView reloadData];
            }
        } else {
            [s setOn: YES animated: NO];
            __weak __typeof(&*self)weakSelf = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定删除托身份?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [s setOn: NO animated: NO];
                [tmanager.mRobot.mTuos delTuo: mMemberData[@"userid"]];
                
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"tuoDelete",
                                                      @"userid" : mMemberData[@"userid"],
                                                      }];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
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
    
    if ([arr count] <= 2) {
        return;
    }
    
    NSString* key = arr[2];
    if ([key isEqualToString: @"score"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置分数" message: @"输入用户的最终分数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* num = alertController.textFields.firstObject;
            if (![ycFunction isInt: num.text]) {
                [ycFunction showMsg: @"必须是纯数字" msg:nil vc:self.mSuperViewVC];
                return;
            }
            int oldScore = [mMemberData[@"score"] intValue];
            if ([tmanager.mRobot.mMembers addScore: mMemberData[@"userid"] score: [num.text intValue] isSet: YES params: @{
                                                                                                                     @"type":@"manual"
                                                                                                                     }]) {
                NSString* msg = [tmanager.mRobot.mCommand newScoreChangedMsg: oldScore memData: mMemberData from: @"机器人" chatroom: nil];
                [ycFunction showMsg:nil msg:msg vc: self.mSuperViewVC];
                [tmanager.mRobot.mData saveMemberListFile];
                int newScore = [mMemberData[@"score"] intValue];
                [mTableView reloadData];
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"scoreChange",
                                                      @"userid" : mMemberData[@"userid"],
                                                      @"newScore" : deInt2String(newScore),
                                                      @"oldScore" : deInt2String(oldScore),
                                                      }];
            } else {
                [ycFunction showMsg: @"设置分数失败" msg:nil vc:self.mSuperViewVC];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"数字";
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    } else if ([key isEqualToString: @"upScore"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上分" message: @"输入要加的分数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* num = alertController.textFields.firstObject;
            if (![ycFunction isInt: num.text]) {
                [ycFunction showMsg: @"必须是纯数字" msg:nil vc:self.mSuperViewVC];
                return;
            }
            int oldScore = [mMemberData[@"score"] intValue];
            if ([tmanager.mRobot.mMembers addScore: mMemberData[@"userid"] score: [num.text intValue] isSet: NO params: @{
                                                                                                                    @"type":@"manual"
                                                                                                                    }]) {
                NSString* msg = [tmanager.mRobot.mCommand newScoreChangedMsg: oldScore memData: mMemberData from: @"机器人" chatroom: nil];
                [ycFunction showMsg:nil msg:msg vc: self.mSuperViewVC];
                [tmanager.mRobot.mData saveMemberListFile];
                int newScore = [mMemberData[@"score"] intValue];
                [mTableView reloadData];
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"scoreChange",
                                                      @"userid" : mMemberData[@"userid"],
                                                      @"newScore" : deInt2String(newScore),
                                                      @"oldScore" : deInt2String(oldScore),
                                                      }];
            } else {
                [ycFunction showMsg: @"上分失败" msg:nil vc:self.mSuperViewVC];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"数字";
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    } else if ([key isEqualToString: @"downScore"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下分" message: @"输入要下的分数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* num = alertController.textFields.firstObject;
            if (![ycFunction isInt: num.text]) {
                [ycFunction showMsg: @"必须是纯数字" msg:nil vc:self.mSuperViewVC];
                return;
            }
            int oldScore = [mMemberData[@"score"] intValue];
            if ([tmanager.mRobot.mMembers addScore: mMemberData[@"userid"] score: -[num.text intValue] isSet: NO params: @{
                                                                                                                     @"type":@"manual"
                                                                                                                     }]) {
                NSString* msg = [tmanager.mRobot.mCommand newScoreChangedMsg: oldScore memData: mMemberData from: @"机器人" chatroom: nil];
                [ycFunction showMsg:nil msg:msg vc: self.mSuperViewVC];
                [tmanager.mRobot.mData saveMemberListFile];
                int newScore = [mMemberData[@"score"] intValue];
                [mTableView reloadData];
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"scoreChange",
                                                      @"userid" : mMemberData[@"userid"],
                                                      @"newScore" : deInt2String(newScore),
                                                      @"oldScore" : deInt2String(oldScore),
                                                      }];
            } else {
                [ycFunction showMsg: @"下分失败" msg:nil vc:self.mSuperViewVC];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"数字";
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    } else if ([key isEqualToString: @"allDownScore"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确定将分数清零" message: nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            int oldScore = [mMemberData[@"score"] intValue];
            if ([tmanager.mRobot.mMembers addScore: mMemberData[@"userid"] score: 0 isSet: YES params: @{
                                                                                                   @"type":@"manual"
                                                                                                   }]) {
                NSString* msg = [tmanager.mRobot.mCommand newScoreChangedMsg: oldScore memData: mMemberData from: @"机器人" chatroom: nil];
                [ycFunction showMsg:nil msg:msg vc: self.mSuperViewVC];
                [tmanager.mRobot.mData saveMemberListFile];
                int newScore = [mMemberData[@"score"] intValue];
                [mTableView reloadData];
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"scoreChange",
                                                      @"userid" : mMemberData[@"userid"],
                                                      @"newScore" : deInt2String(newScore),
                                                      @"oldScore" : deInt2String(oldScore),
                                                      }];
            } else {
                [ycFunction showMsg: @"分数清零失败" msg:nil vc:self.mSuperViewVC];
            }
        }]];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    } else if([key isEqualToString: @"addMember"]) {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加会员" message:@"名字4个字以内，自动过滤特殊字符、表情" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* name = alertController.textFields.firstObject;
            NSString* errMsg = nil;
            if ([name.text isEqualToString: @""]) {
                errMsg = @"名字不能为空";
            } else {
                errMsg = [tmanager.mRobot.mMembers addMember:mUserData[@"userid"] billName:[niuniuRobotMembers formatName: name.text]];
            }
            if (errMsg) {
                [ycFunction showMsg: nil msg:errMsg vc:self.mSuperViewVC];
            } else {
                [tmanager.mRobot.mData saveMemberListFile];
                [weakSelf loadWithUserid:mUserData[@"userid"]];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"名字";
            textField.text = [niuniuRobotMembers formatName: mUserData[@"name"]];
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];

    } else if([key isEqualToString: @"remarkName"]) {//修改名字
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改名字" message:@"名字4个字以内，自动过滤特殊字符、表情" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* name = alertController.textFields.firstObject;
            NSString* errMsg = nil;
            if ([name.text isEqualToString: @""]) {
                errMsg = @"名字不能为空";
            } else {
                errMsg = [tmanager.mRobot.mMembers renameMemberBillName:mMemberData[@"userid"] billName:[niuniuRobotMembers formatName: name.text]];
            }
            if (errMsg) {
                [[[[UIAlertView alloc] initWithTitle: nil message: errMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
            } else {
                [tmanager.mRobot.mData saveMemberListFile];
                [mTableView reloadData];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"名字";
            textField.text = [niuniuRobotMembers formatName: mMemberData[@"name"]];
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    } else if([key isEqualToString: @"chatongji"]) {
        self.mAlertFrameText = [tmanager.mRobot.mCommand newPlayerResultInfo:mMemberData queryDate:tmanager.mRobot.mQueryDate];
        UIAlertView* view = [[[UIAlertView alloc] initWithTitle: nil message: self.mAlertFrameText delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"发送", nil] autorelease];
        [view show];
    } else if([key isEqualToString: @"chalingbao"]) {
        self.mAlertFrameText = [tmanager.mRobot.mCommand newPlayerBetInfo:mMemberData queryDate:tmanager.mRobot.mQueryDate];
        UIAlertView* view = [[[UIAlertView alloc] initWithTitle: nil message: self.mAlertFrameText delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"发送", nil] autorelease];
        [view show];
    } else if([key isEqualToString: @"chashangxiafen"]) {
        self.mAlertFrameText = [tmanager.mRobot.mCommand newUpScoreRecords:mMemberData queryDate:tmanager.mRobot.mQueryDate];
        UIAlertView* view = [[[UIAlertView alloc] initWithTitle: nil message: self.mAlertFrameText delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"发送", nil] autorelease];
        [view show];
    } else if([key isEqualToString: @"chamingxi"]) {
        UIViewController* controller =[ycFunction getCurrentVisableVC];
        if (!controller) {
            return;
        }
        
        NSString* className = NSStringFromClass([controller class]);
        NSString* target = nil;
        if([className isEqualToString: @"BaseMsgContentViewController"]) {
            id concact = [controller performSelector: @selector(GetContact) withObject:nil];
            target = [ycFunction getVar:concact name: @"m_nsUsrName"];
        }
        if (!target) {
            [ycFunction showMsg: @"界面不在群" msg: nil vc: nil];
            return;
        }
        UIImage* img = [tmanager.mRobot.mCommand queryPlayerAllDetail: mMemberData];
        [tmanager.mRobot.mSendMsg sendPic:target img:img];
    }
}

//消息框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        UIViewController* controller =[ycFunction getCurrentVisableVC];
        if (!controller) {
            return;
        }
        
        NSString* className = NSStringFromClass([controller class]);
        NSString* target = nil;
        if([className isEqualToString: @"BaseMsgContentViewController"]) {
            id concact = [controller performSelector: @selector(GetContact) withObject:nil];
            target = [ycFunction getVar:concact name: @"m_nsUsrName"];
        }
        if (!target) {
            [ycFunction showMsg: @"界面不在群" msg: nil vc: nil];
            return;
        }
        [tmanager.mRobot.mSendMsg sendText: target content:self.mAlertFrameText at:nil title:@""];
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
    if (7 == celltype) {
        NSString* key = @"";
        if ([arr count] > 2) {
            key = arr[2];
        }
        if ([key isEqualToString: @"baseinfo"]) {
            NSDictionary* dic = mMemberData ? mMemberData : mUserData;
            cell.textLabel.text = dic[@"name"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.text = dic[@"userid"];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            UIImage* icon = [wxFunction getHead: dic[@"userid"]];
            cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
        }
        else if ([key isEqualToString: @"remarkName"]) {
            id CBaseContact = [wxFunction getContact: mMemberData[@"userid"]];
            NSString* m_nsRemark = [CBaseContact performSelector: @selector(getRemark) withObject: nil];
            if (!m_nsRemark) {
                m_nsRemark = [niuniuRobotMembers newRemark: mMemberData];
            }
            cell.textLabel.text = m_nsRemark;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.text = @"备注名字";
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (tmanager.mRobot.mStatus == eNiuniuRobotStatusBet) {
                __weak __typeof(&*self)weakSelf = self;
                [ycFunction cellAddRightBtn:cell tableView:tableView text:@"上庄" func: ^{
                    if ([tmanager.mRobot.mBet.mBankers count] > 0) {
                        [ycFunction showMsg: @"庄已添加过, 请先删除原来的庄！" msg:nil vc: weakSelf.mSuperViewVC];
                        return;
                    }
                    [ycFunction showMsg: @"上庄成功!" msg:nil vc:weakSelf.mSuperViewVC];
                    [tmanager.mRobot.mBet addBanker:mMemberData[@"userid"] name:mMemberData[@"name"]];
                    int score = [tmanager.mRobot.mMembers getMemberScore: mMemberData[@"userid"]];
                    if (score > 0) {
                        [tmanager.mRobot.mBet setBankerFee:[tmanager.mRobot.mBet getBanker: mMemberData[@"userid"]] num:score];
                    }
                }];
            }
        }
        else if ([key isEqualToString: @"score"]) {
            cell.textLabel.text = @"分数";
            cell.textLabel.textColor = [UIColor whiteColor];
            [ycFunction cellAddRightText: cell text: mMemberData[@"score"] color:[UIColor whiteColor] size:18 offset:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (0 == celltype) {
        NSString* key = @"";
        if ([arr count] > 2) {
            key = arr[2];
        }
        UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
        switchview.tag = key;
        [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchview;
        
        if ([key isEqualToString: @"isAdmin"]) {
            [switchview setOn:[tmanager.mRobot.mAdmins isAdmin: mMemberData[@"userid"]]];
        }
        else if ([key isEqualToString: @"isTuo"]) {
            [switchview setOn:[tmanager.mRobot.mTuos isTuo: mMemberData[@"userid"]]];
        }
        else if ([key isEqualToString: @"isLashou"]) {
            [switchview setOn:[tmanager.mRobot.mLashous isLashou: mMemberData[@"userid"]]];
        }
        else if ([key isEqualToString: @"isLashouHead"]) {
            [switchview setOn:[tmanager.mRobot.mLashouHeads isLashouHead: mMemberData[@"userid"]]];
        }
        
        NSString* title = arr[1];
        UIColor* titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
        cell.textLabel.text = title;
        cell.textLabel.textColor = titleColor;
    }  else {
        NSString* key = @"";
        if ([arr count] > 2) {
            key = arr[2];
        }
        NSString* title = arr[1];
        UIColor* titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
        if (3 == celltype) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(1 == celltype) {
            NSString* rightText = @"";
            if ([key isEqualToString: @"lashouMember"]) {
                NSDictionary* dic = [tmanager.mRobot.mLashous getLashouWithPlayer: mMemberData[@"userid"]];
                if (dic) {
                    rightText = dic[@"billName"] ? dic[@"billName"] : dic[@"userid"];
                } else {
                    rightText = @"无";
                }
            }
            UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
            [ycFunction cellAddRightText: cell text: rightText color: rightTextColor size: 12 offset:20];
        }
        if([key isEqualToString: @"addMember"]) {
            titleColor = [UIColor greenColor];
        }
        cell.textLabel.text = title;
        cell.textLabel.textColor = titleColor;
    }
    return cell;
}

@end
