// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "LZRedPageManager.h"

@interface GameController
+ (NSString *)getMD5ByGameContent:(unsigned int)arg1;
@end



//FILE *fopen(const char *restrict __filename, const char *restrict __mode)
%hookf (FILE *, fopen, const char * path, const char * mode){
    return %orig;
}

%hook BaseMsgContentViewController
//[BaseMsgContentViewController SendEmoticonMesssageToolView:]
//-[BaseMsgContentLogicController SendEmoticonMessage:]:
- (void)SendEmoticonMesssageToolView:(CEmoticonWrap *)arg1 {
    NSLog(@"[BaseMsgContentViewController SendEmoticonMesssageToolView:%@]", arg1);
    //m_uiGameType = 1 || 2
    // 4 4 5 8 5
    %orig;
}
%end



%hook BaseMsgContentLogicController
- (void)SendEmoticonMessage:(id)arg1 {
    %log;
    %orig;

}

%end


%hook GameController
+ (void)SetGameContentForMsgWrap:(CMessageWrap *)arg1{
    int count = 3;
    if([arg1 m_uiGameType] == 1){
        count = 3;
    }
    
    if([arg1 m_uiGameType] == 2){
        count = 9;
    }
    
    [arg1 setM_nsEmoticonMD5:[%c(GameController) getMD5ByGameContent:count]];
    [arg1 setM_uiGameContent:count];
    
//
//    int cont = [arg1 m_uiGameContent];
//
//    NSLog(@"sss");
//    {m_uiMesLocalID=0, m_ui64MesSvrID=0, m_nsFromUsr=lzl*340~12, m_nsToUsr=wxi*k22~19, m_uiStatus=1, type=47, msgSource="(null)"}
}
//+ (NSString *)getMD5ByGameContent:(unsigned int)arg1{
//    CMessageWrap *model = RedPageManager.emoticon;
//    int cont = [model m_uiGameContent];
//    int count = 0;
//
//    if([model m_uiGameType] == 1){
//        count = 3;
//    }
//
//    if([model m_uiGameType] == 2){
//        count = 9;
//    }
//
//    id r = %orig(count);
//    return r;
//}
%end


%hook CMessageMgr
- (void)AddEmoticonMsg:(id)arg1 MsgWrap:(id)arg2{
    %orig;
}

- (void)AddMsg:(id)arg1 MsgWrap:(id)arg2{
    %orig;
}
%end





