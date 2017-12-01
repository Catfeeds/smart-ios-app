//
//  HTDropBoxDetailLeftCell.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxDetailLeftCell.h"

@interface HTDropBoxDetailLeftCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTDropBoxDetailLeftCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSeparatorStyleNone;
	[self addSubview:self.titleNameLabel];
	self.titleNameLabel.translatesAutoresizingMaskIntoConstraints = false;
	NSString *titleNameLabelString = @"titleNameLabelString";
	NSDictionary *viewBinding = @{titleNameLabelString:self.titleNameLabel};
	NSString *horizontal = [NSString stringWithFormat:@"H:|[%@]|", titleNameLabelString];
	NSString *vertical = [NSString stringWithFormat:@"V:|[%@]|", titleNameLabelString];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vertical options:kNilOptions metrics:nil views:viewBinding]];
}

- (void)setModel:(id <HTDropBoxProtocol> )model {
	self.titleNameLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	self.titleNameLabel.backgroundColor = selected ? [UIColor whiteColor] : [UIColor clearColor];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor lightGrayColor];
		_titleNameLabel.font = [UIFont systemFontOfSize:13];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameLabel;
}

@end
