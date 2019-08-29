//
//  niuniuRobotGameViewController.m
//  wechatHook
//
//  Created by antion mac on 2016/12/9.
//
//

#import "niuniuRobotGameViewController.h"
#import "toolManager.h"
#import "niuniuRobotNormalView.h"
#import "niuniuRobotBetView.h"
#import "niuniuRobotResultView.h"
#import "ycFunction.h"
#import "niuniuSupportDragView.h"

static int infoh = 37;
static int btnh = 46;

@interface niuniuRobotGameViewController () {
    UIWindow* mWindows;
    NSTimer* mLabelUpdateTimer;
}
@end

@implementation niuniuRobotGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, 234, 395);
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: .8];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    self.mBgView = [[UIView alloc] initWithFrame: self.view.frame];
    self.mBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.mBgView];
    [self.mBgView release];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, infoh)];
    titleLabel.center = CGPointMake(self.view.frame.size.width/2, infoh/2);
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.text = tmanager.mRobot.mGameTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.mBgView addSubview:titleLabel];
    [titleLabel release];
    
    self.mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, infoh, self.view.frame.size.width, self.view.frame.size.height-infoh-btnh)];
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.mTableView setSeparatorColor: [UIColor yellowColor]];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.mBgView addSubview: self.mTableView];
    [self.mTableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"首页" func: ^() {
        weakSelf.mBackFunc();
    }];
    okBtn.center = CGPointMake(self.view.frame.size.width/3-8, infoh+self.mTableView.frame.size.height+btnh/2);
    [self.mBgView addSubview: okBtn];
    [okBtn release];
    
    ycButtonView* backBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"返回" func: ^() {
        if (tmanager.mRobot.mStatus == eNiuniuRobotStatusBet) {
            [tmanager.mRobot.mBet cancelBet];
            [weakSelf updateTableView: 2];
        }
        else if (tmanager.mRobot.mStatus == eNiuniuRobotStatusResult) {
            [tmanager.mRobot.mResult setIsAutoQueryHongbao:NO];
            [tmanager.mRobot changeStatus: eNiuniuRobotStatusBet];
            [weakSelf updateTableView: 2];
        }
        else {
            [ycFunction showMsg: @"已经到顶了" msg: nil vc: weakSelf];
        }
    }];
    backBtn.center = CGPointMake(self.view.frame.size.width/3*2+8, infoh+self.mTableView.frame.size.height+btnh/2);
    [self.mBgView addSubview: backBtn];
    [backBtn release];
    
    //支持拖动， 单击
    deSupportDrag(self.view, self.view.frame.size.height, infoh, niuniuSupportDragTypeDefault);
    
    //更新内容视图
    [self updateTableView: 0];
    mLabelUpdateTimer = nil;
}

-(void) dealloc {
    if (mLabelUpdateTimer) {
        [mLabelUpdateTimer invalidate];
        mLabelUpdateTimer = nil;
    }
    self.mTableView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//更新tableview
-(void) updateTableView: (int)aniType {    
    UITableView* tableView = nil;
    if (tmanager.mRobot.mStatus == eNiuniuRobotStatusNone) {
        niuniuRobotNormalView* view = [[niuniuRobotNormalView alloc] initWithFrame: self.mTableView.frame];
        view.mSuperViewVC = self;
        view.dataSource = view;
        view.delegate = view;
        tableView = view;
    }
    else if (tmanager.mRobot.mStatus == eNiuniuRobotStatusBet) {
        niuniuRobotBetView* view = [[niuniuRobotBetView alloc] initWithFrame: self.mTableView.frame];
        view.mSuperViewVC = self;
        view.dataSource = view;
        view.delegate = view;
        tableView = view;
    }
    else if (tmanager.mRobot.mStatus == eNiuniuRobotStatusResult) {
        niuniuRobotResultView* view = [[niuniuRobotResultView alloc] initWithFrame: self.mTableView.frame];
        view.mSuperViewVC = self;
        view.dataSource = view;
        view.delegate = view;
        tableView = view;
    }
    
    if (!tableView) {
        return;
    }
    
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorColor: [UIColor yellowColor]];
    [tableView reloadData];
    [self.mBgView addSubview: tableView];
    [tableView release];
    
    __weak __typeof(&*self)weakSelf = self;
    if (aniType == 1) {//push
        tableView.hidden = YES;
        dispatch_async(deMainQueue, ^{
            tableView.hidden = NO;
            [ycFunction pushView: weakSelf.mTableView view: tableView dur: .2 completion:^(BOOL b) {
                weakSelf.mTableView.delegate = nil;
                weakSelf.mTableView.dataSource = nil;
                [weakSelf.mTableView removeFromSuperview];
                weakSelf.mTableView = tableView;
            }];
        });
    } else if (aniType == 2) {//pop
        [self.mBgView bringSubviewToFront: weakSelf.mTableView];
        dispatch_async(deMainQueue, ^{
            [ycFunction popView: tableView view: weakSelf.mTableView dur: .2 completion:^(BOOL b) {
                weakSelf.mTableView.delegate = nil;
                weakSelf.mTableView.dataSource = nil;
                [weakSelf.mTableView removeFromSuperview];
                weakSelf.mTableView = tableView;
            }];
        });
    } else if(aniType == 3) {
        [UIView transitionFromView: weakSelf.mTableView toView: tableView duration: 1 options:UIViewAnimationOptionTransitionCurlUp completion: ^(BOOL b) {
            if (b) {
                weakSelf.mTableView.delegate = nil;
                weakSelf.mTableView.dataSource = nil;
                [weakSelf.mTableView removeFromSuperview];
                weakSelf.mTableView = tableView;
            }
        }];
    } else if(aniType == 4) {
        [UIView transitionFromView: weakSelf.mTableView toView: tableView duration: 1 options:UIViewAnimationOptionTransitionCurlDown completion: ^(BOOL b) {
            if (b) {
                weakSelf.mTableView.delegate = nil;
                weakSelf.mTableView.dataSource = nil;
                [weakSelf.mTableView removeFromSuperview];
                weakSelf.mTableView = tableView;
            }
        }];
    }
    else {
        weakSelf.mTableView.delegate = nil;
        weakSelf.mTableView.dataSource = nil;
        [weakSelf.mTableView removeFromSuperview];
        weakSelf.mTableView = tableView;
    }
}


@end
