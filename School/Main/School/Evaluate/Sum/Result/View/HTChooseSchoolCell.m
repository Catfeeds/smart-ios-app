//
//  HTChooseSchoolCell.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolCell.h"

@implementation HTChooseSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSchool:(HTResultSchool *)school{
    _school = school;
    [self.schoolImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(school.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.schoolNameLabel.text = school.name;
    self.EnglishNameLabel.text = school.title;
    self.addressLabel.text = [NSString stringWithFormat:@"所在地区:%@",school.place];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
