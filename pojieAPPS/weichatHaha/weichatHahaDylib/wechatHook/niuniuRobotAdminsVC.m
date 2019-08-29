//
//  niuniuRobotAdminsVC.m
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import "niuniuRobotAdminsVC.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "ycButtonView.h"
#import "niuniuMembersGroupView.h"
#import "niuniuSupportDragView.h"
#import "niuniuRobotAdminPowerView.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotAdminsVC ()

@end

@implementation niuniuRobotAdminsVC {
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
    titleLabel.text = @"管理员";
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
    
    ycButtonView* addBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"添加" func: ^() {
        niuniuMembersGroupView* friendView = [[niuniuMembersGroupView alloc] initWithFrame: mBgView.frame];
        friendView.mSuperViewVC = self;
        friendView.mBackFunc = ^{
            mBgView.hidden = NO;
            [ycFunction popView: mBgView view: friendView dur: .2 completion:^(BOOL b) {
                [friendView removeFromSuperview];
            }];
        };
        friendView.mChooseFunc = ^(NSDictionary* dic) {
            [tmanager.mRobot.mAdmins addAdmin: dic[@"userid"]];
            [weakSelf loadList];
        };
        friendView.mTitle.text = @"添加管理员";
        friendView.mTitle.textColor = [UIColor yellowColor];
        friendView.hidden = YES;
        [weakSelf.view addSubview: friendView];
        [friendView release];
        dispatch_async(deMainQueue, ^{
            friendView.hidden = NO;
            [ycFunction pushView: mBgView view: friendView dur: .2 completion:^(BOOL b){
                if (b) {
                    mBgView.hidden = YES;
                }
            }];
        });
    }];
    addBtn.center = CGPointMake(self.view.frame.size.width/3*2+8, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: addBtn];
    [addBtn release];

    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
    
    [self loadList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadList {
    if (mLists) {
        [mLists release];
    }
    mLists = [[tmanager.mRobot.mAdmins getAllAdminDetail] retain];
    [mTableView reloadData];
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
    NSDictionary* dic = mLists[row];
    
    __weak __typeof(&*self)weakSelf = self;
    niuniuRobotAdminPowerView* view = [[niuniuRobotAdminPowerView alloc] initWithFrame: self.view.frame userid:dic[@"userid"]];
    view.mBackFunc = ^{
        [mTableView reloadData];
        mBgView.hidden = NO;
        [ycFunction popView: mBgView view: view dur: .2 completion:^(BOOL b) {
            [view removeFromSuperview];
        }];
    };
    view.hidden = YES;
    [self.view addSubview: view];
    [view release];
    dispatch_async(deMainQueue, ^{
        view.hidden = NO;
        [ycFunction pushView: mBgView view: view dur: .2 completion:^(BOOL b){
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
    titleLabel.text = deString(@"管理员(%d)", (int)[mLists count]);
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
    NSDictionary* dic = mLists[row];
    
    UIImage* icon = [wxFunction getHead: dic[@"userid"]];
    cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
    
    NSString* name = nil;
    UIColor* nameColor = nil;
    if (dic[@"billName"]) {
        name = deString(@"%@#%@", dic[@"index"], dic[@"billName"]);
        nameColor = [UIColor whiteColor];
    }
    else if (dic[@"name"]) {
        name = dic[@"name"];
        nameColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:1];
    }
    else {
        name = @"获取失败";
        nameColor = [UIColor redColor];
    }
    
    cell.textLabel.text = name;
    cell.textLabel.textColor = nameColor;
    cell.detailTextLabel.text = dic[@"userid"];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    if (dic[@"userid"]) {
        [ycFunction cellAddRightText: cell text: deString(@"%d个", [tmanager.mRobot.mAdmins getPowerCount: dic[@"userid"]]) color: [UIColor greenColor] size: 16 offset: 20];
    }
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self)weakSelf = self;
    UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary* dic = mLists[[indexPath row]];
        [tmanager.mRobot.mAdmins delAdmin: dic[@"userid"]];
        [weakSelf loadList];
    }];
    return @[btn1];
}

@end
