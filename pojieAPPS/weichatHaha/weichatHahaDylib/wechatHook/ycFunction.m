//
//  ycFunction.m
//  wechatHook
//
//  Created by antion on 16/11/13.
//
//

#import "ycFunction.h"
#import "ycButtonView.h"
#import <objc/runtime.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#include <dlfcn.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ZipArchive.h"

@implementation ycFunction

+(CTTelephonyNetworkInfo*) getTelInfo {
    static CTTelephonyNetworkInfo* ret = nil;
    if (!ret) {
        ret = [[CTTelephonyNetworkInfo alloc] init];
    }
    return ret;
}

+(NSDictionary*) devicesInfo {
    NSMutableDictionary* dic = [@{} mutableCopy];
    dic[@"name"] = [UIDevice currentDevice].name;
    dic[@"model"] = [UIDevice currentDevice].model;
    dic[@"systemName"] = [UIDevice currentDevice].systemName;
    dic[@"systemVersion"] = [UIDevice currentDevice].systemVersion;
    dic[@"uuid"] = [ycFunction myUUID];
    
    NSString* carrier = [ycFunction operators];
    if (carrier) {
        dic[@"carrier"] = carrier;
    } else {
        dic[@"carrier"] = @"null";
    }
    
    NSString* currentNetType = [ycFunction getCurrentNetType];
    if (currentNetType) {
        dic[@"currentNetType"] = currentNetType;
    } else {
        dic[@"currentNetType"] = @"null"; 
    }
    return dic;
}

+(NSString*) myUUID {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getRandomStringWithNum:(NSInteger)num {
    NSMutableString* string = [NSMutableString string];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 16;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            [string appendString: tempString];
        }else {
            int figure = (arc4random() % 6) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            [string appendString: tempString];
        }
    }
    return string;
}

+(NSString*) randomIdentifier {
    NSString* str1 = [ycFunction getRandomStringWithNum: 8];
    NSString* str2 = [ycFunction getRandomStringWithNum: 4];
    NSString* str3 = [ycFunction getRandomStringWithNum: 4];
    NSString* str4 = [ycFunction getRandomStringWithNum: 4];
    NSString* str5 = [ycFunction getRandomStringWithNum: 12];
    return [[NSString stringWithFormat:@"%@-%@-%@-%@-%@", str1, str2, str3, str4, str5] uppercaseString];
}

+(NSString*) operators {
    CTTelephonyNetworkInfo *info = [ycFunction getTelInfo];
    if (info) {
        CTCarrier *carrier = [info subscriberCellularProvider];
        if (carrier) {
            return [carrier carrierName];
        }
    }
    return nil;
}

+(NSString*) getCurrentNetType {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CTTelephonyNetworkInfo *info = [ycFunction getTelInfo];
        if (info) {
            return info.currentRadioAccessTechnology;
        }
    }
    return nil;
}

+(NSString*) getCachesDirectory {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (paths && paths.count > 0) {
        return [paths lastObject];
    }
    return @"";
}

+(int) getBattery {
    return (int)([UIDevice currentDevice].batteryLevel*100);
}

+(void) compressJPG:(NSDictionary*)dic {
    UIImage* img = [UIImage imageNamed: dic[@"input"]];
    NSData* data = UIImageJPEGRepresentation(img, .65);
    [data writeToFile:dic[@"output"] atomically: YES];
}

// 获取当前设备可用内存(单位：MB）
+(float) availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return (float)(vm_page_size*vmStats.free_count / 1024.0 / 1024.0);
}

// 获取当前任务所占用的内存（单位：MB）
+(float) usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return (float)(taskInfo.resident_size / 1024.0 / 1024.0);
}

+(NSString*)getCurrentTimestamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    return timeString;
}

+(NSString*) getFormatTimeStr:(NSDate*)date format:(NSString*)format {
    NSDateFormatter* f = [[[NSDateFormatter alloc] init] autorelease];
    [f setDateFormat: format];
    return [f stringFromDate: date];
}

+(NSString*) getTodayDate {
    return [ycFunction getFormatTimeStr: [NSDate date] format: @"YYYY-MM-dd"];
}

+(NSString*) getLastdayDate {
    NSDate* date = [NSDate date];//当前时间
    NSDate* lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate: date];//前一天
    return [ycFunction getFormatTimeStr: lastDay format: @"YYYY-MM-dd"];
}

