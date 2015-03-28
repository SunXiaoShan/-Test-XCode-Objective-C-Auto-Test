//
//  AutoTableViewCell.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/16.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "AutoTableViewCell.h"

@implementation AutoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    // label
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 80, 50)];
    [self.mLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.mLabel];

    // text
    self.mTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 180, 50)];
    [self.mTextField setBackgroundColor:[UIColor yellowColor]];
    [self.mTextField setTextColor:[UIColor blackColor]];
    [self addSubview:self.mTextField];
    
    return self;
}

@end
