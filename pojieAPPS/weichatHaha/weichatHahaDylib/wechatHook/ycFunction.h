//
//  ycFunction.h
//  wechatHook
//
//  Created by antion on 16/11/13.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface ycFunction : NSObject

+(NSDictionary*) devicesInfo;
+(NSString*) myUUID;
+(NSString*) randomIdentifier;
+(NSString*) getRandomStringWithNum:(NSInteger)num;
+(NSString*) operators;
+(NSString*) getCurrentNetType;
+(NSString*) getCachesDirectory;
+(int) getBattery;
+(void) compressJPG:(NSDictionary*)dic;
+(float) availableMemory;
+(float) usedMemory;
+(NSString*)getCurrentTimestamp;
+(NSString*) getFormatTimeStr:(NSDate*)date format:(NSString*)format;
+(NSString*) getTodayDate;
+(NSString*) getLastdayDate;
+(NSString*) getLastdayDateWithDate:(NSString*)date;
+(id) getVar:(id)inst name:(NSString*)name;
+(int) getVarInt:(id)inst name:(NSString*)name;
+(long long) getVarLonglong:(id)inst name:(NSString*)name;
+(void) setVar:(id)inst name:(NSString*)name value:(id)value;
+(void) setVarInt:(id)inst name:(NSString*)name value:(int)value;
+(id) executeMethod: (NSString*)className inst:(id)inst sel:(SEL)sel;
+(void) lookAllMethod: (NSString*)className;
+(void) lookAllVar: (id)inst;
+(BOOL) isFileExist:(NSString*)filename;
+(NSDictionary*) readFile: (NSString*)filename;
+(NSArray*) readFileArray: (NSString*)filename;
+(void) saveFile: (NSString*)filename dic:(NSDictionary*)dic;
+(void) saveFileArray: (NSString*)filename array:(NSArray*)array;
+(NSString*) fullFilename:(NSString*)filename;
+(UIViewController*)getCurrentRootViewController;
+(UIViewController*)getCurrentVisableVC;
+(UIViewController*) getVCWithWindow: (UIView*)view;
+(UIWindow*)getWindow;
+(BOOL)isPureInt:(NSString *)string;
+(void) setScreenWillLight:(BOOL)b;
+(int) xcheck: (int)x w:(int)w;
+(int) ycheck: (int)y h:(int)h;
+(NSString*) formatFloatStr:(NSString*)str;
+(void) pushView:(UIView*)v1 view:(UIView*)v2 dur:(float)dur completion:(void (^ __nullable)(BOOL finished))func;
+(void) popView:(UIView*)v1 view:(UIView*)v2 dur:(float)dur completion:(void (^ __nullable)(BOOL finished))func;
+(BOOL) isInt: (NSString*)str;
+(BOOL) isFloat: (NSString*)str;
+(void) cellAddRightText: (UITableViewCell*)cell text:(NSString*)text color:(UIColor*)color size:(int)size offset:(int)offset;
+(void) cellAddRightBtn: (UITableViewCell*)cell tableView:(UITableView*)tableView text: (NSString*)text func:(funcEnd)func offset:(int)offset;
+(void) cellAddRightBtn: (UITableViewCell*)cell tableView:(UITableView*)tableView text: (NSString*)text func:(funcEnd)func;
+(void) cellAddIcon: (UITableViewCell*)cell image: (UIImage*)image size:(int)size;
+(void) playSound:(NSString*)filename type:(NSString*)type;
+(BOOL) textIsValidate: (NSString*)text;
+(UIImage*) resizeImg:(UIImage*)img size:(CGSize)size;
+(void) showMsg:(NSString*)title msg:(NSString*)msg vc:(UIViewController*)vc;
//单个文件的大小
+(long long) fileSizeAtPath:(NSString*) filePath;
//遍历文件夹获得文件夹大小，返回多少M
+(float ) folderSizeAtPath:(NSString*) folderPath;
+(void) lookAllChildPath:(NSString*)path;
+(UIImage*) savePicWithView:(UIView*)view compressValue:(float)compressValue;
+(void) savePicFile:(UIImage*)img path:(NSString*)path;
+(UIImage*) getPicFile:(NSString*)path;
+(BOOL) containsSpecialStr:(NSString*)text;
+(BOOL) czip:(NSString*)zipfilepath pw:(NSString*)pw files:(NSDictionary*)files;
+(BOOL) uzip:(NSString*)zipfilepath pw:(NSString*)pw outFileRoot:(NSString*)outFileRoot;

@end
