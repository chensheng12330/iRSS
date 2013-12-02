// Copyright (c) 2013 Mutual Mobile (http://mutualmobile.com/)
//



#import "RSSListTableViewCell.h"

@implementation MMCenterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryCheckmarkColor:[UIColor colorWithRed:13.0/255.0
                                                         green:88.0/255.0
                                                          blue:161.0/255.0
                                                         alpha:1.0]];
    }
    return self;
}

-(void)updateContentForNewContentSize{
    if([[UIFont class] respondsToSelector:@selector(preferredFontForTextStyle:)]){
        [self.textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    }
}
@end
