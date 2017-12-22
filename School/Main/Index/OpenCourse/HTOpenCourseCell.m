//
//  HTOpenCourseCell.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseCell.h"

@implementation HTOpenCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourseModel:(HTOpenCourseModel *)courseModel{
	_courseModel = courseModel;
	NSString *urlStr = [NSString stringWithFormat:@"http://open.viplgw.cn%@",courseModel.image];
	[self.courseImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:HTPLACEHOLDERIMAGE];
	self.courseTitleLabel.text = HTPlaceholderString(courseModel.title, courseModel.name);
	self.courseTimeLabel.text = [NSString stringWithFormat:@"时长:%@",courseModel.problemComplement];
	self.courseCreateTimeLabel.text = [NSString stringWithFormat:@"开课时间:%@",courseModel.cnName];
	[self.goodButton setTitle:courseModel.viewCount forState:UIControlStateNormal];
}

- (IBAction)goodAction:(UIButton *)sender {
}

@end
