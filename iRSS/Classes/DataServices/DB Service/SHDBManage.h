//
//  SHDBManage.h
//  iNote
//
//  Created by Sherwin.Chen on 12-12-7.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#ifndef DBMQuickCheck//(SomeBool)
#define DBMQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }
#endif

#ifndef DBMRollback//(SomeBool)
#define DBMRollback(SomeBool) { if (!(SomeBool)) { [db rollback]; return NO;} }
#endif

//log out flag
#ifndef DEBUG_OUT
#define DEBUG_OUT 1
#endif

//0 FALSE
//1 nil
#ifndef DEBUG_DB_ERROR_LOG
#define DEBUG_DB_ERROR_LOG { if(DEBUG_OUT) { if([db hadError]){ NSLog(@"DB ERROR: %@ on line %d",[db lastErrorMessage],__LINE__);return FALSE;}}}
#endif



#define SHDBM [SHDBManage sharedDBManage]

@interface SHDBManage : NSObject
{
@private
    
}

@property (nonatomic, readonly) FMDatabase *db;
@property(readonly) NSString *dbErrorInfo;
//***************************************
//object init Method

/*
 初使化对象唯一方法
 */
+(SHDBManage*) sharedDBManage;


@end
