//
//  HTDropBoxDetailTableCell.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxDetailTableCell.h"

@interface HTDropBoxDetailTableCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation HTDropBoxDetailTableCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self addSubview:self.titleNameButton];
	[self addSubview:self.rightImageView];
	self.titleNameButton.translatesAutoresizingMaskIntoConstraints = false;
	self.rightImageView.translatesAutoresizingMaskIntoConstraints = false;
	NSString *titleNameButtonString = @"titleNameButtonString";
	NSString *rightImageString = @"rightImageString";
	NSDictionary *viewBinding = @{titleNameButtonString:self.titleNameButton, rightImageString:self.rightImageView};
	NSString *horizontal = [NSString stringWithFormat:@"H:|[%@][%@(15)]-15-|", titleNameButtonString, rightImageString];
	NSString *buttonVertical = [NSString stringWithFormat:@"V:|[%@]|", titleNameButtonString];
	NSString *imageVertical = [NSString stringWithFormat:@"V:|-[%@(15)]-|", rightImageString];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:buttonVertical options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:imageVertical options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewBinding]];
}

- (void)setModel:(id <HTDropBoxProtocol> )model {
	[self.titleNameButton setTitle:model.title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	self.titleNameButton.selected = selected;
	self.rightImageView.hidden = !selected;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		[_titleNameButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
		_titleNameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

- (UIImageView *)rightImageView {
	if (!_rightImageView) {
		_rightImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_selected_right"];
		_rightImageView.image = image;
	}
	return _rightImageView;
}

@end
