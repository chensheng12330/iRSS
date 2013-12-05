//
//  MKNetworkEngineEx.m
//  iRSS
//
//  Created by sherwin on 13-12-5.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "MKNetworkEngineEx.h"

static MKNetworkEngineEx *mkNetReqEngineEx;

@implementation MKNetworkEngineEx

+(id) shareMKNetworkEngineEx
{
    @synchronized(self)
    {
        if (mkNetReqEngineEx ==NULL) {
            mkNetReqEngineEx = [[self alloc] initWithHostName:@"google.com.hk"];
            mkNetReqEngineEx.opersInfoDict  = [[[NSMutableDictionary alloc] initWithCapacity:3] autorelease];
        }
    }
    return self;
}
@end
