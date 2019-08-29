//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  i11Dylib.m
//  i11Dylib
//
//  Created by 梁泽 on 2019/8/15.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import "i11Dylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>




CHDeclareClass(CLLocation)
CHOptimizedMethod0(self, CLLocationCoordinate2D, CLLocation, coordinate){
    //公司地址
    CLLocationDegrees latitude = 30.54596110026042;
    CLLocationDegrees longitude = 114.1967662217882;
    
    double ra = 50.00; //半径为50米
    double miperweidu = 111000 * cos(latitude * M_PI / 180);
    double randHudu = arc4random() % 36000 / (double)100 *M_PI / 180;
    double randVector = arc4random() % 10000 /(double)10000 * ra / miperweidu;
    double newLo = longitude + sin(randHudu) * randVector;
    double newLa = latitude + cos(randHudu) * randVector;
    if (newLo > 0 && newLo < 180) {
        longitude = newLo;
    }
    if (newLa > 0 && newLa < 80) {
        latitude = newLa;
    }
    return CLLocationCoordinate2DMake(latitude, longitude);
}

CHConstructor{
    CHLoadLateClass(CLLocation);
    CHClassHook0(CLLocation, coordinate);
    CHHook0(CLLocation, coordinate);
    
}
