//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "JLRoutes.h"

@class NSString, UINavigationController, UIWindow;

@interface Router : JLRoutes
{
    UIWindow *originKeyWindow;
    UINavigationController *_currentNavigationController;
    NSString *_cacheRouterURL;
}

+ (id)shareInstance;
@property(copy, nonatomic) NSString *cacheRouterURL; // @synthesize cacheRouterURL=_cacheRouterURL;
@property(nonatomic) __weak UINavigationController *currentNavigationController; // @synthesize currentNavigationController=_currentNavigationController;
- (void).cxx_destruct;
- (void)addRoute:(id)arg1 handler:(CDUnknownBlockType)arg2;
- (_Bool)routeURL:(id)arg1 withParameters:(id)arg2;
- (_Bool)routeURL:(id)arg1;
- (_Bool)canRouteURL:(id)arg1;
- (void)setup;

@end

