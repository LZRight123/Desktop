//
//  robotBackgroundSetting.m
//  wechatHook
//
//  Created by antion on 2017/11/26.
//
//

#import "niuniuRobotBackgroundSetting.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycButtonView.h"
#import "niuniuSupportDragView.h"
#import "robotSettingBillColorView.h"

static int infoh = 37;
static int btnh = 46;

@implementation niuniuRobotBackgroundSetting {
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSString* mChatroom;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id) initWithChatroom:(CGRect)frame chatroom:(NSString*)chatroom {
    if (self = [super initWithFrame: frame]) {
        mChatroom = [chatroom retain];
        
        self.mTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, infoh)];
        self.mTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mTitle];
        [self.mTitle release];
        
        mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.frame.size.width, self.frame.size.height-infoh-btnh)];
        mTableView.backgroundColor = [UIColor clearColor];
        mTableView.dataSource = self;
        mTableView.delegate = self;
        [mTableView setSeparatorColor: [UIColor yellowColor]];
        [self addSubview: mTableView];
        [mTableView release];
        
        __weak __typeof(&*self)weakSelf = self;
        ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"返回" func: ^() {
            weakSelf.mBackFunc();
        }];
        okBtn.center = CGPointMake(self.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
        [self addSubview: okBtn];
        [okBtn release];
        
        //支持拖动， 单击
        deSupportDrag(self, self.frame.size.height, infoh, niuniuSupportDragTypeDefault);
        
        //数据
        mTableViewConfigs = [@{} mutableCopy];
        [self loadConfig];
    }
    return self;
}

-(void) dealloc {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
    }
    [mChatroom release];
    self.mBackFunc = nil;
    [super dealloc];
}

-(void) loadConfig {
    [mTableViewConfigs removeAllObjects];
  
    //标题, 标题高
    mTableViewConfigs[@"titles"] = @[
                                     @[@"类型", @30],
                                     @[@"功能", @30],
                                     ];
    
    mTableViewConfigs[@"rows"] = @[
                                   @[
                                       @[@1, @"默认", @"default", @"标记本群为普通后台群", @NO],
                                       @[@1, @"上分群", @"shangfen", @"标记本群为财务上分群, 当天总上分会统计在‘查流水’命令里", @NO],
                                       @[@1, @"下分群", @"xiafen", @"标记本群为财务下分群, 当天总下分会统计在‘查流水’命令里", @NO],
                                       @[@1, @"福利群", @"fuli", @"标记本群为福利上分群, 当天总上分会统计在‘查流水’命令里", @NO],
                                       ],
                                   
                                   @[
                                       @[@0, @"播报机器修改", @"robotRework", @"如果开启的话，机器后台上下分，人为修改点数、押注、认尾都会提示, 所有后台群只允许设置一个，如果开启会自动关闭其他后台群的这个功能。", @YES],
                                       @[@0, @"每局播报输赢", @"isSendResult", @"如果开启的话，机器人会自动将本局输赢情况数据发到这个群, 所有后台群只允许设置一个，如果开启会自动关闭其他后台群的这个功能。", @YES],
                                       @[@0, @"每局播报观战", @"isInviteCheck", @"如果开启的话，机器人会自动将玩家观战、无分抢包、有人进群数据发到这个群, 所有后台群只允许设置一个，如果开启会自动关闭其他后台群的这个功能。", @YES],
                                       @[@0, @"推名片不反馈", @"isHideCard", @"如果开启的话，管理人员推一个名片到后台群，机器人不会反馈名片信息，但是命令依然有效， 主要用于财务上分群，信息量比较少看起来直观。", @NO],
                                       ],
                                   ];
    
    [mTableView reloadData];
}

-(NSArray*) key2array:(NSString*)key {
    for (NSArray* arr1 in mTableViewConfigs[@"rows"]) {
        for (NSArray* arr2 in arr1) {
            if ([arr2[2] isEqualToString: key]) {
                return arr2;
            }
        }
    }
    return nil;
}

//开关
-(void) switchChanged:(id)sender {
    UISwitch* s = sender;
    NSString* key = (NSString*)s.tag;
    NSArray* array = [self key2array: key];
    if (!array) {
        return;
    }
    
    [tmanager.mRobot setBackgroundFunc:mChatroom func:key value:s.isOn only:[array[4] boolValue]];
    
    NSString* text = nil;
    if ([array count] > 3) {
        text = array[3];
    }
    text = text ? text : @"";
    text = deString(@"%@\n%@", s.isOn ? @"✅已开启✅" : @"❌已关闭❌", text);
    [ycFunction showMsg:array[1] msg:text vc:self.mSuperViewVC];
    [mTableView reloadData];
}
//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* array = mTableViewConfigs[@"rows"][section][row];
    int type = [array[0] intValue];
    if (type == 0) {//开关
        return;
    }
    
    NSString* key = array[2];
    [tmanager.mRobot setBackgroundType:mChatroom type:key only:[array[4] boolValue]];
    
    NSString* text = nil;
    if ([array count] > 3) {
        text = array[3];
    }
    text = text ? text : @"";
    text = deString(@"%@", text);
    [ycFunction showMsg:array[1] msg:text vc:self.mSuperViewVC];
    [mTableView reloadData];
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 22)];
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
    
    if (0 == celltype) {
        UISwitch *switchview = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
        switchview.tag = key;
        [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [switchview setOn: [tmanager.mRobot getBackgroundHasFunc:mChatroom func: key]];
        cell.accessoryView = switchview;
    }
    else if(1 == celltype) {
        if ([tmanager.mRobot getBackgroundIsType:mChatroom type: key]) {
            cell.tintColor = [UIColor yellowColor];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}

@end
