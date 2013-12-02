// Copyright (c) 2013 Mutual Mobile (http://mutualmobile.com/)
//

#import <UIKit/UIKit.h>

@interface MMTableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor * accessoryCheckmarkColor;
@property (nonatomic, strong) UIColor * disclosureIndicatorColor;

-(void)updateContentForNewContentSize;

@end
