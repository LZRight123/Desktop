//
//  ForgeIdentifier.h
//  wechatHook
//
//  Created by antion on 2018/4/11.
//
//

#import <Foundation/Foundation.h>

@interface ForgeIdentifier : NSObject

+(ForgeIdentifier*) getInst;

-(void) resetAll;

-(NSString*) get_advertisingIdentifier;
-(NSString*) get_identifierForVendor;
-(NSString*) get_client_seq_id;

@end

