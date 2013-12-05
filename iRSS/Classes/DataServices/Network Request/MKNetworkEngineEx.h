//
//  MKNetworkEngineEx.h
//  iRSS
//
//  Created by sherwin on 13-12-5.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "MKNetworkKit.h"

#define MKNET [MKNetworkEngineEx shareMKNetworkEngineEx]

@interface MKNetworkEngineEx : MKNetworkEngine

@property (nonatomic, retain) NSMutableDictionary* opersInfoDict; //当前运行的线程

+(id) shareMKNetworkEngineEx;
@end
