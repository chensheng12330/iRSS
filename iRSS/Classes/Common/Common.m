//
//  Common.m
//  MPRSP
//
//  Created by sherwin on 13-4-19.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import "Common.h"
#import "SHKeyedArchiverManage.h"

static Common *_sharedCommon = nil;

@implementation Common


#pragma mark - object init
+(Common*) sharedCommon
{
    @synchronized(self)
    {
        if (nil == _sharedCommon ) {
            _sharedCommon = [[self alloc] init];
        }
    }
    return _sharedCommon;
}

+(id)alloc
{
    @synchronized([Common class]) //线程访问加锁
    {
        NSAssert(_sharedCommon == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedCommon  = [super alloc];
        return _sharedCommon;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
        //[self initDatabase];
        
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _sharedCommon) {
            _sharedCommon = [super allocWithZone:zone];
            return _sharedCommon;
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
    [super dealloc];
    _sharedCommon = nil;

}

- (oneway void)release
{
    // do nothing
    if( _sharedCommon == nil)
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


- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - SH CommonMethod

-(NSString*) getDeviceID
{
    return @"";
}

-(NSString*) getContentHtmlString:(NSString*) string Type:(int)type
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    NSString *filePathstring =[resourcePath stringByAppendingPathComponent:@"web_tpl.html"];
    
    //filePathstring = [filePathstring stringByReplacingOccurrencesOfString:@"Content" withString:@""];
    
    NSString*htmlstring=[[[NSString alloc] initWithContentsOfFile:filePathstring  encoding:NSUTF8StringEncoding error:nil] autorelease];
    
    htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"[Content]" withString:string];
    
    return htmlstring;
}

#pragma mark iOS5之前的拉伸方式
#pragma mark 返回一张已经拉伸好的图片
- (UIImage *)stretchiOS5before:(NSString *)icon {
    UIImage *image = [UIImage imageNamed:icon];
    CGFloat normalLeftCap = image.size.width * 0.5f;
    CGFloat normalTopCap = image.size.height * 0.5f;
    return [image stretchableImageWithLeftCapWidth:normalLeftCap topCapHeight:normalTopCap];
}

#pragma mark iOS5的拉伸方式
- (UIImage *) stretchiOS5:(NSString *)icon {
    UIImage *image = [UIImage imageNamed:icon];
    CGFloat normalLeftCap = image.size.width * 0.5f;
    CGFloat normalTopCap = image.size.height * 0.5f;
    // 13 * 34
    // 指定不需要拉伸的区域
    UIEdgeInsets insets = UIEdgeInsetsMake(normalTopCap, normalLeftCap, normalTopCap - 1, normalLeftCap - 1);
    return [image resizableImageWithCapInsets:insets];
}

#pragma mark iOS6的拉伸方式
- (UIImage *) stretchiOS6:(NSString *)icon {
    UIImage *image = [UIImage imageNamed:icon];
    CGFloat normalLeftCap = image.size.width * 0.5f;
    CGFloat normalTopCap = image.size.height * 0.5f;
    // 13 * 34
    // 指定不需要拉伸的区域
    UIEdgeInsets insets = UIEdgeInsetsMake(normalTopCap, normalLeftCap, normalTopCap - 1, normalLeftCap - 1);
    
    // ios6.0的拉伸方式只不过比iOS5.0多了一个拉伸模式参数
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
}
@end
