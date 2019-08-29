//
//  niuniuSupportDragView.h
//  wechatHook
//
//  Created by antion on 2017/3/9.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

typedef enum{
    niuniuSupportDragTypeDrag   = 1 << 0,
    niuniuSupportDragTypeOnce   = 1 << 1,
    niuniuSupportDragTypeDouble = 1 << 2,
    
    niuniuSupportDragTypeDefault = niuniuSupportDragTypeDrag|niuniuSupportDragTypeOnce,
    niuniuSupportDragTypeALL    = niuniuSupportDragTypeDrag|niuniuSupportDragTypeOnce|niuniuSupportDragTypeDouble,

}niuniuSupportDragType;

#define deSupportDrag(a, b, c, d) [[niuniuSupportDragView alloc] initWithView: a maxh: b h: c mask: d]
@interface niuniuSupportDragView : UIView

-(id) initWithView:(UIView*)superView maxh:(int)maxh h:(int)h mask:(int)mask;

@property (copy, nonatomic) funcEnd mDoubleFunc;

@end