+(NSString*) getLastdayDateWithDate:(NSString*)theDate {
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [objDateformat dateFromString: theDate];
    long long time = [date timeIntervalSince1970] + 8*60*60 - 24*60*60;
    date = [NSDate dateWithTimeIntervalSince1970: time];
    return [ycFunction getFormatTimeStr: date format: @"YYYY-MM-dd"];
}

+(id) getVar:(id)inst name:(NSString*)name {
    Ivar ivar = class_getInstanceVariable([inst class], [name UTF8String]);
    return object_getIvar(inst, ivar);
}

+(int) getVarInt:(id)inst name:(NSString*)name {
    Ivar ivar = class_getInstanceVariable([inst class], [name UTF8String]);
    return object_getIvar(inst, ivar);
}

+(long long) getVarLonglong:(id)inst name:(NSString*)name {
    Ivar ivar = class_getInstanceVariable([inst class], [name UTF8String]);
    return object_getIvar(inst, ivar);
}

+(void) setVar:(id)inst name:(NSString*)name value:(id)value {
    Ivar ivar = class_getInstanceVariable([inst class], [name UTF8String]);
    object_setIvar(inst, ivar, value);
}

+(void) setVarInt:(id)inst name:(NSString*)name value:(int)value {
    Ivar ivar = class_getInstanceVariable([inst class], [name UTF8String]);
    object_setIvar(inst, ivar, value);
}

+(id) executeMethod: (NSString*)className inst:(id)inst sel:(SEL)sel {
    Method method = class_getInstanceMethod(objc_getClass([className UTF8String]), sel);
    IMP impGS = method_getImplementation(method);
    return impGS(inst, sel);
}

+(void) lookAllMethod: (NSString*)className {
    const char *cClassName = [className UTF8String];
    id theClass = objc_getClass(cClassName);
    unsigned int outCount;
    Method *m =  class_copyMethodList(theClass,&outCount);
    NSLog(@"%@ ->method count: %d",className, outCount);
    for (int i = 0; i<outCount; i++) {
        SEL a = method_getName(*(m+i));
        NSString *sn = NSStringFromSelector(a);
        NSLog(@"%@",sn);
    }
}

+(void) lookAllVar: (id)inst {
    {
        unsigned int outCount = 0;
        Ivar * ivars = class_copyIvarList([inst class], &outCount);
        for (int i = 0; i < outCount; ++i) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            const char * type = ivar_getTypeEncoding(ivar);
            NSString* classType = deString(@"%s", type);
            if ([classType hasPrefix: @"@"]) {
                id value = object_getIvar(inst, ivar);
                NSLog(@"%s, %s, %@", type, name,value);
            } else {
                int value = object_getIvar(inst, ivar);
                NSLog(@"%s, %s, %d", type, name,value);
            }
            
        }
        free(ivars);
    }{
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList([inst class], &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++ ) {
            objc_property_t thisProperty = propertyList[i];
            const char* propertyName = property_getName(thisProperty);
            const char* attributes = property_getAttributes(thisProperty);
            NSString* classType = deString(@"%s", attributes);
            NSString* name = deString(@"%s", propertyName);
            if ([classType containsString: @"@"]) {
                id value = [ycFunction getVar:inst name:name];
                NSLog(@"%s, %s, %@", attributes, propertyName,value);
            } else {
                int value = [ycFunction getVarInt:inst name:name];
                NSLog(@"%s, %s, %d", attributes, propertyName,value);
            }
        }
        free(propertyList);
    }
}

+(UIViewController*)getCurrentRootViewController {
    UIViewController *result;
    
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        return nil;
        //NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;
}

+(BOOL) isFileExist:(NSString*)filename {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    return [[NSFileManager defaultManager] fileExistsAtPath: path];
}

+(NSDictionary*) readFile: (NSString*)filename {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    return [NSDictionary dictionaryWithContentsOfFile: path];
}

+(NSArray*) readFileArray: (NSString*)filename {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    return [NSArray arrayWithContentsOfFile: path];
}

+(void) saveFile: (NSString*)filename dic:(NSDictionary*)dic {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    [dic writeToFile: path atomically: YES];
}

+(void) saveFileArray: (NSString*)filename array:(NSArray*)array {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    [array writeToFile: path atomically: YES];
}

