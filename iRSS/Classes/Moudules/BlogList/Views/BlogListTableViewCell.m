// Copyright (c) 2013 Mutual Mobile (http://mutualmobile.com/)
//



#import "BlogListTableViewCell.h"

@implementation BlogListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryCheckmarkColor:[UIColor colorWithRed:13.0/255.0
                                                         green:88.0/255.0
                                                          blue:161.0/255.0
                                                         alpha:1.0]];
    }
    
    _lbTitile = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 21)];
    _lbDate   = [[UILabel alloc] initWithFrame:CGRectMake(183, 88, 117, 21)];
    _lbCreator= [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 155, 21)];
    
    NSArray *lbAry = @[_lbCreator,_lbDate,_lbTitile];
    for (UILabel *lab in lbAry) {
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:13]];
        
        [self addSubview:lab];
    }
    [_lbDate  setTextColor:[UIColor orangeColor]];
    
    _tvSummary= [[UITextView alloc] initWithFrame:CGRectMake(13, 18, 287, 71)];
    [_tvSummary setBackgroundColor:[UIColor clearColor]];
    [_tvSummary setFont:[UIFont systemFontOfSize:13]];
    [_tvSummary setTextColor:[UIColor blueColor]];
    [_tvSummary setEditable:NO];
    //[_tvSummary setUserInteractionEnabled:NO];
    
    [self addSubview:_tvSummary];
    return self;
}

- (void)dealloc
{
    self.lbTitile   = nil;
    self.tvSummary  = nil;
    self.lbDate     = nil;
    self.lbCreator  = nil;
    [super dealloc];
}

-(void)updateContentForNewContentSize{
    if([[UIFont class] respondsToSelector:@selector(preferredFontForTextStyle:)]){
        [self.textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    }
}
@end
