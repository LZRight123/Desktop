//
//  niuniuRobotTuoVC.m
//  wechatHook
//
//  Created by antion on 2017/4/4.
//
//

#import "niuniuRobotTuoVC.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "ycButtonView.h"
#import "niuniuMembersGroupView.h"
#import "niuniuSupportDragView.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotTuoVC ()

@end

@implementation niuniuRobotTuoVC {
    UIView* mBgView;
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSMutableDictionary* mHides;
}

-(void) dealloc {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
    }
    [mHides release];
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
    titleLabel.text = @"托";
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
        friendView.mSuperViewVC = weakSelf;
        friendView.mBackFunc = ^{
            mBgView.hidden = NO;
            [ycFunction popView: mBgView view: friendView dur: .2 completion:^(BOOL b) {
                [friendView removeFromSuperview];
            }];
        };
        friendView.mChooseFunc = ^(NSDictionary* dic) {
            NSString* errMsg = [tmanager.mRobot.mTuos addTuo: dic[@"userid"]];
            if (errMsg) {
                [ycFunction showMsg: errMsg msg:nil vc:weakSelf];
            } else {
                [weakSelf loadConfigs];
            }
        };
        friendView.mTitle.text = @"添加托";
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
    
    mHides = [@{} mutableCopy];
    mTableViewConfigs = [@{} mutableCopy];
    [self loadConfigs];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadConfigs {
    if (mTableViewConfigs) {
        [mTableViewConfigs removeAllObjects];
    }
    
    //标题, 标题高
    mTableViewConfigs[@"titles"] = @[
                                     @[@"托", @30, @"tuo"],
                                     @[@"曾经是托", @30, @"everTuo"],
                                     ];
    
    //展示类型(0: switch, 1: 文字+右文字带下级, 2:文字+下文字带下级, 3:文字带下级, 4: 文字, 5: 文字+按钮), key
    mTableViewConfigs[@"rows"] = @[
                                   [tmanager.mRobot.mTuos getAllTuoDetail: NO sortType:@"index"],
                                   [tmanager.mRobot.mTuos getAllTuoDetail: YES sortType: @"index"],
                                   ];
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 22)];
    titleLabel.center = CGPointMake(titleLabel.frame.size.width/2+10, titleh/2);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = deString(@"%@(%d)", config[0], (int)[mTableViewConfigs[@"rows"][section] count]);
    [myView addSubview:titleLabel];
    [titleLabel release];
    
    NSString* key = config[2];
    BOOL isOpen = !mHides[key] || [mHides[key] isEqualToString: @"false"];
    ycButtonView* hideBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: isOpen ? @"收起" : @"展开" func: ^() {
        mHides[key] = isOpen ? @"true" : @"false";
        [mTableView reloadData];
    }];
    [hideBtn setBtnColor: [UIColor colorWithRed:.5 green:.5 blue:0 alpha:1] isSelected:NO];
    hideBtn.center = CGPointMake(self.view.frame.size.width-30, titleh/2);
    [myView addSubview: hideBtn];
    [hideBtn release];
    return myView;
}

//组底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

//行个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* config = mTableViewConfigs[@"titles"][section];
    NSString* key = config[2];
    if (mHides[key] && [mHides[key] isEqualToString: @"true"]) {
        return 0;
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

    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
    
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
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self)weakSelf = self;
    UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSInteger row = [indexPath row];
        NSInteger section = [indexPath section];
        NSArray* config = mTableViewConfigs[@"titles"][section];
        NSString* key = config[2];
        NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
        if ([key isEqualToString: @"tuo"]) {
            [tmanager.mRobot.mTuos delTuo: dic[@"userid"]];
        } else if ([key isEqualToString: @"everTuo"]) {
            [tmanager.mRobot.mTuos delEverTuo: dic[@"userid"]];
        }
        [weakSelf loadConfigs];
    }];
    return @[btn1];
}

@end

