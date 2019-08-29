//
//  niuniuRobotMembersVC.m
//  wechatHook
//
//  Created by antion on 2017/3/6.
//
//

#import "niuniuRobotMembersVC.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "niuniuRobotMembers.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "niuniuSupportDragView.h"
#import "niuniuRobotMemberDetailView.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotMembersVC ()

@end

@implementation niuniuRobotMembersVC {
    UIView* mBgView;
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSMutableDictionary* mDatas;
    NSString* mSortType;
    NSString* mFilterText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, 234, 395);
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: .8];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
        
    mSortType = [@"score" retain];
    
    mBgView = [[UIView alloc] initWithFrame: self.view.frame];
    mBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: mBgView];
    [mBgView release];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, infoh)];
    titleLabel.center = CGPointMake(self.view.frame.size.width/2, infoh/2);
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.text = @"会员";
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
    
    ycButtonView* addBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"积分榜" func: ^() {
        [tmanager.mRobot.mMembers showTop];
    }];
    addBtn.center = CGPointMake(self.view.frame.size.width/3*2+8, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: addBtn];
    [addBtn release];
    
    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
    
    mFilterText = [@"" retain];
    mTableViewConfigs = [@{} mutableCopy];
    [self loadConfig];
}

-(void) dealloc {
    [mFilterText release];
    self.mBackFunc = nil;
    [mTableViewConfigs release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadConfig {
    [mTableViewConfigs removeAllObjects];
    
    //标题, 标题高
    mTableViewConfigs[@"titles"] = @[
                                     @[@"操作", @30, @"operation"],
                                     @[@"会员", @30, @"normal"],
                                     ];
    
    mTableViewConfigs[@"rows"] = [NSMutableArray array];
    
    //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
    [mTableViewConfigs[@"rows"] addObject: @[
                                             @[@1, @"名字搜索", @"filter"],
                                             @[@4, @"排序方式", @"sort"],
                                             ]];
    
    [mTableViewConfigs[@"rows"] addObject: [tmanager.mRobot.mMembers getAllMembers: mSortType filterText: mFilterText]];
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
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* config = mTableViewConfigs[@"titles"][section];
    NSString* key = config[2];
    
    __weak __typeof(&*self)weakSelf = self;
    if ([key isEqualToString: @"operation"]) {//操作
        NSArray* array = mTableViewConfigs[@"rows"][section][row];
        key = array[2];
        if ([key isEqualToString: @"filter"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"设置名字搜索关键字" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField* textField = alertController.textFields.firstObject;
                [mFilterText release];
                mFilterText = [textField.text retain];
                [weakSelf loadConfig];
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.text = mFilterText;
            }];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
        niuniuRobotMemberDetailView* view = [[niuniuRobotMemberDetailView alloc] initWithFrame: mBgView.frame userid: dic[@"userid"] hasBtn: YES];
        view.mSuperViewVC = self;
        view.mBackFunc = ^{
            [weakSelf loadConfig];
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
    NSArray* config = mTableViewConfigs[@"titles"][section];
    int titleh = [config[1] intValue];
    UIView* myView = [[UIView new] autorelease];
    myView.backgroundColor = [UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor = [UIColor whiteColor];
    if ([config[2] isEqualToString: @"operation"]) {
        titleLabel.text = config[0];
    } else {
        if ([mFilterText isEqualToString: @""]) {
            titleLabel.text = deString(@"%@(%d)", config[0], (int)[mTableViewConfigs[@"rows"][section] count]);
        } else {
            titleLabel.text = deString(@"%@[%@](%d)", config[0], mFilterText, (int)[mTableViewConfigs[@"rows"][section] count]);
        }
    }
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
    
    NSArray* config = mTableViewConfigs[@"titles"][section];
    NSString* key = config[2];
    
    if ([key isEqualToString: @"operation"]) {
        config = mTableViewConfigs[@"rows"][section][row];
        key = config[2];
        if ([key isEqualToString: @"sort"]) {//排序
            [ycFunction cellAddRightBtn: cell tableView: tableView text: @"编号" func: ^{
                [mSortType release];
                mSortType = [@"index" retain];
                [self loadConfig];
            } offset: 8];
            
            [ycFunction cellAddRightBtn: cell tableView: tableView text: @"积分" func: ^{
                [mSortType release];
                mSortType = [@"score" retain];
                [self loadConfig];
            } offset: -62];
        } else if([key isEqualToString: @"filter"]){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSString* text = @"无";
            UIColor* color = [UIColor greenColor];
            if (![mFilterText isEqualToString: @""]) {
                text = mFilterText;
                color = [UIColor whiteColor];
            }
            [ycFunction cellAddRightText: cell text: text color: color size: 16 offset: 0];
        }
        cell.textLabel.text = config[1];
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
        
        UIImage* icon = [wxFunction getHead: dic[@"userid"]];
        cell.imageView.image = [ycFunction resizeImg: icon size:CGSizeMake(35, 35)];
        
        cell.textLabel.text = [niuniuRobotMembers newRemark: dic];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.text = dic[@"userid"];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        [ycFunction cellAddRightText: cell text: dic[@"score"] color: [UIColor greenColor] size: 16 offset: 20];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [indexPath section] > 0;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self)weakSelf = self;
    UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSInteger section = [indexPath section];
        NSInteger row = [indexPath row];
        NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:deString(@"是否确定删除[%@]", [niuniuRobotMembers newRemark: dic]) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tmanager.mRobot.mMembers delMember: dic[@"userid"]];
            [tmanager.mRobot.mData saveMemberListFile];
            [weakSelf loadConfig];
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];

    }];
    return @[btn1];
}

@end
