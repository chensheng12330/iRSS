//
//  SHAPPResource.h
//  TestFrame
//
//  Created by sherwin.chen on 13-6-5.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLocalizedImageName(name) \
[[SHAPPResource shareAppResource] NSLocalizedImageName:name]

#define NSLocalizedFont(name,size) \
[[SHAPPResource shareAppResource] NSLocalizedFontWithName:name Size:size]


#define NSLocalizedColor(name) \
[[SHAPPResource shareAppResource] NSLocalizedColorWithName:name]


#define IMAGE_KIND 1

@interface SHAPPResource : NSObject

+(id) shareAppResource;

-(NSString*) NSLocalizedImageName:(NSString*)imageName;

-(UIFont*)   NSLocalizedFontWithName:(NSString *) name Size:(CGFloat) size;

-(UIColor*)  NSLocalizedColorWithName:(NSString *) name;

@end
