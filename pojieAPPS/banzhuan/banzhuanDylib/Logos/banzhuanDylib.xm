// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>


%hook HttpTool
+ (void)postWithBaseURL:(id)baseurl path:(NSString *)path params:(NSDictionary *)params success:(id/*block*/)success failure:(id/*block*/)failure{
    %log;
//    if ([path isEqualToString:@"/index/member/register"]){
//        NSLog(@"没上报");
//        return ;
//    } else {
//        %orig;
//
//    }
    %orig;

}
%end

%hook STool
+ (id)md5:(id)arg1 {
    %log;
    id r = %orig;
    return @"";
}
+ (void)saveObject:(id)arg1 forKey:(id)arg2 { %log; %orig; }
+ (void)showAlertWithMessage:(id)arg1 { %log; %orig; }
+ (id)getNewStrWithDictionary:(id)arg1 {
//    [STool md5:1.4com.recycle.easyiPhone 6s PlusB7C76C82-CB78-48F2-897A-FA72D844FA56com.cv.bfs12.1036{"timeStamp":"1563195735","isVPNOn":false,"battery":"91%-Charging","registeredDate":"1563195688","ctCarrier":"02-460-cn","HMotion":[[-8,25,0],[-9,24,0],[-10,24,2],[10,0,27],[5,1,0]],"purchaserDSID":0,"resetDate":"1551227884","systemPlistDate":"1549347287","isJailBroken":false,"RegionInfo":"CH\/A","iphoneType":"iPhone8,2","brightness":"33583","screenSize":"1242*2208"}1563195735bzl]
//    c7259550876b70fd45c8c7c2a1a03f54
//    {
//        timeap = 1563195601;
//        app_version = 1.4;
//        bundle_id = com.recycle.easy;
//        taskId = 36;
//        testInfo = {"timeStamp":"1563195601","isVPNOn":false,"battery":"91%-Charging","registeredDate":"1563195585","ctCarrier":"02-460-cn","HMotion":[[7,29,12],[7,27,12],[8,23,9],[4,17,23],[11,19,7]],"purchaserDSID":0,"resetDate":"1551227884","systemPlistDate":"1549347287","isJailBroken":false,"RegionInfo":"CH\/A","iphoneType":"iPhone8,2","brightness":"34496","screenSize":"1242*2208"};
//        sysVersion = 12.10;
//        device_type = iPhone 6s Plus;
//        packageName = com.cv.bfs;
//        idfa = B7C76C82-CB78-48F2-897A-FA72D844FA56
//    }
//    id testInfo = arg1[@"testInfo"];
//    5514C2A7-1F8B-4318-A244-E5400F32B670
    %log;
    id r = %orig;
    return r;
//    631d48b49947bd40ed8c9eafc95943ed
}
%end

//%hook MainController
//- (void)PickUpQuick:(id)arg{
//    %log;
//    %orig;
//}
//%end


%hook NSUserDefaults
- (void)setObject:(id)value forKey:(NSString *)defaultName{
    
    if ([defaultName isEqualToString:@"unicode"]){
//        bzl5514C2A7-1F8B-4318-A244-E5400F32B670

        NSLog(@"");
    }
    %orig;
}

- (id)objectForKey:(NSString *)defaultName
{
    if ([defaultName isEqualToString:@"unicode"]){
        NSLog(@"");
    }
    NSLog(@"%s\n%@", __func__, %orig);
    return %orig;
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    BOOL a = %orig;
    BOOL system = ([defaultName containsString:@"UI"] || [defaultName containsString:@"NS"] || [defaultName containsString:@"Kit"]);
    if (system) {return a;}
    %log;
    NSLog(@"defaultName == %@ %d", defaultName, a);
    //    if ([defaultName isEqual:@"xk_hohohohob"]) { return NO; }
    return %orig;
}

- (NSString *)stringForKey:(NSString *)defaultName
{
    if ([defaultName isEqualToString:@"unicode"]){
        NSLog(@"");
    }
    %log;
    return %orig;
}

%end
