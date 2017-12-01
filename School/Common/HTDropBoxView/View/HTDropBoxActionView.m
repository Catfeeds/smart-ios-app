//
//  HTDropBoxActionView.m
//  School
//
//  Created by hublot on 2017/9/23.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxActionView.h"

@interface HTDropBoxActionView ()

@end

@implementation HTDropBoxActionView

- (void)didMoveToSuperview {
	[self addSubview:self.cancelNameButton];
	[self addSubview:self.sureNameButton];
	self.cancelNameButton.translatesAutoresizingMaskIntoConstraints = false;
	self.sureNameButton.translatesAutoresizingMaskIntoConstraints = false;
	NSString *cancelButtonString = @"cancelButtonString";
	NSString *sureButtonString = @"sureButtonString";
	NSDictionary *viewBinding = @{cancelButtonString:self.cancelNameButton, sureButtonString:self.sureNameButton};
	NSString *horizontal = [NSString stringWithFormat:@"H:|[%@][%@(==%@)]|", cancelButtonString, sureButtonString, cancelButtonString];
	NSString *cancelVertical = [NSString stringWithFormat:@"V:|[%@]|", cancelButtonString];
	NSString *sureVertical = [NSString stringWithFormat:@"V:|[%@]|", sureButtonString];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:cancelVertical options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:sureVertical options:kNilOptions metrics:nil views:viewBinding]];
}

- (UIButton *)createNormalButton {
	UIButton *button = [[UIButton alloc] init];
	button.titleLabel.font = [UIFont systemFontOfSize:15];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	return button;
}

- (UIButton *)cancelNameButton {
	if (!_cancelNameButton) {
		_cancelNameButton = [self createNormalButton];
		[_cancelNameButton setTitle:@"取消" forState:UIControlStateNormal];
		_cancelNameButton.backgroundColor = [UIColor lightGrayColor];
	}
	return _cancelNameButton;
}

- (UIButton *)sureNameButton {
	if (!_sureNameButton) {
		_sureNameButton = [self createNormalButton];
		[_sureNameButton setTitle:@"确认" forState:UIControlStateNormal];
		_sureNameButton.backgroundColor = [UIColor orangeColor];
	}
	return _sureNameButton;
}

@end
