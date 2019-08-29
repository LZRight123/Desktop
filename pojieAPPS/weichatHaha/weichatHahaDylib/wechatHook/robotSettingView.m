//
//  robotSettingView.m
//  wechatHook
//
//  Created by antion on 2017/10/20.
//
//

#import "robotSettingView.h"
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

@implementation robotSettingView {
    UITableView* mTableView;
    NSMutableDictionary* mTableViewConfigs;
    NSString* mSettingType;
    UIWindow* mPreviewWindows;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id) initWithType:(CGRect)frame type:(NSString*)type {
    if (self = [super initWithFrame: frame]) {
        mSettingType = [type retain];
        
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
        
        if ([type isEqualToString: @"bill"]) {
            okBtn.center = CGPointMake(self.frame.size.width/3-8, infoh+mTableView.frame.size.height+btnh/2);

            ycButtonView* previewBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 60, 30) text: @"预览" func: ^() {
                [weakSelf perview];
            }];
            previewBtn.center = CGPointMake(self.frame.size.width/3*2+8, infoh+mTableView.frame.size.height+btnh/2);
            [self addSubview: previewBtn];
            [previewBtn release];
        }
        
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
    [mSettingType release];
    self.mBackFunc = nil;
    [super dealloc];
}

-(void) loadConfig {
    [mTableViewConfigs removeAllObjects];

    if ([mSettingType isEqualToString: @"general"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"庄", @30],
                                         @[@"牌型", @30],
                                         @[@"抢包", @30],
                                         @[@"管理命令", @30],
                                         @[@"托命令", @30],
                                         @[@"拉手命令", @30],
                                         @[@"拉手团长命令", @30],
                                         @[@"玩家命令", @30],
                                         @[@"进群检测", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
         @[
             @[@0, @"自动添加会员", @"autoAddMember", @"若开启的话，机器人会一直扫描所有群里的玩家, 并把所有玩家添加成会员。"],
             @[@1, @"超时秒数", @"overtime", @"输入玩家抢红包的超时秒数, 如玩家抢红包的时间跟头包时间相差秒数大于等于这个秒数， 则判定为超时。"],
             @[@1, @"玩家红包费抽取", @"everyPlayerHongbaoFee", @"输入每个玩家的红包费用，如输入‘2’， 则每局结算后额外抽取2积分。"],
             @[@0, @"盈利才抽红包费", @"everyPlayerHongbaoFeeWin", @"若开启的话，只有当玩家盈利的时候才抽取红包费, 若关闭的话，则无论输赢都抽取红包费。"],
             @[@0, @"头包快2秒认第2", @"headQuickAs2", @"若开启的话, 如果头包跟第二包时间差两秒或以上， 则认第二包的时间当头包时间， 头包点数还是认头包的点数。"],
             ],
         @[
             @[@0, @"庄无包尾2(100内)", @"banerAsLast2", @"若开启的话，当本局玩家在100以内，含100，如果庄无包的时候，则认尾巴倒数第二包。"],
             @[@0, @"庄无包尾2(100上)", @"banerAsLast2For100", @"若开启的话，当本局玩家在100以上, 不含100，如果庄无包的时候，则认尾巴倒数第二包。"],
             @[@1, @"庄平赔倍数", @"bankerHeadPow", @"输入庄家平赔赔的倍数。"],
             @[@1, @"上庄抽水比例", @"ratio", @"输入庄家上庄抽水的比例, 如输入“0.03”, 则抽取庄费的3%。"],
             @[@1, @"庄限押注比例", @"betLimit", @"输入闲家最大押注比例, 如输入“0.03”, 则最大只能压庄费的3%，且仅限于喝水牛牛模式。"],
             @[@1, @"庄赢抽水比例", @"bankerWinRatio", @"输入庄家盈利的抽水比例, 如输入“0.03”, 则抽取盈利的3%。"],
             @[@1, @"红包费用", @"hongbaoFee", @"输入每局需要从庄费里面抽取的红包费用，账单里面有显示。"],
             @[@1, @"奖池费用", @"bonusPoolFee", @"输入每局需要从庄费里面抽取的奖池费用，费用会叠加到奖池，账单里面有显示。"],
             @[@1, @"其他费用", @"heiFee", @"输入每局需要从庄费里面额外抽取的费用，账单里面不显示。"],
             ],
         
         @[
             @[@0, @"0开头才对子", @"0duizi", @"若开启的话, 如0.22是对子，3.22算牛7，若关闭的话，如0.22和3.22都算对子。"],
             @[@0, @"012算顺子", @"012shunzi", @"若开启的话，0.12算顺子，若关闭的话，0.12算牛3。"],
             @[@0, @"210算倒顺", @"210daoshun", @"若开启的话，2.10算倒顺，若关闭的话，2.10算牛3。"],
             ],
         
         @[
             @[@1, @"抢闲包扣分", @"robPlayer", @"输入闲家被抢的时候，抢包者自动扣多少福利。"],
             @[@1, @"闲被抢补分", @"robPlayerAdd", @"输入闲家被抢的时候，被抢者自动补多少福利。"],
             @[@1, @"抢庄包扣分", @"robBanker", @"输入庄家被抢的时候，抢包者自动扣多少福利。"],
             @[@1, @"庄被抢补分", @"robBankerAdd", @"输入庄家被抢的时候，被抢的庄自动补多少福利。"],
             @[@0, @"被抢包输才补分", @"robAddMustLost", @"若开启的话，当闲家包被抢，只有被抢者当局输才有加福利。"],
             ],
         
         @[
             @[@0, @"上分显示群累计", @"upScoreCountShow", @"若开启的话，每次有上下分都会在底部多显示一个今日本群的上、下分累计。"],
             @[@0, @"查统计显示牛牛", @"showNiuniuCount", @"若开启的话，'查统计'命令会显示牛牛统计。"],
             @[@0, @"查统计显示金牛", @"showJinniuCount", @"若开启的话，'查统计'命令会显示金牛统计。"],
             @[@0, @"查统计显示对子", @"showDuiziCount", @"若开启的话，'查统计'命令会显示对子统计。"],
             @[@0, @"查统计显示顺子", @"showShunziCount", @"若开启的话，'查统计'命令会显示顺子统计。"],
             @[@0, @"查统计显示倒顺", @"showDaoshunCount", @"若开启的话，'查统计'命令会显示倒顺统计。"],
             @[@0, @"查统计显示满牛", @"showManniuCount", @"若开启的话，'查统计'命令会显示满牛统计。"],
             @[@0, @"查统计显示豹子", @"showBaoziCount", @"若开启的话，'查统计'命令会显示包子统计。"],
             ],
         
         @[
             @[@1, @"托低于多少能补", @"tuoAddScoreStart", @"输入当托低于多少分的时候，才能自助上分。"],
             @[@1, @"托补分下限", @"tuoAddScoreMin", @"输入托自助上分的最低分数限制。"],
             @[@1, @"托补分上限", @"tuoAddScoreMax", @"输入托自动上分的最高分数限制。"],
             ],
         
         @[
             
             @[@0, @"拉手可用搜", @"allowLashouSou", @"若开启的话，拉手在后台群用搜可以搜索到名片，若关闭的话则不能。"],
             @[@0, @"拉手用搜可添加", @"allowLashouSouAdd", @"若开启的话，拉手在后台群用搜的方式，然后打‘添加拉手成员’可以成功添加到自己名下，若关闭的话则只允许用推名片。"],
             @[@0, @"拉手用搜显归属", @"allowLashouShowFrom", @"若开启的话，拉手在后台群用搜的方式，可以显示该名片玩家归属于哪个拉手, 如果该名片是一个拉手, 则还可以显示归属于哪个团长名下，若关闭的话则不显示归属。"],
             @[@0, @"推名片自动添加", @"allowLashouCardAutoAdd", @"若开启的话，拉手在后台群推名片自动添加成员到拉手名下，若这个拉手同时也是团长的话，不能自动添加，需要在推名片之后打‘添加拉手成员’。"],
             ],
         
         @[
             @[@0, @"团长可用搜", @"allowLashouHeadSou", @"若开启的话，拉手团长在后台群用搜可以搜索到名片，若关闭的话则不能。"],
             @[@0, @"团长用搜可添加", @"allowLashouHeadSouAdd", @"若开启的话，拉手团长在后台群用搜的方式，然后打‘添加团长成员’可以成功添加到自己名下，若关闭的话则只允许用推名片。"],
             @[@0, @"团长用搜显归属", @"allowLashouHeadShowFrom", @"若开启的话，团长在后台群用搜的方式，可以显示该名片玩家归属于哪个拉手, 如果该名片是一个拉手, 则还可以显示归属于哪个团长名下，若关闭的话则不显示归属。"],
             ],
         
         @[
             @[@1, @"查询间隔(秒)", @"playerCmdQuerySpace", @"输入允许玩家自助查询的间隔时间。"],
             @[@0, @"查积分", @"playerCmdEnableScore", @"若开启的话， 玩家私聊机器人， 发送‘查积分’, 机器人会自动回复相关信息"],
             @[@0, @"查上下分", @"playerCmdEnableScoreChanged", @"若开启的话， 玩家私聊机器人， 发送‘查上下分’, 机器人会自动回复相关信息"],
             @[@0, @"查统计", @"playerCmdEnableCount", @"若开启的话， 玩家私聊机器人， 发送‘查统计’, 机器人会自动回复相关信息"],
             @[@0, @"查领包", @"playerCmdEnablePackages", @"若开启的话， 玩家私聊机器人， 发送‘查领包’, 机器人会自动回复相关信息"],
             ],
         
         @[
             @[@0, @"是否开启", @"chatroomIntiveCheck", @"若开启的话，机器将会自动检测谁拉谁进群的信息、观战信息、无分抢包名单，并且每局结束的时候会自动发送到主后台群。"],
             @[@0, @"进群提示", @"chatroomEnterHint", @"若开启的话，每当前台有玩家进群， 会自动将信息发送到主后台群。"],
             @[@1, @"显示观战局数", @"chatroomAllowLook", @"输入允许观战的局数。"],
             @[@1, @"显示最近抢包", @"chatroomRobRound", @"输入要显示几把内无分抢包的玩家列表"],
             @[@1, @"显示最近上分", @"chatroomNewScoreChange", @"输入要显示最近几局以内的上分"],
             ],
         ];
    } else if ([mSettingType isEqualToString: @"niuniu"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"列表", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@0, @"玩法开启", @"supportNiuniu", @"若开启的话，将支持识别玩家的牛牛下注。"],
                                           @[@5, @"基本设置", @"base"],
                                           @[@5, @"喝水模式", @"heshui"],
                                           @[@5, @"免佣模式", @"mianyong"],
                                           @[@5, @"一比模式", @"yibi"],
                                           ],
                                       ];
        
    } else if ([mSettingType isEqualToString: @"niuniuBase"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
               @[@"基本", @30],
               @[@"闲赢倍数", @30],
               @[@"庄赢倍数", @30],
               @[@"梭哈闲赢倍数", @30],
               @[@"梭哈庄赢倍数", @30],
               @[@"支持牌型", @30],
               ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
          @[
              @[@0, @"001跑路", @"has001", @"若开启的话，闲家抓到0.01的金额则无输赢，若关闭的话，0.01则是牛1。"],
              @[@0, @"超时大平小赔", @"overtimeIsCompare", @"若开启的话，当闲家超时，比牌如果比庄大则无输赢，比牌比庄小则输。反之庄家超时的话，庄家比闲家大则无输赢，比闲家小则输。"],
              @[@0, @"同金额闲赢", @"sameMoneyPlayerWin", @"若开启的话，闲家和庄家抓到一样金额的红包，则闲家赢。"],
              @[@0, @"正顺倒顺比金额", @"shunziDaoshunCompareAmount", @"若开启的话，正顺和倒顺的比牌规则是金额大的赢，比如4.32跟1.23比牌， 是4.32赢。若关闭的话则所有正顺都大于倒顺。"],
              @[@0, @"倒顺比正顺大", @"daoshunBiShunziDa", @"若开启的话，倒顺比正顺大, 若关闭的话，正顺比倒顺大。"],
              @[@1, @"牛几起比金额", @"startComparePow", @"输入闲家和庄同点的话牛几开始比金额，比如输入5，则当庄闲同点的时候，牛1~牛4是庄家赢，牛5以上金额大的一方赢。"],
              @[@1, @"牛几以下大平小赔", @"daPingXiaoPeiPow", @"输入闲家和庄同点的话牛几以下大平小赔，比如输入5, 则当庄闲同点的时候， 牛1~牛5， 如果闲大于庄则无输赢, 如果闲小于庄则输。"],
              @[@1, @"牛几以下认输", @"admitDefeatPow", @"输入闲家牛几以下直接认输，比如输入2, 则当闲抓到牛1～牛2的时候直接认输。"],
              @[@1, @"牛几以下不抽水", @"normalNiuniuRatioUnder", @"输入闲家牛几以下不抽水，比如输入8, 则当闲抓到牛1～牛8的时候不抽水, 牛牛为10， 金牛为11， 对子为12， 倒顺13， 正顺14， 满牛15， 豹子18。"],
              @[@1, @"牛几以下不抽水(梭哈)", @"normalNiuniuRatioUnderForSuoha", @"输入闲家牛几以下不抽水，比如输入8, 则当闲抓到牛1～牛8的时候不抽水, 牛牛为10， 金牛为11， 对子为12， 倒顺13， 正顺14， 满牛15， 豹子18。"],
              
              @[@1, @"闲赢抽水比例", @"playerWinRatio", @"输入闲家盈利的抽水比例，如输入“0.003”, 则抽取闲家盈利部分的3%，仅限于牛牛下注玩法。"],
              @[@1, @"最低下注", @"minBet", @"输入闲家牛牛下注的最低限额，仅限于不喝水模式。"],
              @[@1, @"最高下注", @"maxBet", @"输入闲家牛牛下注的最高限额，仅限于不喝水模式。"],
              @[@1, @"闲赢抽水(梭哈)", @"playerWinRatioSuoha", @"输入闲家盈利的抽水比例，如输入“0.003”, 则抽取闲家盈利部分的3%，仅限于牛牛梭哈玩法。"],
              @[@1, @"最低下注(梭哈)", @"minBetSuoha", @"输入闲家牛牛梭哈的最低限额，仅限于不喝水模式。"],
              @[@1, @"最高下注(梭哈)", @"maxBetSuoha", @"输入闲家牛牛梭哈的最高限额，仅限于不喝水模式。"],
              ],
          
          @[
              @[@1, @"牛1", @"powNiu1", @"输入闲赢牛1的倍数。"],
              @[@1, @"牛2", @"powNiu2", @"输入闲赢牛2的倍数。"],
              @[@1, @"牛3", @"powNiu3", @"输入闲赢牛3的倍数。"],
              @[@1, @"牛4", @"powNiu4", @"输入闲赢牛4的倍数。"],
              @[@1, @"牛5", @"powNiu5", @"输入闲赢牛5的倍数。"],
              @[@1, @"牛6", @"powNiu6", @"输入闲赢牛6的倍数。"],
              @[@1, @"牛7", @"powNiu7", @"输入闲赢牛7的倍数。"],
              @[@1, @"牛8", @"powNiu8", @"输入闲赢牛8的倍数。"],
              @[@1, @"牛9", @"powNiu9", @"输入闲赢牛9的倍数。"],
              @[@1, @"牛牛", @"powNiu10", @"输入闲赢牛牛的倍数。"],
              @[@1, @"金牛", @"powJinniu", @"输入闲赢金牛的倍数。"],
              @[@1, @"对子", @"powDuizi", @"输入闲赢对子的倍数。"],
              @[@1, @"倒顺", @"powDaoshun", @"输入闲赢倒顺的倍数。"],
              @[@1, @"正顺", @"powShunzi", @"输入闲赢正顺的倍数。"],
              @[@1, @"满牛", @"powManniu", @"输入闲赢满牛的倍数。"],
              @[@1, @"豹子", @"powBaozi", @"输入闲赢豹子的倍数。"],
              ],
          
          @[
              @[@1, @"牛1", @"powBankerNiu1", @"输入庄赢牛1的倍数。"],
              @[@1, @"牛2", @"powBankerNiu2", @"输入庄赢牛2的倍数。"],
              @[@1, @"牛3", @"powBankerNiu3", @"输入庄赢牛3的倍数。"],
              @[@1, @"牛4", @"powBankerNiu4", @"输入庄赢牛4的倍数。"],
              @[@1, @"牛5", @"powBankerNiu5", @"输入庄赢牛5的倍数。"],
              @[@1, @"牛6", @"powBankerNiu6", @"输入庄赢牛6的倍数。"],
              @[@1, @"牛7", @"powBankerNiu7", @"输入庄赢牛7的倍数。"],
              @[@1, @"牛8", @"powBankerNiu8", @"输入庄赢牛8的倍数。"],
              @[@1, @"牛9", @"powBankerNiu9", @"输入庄赢牛9的倍数。"],
              @[@1, @"牛牛", @"powBankerNiu10", @"输入庄赢牛牛的倍数。"],
              @[@1, @"金牛", @"powBankerJinniu", @"输入庄赢金牛的倍数。"],
              @[@1, @"对子", @"powBankerDuizi", @"输入庄赢对子的倍数。"],
              @[@1, @"倒顺", @"powBankerDaoshun", @"输入庄赢倒顺的倍数。"],
              @[@1, @"正顺", @"powBankerShunzi", @"输入庄赢正顺的倍数。"],
              @[@1, @"满牛", @"powBankerManniu", @"输入庄赢满牛的倍数。"],
              @[@1, @"豹子", @"powBankerBaozi", @"输入庄赢豹子的倍数。"],
              ],
          
          @[
              @[@1, @"牛1", @"powSuohaNiu1", @"输入梭哈闲赢牛1的倍数。"],
              @[@1, @"牛2", @"powSuohaNiu2", @"输入梭哈闲赢牛2的倍数。"],
              @[@1, @"牛3", @"powSuohaNiu3", @"输入梭哈闲赢牛3的倍数。"],
              @[@1, @"牛4", @"powSuohaNiu4", @"输入梭哈闲赢牛4的倍数。"],
              @[@1, @"牛5", @"powSuohaNiu5", @"输入梭哈闲赢牛5的倍数。"],
              @[@1, @"牛6", @"powSuohaNiu6", @"输入梭哈闲赢牛6的倍数。"],
              @[@1, @"牛7", @"powSuohaNiu7", @"输入梭哈闲赢牛7的倍数。"],
              @[@1, @"牛8", @"powSuohaNiu8", @"输入梭哈闲赢牛8的倍数。"],
              @[@1, @"牛9", @"powSuohaNiu9", @"输入梭哈闲赢牛9的倍数。"],
              @[@1, @"牛牛", @"powSuohaNiu10", @"输入梭哈闲赢牛牛的倍数。"],
              @[@1, @"金牛", @"powSuohaJinniu", @"输入梭哈闲赢金牛的倍数。"],
              @[@1, @"对子", @"powSuohaDuizi", @"输入梭哈闲赢对子的倍数。"],
              @[@1, @"倒顺", @"powSuohaDaoshun", @"输入梭哈闲赢倒顺的倍数。"],
              @[@1, @"正顺", @"powSuohaShunzi", @"输入梭哈闲赢正顺的倍数。"],
              @[@1, @"满牛", @"powSuohaManniu", @"输入梭哈闲赢满牛的倍数。"],
              @[@1, @"豹子", @"powSuohaBaozi", @"输入梭哈闲赢豹子的倍数。"],
              ],
          
          @[
              @[@1, @"牛1", @"powSuohaBankerNiu1", @"输入梭哈庄赢牛1的倍数。"],
              @[@1, @"牛2", @"powSuohaBankerNiu2", @"输入梭哈庄赢牛2的倍数。"],
              @[@1, @"牛3", @"powSuohaBankerNiu3", @"输入梭哈庄赢牛3的倍数。"],
              @[@1, @"牛4", @"powSuohaBankerNiu4", @"输入梭哈庄赢牛4的倍数。"],
              @[@1, @"牛5", @"powSuohaBankerNiu5", @"输入梭哈庄赢牛5的倍数。"],
              @[@1, @"牛6", @"powSuohaBankerNiu6", @"输入梭哈庄赢牛6的倍数。"],
              @[@1, @"牛7", @"powSuohaBankerNiu7", @"输入梭哈庄赢牛7的倍数。"],
              @[@1, @"牛8", @"powSuohaBankerNiu8", @"输入梭哈庄赢牛8的倍数。"],
              @[@1, @"牛9", @"powSuohaBankerNiu9", @"输入梭哈庄赢牛9的倍数。"],
              @[@1, @"牛牛", @"powSuohaBankerNiu10", @"输入梭哈庄赢牛牛的倍数。"],
              @[@1, @"金牛", @"powSuohaBankerJinniu", @"输入梭哈庄赢金牛的倍数。"],
              @[@1, @"对子", @"powSuohaBankerDuizi", @"输入梭哈庄赢对子的倍数。"],
              @[@1, @"倒顺", @"powSuohaBankerDaoshun", @"输入梭哈庄赢倒顺的倍数。"],
              @[@1, @"正顺", @"powSuohaBankerShunzi", @"输入梭哈庄赢正顺的倍数。"],
              @[@1, @"满牛", @"powSuohaBankerManniu", @"输入梭哈庄赢满牛的倍数。"],
              @[@1, @"豹子", @"powSuohaBankerBaozi", @"输入梭哈庄赢豹子的倍数。"],
              ],
          
          @[
              @[@0, @"金牛", @"powEnableJinniu", @"若开启的话，则开放金牛牌型，若关闭的话，如0.10当作牛1。"],
              @[@0, @"对子", @"powEnableDuizi", @"若开启的话，则开放对子牌型，若关闭的话，如0.99当作牛8。"],
              @[@0, @"倒顺", @"powEnableDaoshun", @"若开启的话，则开放倒顺牌型，若关闭的话，如4.32当作牛9。"],
              @[@0, @"正顺", @"powEnableShunzi", @"若开启的话，则开放正顺牌型，若关闭的话，如1.23当作牛6。"],
              @[@0, @"满牛", @"powEnableManniu", @"若开启的话，则开放满牛牌型，若关闭的话，如2.00当作牛2。"],
              @[@0, @"豹子", @"powEnableBaozi", @"若开启的话，则开放豹子牌型，若关闭的话，如3.33当作牛9。"],
              ],
          ];
    } else if ([mSettingType isEqualToString: @"niuniuHeshui"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"喝水补贴", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@0, @"喝水模式开启", @"isHeshuiMode", @"若开启的话，是喝水群模式，若关闭的话是不喝水群。"],
                                           ],

                                       @[
                                           @[@1, @"牛1补贴", @"heshuiSubsidyNiu1", @"输入喝水模式下，且当闲家抓到牛1喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛2补贴", @"heshuiSubsidyNiu2", @"输入喝水模式下，且当闲家抓到牛2喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛3补贴", @"heshuiSubsidyNiu3", @"输入喝水模式下，且当闲家抓到牛3喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛4补贴", @"heshuiSubsidyNiu4", @"输入喝水模式下，且当闲家抓到牛4喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛5补贴", @"heshuiSubsidyNiu5", @"输入喝水模式下，且当闲家抓到牛5喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛6补贴", @"heshuiSubsidyNiu6", @"输入喝水模式下，且当闲家抓到牛6喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛7补贴", @"heshuiSubsidyNiu7", @"输入喝水模式下，且当闲家抓到牛7喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛8补贴", @"heshuiSubsidyNiu8", @"输入喝水模式下，且当闲家抓到牛8喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛9补贴", @"heshuiSubsidyNiu9", @"输入喝水模式下，且当闲家抓到牛9喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"牛牛补贴", @"heshuiSubsidyNiu10", @"输入喝水模式下，且当闲家抓到牛牛喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"金牛补贴", @"heshuiSubsidyJinniu", @"输入喝水模式下，且当闲家抓到金牛喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"对子补贴", @"heshuiSubsidyDuizi", @"输入喝水模式下，且当闲家抓到对子喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"倒顺补贴", @"heshuiSubsidyDaoshun", @"输入喝水模式下，且当闲家抓到倒顺喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"顺子补贴", @"heshuiSubsidyShunzi", @"输入喝水模式下，且当闲家抓到正顺喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"满牛补贴", @"heshuiSubsidyManniu", @"输入喝水模式下，且当闲家抓到满牛喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           @[@1, @"豹子补贴", @"heshuiSubsidyBaozi", @"输入喝水模式下，且当闲家抓到豹子喝水的时候，闲家的补贴比例，如输入0.3，则补贴闲家本应盈利部分的30%。"],
                                           ],
                                       ];
        
    } else if ([mSettingType isEqualToString: @"niuniuMianyong"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"闲赢倍数", @30],
                                         @[@"庄赢倍数", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[

                                       @[
                                           @[@0, @"免佣模式开启", @"supportMianyong", @"若开启的话，将支持免佣模式。下注格式： ‘免300’或‘300免’"],
                                           @[@1, @"牛几起比金额", @"startComparePowForMianyong", @"输入闲家和庄同点的话牛几开始比金额，比如输入5，则当庄闲同点的时候，牛1~牛4是庄家赢，牛5以上金额大的一方赢。"],
                                           @[@1, @"牛几以下大平小赔", @"daPingXiaoPeiPowForMianyong", @"输入闲家和庄同点的话牛几以下大平小赔，比如输入5, 则当庄闲同点的时候， 牛1~牛5， 如果闲大于庄则无输赢, 如果闲小于庄则输。"],
                                           @[@1, @"牛几以下认输", @"admitDefeatPowForMianyong", @"输入闲家牛几以下直接认输，比如输入2, 则当闲抓到牛1～牛2的时候直接认输。"],
                                           ],
 
                                       @[
                                           @[@1, @"牛1", @"powMianyongNiu1", @"输入闲赢牛1的倍数。"],
                                           @[@1, @"牛2", @"powMianyongNiu2", @"输入闲赢牛2的倍数。"],
                                           @[@1, @"牛3", @"powMianyongNiu3", @"输入闲赢牛3的倍数。"],
                                           @[@1, @"牛4", @"powMianyongNiu4", @"输入闲赢牛4的倍数。"],
                                           @[@1, @"牛5", @"powMianyongNiu5", @"输入闲赢牛5的倍数。"],
                                           @[@1, @"牛6", @"powMianyongNiu6", @"输入闲赢牛6的倍数。"],
                                           @[@1, @"牛7", @"powMianyongNiu7", @"输入闲赢牛7的倍数。"],
                                           @[@1, @"牛8", @"powMianyongNiu8", @"输入闲赢牛8的倍数。"],
                                           @[@1, @"牛9", @"powMianyongNiu9", @"输入闲赢牛9的倍数。"],
                                           @[@1, @"牛牛", @"powMianyongNiu10", @"输入闲赢牛牛的倍数。"],
                                           @[@1, @"金牛", @"powMianyongJinniu", @"输入闲赢金牛的倍数。"],
                                           @[@1, @"对子", @"powMianyongDuizi", @"输入闲赢对子的倍数。"],
                                           @[@1, @"倒顺", @"powMianyongDaoshun", @"输入闲赢倒顺的倍数。"],
                                           @[@1, @"正顺", @"powMianyongShunzi", @"输入闲赢正顺的倍数。"],
                                           @[@1, @"满牛", @"powMianyongManniu", @"输入闲赢满牛的倍数。"],
                                           @[@1, @"豹子", @"powMianyongBaozi", @"输入闲赢豹子的倍数。"],
                                           ],
                                       
                                       @[
                                           @[@1, @"牛1", @"powMianyongBankerNiu1", @"输入庄赢牛1的倍数。"],
                                           @[@1, @"牛2", @"powMianyongBankerNiu2", @"输入庄赢牛2的倍数。"],
                                           @[@1, @"牛3", @"powMianyongBankerNiu3", @"输入庄赢牛3的倍数。"],
                                           @[@1, @"牛4", @"powMianyongBankerNiu4", @"输入庄赢牛4的倍数。"],
                                           @[@1, @"牛5", @"powMianyongBankerNiu5", @"输入庄赢牛5的倍数。"],
                                           @[@1, @"牛6", @"powMianyongBankerNiu6", @"输入庄赢牛6的倍数。"],
                                           @[@1, @"牛7", @"powMianyongBankerNiu7", @"输入庄赢牛7的倍数。"],
                                           @[@1, @"牛8", @"powMianyongBankerNiu8", @"输入庄赢牛8的倍数。"],
                                           @[@1, @"牛9", @"powMianyongBankerNiu9", @"输入庄赢牛9的倍数。"],
                                           @[@1, @"牛牛", @"powMianyongBankerNiu10", @"输入庄赢牛牛的倍数。"],
                                           @[@1, @"金牛", @"powMianyongBankerJinniu", @"输入庄赢金牛的倍数。"],
                                           @[@1, @"对子", @"powMianyongBankerDuizi", @"输入庄赢对子的倍数。"],
                                           @[@1, @"倒顺", @"powMianyongBankerDaoshun", @"输入庄赢倒顺的倍数。"],
                                           @[@1, @"正顺", @"powMianyongBankerShunzi", @"输入庄赢正顺的倍数。"],
                                           @[@1, @"满牛", @"powMianyongBankerManniu", @"输入庄赢满牛的倍数。"],
                                           @[@1, @"豹子", @"powMianyongBankerBaozi", @"输入庄赢豹子的倍数。"],
                                           ],
                                       ];
        
    } else if ([mSettingType isEqualToString: @"niuniuYibi"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"闲赢倍数", @30],
                                         @[@"庄赢倍数", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@0, @"一比模式开启", @"supportYibi", @"若开启的话，将支持一比模式。下注格式： ‘一比300’或‘300一比’"],
                                           @[@1, @"牛几起比金额", @"startComparePowForYibi", @"输入闲家和庄同点的话牛几开始比金额，比如输入5，则当庄闲同点的时候，牛1~牛4是庄家赢，牛5以上金额大的一方赢。"],
                                           @[@1, @"牛几以下大平小赔", @"daPingXiaoPeiPowForYibi", @"输入闲家和庄同点的话牛几以下大平小赔，比如输入5, 则当庄闲同点的时候， 牛1~牛5， 如果闲大于庄则无输赢, 如果闲小于庄则输。"],
                                           @[@1, @"牛几以下认输", @"admitDefeatPowForYibi", @"输入闲家牛几以下直接认输，比如输入2, 则当闲抓到牛1～牛2的时候直接认输。"],
                                           @[@1, @"牛几以下不抽水", @"yibiNiuniuRatioUnder", @"输入闲家牛几以下不抽水，比如输入8, 则当闲抓到牛1～牛8的时候不抽水, 牛牛为10， 金牛为11， 对子为12， 倒顺13， 正顺14， 满牛15， 豹子18。"],
                                           @[@1, @"闲赢抽水比例", @"niuniuYibiWinRatio", @"输入闲家盈利的抽水比例，如输入“0.003”, 则抽取闲家盈利部分的3%，仅限于牛牛一比模式。"],
                                           @[@1, @"流水比例(反水)", @"niuniuYibiBetTotalRatioPlayerBack", @"输入闲家一比模式下，玩家反水流水按多少的比例显示。"],
                                           @[@1, @"流水比例(其他)", @"niuniuYibiBetTotalRatio", @"输入闲家一比模式下，总下注流水按多少的比例显示。"],
                                           ],
  
                                       @[
                                           @[@1, @"牛1", @"powYibiNiu1", @"输入闲赢牛1的倍数。"],
                                           @[@1, @"牛2", @"powYibiNiu2", @"输入闲赢牛2的倍数。"],
                                           @[@1, @"牛3", @"powYibiNiu3", @"输入闲赢牛3的倍数。"],
                                           @[@1, @"牛4", @"powYibiNiu4", @"输入闲赢牛4的倍数。"],
                                           @[@1, @"牛5", @"powYibiNiu5", @"输入闲赢牛5的倍数。"],
                                           @[@1, @"牛6", @"powYibiNiu6", @"输入闲赢牛6的倍数。"],
                                           @[@1, @"牛7", @"powYibiNiu7", @"输入闲赢牛7的倍数。"],
                                           @[@1, @"牛8", @"powYibiNiu8", @"输入闲赢牛8的倍数。"],
                                           @[@1, @"牛9", @"powYibiNiu9", @"输入闲赢牛9的倍数。"],
                                           @[@1, @"牛牛", @"powYibiNiu10", @"输入闲赢牛牛的倍数。"],
                                           @[@1, @"金牛", @"powYibiJinniu", @"输入闲赢金牛的倍数。"],
                                           @[@1, @"对子", @"powYibiDuizi", @"输入闲赢对子的倍数。"],
                                           @[@1, @"倒顺", @"powYibiDaoshun", @"输入闲赢倒顺的倍数。"],
                                           @[@1, @"正顺", @"powYibiShunzi", @"输入闲赢正顺的倍数。"],
                                           @[@1, @"满牛", @"powYibiManniu", @"输入闲赢满牛的倍数。"],
                                           @[@1, @"豹子", @"powYibiBaozi", @"输入闲赢豹子的倍数。"],
                                           ],
                                       
                                       @[
                                           @[@1, @"牛1", @"powYibiBankerNiu1", @"输入庄赢牛1的倍数。"],
                                           @[@1, @"牛2", @"powYibiBankerNiu2", @"输入庄赢牛2的倍数。"],
                                           @[@1, @"牛3", @"powYibiBankerNiu3", @"输入庄赢牛3的倍数。"],
                                           @[@1, @"牛4", @"powYibiBankerNiu4", @"输入庄赢牛4的倍数。"],
                                           @[@1, @"牛5", @"powYibiBankerNiu5", @"输入庄赢牛5的倍数。"],
                                           @[@1, @"牛6", @"powYibiBankerNiu6", @"输入庄赢牛6的倍数。"],
                                           @[@1, @"牛7", @"powYibiBankerNiu7", @"输入庄赢牛7的倍数。"],
                                           @[@1, @"牛8", @"powYibiBankerNiu8", @"输入庄赢牛8的倍数。"],
                                           @[@1, @"牛9", @"powYibiBankerNiu9", @"输入庄赢牛9的倍数。"],
                                           @[@1, @"牛牛", @"powYibiBankerNiu10", @"输入庄赢牛牛的倍数。"],
                                           @[@1, @"金牛", @"powYibiBankerJinniu", @"输入庄赢金牛的倍数。"],
                                           @[@1, @"对子", @"powYibiBankerDuizi", @"输入庄赢对子的倍数。"],
                                           @[@1, @"倒顺", @"powYibiBankerDaoshun", @"输入庄赢倒顺的倍数。"],
                                           @[@1, @"正顺", @"powYibiBankerShunzi", @"输入庄赢正顺的倍数。"],
                                           @[@1, @"满牛", @"powYibiBankerManniu", @"输入庄赢满牛的倍数。"],
                                           @[@1, @"豹子", @"powYibiBankerBaozi", @"输入庄赢豹子的倍数。"],
                                           ],
                                       
                                       ];
        
    } else if ([mSettingType isEqualToString: @"daxiao"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"倍数", @30],
                                         @[@"支持牌型", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
          @[
              @[@0, @"玩法开启", @"supportLonghu", @"若开启的话，将支持识别玩家的大小单双下注。"],
              @[@1, @"闲赢抽水比例", @"longhuRatioValue", @"输入闲家盈利的抽水比例，如输入“0.03”, 则抽取闲家盈利部分的3%，仅限于大小单双玩法。"],
              @[@1, @"最低下注(大小)", @"longhuMinBet", @"输入闲家大小单双下注的最低限额。"],
              @[@1, @"最高下注(大小)", @"longhuMaxBet", @"输入闲家大小单双下注的最高限额。"],
              @[@1, @"最低下注(合)", @"longhuMinBetHe", @"输入闲家合下注的最低限额。"],
              @[@1, @"最高下注(合)", @"longhuMaxBetHe", @"输入闲家合下注的最高限额。"],
              @[@0, @"抓到合退一半", @"longhuHeBackHalf", @"若开启的话， 闲家抓到‘合’牌型，将返还除‘合’以外下注本金的一半。"],
              @[@0, @"限制多个组合", @"longhuLimitMutil", @"若开启的话，‘大单、大双、小单、小双’这几个组合一局只能压一种，不能同时压。"],
              ],
          
          @[
              @[@1, @"大小单双", @"powLonghuDaXiaoDanShuang", @"输入大、小、单、双的倍数，不含本金。"],
              @[@1, @"小单、大双", @"powLonghuDaXiaoDanShuangZuhe3", @"输入小单、大双的倍数，不含本金。"],
              @[@1, @"大单、小双", @"powLonghuDaXiaoDanShuangZuhe2", @"输入大单、小双的倍数，不含本金。"],
              @[@1, @"合", @"powLonghuHe", @"输入合的倍数，不含本金。"],
              ],
          
          @[
              @[@0, @"大", @"daxiaoEnableDa", @"若开启的话，将开放‘大’牌型。"],
              @[@0, @"小", @"daxiaoEnableXiao", @"若开启的话，将开放‘小’牌型。"],
              @[@0, @"单", @"daxiaoEnableDan", @"若开启的话，将开放‘单’牌型。"],
              @[@0, @"双", @"daxiaoEnableShuang", @"若开启的话，将开放‘双’牌型。"],
              @[@0, @"合", @"daxiaoEnableHe", @"若开启的话，将开放‘合’牌型。"],
              @[@0, @"大单", @"daxiaoEnableDaDan", @"若开启的话，将开放‘大单’牌型。"],
              @[@0, @"大双", @"daxiaoEnableDaShuang", @"若开启的话，将开放‘大双’牌型。"],
              @[@0, @"小单", @"daxiaoEnableXiaoDan", @"若开启的话，将开放‘小单’牌型。"],
              @[@0, @"小双", @"daxiaoEnableXiaoShuang", @"若开启的话，将开放‘小双’牌型。"],
              ],
          ];
        
    } else if ([mSettingType isEqualToString: @"tema"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
            @[@"基本", @30],
            @[@"倍数", @30],
            ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
            @[
                @[@0, @"玩法开启", @"supportTema", @"若开启的话，将支持识别玩家的特码下注。"],
                @[@1, @"闲赢抽水比例", @"temaRatioValue", @"输入闲家盈利的抽水比例，如输入“0.03”, 则抽取闲家盈利部分的3%，仅限于特码玩法。"],
                @[@1, @"最低下注", @"temaMinBet", @"输入闲家特码下注的最低限额。"],
                @[@1, @"最高下注", @"temaMaxBet", @"输入闲家特码下注的最高限额。"],
                @[@0, @"抓到合退一半", @"temaHeBackHalf", @"若开启的话， 闲家抓到‘合’牌型，将返还下注本金的一半。"],
                ],
            
            @[
                @[@1, @"倍数", @"powTema", @"输入特码的倍数，支持小数点。"],
                ],
            ];
    } else if ([mSettingType isEqualToString: @"baijiale"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
             @[@"基本", @30],
             @[@"倍数", @30],
             @[@"支持牌型", @30],
             ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@0, @"玩法开启", @"supportBaijiale", @"若开启的话，将支持识别玩家的百家乐下注。"],
                                           @[@1, @"闲赢抽水比例", @"baijialeRatioValue", @"输入闲家盈利的抽水比例，如输入“0.03”, 则抽取闲家盈利部分的3%，仅限于百家乐玩法。"],
                                           @[@1, @"最低下注", @"baijialeMinBet", @"输入闲家百家乐下注的最低限额。"],
                                           @[@1, @"最高下注", @"baijialeMaxBet", @"输入闲家百家乐下注的最高限额。"],
                                           @[@1, @"牛几开始比", @"baijialeStartCompare", @"输入庄闲同点的情况下，牛几开始比，如输入5， 当点数为牛1-牛4，不管买庄赢还是闲赢，则认输。"],
                                           ],
                                       
                                       @[
                                           @[@1, @"庄", @"baijialePowZhuang", @"输入庄赢的倍数，不含本金。"],
                                           @[@1, @"闲", @"baijialePowXian", @"输入闲赢的倍数，不含本金。"],
                                           @[@1, @"和", @"baijialePowTie", @"输入和的倍数，不含本金。"],
                                           @[@1, @"庄对", @"baijialePowZhuangPair", @"输入庄对的倍数，不含本金。"],
                                           @[@1, @"闲对", @"baijialePowXianPair", @"输入闲对的倍数，不含本金。"],
                                           ],
                                       
                                       @[
                                           @[@0, @"庄", @"baijialeEnableZhuang", @"若开启的话，将开放‘庄赢’牌型。"],
                                           @[@0, @"闲", @"baijialeEnableXian", @"若开启的话，将开放‘闲赢’牌型。"],
                                           @[@0, @"和", @"baijialeEnableTie", @"若开启的话，将开放‘和’牌型。"],
                                           @[@0, @"庄对", @"baijialeEnableZhuangPair", @"若开启的话，将开放‘庄对’牌型。"],
                                           @[@0, @"闲对", @"baijialeEnableXianPair", @"若开启的话，将开放‘闲对’牌型。"],
                                           ],
                                       ];
    } else if ([mSettingType isEqualToString: @"bonus"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"连赢", @30],
                                         @[@"反水奖励", @30],
                                         @[@"输分奖励", @30],
                                         @[@"集齐奖励", @30],
                                         @[@"局数奖励", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
         @[
             @[@0, @"自动连赢兑奖", @"seriesWinAutoBonusEnable", @"若开启的话，机器会自动检测玩家的连赢，当玩家断连的时候，满足条件的会自动兑奖上分，在账单上有显示。"],
             @[@0, @"支持牛牛", @"seriesWinAllowTypeNiuniu", @"若开启的话，连赢在牛牛普通玩法上能正常统计，若关闭的话，如果玩家压牛牛， 连赢会重置为0。"],
             @[@0, @"支持牛牛免佣", @"seriesWinAllowTypeNiuniuMianyong", @"若开启的话，连赢在牛牛免佣玩法上能正常统计，若关闭的话，如果玩家压牛牛， 连赢会重置为0。"],
             @[@0, @"支持牛牛一比", @"seriesWinAllowTypeNiuniuYibi", @"若开启的话，连赢在牛牛一比玩法上能正常统计，若关闭的话，如果玩家压牛牛， 连赢会重置为0。"],
             @[@0, @"支持大小单双", @"seriesWinAllowTypeDaxiao", @"若开启的话，连赢在大小单双玩法上能正常统计，若关闭的话，如果玩家压大小单双， 连赢会重置为0。"],
             @[@0, @"支持特码", @"seriesWinAllowTypeTema", @"若开启的话，连赢在特码玩法上能正常统计，若关闭的话，如果玩家压特码， 连赢会重置为0。"],
             @[@0, @"支持百家乐", @"seriesWinAllowTypeBaijiale", @"若开启的话，连赢在百家乐玩法上能正常统计，若关闭的话，如果玩家压百家乐， 连赢会重置为0。"],
             @[@0, @"大小连赢认第一注", @"seriesWinDaxiaoAsFirst", @"若开启的话，玩家压大小单双玩法，有没有连赢是根据第一注来算，比如玩家压‘大500小单300’, 如果玩家抓了'大'就连赢+1, 抓到其他牌型则断连赢， 若关闭的话， 玩家大小单双的连赢标准就是按照该把输赢决定，赢则连赢+1, 输就断连。 "],
             @[@0, @"大小押注认第一注", @"seriesWinDaxiaoAsFirstBet", @"若开启的话，玩家压大小单双玩法，兑奖的时候取押注值是按照第一注来认，比如玩家压‘大500小单300’， 则默认这把押注为500， 若关闭的话， 则默认这把押注为800。"],
             @[@0, @"百家连赢认第一注", @"seriesWinBaijialeAsFirst", @"若开启的话，玩家压百家乐玩法，有没有连赢是根据第一注来算，比如玩家压‘闲500和300’, 如果买中'闲'就连赢+1, 否则断连赢， 若关闭的话， 玩家百家乐的连赢标准就是按照该把输赢决定，赢则连赢+1, 输就断连。 "],
             @[@0, @"百家押注认第一注", @"seriesWinBaijialeAsFirstBet", @"若开启的话，玩家压百家乐玩法，兑奖的时候取押注值是按照第一注来认，比如玩家压‘闲500和300’， 则默认这把押注为500， 若关闭的话， 则默认这把押注为800。"],
             @[@0, @"平赔闲家断连", @"bankerHeadEndSeriesWin", @"若开启的话，当庄家头包出现平赔时，本局闲家连赢全部断连。"],
             @[@0, @"平赔连赢不加", @"bankerHeadNotSeriesWin", @"若开启的话，当庄家头包出现平赔时，本局闲家连赢次数不变，不递增也不递减。"],
             @[@0, @"庄超连赢不加", @"bankerOvertimeNotSeriesWin", @"若开启的话，当庄家超时的话，本局闲家连赢次数不变，不递增也不递减。"],
             @[@0, @"闲认尾中断连赢", @"playerAsLastEndSeriesWin", @"若开启的话，当闲无包认尾的时候，直接断连。"],
             @[@0, @"闲认尾连赢不加", @"playerAsLastNotSeriesWin", @"若开启的话，当闲无包认尾的时候，本局闲家连赢次数不变，不递增也不递减。"],
             @[@1, @"连赢超几把重置", @"seriesWinResetNum", @"输入当闲家连赢次数超过多少的时候重置，如输入15，当闲家连赢16把，账单连赢会显示‘连赢1’"],
             @[@1, @"1局奖励", @"seriesWinAutoBonus1", @"输入连赢1把的奖励数量。"],
             @[@1, @"2局奖励", @"seriesWinAutoBonus2", @"输入连赢2把的奖励数量。"],
             @[@1, @"3局奖励", @"seriesWinAutoBonus3", @"输入连赢3把的奖励数量。"],
             @[@1, @"4局奖励", @"seriesWinAutoBonus4", @"输入连赢4把的奖励数量。"],
             @[@1, @"5局奖励", @"seriesWinAutoBonus5", @"输入连赢5把的奖励数量。"],
             @[@1, @"6局奖励", @"seriesWinAutoBonus6", @"输入连赢6把的奖励数量。"],
             @[@1, @"7局奖励", @"seriesWinAutoBonus7", @"输入连赢7把的奖励数量。"],
             @[@1, @"8局奖励", @"seriesWinAutoBonus8", @"输入连赢8把的奖励数量。"],
             @[@1, @"9局奖励", @"seriesWinAutoBonus9", @"输入连赢9把的奖励数量。"],
             @[@1, @"10局奖励", @"seriesWinAutoBonus10", @"输入连赢10把的奖励数量。"],
             @[@1, @"11局奖励", @"seriesWinAutoBonus11", @"输入连赢11把的奖励数量。"],
             @[@1, @"12局奖励", @"seriesWinAutoBonus12", @"输入连赢12把的奖励数量。"],
             @[@1, @"13局奖励", @"seriesWinAutoBonus13", @"输入连赢13把的奖励数量。"],
             @[@1, @"14局奖励", @"seriesWinAutoBonus14", @"输入连赢14把的奖励数量。"],
             @[@1, @"15局奖励", @"seriesWinAutoBonus15", @"输入连赢15把的奖励数量。"],
             @[@1, @"16局奖励", @"seriesWinAutoBonus16", @"输入连赢16把的奖励数量。"],
             @[@1, @"17局奖励", @"seriesWinAutoBonus17", @"输入连赢18把的奖励数量。"],
             @[@1, @"18局奖励", @"seriesWinAutoBonus18", @"输入连赢19把的奖励数量。"],
             @[@1, @"19局奖励", @"seriesWinAutoBonus19", @"输入连赢10把的奖励数量。"],
             @[@1, @"20局奖励", @"seriesWinAutoBonus20", @"输入连赢20把的奖励数量。"],
             @[@1, @"20局每把增加", @"seriesWinAutoBonus20up", @"输入当连赢超过20把，在20把奖励基础上每多1把的奖励递增多少的数量。"],
             @[@1, @"奖励比例1", @"seriesWinAutoBonusRatio1", @"输入奖励比例，如输入‘30-49-0.33’，表示押注30~49的， 奖励福利的33%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算, 如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例2", @"seriesWinAutoBonusRatio2", @"输入奖励比例，如输入‘50-99-0.5’，表示押注50~99的， 奖励福利的50%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算, 如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例3", @"seriesWinAutoBonusRatio3", @"输入奖励比例，如输入‘100-299-0.75’，表示押注100~299的， 奖励福利的75%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算, 如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例4", @"seriesWinAutoBonusRatio4", @"输入奖励比例，如输入‘300-499-1’，表示押注300~499的， 奖励福利的100%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算, 如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例5", @"seriesWinAutoBonusRatio5", @"输入奖励比例，如输入‘500-999999999-2’，表示押注500-999999999的， 奖励福利的200%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算, 如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             ],
         
         @[
             @[@0, @"是否开启", @"playerBackEnable", @"若开启的话，后台将支持以下命令\n‘查反水奖励’\n‘执行反水奖励’\n‘取消反水奖励’"],
             @[@1, @"奖励比例1", @"playerBackRatio1", @"输入反水比例，如输入‘3000-300000-0.04’，表示总押注3000~300000的， 反总押注的4%, 注: 总押注 = 牛牛下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10, 如不需要则留空。"],
             @[@1, @"奖励比例2", @"playerBackRatio2", @"输入反水比例，如输入‘300001-500000-0.05’，表示总押注300001~500000的， 反总押注的5%, 注: 总押注 = 牛牛下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10, 如不需要则留空。"],
             @[@1, @"奖励比例3", @"playerBackRatio3", @"输入反水比例，如输入‘500001-999999999-0.07’，表示总押注500001~999999999的， 反总押注的7%, 注: 总押注 = 牛牛下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10, 如不需要则留空。"],
             @[@1, @"奖励比例4", @"playerBackRatio4", @"输入反水比例，如输入‘500001-999999999-0.07’，表示总押注500001~999999999的， 反总押注的7%, 注: 总押注 = 牛牛下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10, 如不需要则留空。"],
             @[@1, @"奖励比例5", @"playerBackRatio5", @"输入反水比例，如输入‘500001-999999999-0.07’，表示总押注500001~999999999的， 反总押注的7%, 注: 总押注 = 牛牛下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10, 如不需要则留空。"],
             ],
         
         @[
             @[@0, @"是否开启", @"loseBonusEnable", @"若开启的话，后台将支持以下命令\n‘查输分奖励’\n‘执行输分奖励’\n‘取消输分奖励’"],
             @[@1, @"奖励比例1", @"loseBonusRatio1", @"输入奖励比例，如输入‘3000-300000-0.04’，表示输分3000~300000的， 奖励输分的4%。"],
             @[@1, @"奖励比例2", @"loseBonusRatio2", @"输入奖励比例，如输入‘3000-300000-0.04’，表示输分3000~300000的， 奖励输分的4%。"],
             @[@1, @"奖励比例3", @"loseBonusRatio3", @"输入奖励比例，如输入‘3000-300000-0.04’，表示输分3000~300000的， 奖励输分的4%。"],
             @[@1, @"奖励比例4", @"loseBonusRatio4", @"输入奖励比例，如输入‘3000-300000-0.04’，表示输分3000~300000的， 奖励输分的4%。"],
             @[@1, @"奖励比例5", @"loseBonusRatio5", @"输入奖励比例，如输入‘3000-300000-0.04’，表示输分3000~300000的， 奖励输分的4%。"],
             ],
         
         @[
             @[@0, @"是否开启", @"collectBonusEnable", @"若开启的话，后台将支持以下命令\n‘查集齐奖励’\n‘查集齐奖励2’\n‘执行集齐奖励’\n‘取消集齐奖励’"],
             @[@0, @"牛牛不重复", @"collectBonusNiuniuMustNotSame", @"若开启的话，牛牛的集齐条件需要是不重复的。"],
             @[@0, @"金牛不重复", @"collectBonusJinniuMustNotSame", @"若开启的话，金牛的集齐条件需要是不重复的。"],
             @[@0, @"对子不重复", @"collectBonusDuiziMustNotSame", @"若开启的话，对子的集齐条件需要是不重复的。"],
             @[@0, @"顺子不重复", @"collectBonusShunziMustNotSame", @"若开启的话，顺子的集齐条件需要是不重复的。"],
             @[@0, @"倒顺不重复", @"collectBonusDaoshunMustNotSame", @"若开启的话，倒顺的集齐条件需要是不重复的。"],
             @[@0, @"满牛不重复", @"collectBonusManniuMustNotSame", @"若开启的话，满牛的集齐条件需要是不重复的。"],
             @[@0, @"豹子不重复", @"collectBonusBaoziMustNotSame", @"若开启的话，豹子的集齐条件需要是不重复的。"],
             @[@1, @"牛牛奖励", @"collectBonusNiuniuNum", @"输入牛牛奖励规则，如输入‘10-888-100’，表示抓到10个牛牛奖励888，每多拿一个额外奖励100, 如牛牛不奖励则留空。"],
             @[@1, @"金牛奖励", @"collectBonusJinniuNum", @"输入金牛奖励规则，如输入‘6-3888-1888’，表示抓到6个金牛奖励3888，每多拿一个额外奖励1888, 如金牛不奖励则留空。"],
             @[@1, @"对子奖励", @"collectBonusDuiziNum", @"输入对子奖励规则，如输入‘6-3888-1888’，表示抓到6个对子奖励3888，每多拿一个额外奖励1888, 如对子不奖励则留空。"],
             @[@1, @"顺子奖励", @"collectBonusShunziNum", @"输入顺子奖励规则，如输入‘4-10000-8888’，表示抓到4顺子奖励10000，每多拿一个额外奖励8888, 如顺子不奖励则留空。"],
             @[@1, @"倒顺奖励", @"collectBonusDaoshunNum", @"输入倒顺奖励规则，如输入‘4-10000-8888’，表示抓到4个倒顺奖励10000，每多拿一个额外奖励8888, 如倒顺不奖励则留空。"],
             @[@1, @"满牛奖励", @"collectBonusManniuNum", @"输入满牛奖励规则，如输入‘4-10000-8888’，表示抓到4个满牛奖励10000，每多拿一个额外奖励8888, 如满牛不奖励则留空。"],
             @[@1, @"豹子奖励", @"collectBonusBaoziNum", @"输入豹子奖励规则，如输入‘4-10000-8888’，表示抓到4个豹子奖励10000，每多拿一个额外奖励8888, 如豹子不奖励则留空。"],
             @[@0, @"押注取平均值", @"collectBonusBetUseAverage", @"若开启的话，奖励规则取相应有奖牌型的押注平均值去算奖励比例， 若关闭的话， 取相应有奖牌型的押注最低值去算奖励比例。"],
             @[@1, @"奖励比例1", @"collectBonusRatio1", @"输入奖励比例，如输入‘30-49-0.33’，表示押注30~49的， 奖励相应牌型奖励的33%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算，如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例2", @"collectBonusRatio2", @"输入奖励比例，如输入‘50-99-0.5’，表示押注50~99的， 奖励相应牌型奖励的50%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算，如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例3", @"collectBonusRatio3", @"输入奖励比例，如输入‘100-299-0.75’，表示押注100~299的， 奖励相应牌型奖励的75%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算，如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例4", @"collectBonusRatio4", @"输入奖励比例，如输入‘300-499-1’，表示押注300~499的， 奖励相应牌型奖励的100%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算，如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             @[@1, @"奖励比例5", @"collectBonusRatio5", @"输入奖励比例，如输入‘500-999999999-2’，表示押注500~999999999的， 奖励相应牌型奖励的200%, 牛牛梭哈、大小、特码、百家乐押注是按原押注10%算，如果玩家押注不在这五个比例范围内， 则奖励无效, 如不需要则留空。"],
             ],
         
         @[
             @[@0, @"是否开启", @"huangzu_roundBonus_enable", @"若开启的话，后台将支持以下命令\n‘查局数奖励’\n‘查局数奖励2’\n‘执行局数奖励’\n‘取消局数奖励’"],
             @[@1, @"押注范围1", @"huangzu_roundBonus_level1", @"输入押注范围1，如输入100，则表示押注1~99"],
             @[@1, @"押注范围2", @"huangzu_roundBonus_level2", @"输入押注范围2，如输入300，则表示‘押注范围1’~299"],
             @[@1, @"押注范围3", @"huangzu_roundBonus_level3", @"输入押注范围3，如输入1000，则表示‘押注范围2’~999"],
             @[@1, @"满足局数1", @"huangzu_roundBonus_roundMust1", @"输入满足需要满足局数1"],
             @[@1, @"满足局数2", @"huangzu_roundBonus_roundMust2", @"输入满足需要满足局数2"],
             @[@1, @"满足局数3", @"huangzu_roundBonus_roundMust3", @"输入满足需要满足局数3"],
             @[@1, @"满足局数4", @"huangzu_roundBonus_roundMust4", @"输入满足需要满足局数4"],
             @[@1, @"奖励1—1", @"huangzu_roundBonus_bonus1_1", @"输入‘押注范围1’和‘满足局数1’的奖励"],
             @[@1, @"奖励1—2", @"huangzu_roundBonus_bonus1_2", @"输入‘押注范围1’和‘满足局数2’的奖励"],
             @[@1, @"奖励1—3", @"huangzu_roundBonus_bonus1_3", @"输入‘押注范围1’和‘满足局数3’的奖励"],
             @[@1, @"奖励1—4", @"huangzu_roundBonus_bonus1_4", @"输入‘押注范围1’和‘满足局数4’的奖励"],
             @[@1, @"奖励2—1", @"huangzu_roundBonus_bonus2_1", @"输入‘押注范围2’和‘满足局数1’的奖励"],
             @[@1, @"奖励2—2", @"huangzu_roundBonus_bonus2_2", @"输入‘押注范围2’和‘满足局数2’的奖励"],
             @[@1, @"奖励2—3", @"huangzu_roundBonus_bonus2_3", @"输入‘押注范围2’和‘满足局数3’的奖励"],
             @[@1, @"奖励2—4", @"huangzu_roundBonus_bonus2_4", @"输入‘押注范围2’和‘满足局数4’的奖励"],
             @[@1, @"奖励3—1", @"huangzu_roundBonus_bonus3_1", @"输入‘押注范围3’和‘满足局数1’的奖励"],
             @[@1, @"奖励3—2", @"huangzu_roundBonus_bonus3_2", @"输入‘押注范围3’和‘满足局数2’的奖励"],
             @[@1, @"奖励3—3", @"huangzu_roundBonus_bonus3_3", @"输入‘押注范围3’和‘满足局数3’的奖励"],
             @[@1, @"奖励3—4", @"huangzu_roundBonus_bonus3_4", @"输入‘押注范围3’和‘满足局数4’的奖励"],
             @[@1, @"奖励4—1", @"huangzu_roundBonus_bonus4_1", @"输入比‘押注范围3’还高的押注和‘满足局数1’的奖励"],
             @[@1, @"奖励4—2", @"huangzu_roundBonus_bonus4_2", @"输入比‘押注范围3’还高的押注和‘满足局数2’的奖励"],
             @[@1, @"奖励4—3", @"huangzu_roundBonus_bonus4_3", @"输入比‘押注范围3’还高的押注和‘满足局数3’的奖励"],
             @[@1, @"奖励4—4", @"huangzu_roundBonus_bonus4_4", @"输入比‘押注范围3’还高的押注和‘满足局数4’的奖励"],
             ],
         ];
    } else if ([mSettingType isEqualToString: @"bill"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"基本", @30],
                                         @[@"结算单样式", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@0, @"押注单用图片", @"showPicBillForBet", @"若开启的话，机器出的押注单将以图片方式出单，若关闭的话以文字方式出单。"],
                                           @[@0, @"单独发人数金额", @"sendPlayerCountAndAmount", @"若开启的话，机器出完押注单之后还会发一条人数以及金额的信息。"],
                                           @[@1, @"发包金额尾数", @"sendHongbaoSmallNumber", @"输入押注单里面出现的发包金额尾数，如输入88，本局50个玩家，发包金额将会提示：100.88"],
                                           @[@1, @"押注单头广告", @"betBillHeadStr", @"输入押注单上方需要加入的文字广告。"],
                                           @[@1, @"押注单尾广告", @"betBillLastStr", @"输入押注单末尾需要加入的文字广告。"],
                                           @[@0, @"结算单用图片", @"showPicBill", @"若开启的话，机器出的结算单将以图片方式出单，若关闭的话以文字方式出单。"],
                                           @[@1, @"结算图高亮押注", @"hightBet", @"输入押注金额满多少的时候，图片上的押注文字颜色变成紫色。"],
                                           @[@0, @"结算图含积分", @"picHasTop", @"若开启的话，图片结算单将包含玩家积分排行榜。"],
                                           @[@1, @"结算图压缩系数", @"picCompressValue", @"输入图片结算单需要压缩的比例，节省流量，输入范围‘0~1’。"],
                                           @[@0, @"出单前撤注提示", @"revokeMsgHint", @"若开启的话，当玩家在出单前撤回自己的押注，机器自动会出文字提示撤回押注成功。"],
                                           @[@0, @"出单后撤注提示", @"revokeMsgHintForShowBill", @"若开启的话，当玩家在出单后撤回自己的押注，机器自动会出文字提示撤回押注失败。"],
                                           @[@0, @"存储自动出结算", @"savedAutoSendPic", @"若开启的话，结算完点存储会自动出结算图。"],
                                           @[@0, @"存储自动出积分", @"savedAutoSendTop", @"若开启的话，结算完点存储会自动出积分榜。"],
                                           @[@0, @"积分含最近上下分", @"topHasNewScoreChange", @"若开启的话，积分榜上会显示最近上下分。"],
                                           @[@1, @"自动出积分格式", @"autoSendTopType", @"输入自动出积分榜的格式的序号\n1: 文字\n2: 文本\n3: 表格\n4: 图片"],
                                           @[@1, @"表格一行显几个", @"autoSendTopExcelLineNum", @"输入表格积分榜的一行显示几个玩家"],
                                           @[@1, @"获取红包等待", @"autoOpenHongbaoWait", @"输入机器自动获取红包的等待时间，从车手发出红包后开始计时。"],
                                           ],
                                       
                                       @[
                                           @[@1, @"广告头背景图", @"headIndex", @""],
                                           @[@1, @"走势图背景图", @"trendIndex", @""],
                                           @[@1, @"标题背景颜色", @"titleR", @""],
                                           @[@1, @"标题文字颜色", @"titleTextR", @""],
                                           @[@1, @"往期走势圆颜色", @"trendCurrentR", @""],
                                           @[@1, @"本期走势圆颜色", @"trendHighR", @""],
                                           ],
                                       ];
    } else if ([mSettingType isEqualToString: @"cache"]) {
        //标题, 标题高
        mTableViewConfigs[@"titles"] = @[
                                         @[@"缓存清理", @30],
                                         @[@"部分清除", @30],
                                         @[@"全部清除(慎重)", @30],
                                         @[@"数据备份", @30],
                                         @[@"数据恢复", @30],
                                         ];
        
        //展示类型(0: switch, 1: 文字+右文字带下级 2: 文字, 3:文字+下文字), key
        mTableViewConfigs[@"rows"] = @[
                                       @[
                                           @[@2, @"清理微信缓存", @"clearnWechat"],
                                           ],
                                       
                                       @[
                                           @[@3, @"删除部分局数记录", @"clearPartRound"],
                                           @[@3, @"清理会员低分", @"clearMemberLowScores"],
                                           ],
                                       
                                       @[
                                           @[@3, @"清空所有局数记录", @"clearRound"],
                                           @[@3, @"清空管理员", @"clearAdmin"],
                                           @[@3, @"清空托", @"clearTuo"],
                                           @[@3, @"清空拉手", @"clearLashou"],
                                           @[@3, @"清空团长", @"clearLashouHead"],
                                           @[@3, @"清空会员积分", @"clearMemberScores"],
                                           @[@3, @"删除所有会员", @"clearMembers"],
                                           ],
                                       
                                       @[
                                           @[@4, @"备份到聊天窗口", @"uploadCache2"],
                                           ],
                                       
                                       @[
                                           @[@4, @"从聊天窗口恢复", @"downloadCache2"],
                                           ],
                                       ];
    }

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
    
    tmanager.mRobot.mData.mBaseSetting[key] = s.isOn ? @"true" : @"false";
    [tmanager.mRobot.mData saveBaseSettingFile];
    
    if ([key isEqualToString: @"supportNiuniu"]) {
        tmanager.mRobot.mEnableNiuniu = s.isOn;
    }
    else if([key isEqualToString: @"supportLonghu"]) {
        tmanager.mRobot.mEnableLonghu = s.isOn;
    }
    else if([key isEqualToString: @"supportTema"]) {
        tmanager.mRobot.mEnableTema = s.isOn;
    }
    else if([key isEqualToString: @"supportBaijiale"]) {
        tmanager.mRobot.mEnableBaijiale = s.isOn;
    }
    
    NSArray* array = [self key2array: key];
    if (!array) {
        return;
    }
    NSString* text = nil;
    if ([array count] > 3) {
        text = array[3];
    }
    text = text ? text : @"";
    text = deString(@"%@\n%@", s.isOn ? @"✅已开启✅" : @"❌已关闭❌", text);
    [ycFunction showMsg:array[1] msg:text vc:self.mSuperViewVC];
}

