//
//  RSSListEntity.h
//  iRSS
//
//  Created by sherwin on 13-12-3.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "Entity.h"

@interface RSSListEntity : Entity
@property (nonatomic, copy) NSString *strRssName;
@property (nonatomic, copy) NSString *strRssUrl;
@property (nonatomic, copy) NSString *strRssClass;
@property (nonatomic, assign) NSInteger nUnReadNum; //未读blog条数
@property (nonatomic, retain) NSDate *deAdd_time;   //增加的时间
@end
