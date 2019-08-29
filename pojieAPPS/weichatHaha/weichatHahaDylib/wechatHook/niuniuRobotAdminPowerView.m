//
//  niuniuAdminPowerView.m
//  wechatHook
//
//  Created by antion on 2017/7/6.
//
//

#import "niuniuRobotAdminPowerView.h"
#import "ycButtonView.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "niuniuSupportDragView.h"

static int infoh = 37;
static int btnh = 46;

@implementation niuniuRobotAdminPowerView {
    UITableView* mTableView;
    NSMutableArray* mLists;
    NSString* mAdminUserid;
}

-(id) initWithFrame:(CGRect)frame userid:(NSString*)userid {
    if (self = [super initWithFrame: frame]) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, infoh)];
        titleLabel.center = CGPointMake(self.frame.size.width/2, infoh/2);
        titleLabel.textColor = [UIColor yellowColor];
        if (memData) {
            titleLabel.text = deString(@"%@#%@", memData[@"index"], memData[@"billName"]);
        } else {
            titleLabel.text = @"获取失败";
        }
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel release];
        
        mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.frame.size.width, self.frame.size.height-infoh-btnh)];
        mTableView.backgroundColor = [UIColor clearColor];
        [mTableView setSeparatorColor: [UIColor yellowColor]];
        mTableView.delegate = self;
        mTableView.dataSource = self;
        [self addSubview: mTableView];
        [mTableView release];
        
        __weak __typeof(&*self)weakSelf = self;
        ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"返回" func: ^() {
            weakSelf.mBackFunc();
        }];
        okBtn.center = CGPointMake(self.frame.size.width/4-15, infoh+mTableView.frame.size.height+btnh/2);
        [self addSubview: okBtn];
        [okBtn release];
        
        ycButtonView* hasAll = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"全有" func: ^() {
            [tmanager.mRobot.mAdmins setAllPower:userid isEnable:YES];
            [weakSelf loadList];
        }];
        hasAll.center = CGPointMake(self.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
        [self addSubview: hasAll];
        [hasAll release];
        
        ycButtonView* nullAll = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"全无" func: ^() {
            [tmanager.mRobot.mAdmins setAllPower:userid isEnable:NO];
            [weakSelf loadList];
        }];
        nullAll.center = CGPointMake(self.frame.size.width/4*3+15, infoh+mTableView.frame.size.height+btnh/2);
        [self addSubview: nullAll];
        [nullAll release];
        
        //支持拖动， 单击
        deSupportDrag(self, self.frame.size.height, 37, niuniuSupportDragTypeDefault);
        
        mAdminUserid = [userid retain];
        mLists = [@[] mutableCopy];
        [self loadList];
    }
    return self;
}


-(void) dealloc {
    if (mLists) {
        [mLists release];
    }
    if (mAdminUserid) {
        [mAdminUserid release];
    }
    self.mBackFunc = nil;
    [super dealloc];
}

-(void) loadList {
    [mLists removeAllObjects];
    [mLists addObjectsFromArray: [tmanager.mRobot.mAdmins getAllPowers]];
    [mTableView reloadData];
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
    [tmanager.mRobot.mAdmins setPower:mAdminUserid key:key isEnable:s.isOn];
}

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger row = [indexPath row];
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
    titleLabel.text = deString(@"权限(%d)", (int)[mLists count]);
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
    NSString* key = array[0];
    NSString* name = array[1];
    
    UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
    switchview.tag = key;
    [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [switchview setOn: [tmanager.mRobot.mAdmins hasPower:mAdminUserid key:key]];
    cell.accessoryView = switchview;

    cell.textLabel.text = name;
    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.detailTextLabel.text = array[2];
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
    return cell;
}

@end
