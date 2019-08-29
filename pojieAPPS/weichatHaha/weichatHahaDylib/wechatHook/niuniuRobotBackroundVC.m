//
//  niuniuRobotBackroundVC.m
//  wechatHook
//
//  Created by antion on 2017/4/4.
//
//

#import "niuniuRobotBackroundVC.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "ycButtonView.h"
#import "niuniuSupportDragView.h"
#import "niuniuRobotBackgroundSetting.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotBackroundVC ()

@end

@implementation niuniuRobotBackroundVC {
    UIView* mBgView;
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
}

-(void) dealloc {
    self.mBackFunc = nil;
    [mTableViewConfigs release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, 234, 395);
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: .8];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    mBgView = [[UIView alloc] initWithFrame: self.view.frame];
    mBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: mBgView];
    [mBgView release];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, infoh)];
    titleLabel.center = CGPointMake(self.view.frame.size.width/2, infoh/2);
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.text = @"后台群";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [mBgView addSubview:titleLabel];
    [titleLabel release];
    
    mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.view.frame.size.width, self.view.frame.size.height-infoh-btnh)];
    mTableView.backgroundColor = [UIColor clearColor];
    [mTableView setSeparatorColor: [UIColor yellowColor]];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [mTableView reloadData];
    [mBgView addSubview: mTableView];
    [mTableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"首页" func: ^() {
        weakSelf.mBackFunc();

    }];
    okBtn.center = CGPointMake(self.view.frame.size.width/4-15, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: okBtn];
    [okBtn release];
    
    ycButtonView* addBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"添加" func: ^() {
        NSString* qunTitle = nil;
        NSString* qunUsr = nil;
        UIViewController* controller =[ycFunction getCurrentVisableVC];
        if (!controller) {
            return;
        }
        NSString* className = NSStringFromClass([controller class]);
        if([className isEqualToString: @"BaseMsgContentViewController"]) {
            id concact = [controller performSelector: @selector(GetContact) withObject:nil];
            id m_nsUsrName = [ycFunction getVar:concact name: @"m_nsUsrName"];
            if ([m_nsUsrName containsString: @"@chatroom"]) {//群
                qunTitle = [ycFunction getVar:concact name: @"m_nsNickName"];
                qunUsr = m_nsUsrName;
            }
        }
        
        if (!qunUsr) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"提示" message: @"需要在牛牛群里绑定" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        [tmanager.mRobot bindBackgroundRoom:qunUsr title:qunTitle];
        [tmanager.mRobot.mData saveBackgroundChatroom: tmanager.mRobot.mBackroundRooms];
        [mTableView reloadData];
    }];
    addBtn.center = CGPointMake(self.view.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: addBtn];
    [addBtn release];
    
    ycButtonView* importLast = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"导入" func: ^() {
        if ([tmanager.mRobot loadLastBackgroundData]) {
            [ycFunction showMsg: nil msg: @"导入上次数据成功! 添加、删除操作会更新“上次数据”。" vc:self];
            [mTableView reloadData];
        } else {
            [ycFunction showMsg: nil msg: @"导入上次数据失败!" vc:self];
        }
    }];
    importLast.center = CGPointMake(self.view.frame.size.width/4*3+15, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: importLast];
    [importLast release];
    
    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
}

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger row = [indexPath row];
    NSMutableDictionary* dic = tmanager.mRobot.mBackroundRooms[row];

    niuniuRobotBackgroundSetting* settingView = [[niuniuRobotBackgroundSetting alloc] initWithChatroom: mBgView.frame chatroom: dic[@"room"]];
    settingView.mSuperViewVC = self;
    settingView.mBackFunc = ^{
        mBgView.hidden = NO;
        [ycFunction popView: mBgView view: settingView dur: .2 completion:^(BOOL b) {
            [settingView removeFromSuperview];
        }];
        [mTableView reloadData];
    };
    
    settingView.mTitle.text = dic[@"title"];
    settingView.mTitle.textColor = [UIColor yellowColor];
    settingView.hidden = YES;
    [self.view addSubview: settingView];
    [settingView release];
    dispatch_async(deMainQueue, ^{
        settingView.hidden = NO;
        [ycFunction pushView: mBgView view: settingView dur: .2 completion:^(BOOL b){
            if (b) {
                mBgView.hidden = YES;
            }
        }];
    });
}