+(NSString*) fullFilename:(NSString*)filename {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], filename];
    return path;
}


//必须是UITabBarController类型的视图
+(UIViewController*)getCurrentVisableVC {
    id root = [ycFunction getCurrentRootViewController];
    if (!root) {
        return nil;
    }
    
    if (![root isKindOfClass: [UITabBarController class]]) {
        return nil;
    }
    UITabBarController* tab = root;
    return ((UINavigationController*)tab.selectedViewController).visibleViewController;
}

+(UIViewController*) getVCWithWindow: (UIView*)view {
    id nextResponder = [view nextResponder];
    if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }
    for (UIView* subview in [view subviews]) {
        id ret = [self getVCWithWindow: subview];
        if (ret) {
            return ret;
        }
    }
    return nil;
}

+(UIWindow*)getWindow {
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    return topWindow;
}

//是否数字
+(BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//手机常亮
+(void) setScreenWillLight:(BOOL)b {
    [UIApplication sharedApplication].idleTimerDisabled = b;
}

//x坐标边缘检测
+(int) xcheck: (int)x w:(int)w {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return x < 0 ? 0 : x + w > width ? width - w : x;
}

//y坐标边缘检测
+(int) ycheck: (int)y h:(int)h {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return y < 0 ? 0 : y + h > height ? height - h : y;
}

+(NSString*) formatFloatStr:(NSString*)str {
    float num = [str floatValue];
    int num2 = (int)num;
    if (num2 == num) {
        return deInt2String(num2);
    }
    return str;
}

+(void) pushView:(UIView*)v1 view:(UIView*)v2 dur:(float)dur completion:(void (^ __nullable)(BOOL finished))func {
    CGRect frame1 = v1.frame;
    CGRect frame2 = v2.frame;
    
    frame2.origin = CGPointMake(frame1.origin.x+frame1.size.width, frame1.origin.y);
    v2.frame = frame2;

    frame1.origin = CGPointMake(-frame2.size.width, frame1.origin.y);
    frame2.origin = v1.frame.origin;
    
    [UIView animateWithDuration: dur animations: ^(void) {
        v1.frame = frame1;
        v2.frame = frame2;
    } completion: ^(BOOL b) {
        if (func) {
            func(b);
        }
    }];
}

+(void) popView:(UIView*)v1 view:(UIView*)v2 dur:(float)dur completion:(void (^ __nullable)(BOOL finished))func {
    CGRect frame1 = v1.frame;
    CGRect frame2 = v2.frame;
    frame1.origin = frame2.origin;
    frame2.origin = CGPointMake(frame1.origin.x+frame1.size.width, frame1.origin.y);
    [UIView animateWithDuration: dur animations: ^(void) {
        v1.frame = frame1;
        v2.frame = frame2;
    } completion: ^(BOOL b) {
        if (func) {
            func(b);
        }
    }];
}

+(BOOL) isInt: (NSString*)str {
    NSScanner* scan = [NSScanner scannerWithString: str];
    int value;
    if (![scan scanInt: &value] || ![scan isAtEnd]) {
        return NO;
    }
    return YES;
}

+(BOOL) isFloat: (NSString*)str {
    NSScanner* scan = [NSScanner scannerWithString: str];
    float value;
    if (![scan scanFloat: &value] || ![scan isAtEnd]) {
        return NO;
    }
    return YES;
}

+(void) cellAddRightText: (UITableViewCell*)cell text:(NSString*)text color:(UIColor*)color size:(int)size offset:(int)offset{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width/3, 22)];
    label.textAlignment = NSTextAlignmentRight;
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize: size];
    label.center = CGPointMake(cell.contentView.frame.size.width/2-10+offset, cell.contentView.frame.size.height/2);
    [cell.contentView addSubview:label];
    [label release];
}

+(void) cellAddRightBtn: (UITableViewCell*)cell tableView:(UITableView*)tableView text: (NSString*)text func:(funcEnd)func offset:(int)offset {
    ycButtonView* btn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 64, 32) text:text func: func];
    [btn setScrollView: tableView];
    btn.center = CGPointMake(cell.contentView.frame.size.width-135+offset, cell.contentView.frame.size.height/2);
    [cell.contentView addSubview:btn];
    [btn release];
}

