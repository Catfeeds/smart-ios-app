//
//  HTMatriculateAllCell.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateAllCell.h"
#import "HTMatriculateRecordModel.h"

@implementation HTMatriculateAllCell

- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	self.selectionStyle = UITableViewCellSelectionStyleGray;
	self.backgroundColor = [UIColor whiteColor];
	
	self.scoreCountLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.scoreCountLabel.font = [UIFont systemFontOfSize:19];
	
	[self.detailNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	UIColor *normalBackgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	UIColor *highlightBackgroundColor = [normalBackgroundColor colorWithAlphaComponent:0.5];
	[self.detailNameButton setBackgroundImage:[UIImage ht_pureColor:normalBackgroundColor] forState:UIControlStateNormal];
	[self.detailNameButton setBackgroundImage:[UIImage ht_pureColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
	[self.detailNameButton setTitle:@"查看详情" forState:UIControlStateNormal];
	self.detailNameButton.titleLabel.font = [UIFont systemFontOfSize:13];
	self.detailNameButton.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
	self.detailNameButton.layer.cornerRadius = 3;
	self.detailNameButton.layer.masksToBounds = true;
	self.detailNameButton.userInteractionEnabled = false;
	
	self.matriculateDateLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
}

- (void)setModel:(HTMatriculateRecordAllSchoolModel *)model row:(NSInteger)row {
	self.scoreCountLabel.text = [NSString stringWithFormat:@"%@分", model.score];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createTime.integerValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSString *createTimeString = [formatter stringFromDate:date];
    self.matriculateDateLabel.text = createTimeString;
}

@end