#pragma mark- UITableViewDataSource

//组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//标题高
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section {
    return 30;
}

//标题视图
- (UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, 30/2);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = deString(@"已绑定(%d)", (int)[tmanager.mRobot.mBackroundRooms count]);
    [myView addSubview:titleLabel];
    [titleLabel release];
    
    ycButtonView* clearBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"清空" func: ^() {
        [tmanager.mRobot.mBackroundRooms removeAllObjects];
        [mTableView reloadData];
    }];
    [clearBtn setBtnColor: [UIColor colorWithRed:.5 green:.5 blue:0 alpha:1] isSelected:NO];
    clearBtn.center = CGPointMake(self.view.frame.size.width-30, 30/2);
    [myView addSubview: clearBtn];
    [clearBtn release];
    return myView;
}

//组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tmanager.mRobot.mBackroundRooms count];
}

//消除cell选择痕迹
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    [self clickLine: indexPath];
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
    
    NSInteger row = [indexPath row];
    NSDictionary* dic = tmanager.mRobot.mBackroundRooms[row];

    NSMutableString* detailText = [NSMutableString string];
    if ([dic[@"type"] isEqualToString: @"shangfen"]) {
        [detailText appendString: @"上分群"];
    } else if ([dic[@"type"] isEqualToString: @"xiafen"]) {
        [detailText appendString: @"下分群"];
    } else if ([dic[@"type"] isEqualToString: @"fuli"]) {
        [detailText appendString: @"福利群"];
    } else {
        [detailText appendString: @"默认"];
    }
    if (dic[@"robotRework"] && [dic[@"robotRework"] isEqualToString: @"true"]) {
        [detailText appendString: @"/机器播报"];
    }
    if (dic[@"isSendResult"] && [dic[@"isSendResult"] isEqualToString: @"true"]) {
        [detailText appendString: @"/输赢播报"];
    }
    if (dic[@"isInviteCheck"] && [dic[@"isInviteCheck"] isEqualToString: @"true"]) {
        [detailText appendString: @"/观战播报"];
    }
    if (dic[@"isHideCard"] && [dic[@"isHideCard"] isEqualToString: @"true"]) {
        [detailText appendString: @"/名片不反馈"];
    }
    
    UIColor* color = [UIColor whiteColor];
    if ((dic[@"robotRework"] && [dic[@"robotRework"] isEqualToString: @"true"]) ||
        (dic[@"isSendResult"] && [dic[@"isSendResult"] isEqualToString: @"true"]) ||
        (dic[@"isInviteCheck"] && [dic[@"isInviteCheck"] isEqualToString: @"true"]) ||
        (dic[@"isHideCard"] && [dic[@"isHideCard"] isEqualToString: @"true"]) ) {
        color = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
    }
    if (![dic[@"type"] isEqualToString: @"default"]) {
        color = [UIColor greenColor];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dic[@"title"] && ![dic[@"title"] isEqualToString: @""] ? dic[@"title"] : dic[@"room"];
    cell.textLabel.textColor = color;
    cell.detailTextLabel.text = detailText;
    cell.detailTextLabel.textColor = color;

    if (![wxFunction checkIsInChatroom: dic[@"room"]]) {
        [ycFunction cellAddRightText: cell text: @"未进群" color: [UIColor redColor] size: 16 offset: 0];
    }
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak __typeof(&*self)weakSelf = self;
    NSMutableDictionary* dic = tmanager.mRobot.mBackroundRooms[[indexPath row]];
    UITableViewRowAction *btn2 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tmanager.mRobot unbindBackgroundRoom: dic[@"room"]];
        [tmanager.mRobot.mData saveBackgroundChatroom: tmanager.mRobot.mBackroundRooms];
        [mTableView reloadData];
    }];
    btn2.backgroundColor = [UIColor redColor];
    return @[btn2];
}

@end

