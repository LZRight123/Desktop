// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "LZHelpTool.h"

%hook NSBundle
- (NSString *)bundleIdentifier{
    if (isCallFromOriginApp()){
        LZLog(@"检测了bundleIdentifier");
        return @"com.qq.com";
    }
    return %orig;
}
%end
