// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "LZHelpTool.h"

#import "xctheos.h"

%hook UIView
- (void)addSubview:(UIView *)view{
    %orig;

}
%end

