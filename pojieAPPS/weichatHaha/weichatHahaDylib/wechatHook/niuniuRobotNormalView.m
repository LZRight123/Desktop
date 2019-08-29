//
//  niuniuRobotNormalView.m
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import "niuniuRobotNormalView.h"
#import "toolManager.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "JSON.h"

@implementation niuniuRobotNormalView {
    NSMutableDictionary* mTableViewConfigs;
}

-(id) initWithFrame:(CGRect)frame {
    NSLog(@"######## niuniuRobotNormalView initWithFrame ");

    if (self = [super initWithFrame:frame]) {
        mTableViewConfigs = [@{} mutableCopy];

        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[deString(@"第%d局", tmanager.mRobot.mNumber), @30],
                                         ];
        
        if (tmanager.mRobot.mEnableNiuniu) {
            //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
            mTableViewConfigs[@"rows"] = @[
                                           @[
                                               @[@3, @"新庄", @"nextRound"],
                                               @[@3, @"庄续", @"nextRound2"],
                                               @[@3, @"庄铺", @"nextRound3"],
                                               @[@3, @"修改上局", @"reworkLast"],
                                               @[@3, @"积分榜", @"showTop"],
                                               @[@4, @"解除绑定", @"gameover"],
//                                               @[@4, @"测试", @"test"],
                                               ],
                                           ];
        } else {
            //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
            mTableViewConfigs[@"rows"] = @[
                                           @[
                                               @[@3, @"下一局", @"nextRound"],
                                               @[@3, @"庄续", @"nextRound2"],
                                               @[@3, @"修改上局", @"reworkLast"],
                                               @[@3, @"积分榜", @"showTop"],
                                               @[@4, @"解除绑定", @"gameover"],
                                               ],
                                           ];
        }
    }
    return self;
}