+(void) cellAddRightBtn: (UITableViewCell*)cell tableView:(UITableView*)tableView text: (NSString*)text func:(funcEnd)func {
    [ycFunction cellAddRightBtn: cell tableView: tableView text: text func: func offset: 0];
}

+(void) cellAddIcon: (UITableViewCell*)cell image: (UIImage*)image size:(int)size {
    if (image.size.width == size && image.size.height == size) {
        cell.imageView.image = image;
    } else {
        CGSize itemSize = CGSizeMake(size, size);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

+(void) playSound:(NSString*)filename type:(NSString*)type {
    //定义URl，要播放的音乐文件是win.wav
    NSURL *audioPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:filename ofType:type]];
    //定义SystemSoundID
    SystemSoundID soundId;
    //C语言的方法调用
    //注册服务
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioPath, &soundId);
    //增添回调方法
    AudioServicesAddSystemSoundCompletion(soundId,NULL, NULL, NULL, NULL);
    //开始播放
    AudioServicesPlayAlertSound(soundId);
}


+(BOOL) textIsValidate: (NSString*)text {
    return [text length] == [[text dataUsingEncoding:NSUTF8StringEncoding] length];
}

+(UIImage*) resizeImg:(UIImage*)img size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [img drawInRect:imageRect];
    UIImage* ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}

+(void) showMsg:(NSString*)title msg:(NSString*)msg vc:(UIViewController*)vc {
    if (vc) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message: msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [vc presentViewController:alertController animated:YES completion:nil];
    } else {
        [[[[UIAlertView alloc] initWithTitle: title message: msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
    }
}

//单个文件的大小
+(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+(float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    float folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+(void) lookAllChildPath:(NSString*)path {
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator;
    myDirectoryEnumerator=[myFileManager enumeratorAtPath:path];
    
    //列举目录内容，可以遍历子目录
    NSLog(@"用enumeratorAtPath:显示目录%@的内容：",path);
    
    while((path=[myDirectoryEnumerator nextObject])!=nil) {
        NSLog(@"%@", path);
    }
}

+(UIImage*) savePicWithView:(UIView*)view compressValue:(float)compressValue {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(compressValue < 1){//压缩
        NSData* data = UIImageJPEGRepresentation(viewImage, compressValue);
        if (data) {
            viewImage = [UIImage imageWithData: data];
        }
    }
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    return viewImage;
}

+(void) savePicFile:(UIImage*)img path:(NSString*)path {
    path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], path];
    NSData* data = UIImagePNGRepresentation(img);
    [data writeToFile:path atomically: YES];
}

+(UIImage*) getPicFile:(NSString*)path {
    path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], path];
    NSData *imageData = [NSData dataWithContentsOfFile: path];
    UIImage *image = [UIImage imageWithData: imageData];
    return image;
}

+(BOOL) containsSpecialStr:(NSString*)text {
    NSString *str =@"^[\\u0000-\u0c00\\u4e00-\u9fa5\\u2600-\u27ff]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

+(BOOL) czip:(NSString*)zipfilepath pw:(NSString*)pw files:(NSDictionary*)files {    
    ZipArchive* zip = [[[ZipArchive alloc] init] autorelease];
    if (pw) {
        if ([zip CreateZipFile2: zipfilepath Password:pw]) {
            return NO;
        }
    } else {
        if (![zip CreateZipFile2: zipfilepath]) {
            return NO;
        }
    }
    
    for (NSString* filename in files) {
        NSString* filepath = files[filename];
        if (![zip addFileToZip: filepath newname: filename]) {
            return NO;
        }
    }
    
    if( ![zip CloseZipFile2] ){
        return NO;
    }
    return YES;
}

+(BOOL) uzip:(NSString*)zipfilepath pw:(NSString*)pw outFileRoot:(NSString*)outFileRoot {
    ZipArchive* zip = [[[ZipArchive alloc] init] autorelease];
    if (pw) {
        if (![zip UnzipOpenFile: zipfilepath Password:pw]) {
            return NO;
        }
    } else {
        if (![zip UnzipOpenFile: zipfilepath]) {
            return NO;
        }
    }
    
    if (![zip UnzipFileTo:outFileRoot overWrite:YES]) {
        return NO;
    }
    
    if (![zip UnzipCloseFile]) {
        return NO;
    }
    return YES;
}

@end
