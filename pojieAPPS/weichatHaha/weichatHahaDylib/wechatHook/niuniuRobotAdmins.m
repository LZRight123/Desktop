//
//  niuniuRobotAdmins.m
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//

#import "niuniuRobotAdmins.h"
#import "toolManager.h"
#import "wxFunction.h"
#import "ycFunction.h"

@implementation niuniuRobotAdmins

-(id) init {
    if (self = [super init]) {
        [self performSelector: @selector(removeSurplusKeys) withObject: nil afterDelay: .1];
    }
    return self;
}

//删除多余的key
-(void) removeSurplusKeys {
    BOOL hasChange = NO;
    NSArray* pows = [self getAllPowers];
    for (NSString* userid in tmanager.mRobot.mData.mAdminList) {
        NSMutableDictionary* dic = tmanager.mRobot.mData.mAdminList[userid];
        NSArray* keys = [dic allKeys];
        for (NSString* key in keys) {
            BOOL exist = NO;
            for (NSArray* array in pows) {
                if ([array[0] isEqualToString: key]) {
                    exist = YES;
                    break;
                }
            }
            if (!exist) {
                [dic removeObjectForKey: key];
                hasChange = YES;
            }
        }
    }
    if (hasChange) {
        [tmanager.mRobot.mData saveAdminListFile];
    }
}

//添加管理员
-(void) addAdmin:(NSString*)userid {
    if (!tmanager.mRobot.mData.mAdminList[userid]) {
        tmanager.mRobot.mData.mAdminList[userid] = [NSMutableDictionary dictionary];
        [tmanager.mRobot.mData saveAdminListFile];
    }
    
}

//删除管理员
-(void) delAdmin:(NSString*)userid {
    if (tmanager.mRobot.mData.mAdminList[userid]) {
        [tmanager.mRobot.mData.mAdminList removeObjectForKey: userid];
        [tmanager.mRobot.mData saveAdminListFile];
    }
}

//是否管理员
-(BOOL) isAdmin:(NSString*)userid {
    return tmanager.mRobot.mData.mAdminList[userid];
}

//获取权限个数
-(int) getPowerCount:(NSString*)userid {
    NSDictionary* dic = tmanager.mRobot.mData.mAdminList[userid];
    if (!dic) {
        return 0;
    }
    return (int)([[self getAllPowers] count]-[dic count]);
}

//是否有权限
-(BOOL) hasPower:(NSString*)userid key:(NSString*)key {
    NSDictionary* dic = tmanager.mRobot.mData.mAdminList[userid];
    return dic && !dic[key];
}

//编辑权限
-(void) setPower:(NSString*)userid key:(NSString*)key isEnable:(BOOL)isEnable {
    NSMutableDictionary* dic = tmanager.mRobot.mData.mAdminList[userid];
    if (dic) {
        if (isEnable) {
            [dic removeObjectForKey: key];
        } else {
            dic[key] = @"true";
        }
        [tmanager.mRobot.mData saveAdminListFile];
    }
}

//设置所有权限
-(void) setAllPower:(NSString*)userid isEnable:(BOOL)isEnable {
    NSMutableDictionary* dic = tmanager.mRobot.mData.mAdminList[userid];
    if (dic) {
        if (isEnable) {
            [dic removeAllObjects];
        } else {
            NSArray* pows = [self getAllPowers];
            for (NSArray* array in pows) {
                dic[array[0]] = @"true";
            }
        }
        [tmanager.mRobot.mData saveAdminListFile];
    }
}

-(NSArray*) getAllAdminDetail {
    NSMutableArray* ret = [NSMutableArray array];
    id CContactMgr = [wxFunction getMgr: @"CContactMgr"];
    for (NSString* userid in tmanager.mRobot.mData.mAdminList) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = userid;
        id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
        if (CBaseContact) {
            NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
            dic[@"name"] = m_nsNickName;
        }
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (memData) {
            dic[@"billName"] = memData[@"billName"];
            dic[@"score"] = memData[@"score"];
            dic[@"index"] = memData[@"index"];
        }
        [ret addObject: dic];
    }
    [ret sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (!a[@"index"]) {
            return 1;
        }
        if (!b[@"index"]) {
            return -1;
        }
        return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
    }];
    return ret;
}

//获取所有权限信息
-(NSArray*) getAllPowers {
    return @[
             @[@"bangzhu", @"帮助"],
             @[@"shangxiafen", @"上下分"],
             @[@"zhuanyi", @"转移"],
             @[@"chaliushui", @"查流水"],
             @[@"daochusuoyoushuju", @"导出所有数据"],
             @[@"chasuoyoushangxiafen", @"查所有上下分"],
             @[@"chudan", @"出单"],
             @[@"chashuying", @"查输赢"],
             @[@"chafanshui", @"查奖励"],
             @[@"zhixingfanshui", @"执行奖励"],
             @[@"quxiaofanshui", @"取消奖励"],
             @[@"shangjujiangli", @"上局奖励[数字]"],
             @[@"chasuoyoulashou", @"查所有拉手"],
             @[@"chagailv", @"查概率"],
             @[@"chadianshu", @"查点数"],
             @[@"chamingxi", @"查明细"],
             @[@"chatongji", @"查统计"],
             @[@"chalingbao", @"查领包"],
             @[@"chashangxiafen", @"查上下分"],
             @[@"chaguanlishangxiafen", @"查管理上下分"],
             @[@"chajushu", @"查局数"],
             @[@"chalashou", @"查拉手"],
             @[@"chatuo", @"查托名单"],
             @[@"chatuodianbao", @"查托点包"],
             @[@"tuofenqingling", @"托分清零"],
             @[@"tianjiatuo", @"添加托"],
             @[@"shanchutuo", @"删除托"],
             @[@"tianjialashou", @"添加拉手"],
             @[@"shanchulashou", @"删除拉手"],
             @[@"tianjiatuanzhang", @"添加团长"],
             @[@"shanchutuanzhang", @"删除团长"],
             @[@"chaxiugai", @"查修改"],
             @[@"qinglidangan", @"清理档案"],
             ];
}

@end
