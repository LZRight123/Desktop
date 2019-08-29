#line 1 "/Users/liangze/Documents/Desktop/Example/TestImon/TestImonDylib/TweakEmpty.xm"


#import <UIKit/UIKit.h>
#import "LZHelpTool.h"

#import "xctheos.h"


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIView; 
static void (*_logos_orig$_ungrouped$UIView$addSubview$)(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIView *); static void _logos_method$_ungrouped$UIView$addSubview$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIView *); 

#line 8 "/Users/liangze/Documents/Desktop/Example/TestImon/TestImonDylib/TweakEmpty.xm"

static void _logos_method$_ungrouped$UIView$addSubview$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIView * view){
    _logos_orig$_ungrouped$UIView$addSubview$(self, _cmd, view);

}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIView = objc_getClass("UIView"); MSHookMessageEx(_logos_class$_ungrouped$UIView, @selector(addSubview:), (IMP)&_logos_method$_ungrouped$UIView$addSubview$, (IMP*)&_logos_orig$_ungrouped$UIView$addSubview$);} }
#line 15 "/Users/liangze/Documents/Desktop/Example/TestImon/TestImonDylib/TweakEmpty.xm"
