//
//  robotSettingVC.m
//  wechatHook
//
//  Created by antion on 2017/10/20.
//
//

#import "robotSettingVC.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "ycButtonView.h"
#import "niuniuMembersGroupView.h"
#import "niuniuSupportDragView.h"
#import "niuniuRobotAdminPowerView.h"
#import "robotSettingView.h"
#import "toolManager.h"

static int infoh = 37;
static int btnh = 46;

@interface robotSettingVC ()

@end

@implementation robotSettingVC {
    UIView* mBgView;
    UITableView* mTableView;
    NSArray* mLists;
}

-(void) dealloc {
    if (mLists) {
        [mLists release];
    }
    self.mBackFunc = nil;
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
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [mBgView addSubview:titleLabel];
    [titleLabel release];
    
    mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.view.frame.size.width, self.view.frame.size.height-infoh-btnh)];
    mTableView.backgroundColor = [UIColor clearColor];
    [mTableView setSeparatorColor: [UIColor yellowColor]];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [mBgView addSubview: mTableView];
    [mTableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"首页" func: ^() {
        weakSelf.mBackFunc();
    }];
    okBtn.center = CGPointMake(self.view.frame.size.width/3-8, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: okBtn];
    [okBtn release];
    
    ycButtonView* addBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"默认" func: ^() {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否恢复默认设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tmanager.mRobot.mData setBaseSettingDefault];
            [mTableView reloadData];
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    }];
    addBtn.center = CGPointMake(self.view.frame.size.width/3*2+8, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: addBtn];
    [addBtn release];
    
    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
    
    mLists = [@[
                @[@"通用", @"general"],
                @[@"牛牛玩法", @"niuniu"],
                @[@"大小单双玩法", @"daxiao"],
                @[@"特码玩法", @"tema"],
                @[@"百家乐玩法", @"baijiale"],
                @[@"连赢、奖励", @"bonus"],
                @[@"前台出单配置", @"bill"],
                @[@"存档管理", @"cache"],
               ] retain];
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
    NSArray* array = mLists[row];
    
    robotSettingView* settingView = [[robotSettingView alloc] initWithType: mBgView.frame type: array[1]];
    settingView.mSuperViewVC = self;
    settingView.mBackFunc = ^{
        mBgView.hidden = NO;
        [ycFunction popView: mBgView view: settingView dur: .2 completion:^(BOOL b) {
            [settingView removeFromSuperview];
        }];
        [mTableView reloadData];
    };

    settingView.mTitle.text = array[0];
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
    titleLabel.text = @"列表";
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}

//组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mLists count];
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
    NSArray* array = mLists[row];
    
    cell.textLabel.text = array[0];
    cell.textLabel.textColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString* key = array[1];
    if ([key isEqualToString: @"niuniu"]) {
        BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportNiuniu"] isEqualToString: @"true"];
        if (enable) {
            cell.detailTextLabel.text = @"已开启牛牛玩法";
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.text = @"已关闭牛牛玩法";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }else if ([key isEqualToString: @"daxiao"]) {
        BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportLonghu"] isEqualToString: @"true"];
        if (enable) {
            cell.detailTextLabel.text = @"已开启大小单双玩法";
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.text = @"已关闭大小单双玩法";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }else if ([key isEqualToString: @"tema"]) {
        BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportTema"] isEqualToString: @"true"];
        if (enable) {
            cell.detailTextLabel.text = @"已开启特码玩法";
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.text = @"已关闭特码玩法";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }else if ([key isEqualToString: @"baijiale"]) {
        BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportBaijiale"] isEqualToString: @"true"];
        if (enable) {
            cell.detailTextLabel.text = @"已开启百家乐玩法";
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.text = @"已关闭百家乐玩法";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }else if ([key isEqualToString: @"bonus"]) {
        BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"seriesWinAutoBonusEnable"] isEqualToString: @"true"];
        if (enable) {
            cell.detailTextLabel.text = @"已开启自动连赢兑奖";
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.text = @"已关闭自动连赢兑奖";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }else if ([key isEqualToString: @"bill"]) {
        BOOL enable1 = [tmanager.mRobot.mData.mBaseSetting[@"showPicBillForBet"] isEqualToString: @"true"];
        BOOL enable2 = [tmanager.mRobot.mData.mBaseSetting[@"showPicBill"] isEqualToString: @"true"];
        cell.detailTextLabel.text = deString(@"%@押注单 | %@结算单", enable1 ? @"图片" : @"文字", enable2 ? @"图片" : @"文字");
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    return cell;
}

@end

