//
//  RSSCategoryCell.m
//  iRSS
//
//  Created by sherwin.chen on 14-3-8.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryCell.h"

@implementation RSSCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_ivImageView release];
    [_lbTitile release];
    [_lbNum release];
    [super dealloc];
}
@end
