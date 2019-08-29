//
//  ycDefine.h
//  wechatHook
//
//  Created by antion mac on 2016/12/3.
//
//

#ifndef ycDefine_h
#define ycDefine_h

/**
 *  完美解决Xcode NSLog打印不全的宏 亲测目前支持到8.2bate版
 */
#ifdef DEBUG
//#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define deBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define deMainQueue dispatch_get_main_queue()

typedef void(^funcEnd)();
typedef void(^funcFinish)(BOOL);

#ifdef deDebug
#define deLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define deLog(format, ...)
#endif

#define deMarkFrame(x) \
{UIView* p = x; \
p.layer.masksToBounds = YES;  \
p.layer.borderWidth = 1;  \
p.layer.borderColor = [[UIColor grayColor] CGColor];}

#define deDelFrame(x) \
{UIView* p = x; \
p.layer.masksToBounds = NO; \
p.layer.borderWidth = 0;}

#define deFrameOriginSet(p1,p2) \
{CGRect r = p1.frame; \
r.origin = p2; \
p1.frame = r;}

#define deFrameSizeSet(p,s) \
{CGRect r = p.frame; \
r.size = s; \
p.frame = r;}

#define deInt2String(d) [NSString stringWithFormat: @"%d", d]
#define deInt2Number(d) [NSNumber numberWithInt: d]
#define deString(format, ...) [NSString stringWithFormat: format, ## __VA_ARGS__]

#endif
