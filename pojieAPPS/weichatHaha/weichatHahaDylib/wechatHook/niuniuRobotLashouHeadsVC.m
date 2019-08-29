//
//  niuniuRobotLashouHeadsVC.m
//  wechatHook
//
//  Created by antion on 2017/11/10.
//
//

#import "niuniuRobotLashouHeadsVC.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "ycButtonView.h"
#import "niuniuMembersGroupView.h"
#import "niuniuSupportDragView.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotLashouHeadsVC ()

@end

@implementation niuniuRobotLashouHeadsVC {
    UIView* mBgView;
    UITableView* mTableView;
    UILabel* mTitle;
    NSArray* mLists;
    NSDictionary* mLashouHeadDic;
    ycButtonView* addBtn;
    ycButtonView* backBtn;
    NSString* mPageType;//lashouHead, lashouHeadMove, lashouMember
}

-(void) dealloc {
    if (mLists) {
        [mLists release];
    }
    if (mLashouHeadDic) {
        [mLashouHeadDic release];
    }
    if (mPageType) {
        [mPageType release];
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
    
    mLashouHeadDic = nil;
    
    mBgView = [[UIView alloc] initWithFrame: self.view.frame];
    mBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: mBgView];
    [mBgView release];
    
    mTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, infoh)];
    mTitle.center = CGPointMake(self.view.frame.size.width/2, infoh/2);
    mTitle.textColor = [UIColor yellowColor];
    mTitle.text = @"拉手团长";
    mTitle.textAlignment = NSTextAlignmentCenter;
    [mBgView addSubview:mTitle];
    [mTitle release];
    
    mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.view.frame.size.width, self.view.frame.size.height-infoh-btnh)];
    mTableView.backgroundColor = [UIColor clearColor];
    [mTableView setSeparatorColor: [UIColor yellowColor]];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [mBgView addSubview: mTableView];
    [mTableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    backBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"首页" func: ^() {
        if ([mPageType isEqualToString: @"lashouHead"]) {
            weakSelf.mBackFunc();
        } else {
            [self setLashouHeadDic: nil];
            [self setPageType: @"lashouHead"];
        }
    }];
    [mBgView addSubview: backBtn];
    [backBtn release];
    
    addBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"添加" func: ^() {
        if ([mPageType isEqualToString: @"lashouHead"]) {
            niuniuMembersGroupView* friendView = [[niuniuMembersGroupView alloc] initWithFrame: mBgView.frame];
            friendView.mSuperViewVC = self;
            friendView.mBackFunc = ^{
                mBgView.hidden = NO;
                [ycFunction popView: mBgView view: friendView dur: .2 completion:^(BOOL b) {
                    [friendView removeFromSuperview];
                }];
            };
            friendView.mChooseFunc = ^(NSDictionary* dic) {
                [tmanager.mRobot.mLashouHeads addLashouHead: dic[@"userid"]];
                [weakSelf loadList];
            };
            friendView.mTitle.text = @"添加团长";
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
        } else {
            [ycFunction showMsg: @"功能开发中.." msg:nil vc:self];
        }
        
    }];
    addBtn.center = CGPointMake(self.view.frame.size.width/3*2+8, infoh+mTableView.frame.size.height+btnh/2);
    [mBgView addSubview: addBtn];
    [addBtn release];
    
    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
    
    [self setPageType: @"lashouHead"];
    [self loadList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPageType:(NSString*)type {
    if (mPageType) {
        [mPageType release];
    }
    mPageType = [type retain];
    
    if ([mPageType isEqualToString: @"lashouHead"]) {
        [backBtn setText: @"首页"];
    } else {
        [backBtn setText: @"返回"];
    }
    
    if ([mPageType isEqualToString: @"lashouHeadMove"]) {
        backBtn.center = CGPointMake(self.view.frame.size.width/2, infoh+mTableView.frame.size.height+btnh/2);
        addBtn.hidden = YES;
    } else {
        backBtn.center = CGPointMake(self.view.frame.size.width/3-8, infoh+mTableView.frame.size.height+btnh/2);
        addBtn.hidden = NO;
    }
    
    UITableView* tableView = [[UITableView alloc] initWithFrame: mTableView.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorColor: [UIColor yellowColor]];
    [tableView reloadData];
    [mBgView addSubview: tableView];
    [tableView release];
    
    [self loadList: tableView];
    
    __weak __typeof(&*self)weakSelf = self;
    if ([mPageType isEqualToString: @"lashouHead"]) {//pop
        mTitle.text = @"拉手团长";
        [mBgView bringSubviewToFront: mTableView];
        dispatch_async(deMainQueue, ^{
            [ycFunction popView: tableView view: mTableView dur: .2 completion:^(BOOL b) {
                mTableView.delegate = nil;
                mTableView.dataSource = nil;
                [mTableView removeFromSuperview];
                mTableView = tableView;
                [weakSelf loadList];
            }];
        });
    } else {//push
        if ([mPageType isEqualToString: @"lashou"]) {
            mTitle.text = deString(@"团长[%@]成员", mLashouHeadDic[@"billName"] ? mLashouHeadDic[@"billName"] : mLashouHeadDic[@"name"]);
        } else {
            mTitle.text = deString(@"团长[%@]转移给", mLashouHeadDic[@"billName"] ? mLashouHeadDic[@"billName"] : mLashouHeadDic[@"name"]);
        }
        tableView.hidden = YES;
        dispatch_async(deMainQueue, ^{
            tableView.hidden = NO;
            [ycFunction pushView: mTableView view: tableView dur: .2 completion:^(BOOL b) {
                mTableView.delegate = nil;
                mTableView.dataSource = nil;
                [mTableView removeFromSuperview];
                mTableView = tableView;
                [weakSelf loadList];
            }];
        });
    }
}

-(void) loadList {
    [self loadList: nil];
}

-(void) loadList: (UITableView*)tableview {
    if (mLists) {
        [mLists release];
    }
    if ([mPageType isEqualToString: @"lashou"]) {
        mLists = [[tmanager.mRobot.mLashouHeads getAllLashouHeadMemberDetail:mLashouHeadDic[@"userid"] sortType: @"index"] retain];
    } else {
        mLists = [[tmanager.mRobot.mLashouHeads getAllLashouHeadDetail] retain];
    }
    [tableview ? tableview : mTableView reloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) setLashouHeadDic:(NSDictionary*)dic {
    if (mLashouHeadDic) {
        [mLashouHeadDic release];
        mLashouHeadDic = nil;
    }
    if (dic) {
        mLashouHeadDic = [dic retain];
    }
}

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    if ([mPageType isEqualToString: @"lashou"]) {
        return;
    }
    if ([mPageType isEqualToString: @"lashouHead"]) {
        [self setLashouHeadDic:  mLists[[indexPath row]]];
        [self setPageType: @"lashou"];
    }
    else if([mPageType isEqualToString: @"lashouHeadMove"]) {
        NSDictionary* destLashouHead = mLists[[indexPath row]];
        if ([destLashouHead[@"userid"] isEqualToString: mLashouHeadDic[@"userid"]]) {
            [ycFunction showMsg: @"不能转移给自己" msg: nil vc: self];
            return;
        }
        
        NSString* msg = deString(@"是否确定将团长[%@]下的所有拉手转移给团长[%@]", mLashouHeadDic[@"billName"] ? mLashouHeadDic[@"billName"] : mLashouHeadDic[@"name"], destLashouHead[@"billName"] ? destLashouHead[@"billName"] : destLashouHead[@"name"]);
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([tmanager.mRobot.mLashouHeads lashouHeadMove:mLashouHeadDic[@"userid"] destUserid:destLashouHead[@"userid"]]) {
                [ycFunction showMsg: @"转移成功!" msg: nil vc: weakSelf];
            } else {
                [ycFunction showMsg: @"转移失败!" msg: nil vc: weakSelf];
            }
            [weakSelf setLashouHeadDic: nil];
            [weakSelf setPageType: @"lashouHead"];
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    }
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
    if ([mPageType isEqualToString: @"lashou"]) {
        titleLabel.text = deString(@"成员(%d)", (int)[mLists count]);
    } else {
        titleLabel.text = deString(@"团长(%d)", (int)[mLists count]);
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
    
    if (dic[@"count"] && [mPageType isEqualToString: @"lashouHead"]) {
        [ycFunction cellAddRightText: cell text:deString(@"%@人", dic[@"count"]) color:[UIColor whiteColor] size:16 offset:20];
    }
    
    if ([mPageType isEqualToString: @"lashouHeadMove"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([mPageType isEqualToString: @"lashouHeadMove"]) {
        return @[];
    }
    
    __weak __typeof(&*self)weakSelf = self;
    UITableViewRowAction *btn1 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary* dic = mLists[[indexPath row]];
        if ([mPageType isEqualToString: @"lashou"]) {
            [tmanager.mRobot.mLashouHeads delLashou: mLashouHeadDic[@"userid"] lashou: dic[@"userid"]];
            [weakSelf loadList];
        } else if ([mPageType isEqualToString: @"lashouHead"]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定删除团长身份?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mLashouHeads delLashouHead: dic[@"userid"]];
                [weakSelf loadList];
            }]];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    if ([mPageType isEqualToString: @"lashou"]) {
        return @[btn1];
    }
    
    UITableViewRowAction *btn2 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"转移给" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf setLashouHeadDic:  mLists[[indexPath row]]];
        [weakSelf setPageType: @"lashouHeadMove"];
    }];
    btn2.backgroundColor = [UIColor colorWithRed:0 green:.7 blue:0 alpha:1];
    return @[btn1, btn2];
}

@end

