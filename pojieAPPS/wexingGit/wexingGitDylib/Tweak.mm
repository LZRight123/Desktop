#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/Tweak.xm"


#import <UIKit/UIKit.h>
#import "LZRedPageManager.h"

@interface GameController
+ (NSString *)getMD5ByGameContent:(unsigned int)arg1;
@end





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

@class BaseMsgContentViewController; @class BaseMsgContentLogicController; @class CMessageMgr; @class GameController; 
static void (*_logos_orig$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$)(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentViewController* _LOGOS_SELF_CONST, SEL, CEmoticonWrap *); static void _logos_method$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentViewController* _LOGOS_SELF_CONST, SEL, CEmoticonWrap *); static void (*_logos_orig$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$)(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentLogicController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentLogicController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$GameController$SetGameContentForMsgWrap$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, CMessageWrap *); static void _logos_meta_method$_ungrouped$GameController$SetGameContentForMsgWrap$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, CMessageWrap *); static void (*_logos_orig$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$GameController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("GameController"); } return _klass; }
#line 13 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/Tweak.xm"
__unused static FILE * (*_logos_orig$_ungrouped$fopen)(const char * path, const char * mode); __unused static FILE * _logos_function$_ungrouped$fopen(const char * path, const char * mode){
    return _logos_orig$_ungrouped$fopen(path, mode);
}




static void _logos_method$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CEmoticonWrap * arg1) {
    NSLog(@"[BaseMsgContentViewController SendEmoticonMesssageToolView:%@]", arg1);
    
    
    _logos_orig$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$(self, _cmd, arg1);
}





static void _logos_method$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$(_LOGOS_SELF_TYPE_NORMAL BaseMsgContentLogicController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    HBLogDebug(@"-[<BaseMsgContentLogicController: %p> SendEmoticonMessage:%@]", self, arg1);
    _logos_orig$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$(self, _cmd, arg1);

}





static void _logos_meta_method$_ungrouped$GameController$SetGameContentForMsgWrap$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CMessageWrap * arg1){
    int count = 3;
    if([arg1 m_uiGameType] == 1){
        count = 3;
    }
    
    if([arg1 m_uiGameType] == 2){
        count = 9;
    }
    
    [arg1 setM_nsEmoticonMD5:[_logos_static_class_lookup$GameController() getMD5ByGameContent:count]];
    [arg1 setM_uiGameContent:count];
    





}




















static void _logos_method$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    _logos_orig$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$(self, _cmd, arg1, arg2);
}

static void _logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    _logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(self, _cmd, arg1, arg2);
}




static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$BaseMsgContentViewController = objc_getClass("BaseMsgContentViewController"); MSHookMessageEx(_logos_class$_ungrouped$BaseMsgContentViewController, @selector(SendEmoticonMesssageToolView:), (IMP)&_logos_method$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$, (IMP*)&_logos_orig$_ungrouped$BaseMsgContentViewController$SendEmoticonMesssageToolView$);Class _logos_class$_ungrouped$BaseMsgContentLogicController = objc_getClass("BaseMsgContentLogicController"); MSHookMessageEx(_logos_class$_ungrouped$BaseMsgContentLogicController, @selector(SendEmoticonMessage:), (IMP)&_logos_method$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$, (IMP*)&_logos_orig$_ungrouped$BaseMsgContentLogicController$SendEmoticonMessage$);Class _logos_class$_ungrouped$GameController = objc_getClass("GameController"); Class _logos_metaclass$_ungrouped$GameController = object_getClass(_logos_class$_ungrouped$GameController); MSHookMessageEx(_logos_metaclass$_ungrouped$GameController, @selector(SetGameContentForMsgWrap:), (IMP)&_logos_meta_method$_ungrouped$GameController$SetGameContentForMsgWrap$, (IMP*)&_logos_meta_orig$_ungrouped$GameController$SetGameContentForMsgWrap$);Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(AddEmoticonMsg:MsgWrap:), (IMP)&_logos_method$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$AddEmoticonMsg$MsgWrap$);MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(AddMsg:MsgWrap:), (IMP)&_logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$); MSHookFunction((void *)fopen, (void *)&_logos_function$_ungrouped$fopen, (void **)&_logos_orig$_ungrouped$fopen);} }
#line 91 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/Tweak.xm"
