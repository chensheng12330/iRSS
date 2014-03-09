//
//  RSSCategoryEntity.m

//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryEntity.h"

@implementation RSSCategoryEntity

- (id)init
{
    self = [super init];
    if (self) {
        self.strIconName    = @"icon";
        self.strName        = nil;
        self.nRssNum        = 0;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    self.nRssNum = 0;
    self.strName = nil;
    self.strIconName=nil;
}

-(id) initWithDictionary:(NSDictionary*) dict
{
    if (dict==NULL) {
        DLog(@"War2: Dictionary cannot is NULL.");
        return nil;
    }
    self = [self init];
    
    self.nId            = [[dict objectForKey:@"id"] integerValue];
    self.nRssNum        = [[dict objectForKey:@"rssNum"] integerValue];
    self.strName        = [dict objectForKey:@"name"];
    self.strIconName    = [dict objectForKey:@"iconName"];
    
    return self;
}

//KVC
-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    
}



-(NSString *)description
{
    NSString *superStr = [super description];
    superStr = [superStr stringByAppendingFormat:@"CateName:[%@], Icon:[%@], RSSNum:[%d]",_strName,_strIconName,_nRssNum];
    return superStr;
}

@end

//+(void) get
//{
//    RSSCategoryEntity *rss = [[RSSCategoryEntity alloc] init];
//    
//    //key use
//    [rss setValue:@"sherwin.chen" forKey:@"strName"];
//    [rss setValue:@"iRSS.icon"    forKey:@"strIconName"];
//    
//    NSString* strRSSName = [rss valueForKey:@"strName"];
//    NSString* strIconName= [rss valueForKey:@"strIconName"];
//    
//    //normal use
//    strRSSName = rss.strName;
//    strIconName= rss.strIconName;
//}
//@implementation RSSEntity
//-(id)initWithDictionary:(NSDictionary *)jsonDict
//{
//    if (self=[super init]) {
//        [self init];
//        [self setValuesForKeysWithDictionary:jsonDict];
//    }
//    return self;
//}
//
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"id"]) {
//        self.itemID = value;
//    }
//    else if ([key isEqualToString:@"date"]) {
//        self.unixDate = [value integerValue];
//    }
//    else
//    {
//        NSLog(@"RSSEntity: Undefined Key: %@", key);
//        [super setValue:value forKeyPath:key];
//    }
//    return;
//}
//
//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    if ([key isEqualToString:@"userInfo"]) {
//        self.userInfo = [[[UserInfoEntity alloc] initWithDictionary:value] autorelease];
//    }
//    else
//    {
//        [super setValue:value forKey:key];
//    }
//    
//    [rss valueForKeyPath:@"userInfo.name"];
//    [rss setValue:@"sherwin.chen" forKeyPath:"userInfo.name"];
//}
//@end

