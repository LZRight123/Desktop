//
//  niuniuRobotViewController.m
//  wechatHook
//
//  Created by antion mac on 2016/12/8.
//
//

#import "niuniuRobotViewController.h"
#import "ycButtonView.h"
#import "ycFunction.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "niuniuRobotGameViewController.h"
#import "ycInputView.h"
#import "niuniuRobotBackroundVC.h"
#import "niuniuRobotMembersVC.h"
#import "niuniuRobotAdminsVC.h"
#import "niuniuRobotTuoVC.h"
#import "niuniuRobotLashousVC.h"
#import "niuniuRobotLashouHeadsVC.h"
#import "niuniuSupportDragView.h"
#import "robotSettingVC.h"
#import "wxFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "niuniuRobotExcelHelper.h"

static int infoh = 37;

@interface niuniuRobotViewController () {
    UIWindow* mWindows;
    NSMutableDictionary* mTableViewConfigs;
}

@end

@implementation niuniuRobotViewController {
    UITableView *mTableView;
}

-(void) dealloc {
    NSLog(@"niuniuRobotViewController dealloc");
    self.mFunc = nil;
    [mTableViewConfigs release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //启动机器人
    [tmanager startNiuniuRobot];
    
    self.view.frame = CGRectMake(0, 0, 234, 395);
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: .8];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, infoh)];
    titleLabel.center = CGPointMake(self.view.frame.size.width/2, infoh/2);
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.text = @"千玺机器";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.view.frame.size.width, self.view.frame.size.height-infoh)];
    mTableView.backgroundColor = [UIColor clearColor];
    [mTableView setSeparatorColor: [UIColor yellowColor]];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview: mTableView];
    [mTableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    niuniuSupportDragView* dragView = deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeALL);
    dragView.mDoubleFunc = ^{
        weakSelf.mFunc();
    };
    
    //数据
    mTableViewConfigs = [@{} mutableCopy];
    
    [self reload];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reload {
    [mTableViewConfigs removeAllObjects];
    
    //标题, 标题高
    mTableViewConfigs[@"titles"] = @[
                                     @[@"基本", @30],
                                     @[@"其他", @30],
                                     ];
    
    NSMutableArray* row1 = [[@[
                             @[@1, @"绑定游戏群", @"startGame"],
                             @[@1, @"绑定后台群", @"bindBackground"],
                             @[@1, @"会员", @"members"],
                             @[@1, @"管理员", @"admins"],
                             @[@1, @"托", @"tuos"],
                             @[@1, @"拉手", @"lashous"],
                             @[@1, @"拉手团长", @"lashouheads"],
                             ] mutableCopy] autorelease];
    
    //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
    mTableViewConfigs[@"rows"] = @[
                                   row1,
                                   
                                   @[
                                       @[@3, @"设置", @"setting"],
                                       ],
                                   ];
    
    [mTableView reloadData];
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
    if ([key isEqualToString: @"startGame"]) {//绑定游戏
        if (!tmanager.mRobot.mGameRoom) {
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
            [mTableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tmanager.mRobot bindGameRoom:qunUsr title:qunTitle];
        }
        niuniuRobotGameViewController* gameController = [[niuniuRobotGameViewController alloc] init];
        gameController.mBackFunc = ^{
            [gameController dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [gameController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: gameController animated: YES completion: ^{
            [gameController release];
        }];
    }
    else if ([key isEqualToString: @"bindBackground"]) {//绑定后台
        niuniuRobotBackroundVC* vc = [[niuniuRobotBackroundVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    }
    else if([key isEqualToString: @"members"]) {//会员
        niuniuRobotMembersVC* members = [[niuniuRobotMembersVC alloc] init];
        members.mBackFunc = ^{
            [members dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [members setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: members animated: YES completion: ^{
            [members release];
        }];
    }
    else if([key isEqualToString: @"admins"]) {//管理
        niuniuRobotAdminsVC* vc = [[niuniuRobotAdminsVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    }
    else if([key isEqualToString: @"tuos"]) {//托
        niuniuRobotTuoVC* vc = [[niuniuRobotTuoVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    }
    else if([key isEqualToString: @"lashous"]) {//拉手
        niuniuRobotLashousVC* vc = [[niuniuRobotLashousVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    } else if([key isEqualToString: @"lashouheads"]) {//拉手团长
        niuniuRobotLashouHeadsVC* vc = [[niuniuRobotLashouHeadsVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    } else if([key isEqualToString: @"setting"]) {
        robotSettingVC* vc = [[robotSettingVC alloc] init];
        vc.mBackFunc = ^{
            [vc dismissViewControllerAnimated: YES completion: ^{
            }];
            [mTableView reloadData];
        };
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal]; //翻转
        [self presentViewController: vc animated: YES completion: ^{
            [vc release];
        }];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"功能开发中.." message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[ycButtonView class]]){
        return NO;
    }
    return YES;
    
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    int titleh = [mTableViewConfigs[@"titles"][section][1] intValue];
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
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
    
    NSArray* arr = mTableViewConfigs[@"rows"][[indexPath section]][[indexPath row]];
    int celltype = [arr[0] intValue];
    NSString* title = arr[1];
    UIColor* titleColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    NSString* key = arr[2];
    NSString* subtitle = nil;
    
    if (0 == celltype) {
//        NSString* data = mEnables[arr[2]];
//        if (!data) {
//            data = @"";
//        }
        
        UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
        switchview.tag = (NSInteger)key;
        [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//        [switchview setOn: [data isEqualToString: @"true"]];
        cell.accessoryView = switchview;
    } else if(1 == celltype) {
        int fontsize = 16;
        NSString* rightText = @"";
        UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
        if ([key isEqualToString: @"startGame"]) {
            fontsize = 12;
            if (tmanager.mRobot.mGameTitle) {
                title = @"继续游戏";
                titleColor = [UIColor greenColor];
                rightText = tmanager.mRobot.mGameTitle;
            } else {
                title = @"绑定游戏群";
                titleColor = [UIColor greenColor];
            }
        }
        else if ([key isEqualToString: @"bindBackground"]) {
            title = @"绑定后台群";
            titleColor = [UIColor greenColor];
            rightText = deInt2String((int)[tmanager.mRobot.mBackroundRooms count]);
        }
        else if ([key isEqualToString: @"members"]) {
            rightText = deInt2String((int)[tmanager.mRobot.mData.mMemberList count]);
        }
        else if ([key isEqualToString: @"admins"]) {
            rightText = deInt2String((int)[tmanager.mRobot.mData.mAdminList count]);
        }
        else if ([key isEqualToString: @"tuos"]) {
            rightText = deInt2String([tmanager.mRobot.mTuos getTuoCount]);
        }
        else if ([key isEqualToString: @"lashous"]) {
            rightText = deInt2String((int)[tmanager.mRobot.mData.mLashouList count]);
        }
        else if ([key isEqualToString: @"lashouheads"]) {
            rightText = deInt2String((int)[tmanager.mRobot.mData.mLashouHeadList count]);
        }
        else if([key isEqualToString: @"queryDate"]) {
            rightText = tmanager.mRobot.mQueryDate;
        }
        else if([key isEqualToString: @"test"]) {
            titleColor = [UIColor redColor];
        }
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width/3, 22)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = rightText;
        label.textColor = rightTextColor;
        label.font = [UIFont systemFontOfSize: fontsize];
        label.center = CGPointMake(cell.contentView.frame.size.width/2-10, cell.contentView.frame.size.height/2);
        [cell.contentView addSubview:label];
        [label release];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if(2 == celltype) {
    } else if(3 == celltype) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([key isEqualToString: @"help"]) {
            titleColor = [UIColor greenColor];
        }
    }
    
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}


@end
