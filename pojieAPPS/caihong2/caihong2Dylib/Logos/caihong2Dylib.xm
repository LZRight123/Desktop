// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "caihong2Dylib.h"

%hook LTHTTPSessionManager
+ (id)getData:(NSString *)path withParameter:(id)arg2 success:(id /*block*/)arg3 fail:(id /*block*/)arg4 {
//    https://ioscccc.mxyl520.cn/wd/210009_config_20190103.json
//    http://game9180.com:8889/wd/210009_config_20190103.json
//    http://103.216.154.254/wd/210009_config_20190103.json
    %log;
    NSString *newPath = newpathWith(path);
    id r = %orig(newPath, arg2, arg3, arg4);
    return r;
}
+ (id)postData:(NSString *)path withParameter:(id)arg2 success:(id /*block*/)arg3 fail:(id /*block*/)arg4 {
//https://ioscccccccc.mxyl520.cn/api/sdk_log!addActivateLog.action
    %log;
    NSString *newPath = newpathWith(path);
    id r = %orig(newPath, arg2, arg3, arg4);
    return r;
}
%end


