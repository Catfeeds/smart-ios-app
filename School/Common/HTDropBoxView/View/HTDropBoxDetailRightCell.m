//
//  HTDropBoxDetailRightCell.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxDetailRightCell.h"

@interface HTDropBoxDetailRightCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTDropBoxDetailRightCell

+ (CGFloat)collectionItemHeight {
	return 30;
}

+ (CGFloat)cellFontPointSize {
	return 13;
}

- (void)didMoveToSuperview {
	self.titleNameButton.layer.cornerRadius = [self.class collectionItemHeight] / 2;
	self.titleNameButton.layer.masksToBounds = true;
	[self addSubview:self.titleNameButton];
	self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage alloc] init]];
	self.selectedBackgroundView.alpha = 0;
	self.titleNameButton.translatesAutoresizingMaskIntoConstraints = false;
	NSString *titleNameButtonString = @"titleNameButtonString";
	NSDictionary *viewBinding = @{titleNameButtonString:self.titleNameButton};
	NSString *horizontal = [NSString stringWithFormat:@"H:|[%@]|", titleNameButtonString];
	NSString *vertical = [NSString stringWithFormat:@"V:|[%@]|", titleNameButtonString];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vertical options:kNilOptions metrics:nil views:viewBinding]];
}

- (void)setModel:(id <HTDropBoxProtocol> )model {
	[self.titleNameButton setTitle:model.title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
	[self setHighlighted:selected];
	[super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.titleNameButton.selected = highlighted;
	self.titleNameButton.backgroundColor = highlighted ? [UIColor orangeColor] : [UIColor clearColor];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:[self.class cellFontPointSize]];
		_titleNameButton.layer.borderColor = [UIColor orangeColor].CGColor;
		_titleNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		[_titleNameButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
