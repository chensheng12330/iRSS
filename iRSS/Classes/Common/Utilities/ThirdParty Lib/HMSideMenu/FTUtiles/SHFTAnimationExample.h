//
//  SHFTAnimationExample.h
//  iNote
//
//  Created by sherwin.chen on 13-1-16.
//
//

#import <Foundation/Foundation.h>


@interface SHFTAnimationExample : NSObject

//触摸视图移动
+(void) MoveView:(UIView*)viewToAnimate inRect:(CGRect)_rect;
+(void) ReleaseMoveControl4View:(UIView*)viewToAnimate;
@end
