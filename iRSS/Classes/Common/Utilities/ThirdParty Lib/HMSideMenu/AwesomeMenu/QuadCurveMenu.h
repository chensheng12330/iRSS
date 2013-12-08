//
//  QuadCurveMenu.h
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuadCurveMenuItem.h"

@protocol QuadCurveMenuDelegate;


@interface QuadCurveMenu : UIView <QuadCurveMenuItemDelegate>
{
    NSArray *_menusArray;
    int _flag;
    NSTimer *_timer;
    QuadCurveMenuItem *_addButton;
    
    CGPoint oldPoint;
    
    id<QuadCurveMenuDelegate> _delegate;
    
    NSTimer *toolDrawerFadeTimer;

}

@property (assign) float fDurationToFade;
@property (nonatomic, copy) NSArray *menusArray;
@property (nonatomic, getter = isExpanding)     BOOL expanding;
@property (nonatomic, assign) id<QuadCurveMenuDelegate> delegate;
- (id)initWithFrame:(CGRect)frame menus:(NSArray *)aMenusArray addImage:(UIImage *) image;
@end

@protocol QuadCurveMenuDelegate <NSObject>
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx;
@end