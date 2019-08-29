//
//  niuniuRobotFuliBankerSettingView.m
//  wechatHook
//
//  Created by antion on 2017/11/28.
//
//

#import "niuniuRobotFuliBankerSettingView.h"
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

@implementation niuniuRobotFuliBankerSettingView {
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
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
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, infoh)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"福利庄设置";
        title.textColor = [UIColor yellowColor];
        [self addSubview: title];
        [title release];
        
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
    self.mBackFunc = nil;
    [super dealloc];
}

-(void) loadConfig {
    [mTableViewConfigs removeAllObjects];
    
    NSMutableArray* titles = [NSMutableArray array];
    NSMutableArray* rows = [NSMutableArray array];
    
    [titles addObject:
        @[@"基本", @30]
     ];
    
    if (!tmanager.mRobot.mBet.mFuliSetting[@"enable"] || ![tmanager.mRobot.mBet.mFuliSetting[@"enable"] isEqualToString: @"true"]) {
        [rows addObject:@[
                          @[@0, @"是否开启", @"enable", @"是否设置本局为福利庄"]
                          ]];
    }

    if (tmanager.mRobot.mBet.mFuliSetting[@"enable"] && [tmanager.mRobot.mBet.mFuliSetting[@"enable"] isEqualToString: @"true"]) {
        [rows addObject:@[
                          @[@0, @"是否开启", @"enable", @"是否设置本局为福利庄"],
                          @[@0, @"统一成牛牛押注", @"allNiuniu", @"若开启的话, 玩家压大小单双、特码、百家乐都会自动变成押注金额为十分之一的牛牛下注，若关闭的话则保持玩家的玩法不变， 福利庄结算大小单双、特码、百家乐的方式为：买中有效，没买中不赔。"],
                          @[@2, @"积分低于多少无效", @"minScore", @"如果玩家积分低于设置的数字，则不能参与福利庄"]
                          ]];
        
        [titles addObject:
            @[@"规则", @30]
         ];
        
        [rows addObject: @[
                                     @[@1, @"固定押注", @"fixed", @"将所有玩家押注值统一设成‘福利值’"],
                                     @[@1, @"上限押注", @"limit", @"以‘福利值’为上限，玩家押注低于‘福利值’则认玩家本来押注，超过这个‘福利值’则认‘福利值’为押注。"],
                                     @[@1, @"分段押注", @"section", @"可按照玩家押注区间设置多个‘福利值’"],
                                     ]];
        
        [titles addObject:
            @[@"福利值", @30]
         ];
        
        NSMutableArray* array = [NSMutableArray array];
        [array addObject:
            @[@2, @"默认", @"value", @"输入默认福利值"]
        ];
        if ([tmanager.mRobot.mBet.mFuliSetting[@"type"] isEqualToString: @"section"]) {
            int i = 0;
            for (NSString* str in tmanager.mRobot.mBet.mFuliSetting[@"sections"]) {
                [array addObject:
                 @[@2, deString(@"押注区间%d", i+1), @"setSection", @"输入押注区间，如输入‘50-100-80’, 则代表玩家押注50~100的，统一都设成80, 如果玩家押注不在所有的区间以内，则认默认值!", deInt2String(i), str]
                 ];
                ++i;
            }
            [array addObject:
                @[@3, @"添加区间", @"addSections", @"添加一个押注区间，如输入‘50-100-80’, 则代表玩家押注50~100的，统一都设成80, 如果玩家押注不在所有的区间以内，则认默认值!"]
             ];
        }
        [rows addObject: array];
    }
    
    mTableViewConfigs[@"titles"] = titles;
    mTableViewConfigs[@"rows"] = rows;
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
    
    tmanager.mRobot.mBet.mFuliSetting[key] = s.isOn ? @"true" : @"false";

    if ([key isEqualToString: @"enable"]) {
        if (!tmanager.mRobot.mBet.mFuliSetting[@"type"]) {
            tmanager.mRobot.mBet.mFuliSetting[@"type"] = @"fixed";
        }
        if (!tmanager.mRobot.mBet.mFuliSetting[@"allNiuniu"]) {
            tmanager.mRobot.mBet.mFuliSetting[@"allNiuniu"] = @"true";
        }
        if (!tmanager.mRobot.mBet.mFuliSetting[@"value"]) {
            tmanager.mRobot.mBet.mFuliSetting[@"value"] = @"66";
        }
        if (!tmanager.mRobot.mBet.mFuliSetting[@"minScore"]) {
            tmanager.mRobot.mBet.mFuliSetting[@"minScore"] = @"0";
        }
    }
    
    NSString* text = nil;
    if ([array count] > 3) {
        text = array[3];
    }
    text = text ? text : @"";
    text = deString(@"%@\n%@", s.isOn ? @"✅已开启✅" : @"❌已关闭❌", text);
    [ycFunction showMsg:array[1] msg:text vc:self.mSuperViewVC];
    [self loadConfig];
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
    
    NSString* text = nil;
    if ([array count] > 3) {
        text = array[3];
    }
    text = text ? text : @"";
    text = deString(@"%@", text);

    NSString* key = array[2];
    if (1 == section) {
        tmanager.mRobot.mBet.mFuliSetting[@"type"] = key;
        if ([key isEqualToString: @"section"]) {
            tmanager.mRobot.mBet.mFuliSetting[@"sections"] = [NSMutableArray array];
        }
        [ycFunction showMsg:array[1] msg:text vc:self.mSuperViewVC];
        [self loadConfig];
    }
    else {
        __weak __typeof(&*self)weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"提示" message:text preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField* textField = alertController.textFields.firstObject;
            if ([key isEqualToString: @"value"] || [key isEqualToString: @"minScore"]) {
                if ([ycFunction isInt: textField.text]) {
                    tmanager.mRobot.mBet.mFuliSetting[key] = textField.text;
                    [weakSelf loadConfig];
                } else {
                    [ycFunction showMsg: @"格式错误" msg: nil vc:weakSelf.mSuperViewVC];
                }
            } else {
                NSArray* textArray = [textField.text componentsSeparatedByString: @"-"];
                if ([textArray count] != 3 || ![ycFunction isInt: textArray[0]] || ![ycFunction isInt: textArray[1]] || ![ycFunction isInt: textArray[2]]) {
                    [ycFunction showMsg: @"格式错误" msg: nil vc: weakSelf.mSuperViewVC];
                } else {
                    if ([key isEqualToString: @"setSection"]) {
                        int i = [array[4] intValue];
                        tmanager.mRobot.mBet.mFuliSetting[@"sections"][i] = textField.text;
                    } else {
                        [tmanager.mRobot.mBet.mFuliSetting[@"sections"] addObject: textField.text];
                    }
                    [weakSelf loadConfig];
                }
            }
            
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if ([key isEqualToString: @"value"]) {
                textField.text = tmanager.mRobot.mBet.mFuliSetting[key];
            }
            else if([key isEqualToString: @"setSection"]) {
                textField.text = array[5];
            }
        }];
        [self.mSuperViewVC presentViewController:alertController  animated:YES completion:nil];
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
        [switchview setOn: tmanager.mRobot.mBet.mFuliSetting[key] && [tmanager.mRobot.mBet.mFuliSetting[key] isEqualToString: @"true"]];
        cell.accessoryView = switchview;
    }
    else if(1 == celltype) {
        if ([tmanager.mRobot.mBet.mFuliSetting[@"type"] isEqualToString: key]) {
            cell.tintColor = [UIColor yellowColor];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    else if(2 == celltype) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* rightText = @"";
        int size = 18;
        if ([key isEqualToString: @"setSection"]) {
            rightText = arr[5];
            size = 16;
        } else {
            rightText = tmanager.mRobot.mBet.mFuliSetting[key];
        }
        UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
        [ycFunction cellAddRightText: cell text: rightText color: rightTextColor size: size offset:0];
    }
    else if(3 == celltype) {
        if ([key isEqualToString: @"addSections"]) {
            titleColor = [UIColor greenColor];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self)weakSelf = self;
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* array = mTableViewConfigs[@"rows"][section][row];
    if([array[2] isEqualToString: @"setSection"]) {
        UITableViewRowAction *btn2 = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            int i = [array[4] intValue];
            [tmanager.mRobot.mBet.mFuliSetting[@"sections"] removeObjectAtIndex: i];
            [weakSelf loadConfig];
        }];
        return @[btn2];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* array = mTableViewConfigs[@"rows"][section][row];
    return [array[2] isEqualToString: @"setSection"];
}


@end

