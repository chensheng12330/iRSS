//
//  SHFTAnimationExample.m
//  iNote
//
//  Created by sherwin.chen on 13-1-16.
//
//

#import "SHFTAnimationExample.h"
#import "FTUtils+UIGestureRecognizer.h"

@implementation SHFTAnimationExample

+(void) MoveView:(UIView*)viewToAnimate
          inRect:(CGRect)_rect
{
    // parameter check
    NSAssert(!(viewToAnimate == NULL || viewToAnimate.retainCount<1),
             @"SHFTAnimationExample->ControlViewMove: paramerter is null");
    
    viewToAnimate.userInteractionEnabled = YES;
    viewToAnimate.multipleTouchEnabled   = YES;
#if NS_BLOCKS_AVAILABLE
    
    [viewToAnimate addGestureRecognizer:
     [UIPanGestureRecognizer recognizerWithActionBlock:^(UIPanGestureRecognizer *pan) {
        if(pan.state == UIGestureRecognizerStateBegan ||
           pan.state == UIGestureRecognizerStateChanged) {
            CGPoint translation = [pan translationInView:viewToAnimate.superview];
            
            //update with sherwin.chen on 2013.1.24
            /*update log
             2013.1.28 add contains rect
            */
            
            CGPoint movePoint =  CGPointMake(viewToAnimate.center.x + translation.x,
                                                viewToAnimate.center.y + translation.y);
            
            if (CGRectContainsPoint(_rect,movePoint)) {
                viewToAnimate.center = movePoint;
                [pan setTranslation:CGPointZero inView:viewToAnimate.superview];
                
                NSLog(@"point:%f,%f",viewToAnimate.center.x,viewToAnimate.center.y);
                //move message
                [viewToAnimate touchesMoved:nil withEvent:nil];
            }
            else
            {

            }
            
            
        }
        if ([pan state] == UIGestureRecognizerStateEnded) {
            //touchesEnded
            [viewToAnimate touchesEnded:nil withEvent:nil];
        }
    }]];
    
    UIPinchGestureRecognizer *thePinch = [UIPinchGestureRecognizer recognizer];
    thePinch.actionBlock = ^(UIPinchGestureRecognizer *pinch) {
        if ([pinch state] == UIGestureRecognizerStateBegan ||
            [pinch state] == UIGestureRecognizerStateChanged) {
            viewToAnimate.transform = CGAffineTransformScale(viewToAnimate.transform, pinch.scale, pinch.scale);
            
            [pinch setScale:1];
        }
    };
    [viewToAnimate addGestureRecognizer:thePinch];
    
    UITapGestureRecognizer *doubleTap = [UITapGestureRecognizer recognizerWithActionBlock:^(id dTap) {
        thePinch.disabled = !thePinch.disabled;
        [UIView animateWithDuration:.25f animations:^{
            viewToAnimate.transform = CGAffineTransformIdentity;
        }];
    }];
    doubleTap.numberOfTapsRequired = 2;
    [viewToAnimate addGestureRecognizer:doubleTap];
    
#endif
    
}
+(void) ReleaseMoveControl4View:(UIView*)viewToAnimate
{
    // parameter check
    NSAssert(!(viewToAnimate == NULL || viewToAnimate.retainCount<1),
             @"SHFTAnimationExample->ReleaseControlView: paramerter is null");
    
    for(UIGestureRecognizer *recognizer in viewToAnimate.gestureRecognizers) {
        [viewToAnimate removeGestureRecognizer:recognizer];
    }
}
@end
