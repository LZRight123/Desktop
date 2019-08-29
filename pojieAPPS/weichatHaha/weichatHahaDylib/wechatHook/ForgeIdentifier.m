//
//  ForgeIdentifier.m
//  wechatHook
//
//  Created by antion on 2018/4/11.
//
//

#import "ForgeIdentifier.h"
#import "ycFunction.h"

@implementation ForgeIdentifier {
    NSString* clientSeqID;
    NSString* advertisingIdentifier;
    NSString* identifierForVendor;
}

+(ForgeIdentifier*) getInst {
    static ForgeIdentifier* inst = nil;
    if (!inst) {
        inst = [ForgeIdentifier new];
    }
    return inst;
}

-(id) init {
    self = [super init];
    if (self) {
        [self resetAll];
    }
    return self;
}

-(void) resetAll {
    if (clientSeqID) {
        [clientSeqID release];
        clientSeqID = nil;
    }
    if (advertisingIdentifier) {
        [advertisingIdentifier release];
        advertisingIdentifier = nil;
    }
    if (identifierForVendor) {
        [identifierForVendor release];
        identifierForVendor = nil;
    }
}

-(NSString*) get_advertisingIdentifier {
    if (!advertisingIdentifier) {
        advertisingIdentifier = [[ycFunction randomIdentifier] retain];
    }
    return advertisingIdentifier;
}

-(NSString*) get_identifierForVendor {
    if (!identifierForVendor) {
        identifierForVendor = [[ycFunction randomIdentifier] retain];
    }
    return identifierForVendor;
}

-(NSString*) get_client_seq_id {
    if (!clientSeqID) {
        NSString* str = [[ycFunction randomIdentifier] lowercaseString];
        clientSeqID = [[str stringByReplacingOccurrencesOfString:@"-" withString:@""] retain];
    }
    return clientSeqID;
}

@end
