//
//  niuniuRobotFriends.m
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import "niuniuMembersGroupView.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycButtonView.h"
#import "niuniuSupportDragView.h"

static int infoh = 37;
static int btnh = 46;

@implementation niuniuMembersGroupView {
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSString* mSortType;
    NSString* mFilterText;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        mSortType = [@"score" retain];

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
        mFilterText = [@"" retain];
        mTableViewConfigs = [@{} mutableCopy];
        [self loadConfig];
    }
    return self;
}

-(void) dealloc {
    if (mTableViewConfigs) {
        [mTableViewConfigs release];
    }
    [mFilterText release];
    self.mChooseFunc = nil;
    self.mBackFunc = nil;
    [super dealloc];
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

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if (section > 0) {
        NSDictionary* dic = mTableViewConfigs[@"rows"][section][row];
        if (dic) {
            self.mChooseFunc(dic);
        }
        self.mBackFunc();
    } else {
        __weak __typeof(&*self)weakSelf = self;
        NSArray* array = mTableViewConfigs[@"rows"][section][row];
        NSString* key = array[2];
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
            [self.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
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
            __weak __typeof(&*self)weakSelf = self;
            [ycFunction cellAddRightBtn: cell tableView: tableView text: @"编号" func: ^{
                [mSortType release];
                mSortType = [@"index" retain];
                [weakSelf loadConfig];
            } offset: 8];
            
            [ycFunction cellAddRightBtn: cell tableView: tableView text: @"积分" func: ^{
                [mSortType release];
                mSortType = [@"score" retain];
                [weakSelf loadConfig];
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


-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