-(void) dealloc {
    NSLog(@"######## niuniuRobotNormalView dealloc ");

    [mTableViewConfigs release];
    [super dealloc];
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
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
    if([key isEqualToString: @"nextRound"]) {//下一局
        [tmanager.mRobot.mBet startBet: @"new" value: nil];
        [self.mSuperViewVC updateTableView: 1];
    }
    else if([key isEqualToString: @"nextRound2"]) {//续
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入庄费" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* bankerFee = alertController.textFields.firstObject;
            if (![ycFunction isInt:bankerFee.text]) {
                [[[[UIAlertView alloc] initWithTitle: nil message: @"格式错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
            } else {
                [tmanager.mRobot.mBet startBet: @"again" value: bankerFee.text];
                [self.mSuperViewVC updateTableView: 1];
            }
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"庄费";
        }];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if([key isEqualToString: @"nextRound3"]) {//铺
        [tmanager.mRobot.mBet startBet: @"full" value: nil];
        [self.mSuperViewVC updateTableView: 1];
    }
    else if ([key isEqualToString: @"gameover"]) {//退出游戏
        [tmanager.mRobot unbindGameRoom];
        self.mSuperViewVC.mBackFunc();
    }
    else if([key isEqualToString: @"reworkLast"]) {//查看上局
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改上局将会把已结算的分数撤销, 是否继续?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([tmanager.mRobot frontRound]) {
                [self.mSuperViewVC updateTableView: 4];
            } else {
                [[[[UIAlertView alloc] initWithTitle: nil message: @"没有上局数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
            }
        }]];
        [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
    }
    else if([key isEqualToString: @"showTop"]) {
        [tmanager.mRobot.mMembers showTop];
    }
    else if([key isEqualToString: @"test"]) {
//        if ([tmanager.mLastHongbaoDetail[@"totalNum"] intValue] != [tmanager.mLastHongbaoDetail[@"record"] count]) {
//            [[[[UIAlertView alloc] initWithTitle: nil message: @"红包未获取完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
//            return;
//        }
//        NSMutableString* str = [NSMutableString string];
//        [str appendFormat: @"%@\n", tmanager.mLastHongbaoDetail[@"totalAmount"]];
//        for (NSDictionary* one in tmanager.mLastHongbaoDetail[@"record"]) {
//            [str appendFormat: @"%@,%@,%@\n", one[@"userName"], one[@"receiveAmount"], one[@"receiveTime"]];
//        }
//        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = str;
//        NSDictionary *tempDictQueryDiamond = [pasteboard.string  JSONValue];
//        NSLog(@"temp: %@", tempDictQueryDiamond);

//        id CContactMgr = [wxFunction getMgr: @"CContactMgr"];
//        NSArray* allUserid = [CContactMgr performSelector:@selector(getAllContactUserName) withObject: nil];
//        for (NSString* userid in allUserid) {
//            id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
//            if (CBaseContact) {//能获取到信息
//                if (![wxFunction isFriend: CBaseContact]) {
//                    NSLog(@"%@", CBaseContact);
//                }
//            }
//        }
//        
//        id CMessageMgr = [wxFunction getMgr: @"CMessageMgr"];
//        id GetHelloMsg = [CMessageMgr GetHelloUsers: @"fmessage" Limit: 0 OnlyUnread: 0];
//        NSLog(@"CMessageMgr -> GetHelloMsg: %@", GetHelloMsg);
//        
//        NSString* userid = GetHelloMsg[0];
//        id array = [CMessageMgr GetHelloMsg: @"fmessage"  HelloUser: userid Limit: 0 OnlyTo: 0];
//        id msg = array[0];
//        NSString* fromUsr = [ycFunction getVar:msg name: @"m_nsFromUsr"];
//        int m_uiMessageType = [ycFunction getVarInt: msg name: @"m_uiMessageType"];
//        NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
//        NSString* m_nsRealChatUsr = [ycFunction getVar: msg name: @"m_nsRealChatUsr"];
//        id CBaseContact = [wxFunction getContact: m_nsRealChatUsr];
//        NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
//        NSString* m_nsInviteTickets = [ycFunction getVar:CBaseContact name: @"m_nsInviteTickets"];
//        NSLog(@"%@, %d, %@, %@, %@, %@, %@", fromUsr, m_uiMessageType, m_nsContent, m_nsRealChatUsr, CBaseContact, m_nsNickName, m_nsInviteTickets);
//        
//        NSRange range;
//        NSString* fromusername; {
//            range = [m_nsContent rangeOfString: @"fromusername=\""];
//            fromusername = [m_nsContent substringFromIndex: range.location+range.length];
//            range = [fromusername rangeOfString: @"\""];
//            fromusername = [fromusername substringToIndex: range.location];
//        }
//        
//        NSString* ticket; {
//            range = [m_nsContent rangeOfString: @"ticket=\""];
//            ticket = [m_nsContent substringFromIndex: range.location+range.length];
//            range = [ticket rangeOfString: @"\""];
//            ticket = [ticket substringToIndex: range.location];
//        }
//
//  
//        id SayHelloViewController = [[NSClassFromString(@"SayHelloViewController") alloc] init];
//        id SayHelloDataLogic = [[NSClassFromString(@"SayHelloDataLogic") alloc] initWithScene: 0 delegate: SayHelloViewController];
//        NSLog(@"SayHelloDataLogic: %@", SayHelloDataLogic);
//        [SayHelloDataLogic loadData: 3];
//
//        
//        id CVerifyContactWrap = [[NSClassFromString(@"CVerifyContactWrap") alloc] init];
//        [ycFunction setVar:CVerifyContactWrap name: @"m_nsUsrName" value: userid];
//        [ycFunction setVar:CVerifyContactWrap name: @"m_nsOriginalUsrName" value: fromusername];
//        [ycFunction setVarInt:CVerifyContactWrap name: @"m_uiScene" value: 6];
//        [ycFunction setVar:CVerifyContactWrap name: @"m_nsTicket" value: ticket];
//        [ycFunction setVarInt:CVerifyContactWrap name: @"m_uiWCFlag" value: 0];
//        id CContact = [NSClassFromString(@"SayHelloDataLogic") getContactFrom: msg];
//        [ycFunction setVar: CVerifyContactWrap name: @"m_oVerifyContact" value:CContact];
//        
//        [SayHelloDataLogic contactVerifyOk: @[CVerifyContactWrap] opCode: 3];
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
    titleLabel.text = deString(@"第%d局", tmanager.mRobot.mNumber);
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
    if ([arr[2] isEqualToString: @"gameover"]) {
        titleColor = [UIColor redColor];
    }
    
    if(3 == celltype) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}

@end
