//
//  NSString+SHNSStringForDate.m
//  iNote
//
//  Created by Sherwin.Chen on 12-12-6.
//
//

#import "NSString+SHNSStringForDate.h"

@implementation NSString (SHNSStringForDate)

+(NSString*) stringFormatDate:(NSDate *)_date
{
    //NSAssert(_date != nil, @"Sherwin: SHNSStringForDate.stringFormatDate parmant is nil.");
    if (_date == nil) {
        
        return nil;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
    
    NSString *_tempstring = [format stringFromDate:_date];
    [format release];
    
    return _tempstring;
}

+(NSString*) stringFormatDateV1:(NSDate*)_date
{
    //NSAssert(_date != nil, @"Sherwin: SHNSStringForDate.stringFormatDate parmant is nil.");
    if (_date == nil) {
        
        return nil;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd'"];
    
    NSString *_tempstring = [format stringFromDate:_date];
    [format release];
    
    return _tempstring;
}

+(NSString*) stringFormatDateV2:(NSDate*)_date
{
    if (_date == nil) {
        
        return nil;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm'"];
    
    NSString *_tempstring = [format stringFromDate:_date];
    [format release];
    
    return _tempstring;
}

+(NSDate*) dateFormatString:(NSString*)_string
{
    //NSAssert(_string != nil, @"Sherwin: SHNSStringForDate.stringFormatDate parmant is nil.");
    if ([_string isEqualToString:@""]) {
        return nil;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
    
    NSDate *_date = [format dateFromString:_string];
    [format release];
    
    return _date;
}

//////
+(NSString*)ToStringWithNSDecimalNumber:(NSDecimalNumber*)_num
{
    double _dnum = [_num doubleValue];
    return [NSString stringWithFormat:@"%.2lf",_dnum];
}


+(NSDate*)ToNSDateWithNSDecimalNumber:(NSDecimalNumber*)_num precision:(float) _precision
{
    double _dnum = [_num doubleValue]/_precision;
    //NSString *str = [NSString stringWithFormat:@"%.lf",(_dnum/1000.0)];
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:_dnum];
    return data;
}

+(NSDate*)  ToNSDateWithDouble:(double) _num
{
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:_num];
    return data;
}

-(BOOL) stringIsNumeral
{
    if ([self isEqualToString:@""]) return NO;
    unichar ch0 ='0' , ch9 = '9', cho = '.';
    
    for (int i=0; i<[self length]; i++) {
        unichar ch = [self characterAtIndex:i];
        if ( (ch<ch0 || ch>ch9) && (ch != cho)) {
            return NO;
        }
    }
    return YES;
}

+(NSString*) getTimeIntervalSince1970WithNowTime
{
    NSTimeZone *zone = [NSTimeZone defaultTimeZone];//获得当前应用程序默认的时区
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];//以秒为单位返回当前应用程序与世界标准时间（格林威尼时间）的时差
    NSDate *localeDate = [[NSDate date] dateByAddingTimeInterval:interval];
    NSTimeInterval timeInterval2 = [localeDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lf",timeInterval2];
}

+(NSString*) getCurWeek
{
    //得到当前的日期
    
    NSDate *date = [NSDate date];
    
    //NSLog(@"date:%@",date);
    
    //得到(24 * 60 * 60)即24小时之前的日期，dateWithTimeIntervalSinceNow:
    
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(24* 60* 60)];
    
    NSLog(@"yesterday:%@",yesterday);
    
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    
    //NSDate *date_ = [NSDate date];
    
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    
    //int week=0;week1是星期天,week7是星期六;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger week = [comps weekday];
    NSString*weekStr=nil;
    if(week==1)
    {
        weekStr=@"星期天";
    }else if(week==2){
        weekStr=@"星期一";
    }else if(week==3){
        weekStr=@"星期二";   
    }else if(week==4){       
        weekStr=@"星期三";  
    }else if(week==5){
        weekStr=@"星期四";  
    }else if(week==6){
        weekStr=@"星期五";  
    }else if(week==7){
        weekStr=@"星期六";
    }
    return weekStr;
}
@end
