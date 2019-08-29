//
//  niuniuRobotRework.m
//  wechatHook
//
//  Created by antion on 2017/12/7.
//
//

#import "niuniuRobotRework.h"
#import "toolManager.h"
#import "ycDefine.h"
#import "ycFunction.h"
#import "wxFunction.h"

@implementation niuniuRobotRework

//添加标题
-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

-(NSString*) resultStr:(NSString*)str {
    NSDictionary* config = @{
                             @"overtime" : @"超时",
                             @"asLast" : @"认尾",
                             @"bankerHead" : @"平赔",
                             @"noWin" : @"无输赢",
                             @"normal" : @"正常",
                             };
    NSString* ret = config[str];
    return ret ? ret : @"无";
}

-(void) addReworkRecord: (NSDictionary*)dic {
    BOOL isSend = NO;
    NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"robotRework"];
    if ([rooms count] > 0 && [wxFunction checkIsInChatroom: rooms[0]]) {
        isSend = YES;
        NSMutableString* text = [NSMutableString string];
        do {
            if ([dic[@"type"] isEqualToString: @"scoreChange"]) {
                [text appendString: [self addTitle: @"机器上下分"]];
            }
            else if ([dic[@"type"] isEqualToString: @"amountChange"]) {
                [text appendString: [self addTitle: @"修改点数"]];
            }
            else if ([dic[@"type"] isEqualToString: @"betChange"]) {
                [text appendString: [self addTitle: @"修改押注"]];
            }
            else if ([dic[@"type"] isEqualToString: @"resultChange"]) {
                [text appendString: [self addTitle: @"修改结算状态"]];
            }
            else if ([dic[@"type"] isEqualToString: @"tuoDelete"]) {
                [text appendString: [self addTitle: @"删除托"]];
            }
            else if ([dic[@"type"] isEqualToString: @"betImport"]) {
                [text appendString: [self addTitle: @"押注单导入"]];
                [text appendString: dic[@"msg"]];
                break;
            }
            else if ([dic[@"type"] isEqualToString: @"hongbaoImport"]) {
                [text appendString: [self addTitle: @"红包外部导入"]];
                break;
            }
            else if ([dic[@"type"] isEqualToString: @"showBillMore"]) {
                [text appendString: [self addTitle: @"二次出单"]];
                [text appendFormat: @"%@局二次以上出单", dic[@"round"]];
                break;
            }
            
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                [text appendFormat: @"编号: %@\n", memData[@"index"]];
                [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
                [text appendFormat: @"昵称: %@\n", memData[@"name"]];
                [text appendFormat: @"单名: %@\n", memData[@"billName"]];
            } else {
                [text appendFormat: @"微信: %@\n", dic[@"userid"]];
                [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
            }
            
            if ([dic[@"type"] isEqualToString: @"scoreChange"]) {
                int oldScore = [dic[@"oldScore"] intValue];
                int newScore = [dic[@"newScore"] intValue];
                int changeScore = newScore - oldScore;
                [text appendFormat: @"原分: %d  %@  %d\n", oldScore, changeScore < 0 ? @"-" : @"+", abs(changeScore)];
                [text appendFormat: @"现分: %d\n", newScore];
            }
            else if ([dic[@"type"] isEqualToString: @"amountChange"]) {
                float oldAmount = [dic[@"oldAmount"] floatValue];
                float newAmount = [dic[@"newAmount"] floatValue];
                [text appendFormat: @"原点数: %.2f\n", oldAmount];
                [text appendFormat: @"现点数: %.2f\n", newAmount];
            }
            else if ([dic[@"type"] isEqualToString: @"betChange"]) {
                [text appendFormat: @"原押注: %@\n", dic[@"oldBet"]];
                [text appendFormat: @"现押注: %@\n", dic[@"newBet"]];
            }
            else if ([dic[@"type"] isEqualToString: @"resultChange"]) {
                NSString* oldResult = [self resultStr: dic[@"oldResult"]];
                NSString* newResult = [self resultStr: dic[@"newResult"]];
                [text appendFormat: @"原状态: %@\n", oldResult];
                [text appendFormat: @"现状态: %@\n", newResult];
            }
            else if([dic[@"type"] isEqualToString: @"tuoDelete"]) {
                [text appendFormat: @"操作者: %@\n", dic[@"admin"] ? dic[@"admin"] : @"机器人"];
            }
        } while (0);
        [tmanager.mRobot.mSendMsg sendText: rooms[0] content: text at: nil title:@""];
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary: dic];
    params[@"round"] = deInt2String(tmanager.mRobot.mNumber);
    params[@"time"] = [ycFunction getCurrentTimestamp];
    params[@"isSend"] = isSend ? @"true" : @"false";
    [tmanager.mRobot.mData.mReworksList addObject: params];
    [tmanager.mRobot.mData saveReworksFile];
}

@end
