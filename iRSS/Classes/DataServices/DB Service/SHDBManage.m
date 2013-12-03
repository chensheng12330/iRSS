//
//  SHDBManage.m
//  iNote
//
//  Created by Sherwin.Chen on 12-12-7.
//
//

#import "SHDBManage.h"

//expand NSString head


static SHDBManage *_sharedDBManage = nil;

@interface SHDBManage ()
@property (nonatomic, retain) FMDatabase *db;
@end


@implementation SHDBManage
@synthesize dbErrorInfo = _dbErrorInfo;

#pragma mark - object init
+(SHDBManage*) sharedDBManage
{
    @synchronized(self)
    {
        if (nil == _sharedDBManage ) {
            _sharedDBManage = [[self alloc] init];
        }
    }
    return _sharedDBManage;
}

+(id)alloc
{
    @synchronized([SHDBManage class]) //线程访问加锁
    {
        NSAssert(_sharedDBManage == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedDBManage  = [super alloc];
        return _sharedDBManage;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
        _db = [[FMDatabase alloc] initWithDBName:@"irss.db"];
        DBMQuickCheck([_db open]);
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _sharedDBManage) {
            _sharedDBManage = [super allocWithZone:zone];
            return _sharedDBManage;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    [_dbErrorInfo release];
    /*
     other property release
     */
    if (_db==nil) { return;}
    else         {[_db close]; [_db release]; _db =nil;}
    
    [super dealloc];
    _sharedDBManage = nil;
}

- (oneway void)release
{
    // do nothing
    if(_db==nil)
    {
        NSLog(@"SHDBManage: retainCount is 0.");
        return;
    }
    [super release];
    return;
}

- (id)retain
{
    return self;
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - SHDBManage_Private_fuction
@end