//点击一行
-(void) clickLine:(NSIndexPath*)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray* arr = mTableViewConfigs[@"rows"][section][row];
    int type = [arr[0] intValue];
    if (type == 0) {//开关
        return;
    }
    
    __weak __typeof(&*self)weakSelf = self;

    NSString* key = arr[2];
    if ( [mSettingType isEqualToString: @"cache"] ) {//存档管理
        if ([key isEqualToString: @"clearMemberLowScores"]) {
            if ([[tmanager.mRobot getBackgroundWithFunc: @"robotRework"] count] <= 0) {
                [ycFunction showMsg: nil msg: @"绑定的后台群至少需要设置其中一个包含‘播报机器修改’功能才能执行此操作！" vc:self.mSuperViewVC];
                return;
            }
        }
        else if (![key isEqualToString: @"clearnWechat"]) {
            if (tmanager.mRobot.mGameRoom || [tmanager.mRobot.mBackroundRooms count] > 0) {
                [ycFunction showMsg: nil msg: @"必须先解绑游戏群，还有所有的后台群才能执行此操作！" vc:self.mSuperViewVC];
                return;
            }
        }
        if ([key isEqualToString: @"uploadCache2"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"提示" message: @"是否要将数据发到当前聊天窗口?" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData bakAllFiles2Chat];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
        else if ([key isEqualToString: @"downloadCache2"]) {
            id controller =[ycFunction getCurrentVisableVC];
            if (!controller) {
                return;
            }
            
            NSString* className = NSStringFromClass([controller class]);
            if (![className isEqualToString: @"FileDetailViewController"]) {
                [ycFunction showMsg:@"需要打开文件界面！" msg:nil vc:weakSelf.mSuperViewVC];
                return;
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"提示" message:@"此操作会删除手机上原有的所有数据！！确定从当前文件恢复数据？" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                id m_logicController = [ycFunction getVar:controller name:@"m_logicController"];
                NSData* data = [NSData dataWithContentsOfFile: [m_logicController GetFilePath]];
                if (!data) {
                    [ycFunction showMsg:@"恢复失败，请重试！" msg:nil vc:weakSelf.mSuperViewVC];
                    return;
                }
                [tmanager.mRobot.mData resumeAllFilesFromZip: [m_logicController GetFilePath]];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
        else if ([key isEqualToString: @"clearRound"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定清空所有局数纪录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearRounds];
                [tmanager.mRobot.mData clearScoreChangedRecords];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearPartRound"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: deString(@"请输入要删除前多少局的数据, 当前最新局数: %d", tmanager.mRobot.mNumber) preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField* textField = alertController.textFields.firstObject;
                if (![ycFunction isInt: textField.text]) {
                    [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                    return;
                }
                int endNum = [textField.text intValue];
                if (endNum >= tmanager.mRobot.mNumber-1) {
                    [ycFunction showMsg: nil msg: deString(@"最多只能输入%d", tmanager.mRobot.mNumber-2) vc: weakSelf.mSuperViewVC];
                    return;
                }
                int removeRoundCount = [tmanager.mRobot.mData clearPartRounds: endNum];
                int removeScoreChangeCount = [tmanager.mRobot.mData clearPartScoreChangedRecords: endNum];
                [ycFunction showMsg: nil msg: deString(@"删除了%d局, %d个上下分记录!", removeRoundCount, removeScoreChangeCount) vc: weakSelf.mSuperViewVC];
                [mTableView reloadData];
            }]];
            [alertController addTextFieldWithConfigurationHandler:nil];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearAdmin"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否删除所有管理?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearAdmins];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearTuo"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否删除所有托?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearTuos];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearLashou"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否删除所有拉手?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearLashous];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearLashouHead"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否删除所有拉手团长?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearLashouHeads];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if ([key isEqualToString: @"clearMembers"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否删除所有会员?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearMembers];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if([key isEqualToString: @"clearMemberScores"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"是否确定清空所有会员积分" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [tmanager.mRobot.mData clearMemberScores];
                [mTableView reloadData];
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if([key isEqualToString: @"clearnWechat"]) {
            NSArray* arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* appDocDir = [NSString stringWithFormat: @"%@", [arr lastObject]];
            //            [ycFunction lookAllChildPath: appDocDir];
            NSString *path = appDocDir;
            float filesize = [ycFunction folderSizeAtPath: path];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: deString(@"可清理空间: %.2fM", filesize) message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager removeItemAtPath:path error:NULL]) {
                    NSLog(@"Removed successfully");
                }
            }]];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }else if([key isEqualToString: @"clearMemberLowScores"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: @"请输入要清理多少以下的积分？" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField* textField = alertController.textFields.firstObject;
                if (![ycFunction isInt: textField.text]) {
                    [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                    return;
                }
                int score = [textField.text intValue];
                if (score <= 0) {
                    [ycFunction showMsg: nil msg: @"格式错误" vc: weakSelf.mSuperViewVC];
                    return;
                }
                NSString* text =  [tmanager.mRobot.mCommand clearLowScores: score];
                NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"robotRework"];
                if ([rooms count] > 0) {
                    [tmanager.mRobot.mSendMsg sendText:rooms[0] content:text at:nil title:@"清理低分"];
                }
                [mTableView reloadData];
            }]];
            [alertController addTextFieldWithConfigurationHandler:nil];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
    } else if([mSettingType isEqualToString: @"niuniu"]) {
        NSString* title = @"基本设置";
        NSString* type = @"niuniuBase";
        if ([key isEqualToString: @"heshui"]) {
            title = @"喝水模式";
            type = @"niuniuHeshui";
        }else if ([key isEqualToString: @"mianyong"]) {
            title = @"免佣模式";
            type = @"niuniuMianyong";
        }else if ([key isEqualToString: @"yibi"]) {
            title = @"一比模式";
            type = @"niuniuYibi";
        }
        robotSettingView* settingView = [[robotSettingView alloc] initWithType:weakSelf.frame type: type];
        settingView.mSuperViewVC = weakSelf.mSuperViewVC;
        settingView.mBackFunc = ^{
            [ycFunction popView: weakSelf view: settingView dur: .2 completion:^(BOOL b) {
                [settingView removeFromSuperview];
            }];
            [mTableView reloadData];
        };
        settingView.mTitle.text = title;
        settingView.mTitle.textColor = [UIColor yellowColor];
        [weakSelf.mSuperViewVC.view addSubview: settingView];
        [settingView release];
        dispatch_async(deMainQueue, ^{
            [ycFunction pushView: weakSelf view: settingView dur: .2 completion:nil];
        });
    } else {
        if ([key isEqualToString: @"headIndex"] || [key isEqualToString: @"trendIndex"] || [key isEqualToString: @"titleR"] || [key isEqualToString: @"titleTextR"] || [key isEqualToString: @"trendHighR"] || [key isEqualToString: @"trendCurrentR"]) {//结算图配置
            if ([key isEqualToString: @"headIndex"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"从相册中选择一张图片当作广告头背景图，推荐尺寸: 750x320" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf getImageFromIpc: 0];
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"使用默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    tmanager.mRobot.mData.mBaseSetting[@"headIndex"] = @"false";
                    [tmanager.mRobot.mData saveBaseSettingFile];
                    [mTableView reloadData];
                }]];
                [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
            }else if ([key isEqualToString: @"trendIndex"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"从相册中选择一张图片当作走势图背景图，推荐尺寸: 750x203" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf getImageFromIpc: 1];
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"使用默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    tmanager.mRobot.mData.mBaseSetting[@"trendIndex"] = @"false";
                    [tmanager.mRobot.mData saveBaseSettingFile];
                    [mTableView reloadData];
                }]];
                [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
            }else {
                robotSettingBillColorView* contentView = [[robotSettingBillColorView alloc] initWithFrame: weakSelf.frame key: key];
                contentView.mFunc = ^(BOOL isOk, int r, int g, int b) {
                    [ycFunction popView: weakSelf view: contentView dur: .2 completion:^(BOOL b) {
                        [contentView removeFromSuperview];
                    }];
                    
                    if (isOk) {
                        if ([key isEqualToString: @"titleR"]) {
                            tmanager.mRobot.mData.mBaseSetting[@"titleR"] = deInt2String(r);
                            tmanager.mRobot.mData.mBaseSetting[@"titleG"] = deInt2String(g);
                            tmanager.mRobot.mData.mBaseSetting[@"titleB"] = deInt2String(b);
                            [tmanager.mRobot.mData saveBaseSettingFile];
                        }
                        else if ([key isEqualToString: @"titleTextR"]) {
                            tmanager.mRobot.mData.mBaseSetting[@"titleTextR"] = deInt2String(r);
                            tmanager.mRobot.mData.mBaseSetting[@"titleTextG"] = deInt2String(g);
                            tmanager.mRobot.mData.mBaseSetting[@"titleTextB"] = deInt2String(b);
                            [tmanager.mRobot.mData saveBaseSettingFile];
                        }
                        else if ([key isEqualToString: @"trendHighR"]) {
                            tmanager.mRobot.mData.mBaseSetting[@"trendHighR"] = deInt2String(r);
                            tmanager.mRobot.mData.mBaseSetting[@"trendHighG"] = deInt2String(g);
                            tmanager.mRobot.mData.mBaseSetting[@"trendHighB"] = deInt2String(b);
                            [tmanager.mRobot.mData saveBaseSettingFile];
                        }
                        else if ([key isEqualToString: @"trendCurrentR"]) {
                            tmanager.mRobot.mData.mBaseSetting[@"trendCurrentR"] = deInt2String(r);
                            tmanager.mRobot.mData.mBaseSetting[@"trendCurrentG"] = deInt2String(g);
                            tmanager.mRobot.mData.mBaseSetting[@"trendCurrentB"] = deInt2String(b);
                            [tmanager.mRobot.mData saveBaseSettingFile];
                        }
                        [mTableView reloadData];
                    }
                };
                [weakSelf.mSuperViewVC.view addSubview: contentView];
                [contentView release];
                dispatch_async(deMainQueue, ^{
                    [ycFunction pushView: weakSelf view: contentView dur: .2 completion:nil];
                });
            }
        } else {
            NSString* text = nil;
            if ([arr count] > 3) {
                text = arr[3];
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: arr[1] message:text preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField* textField = alertController.textFields.firstObject;
                if([key isEqualToString: @"ratio"] || [key isEqualToString: @"betLimit"] || [key isEqualToString: @"bankerWinRatio"] || [key isEqualToString: @"playerWinRatio"] || [key isEqualToString: @"niuniuYibiWinRatio"] || [key isEqualToString: @"playerWinRatioSuoha"] || [key isEqualToString: @"longhuRatioValue"]|| [key isEqualToString: @"picCompressValue"] || [key hasPrefix: @"pow"] || [key isEqualToString: @"niuniuYibiBetTotalRatio"] || [key isEqualToString: @"niuniuYibiBetTotalRatioPlayerBack"] || [key hasPrefix: @"heshuiSubsidy"] || [key hasPrefix:@"tmpBonusPool"] || [key hasPrefix:@"baijialePow"] || [key isEqualToString: @"temaRatioValue"] || [key isEqualToString: @"baijialeRatioValue"] ){
                    if ([ycFunction isFloat: textField.text]) {
                        tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                    } else {
                        [ycFunction showMsg: @"格式错误" msg: nil vc: weakSelf.mSuperViewVC];
                    }
                } else if([key isEqualToString: @"betBillHeadStr"] || [key isEqualToString: @"betBillLastStr"] ){
                    tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                } else if([key hasPrefix: @"playerBackRatio"] || [key hasPrefix: @"loseBonusRatio"] || [key hasPrefix: @"collectBonusRatio"] || [key hasPrefix: @"seriesWinAutoBonusRatio"]) {
                    if ([textField.text isEqualToString: @""]) {
                        tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                    } else {
                        NSArray* array = [textField.text componentsSeparatedByString: @"-"];
                        if ([array count] != 3 || ![ycFunction isInt: array[0]] || ![ycFunction isInt: array[1]] || ![ycFunction isFloat: array[2]]) {
                            [ycFunction showMsg: @"格式错误" msg: nil vc: weakSelf.mSuperViewVC];
                        } else {
                            tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                        }
                    }
                } else if([key isEqualToString: @"collectBonusNiuniuNum"] || [key isEqualToString: @"collectBonusJinniuNum"] || [key isEqualToString: @"collectBonusDuiziNum"] || [key isEqualToString: @"collectBonusShunziNum"] || [key isEqualToString: @"collectBonusDaoshunNum"] || [key isEqualToString: @"collectBonusManniuNum"] || [key isEqualToString: @"collectBonusBaoziNum"]) {
                    if ([textField.text isEqualToString: @""]) {
                        tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                    } else {
                        NSArray* array = [textField.text componentsSeparatedByString: @"-"];
                        if ([array count] != 3 || ![ycFunction isInt: array[0]] || ![ycFunction isInt: array[1]] || ![ycFunction isInt: array[2]]) {
                            [ycFunction showMsg: @"格式错误" msg: nil vc: weakSelf.mSuperViewVC];
                        } else {
                            tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                        }
                    }
                } else {
                    if ([ycFunction isInt: textField.text]) {
                        tmanager.mRobot.mData.mBaseSetting[key] = textField.text;
                    } else {
                        [ycFunction showMsg: @"格式错误" msg: nil vc: weakSelf.mSuperViewVC];
                    }
                }
                [tmanager.mRobot.mData saveBaseSettingFile];
                [mTableView reloadData];
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                if (![key isEqualToString: @"longhuRatioType"]) {
                    textField.text = tmanager.mRobot.mData.mBaseSetting[key];
                }
            }];
            [weakSelf.mSuperViewVC presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)getImageFromIpc: (int)tag {
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.view.tag = tag;
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self.mSuperViewVC presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSInteger tag = picker.view.tag;
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage* img = info[UIImagePickerControllerOriginalImage];
    if (img) {
        img = [ycFunction resizeImg:img size:CGSizeMake(750, 750/img.size.width*img.size.height)];
        if (0 == tag) {
            [tmanager.mRobot.mData saveBillHeadPic: img];
        } else {
            [tmanager.mRobot.mData saveBillTrendPic: img];
        }
        [mTableView reloadData];
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
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
        [switchview setOn: [tmanager.mRobot.mData.mBaseSetting[key] isEqualToString: @"true"]];
        cell.accessoryView = switchview;
    } else if(1 == celltype) {
        BOOL isShowNext = YES;
        NSString* rightText = @"";
        UIColor* rightTextColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
        if([key isEqualToString: @"headIndex"] || [key isEqualToString: @"trendIndex"]) {
            if ([tmanager.mRobot.mData.mBaseSetting[key] isEqualToString: @"true"]) {
                rightText = @"自定义";
            } else {
                rightText = @"默认";
            }
        }
        else {
            rightText = tmanager.mRobot.mData.mBaseSetting[key];
        }
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width/3, 22)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = rightText;
        label.textColor = rightTextColor;
        label.font = [UIFont systemFontOfSize: 16];
        label.center = CGPointMake(cell.contentView.frame.size.width/2-(isShowNext ? 10 : -10), cell.contentView.frame.size.height/2);
        [cell.contentView addSubview:label];
        [label release];
        if (isShowNext) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([key isEqualToString: @"titleR"] || [key isEqualToString: @"titleTextR"]) {
            if ([key isEqualToString: @"titleR"]) {
                label.text = @"背景颜色";
            } else {
                label.text = @"文字颜色";
            }
            int r = [tmanager.mRobot.mData.mBaseSetting[@"titleTextR"] intValue];
            int g = [tmanager.mRobot.mData.mBaseSetting[@"titleTextG"] intValue];
            int b = [tmanager.mRobot.mData.mBaseSetting[@"titleTextB"] intValue];
            label.textColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            r = [tmanager.mRobot.mData.mBaseSetting[@"titleR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"titleG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"titleB"] intValue];
            label.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(0, 0, 80, 22);
            label.center = CGPointMake(cell.contentView.frame.size.width/2+10, cell.contentView.frame.size.height/2);
        } else if([key isEqualToString: @"trendHighR"] || [key isEqualToString: @"trendCurrentR"]) {
            if ([key isEqualToString: @"trendHighR"]) {
                int r = [tmanager.mRobot.mData.mBaseSetting[@"trendHighR"] intValue];
                int g = [tmanager.mRobot.mData.mBaseSetting[@"trendHighG"] intValue];
                int b = [tmanager.mRobot.mData.mBaseSetting[@"trendHighB"] intValue];
                label.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            } else {
                int r = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentR"] intValue];
                int g = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentG"] intValue];
                int b = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentB"] intValue];
                label.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            }
            label.text = @"牛牛";
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize: 14];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(0, 0, 30, 30);
            label.center = CGPointMake(cell.contentView.frame.size.width/2+20, cell.contentView.frame.size.height/2);
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = label.bounds.size.width/2;
        }
    } else if(2 == celltype) {
        if ([key isEqualToString: @"clearnWechat"]) {
            titleColor = [UIColor colorWithRed: 1 green:0 blue:1 alpha:1];
        } else {
            titleColor = [UIColor redColor];
        }
    } else if(4 == celltype) {
        titleColor = [UIColor whiteColor];
    } else if(3 == celltype) {
        titleColor = [UIColor redColor];
        NSString* detailText = @"";
        if ([key isEqualToString: @"clearRound"] || [key isEqualToString: @"clearPartRound"]) {
            int start = 1;
            if ([tmanager.mRobot.mData.mRounds count] > 0) {
                start = [tmanager.mRobot.mData.mRounds[0][@"number"] intValue];
            }
            detailText = deString(@"开始局数:%d, 还能存储%d局", start, [tmanager.mRobot.mData maxSaveRound]-(int)[tmanager.mRobot.mData.mRounds count]);
        }
        else if([key isEqualToString: @"clearMemberScores"]) {
            detailText = deString(@"%d分", [tmanager.mRobot.mMembers getAllScoreCount]);
        }
        else if([key isEqualToString: @"clearMembers"]) {
            detailText = deString(@"%d个会员", (int)[tmanager.mRobot.mData.mMemberList count]);
        }
        else if([key isEqualToString: @"clearAdmin"]) {
            detailText = deString(@"%d个管理", (int)[tmanager.mRobot.mData.mAdminList count]);
        }
        else if([key isEqualToString: @"clearTuo"]) {
            detailText = deString(@"%d个托", [tmanager.mRobot.mTuos getTuoCount]);
        }
        else if([key isEqualToString: @"clearLashou"]) {
            detailText = deString(@"%d个拉手", (int)[tmanager.mRobot.mData.mLashouList count]);
        }
        else if([key isEqualToString: @"clearLashouHead"]) {
            detailText = deString(@"%d个团长", (int)[tmanager.mRobot.mData.mLashouHeadList count]);
        }
        cell.detailTextLabel.text = detailText;
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    } else if(5 == celltype) {
        if ([key isEqualToString: @"heshui"]) {
            BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"isHeshuiMode"] isEqualToString: @"true"];
            if (enable) {
                cell.detailTextLabel.text = @"已开启喝水模式";
                cell.detailTextLabel.textColor = [UIColor greenColor];
            } else {
                cell.detailTextLabel.text = @"已关闭喝水模式";
                cell.detailTextLabel.textColor = [UIColor redColor];
            }
        }else if ([key isEqualToString: @"mianyong"]) {
            BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportMianyong"] isEqualToString: @"true"];
            if (enable) {
                cell.detailTextLabel.text = @"已开启免佣模式";
                cell.detailTextLabel.textColor = [UIColor greenColor];
            } else {
                cell.detailTextLabel.text = @"已关闭免佣模式";
                cell.detailTextLabel.textColor = [UIColor redColor];
            }
        }else if ([key isEqualToString: @"yibi"]) {
            BOOL enable = [tmanager.mRobot.mData.mBaseSetting[@"supportYibi"] isEqualToString: @"true"];
            if (enable) {
                cell.detailTextLabel.text = @"已开启一比模式";
                cell.detailTextLabel.textColor = [UIColor greenColor];
            } else {
                cell.detailTextLabel.text = @"已关闭一比模式";
                cell.detailTextLabel.textColor = [UIColor redColor];
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    cell.textLabel.text = title;
    cell.textLabel.textColor = titleColor;
    return cell;
}

#pragma mark- perview
-(void) perview {
    if (mPreviewWindows) {
        [mPreviewWindows resignKeyWindow];
        mPreviewWindows.hidden = YES;
    }
    mPreviewWindows = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    mPreviewWindows.backgroundColor = [UIColor blackColor];
    mPreviewWindows.windowLevel = UIWindowLevelAlert+2;
    [mPreviewWindows makeKeyAndVisible];
    
    UIScrollView* view = [[UIScrollView alloc] initWithFrame: mPreviewWindows.frame];
    [mPreviewWindows addSubview: view];
    [view release];
    
    UIImage* img = [tmanager.mRobot.mMembers showPicTop: nil];
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.width/img.size.width*img.size.height)];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview: imgView];
    [imgView release];

    view.contentSize = imgView.frame.size;

    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewClick)];
    [view addGestureRecognizer: tap];
    [tap release];
}

-(void) previewClick {
    [mPreviewWindows resignKeyWindow];
    mPreviewWindows.hidden = YES;
    mPreviewWindows = nil;
}

@end
