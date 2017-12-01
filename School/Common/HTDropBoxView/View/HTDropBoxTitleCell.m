//
//  HTDropBoxTitleCell.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxTitleCell.h"

@interface HTDropBoxTitleCell ()



@property (nonatomic, strong) UIView *circelBackgroundView;

@property (nonatomic, strong) UIView *selectedBorderView;

@property (nonatomic, strong) UIView *whiteSeparatorView;

@end

@implementation HTDropBoxTitleCell

+ (UIColor *)separatorLineColor {
	CGFloat gray = 220 / 255.0;
	UIColor *separatorLineColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
	return separatorLineColor;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage alloc] init]];
        self.selectedBackgroundView.alpha = 0;
        [self addSubview:self.circelBackgroundView];
        [self addSubview:self.selectedBorderView];
        [self addSubview:self.whiteSeparatorView];
        [self addSubview:self.titleNameButton];
        self.titleNameButton.translatesAutoresizingMaskIntoConstraints = false;
        self.circelBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        self.selectedBorderView.translatesAutoresizingMaskIntoConstraints = false;
        self.whiteSeparatorView.translatesAutoresizingMaskIntoConstraints = false;
        NSString *titleNameButtonString = @"titleNameButtonString";
        NSString *circelBackgroundString = @"circelBackgroundString";
        NSString *selectedBorderString = @"selectedBorderString";
        NSString *whiteSeparatorString = @"whiteSeparatorString";
        NSDictionary *viewBinding = @{titleNameButtonString:self.titleNameButton, circelBackgroundString:self.circelBackgroundView, selectedBorderString:self.selectedBorderView, whiteSeparatorString:self.whiteSeparatorView};
        UIEdgeInsets titleNameEdge = UIEdgeInsetsMake(7, 7, 7, 7);
        UIEdgeInsets selectedEdge = UIEdgeInsetsMake(7, 7, 3, 7);
        NSString *buttonHorizontal = [NSString stringWithFormat:@"H:|-%lf-[%@]-%lf-|", titleNameEdge.left, titleNameButtonString, titleNameEdge.right];
        NSString *buttonVertical = [NSString stringWithFormat:@"V:|-%lf-[%@]-%lf-|", titleNameEdge.top, titleNameButtonString, titleNameEdge.bottom];
        NSString *circelHorizontal = [NSString stringWithFormat:@"H:|-%lf-[%@]-%lf-|", titleNameEdge.left, circelBackgroundString, titleNameEdge.right];
        NSString *circelVertical = [NSString stringWithFormat:@"V:|-%lf-[%@]-%lf-|", titleNameEdge.top, circelBackgroundString, titleNameEdge.bottom];
        
        NSString *selectedHorizontal = [NSString stringWithFormat:@"H:|-%lf-[%@]-%lf-|", selectedEdge.left, selectedBorderString, selectedEdge.right];
        
        NSString *whilteVertical = [NSString stringWithFormat:@"V:[%@(%lf)]|", whiteSeparatorString, 1 / [UIScreen mainScreen].scale];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:buttonHorizontal options:kNilOptions metrics:nil views:viewBinding]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:buttonVertical options:kNilOptions metrics:nil views:viewBinding]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:circelHorizontal options:kNilOptions metrics:nil views:viewBinding]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:circelVertical options:kNilOptions metrics:nil views:viewBinding]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:selectedHorizontal options:kNilOptions metrics:nil views:viewBinding]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:whilteVertical options:kNilOptions metrics:nil views:viewBinding]];
        [NSLayoutConstraint constraintWithItem:self.selectedBorderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:selectedEdge.top].active = true;
        [NSLayoutConstraint constraintWithItem:self.selectedBorderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:selectedEdge.bottom].active = true;
        [NSLayoutConstraint constraintWithItem:self.whiteSeparatorView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.selectedBorderView attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = true;
        [NSLayoutConstraint constraintWithItem:self.whiteSeparatorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.selectedBorderView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = true;

    }
    
    return self;
}

- (void)setModel:(id <HTDropBoxProtocol> )model {
	_model = model;
	[self.titleNameButton setTitle:model.title forState:UIControlStateNormal];
    [self.titleNameButton setImageEdgeInsets:UIEdgeInsetsZero];
    [self.titleNameButton setTitleEdgeInsets:UIEdgeInsetsZero];
    [self.titleNameButton setImage:[UIImage imageNamed:@"sjx"] forState:UIControlStateNormal];
    CGFloat image_x = self.titleNameButton.imageView.frame.origin.x;
    CGFloat imageOffset = self.titleNameButton.frame.size.width - image_x - 10 - 5;
    [self.titleNameButton setImageEdgeInsets:UIEdgeInsetsMake(0,imageOffset,0,-imageOffset)];
    [self.titleNameButton setTitleEdgeInsets:UIEdgeInsetsMake(0,-10,0,10)];
	[self setSelected:model.isSelected];
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	self.circelBackgroundView.hidden = selected;
	self.selectedBorderView.hidden = self.whiteSeparatorView.hidden = !selected;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
        _titleNameButton.contentMode = UIViewContentModeScaleAspectFit;
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

- (UIView *)circelBackgroundView {
	if (!_circelBackgroundView) {
		_circelBackgroundView = [[UIView alloc] init];
		CGFloat gray = 240 / 255.0;
		_circelBackgroundView.backgroundColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
		_circelBackgroundView.layer.cornerRadius = 3;
		_circelBackgroundView.layer.masksToBounds = true;
	}
	return _circelBackgroundView;
}

- (UIView *)selectedBorderView {
	if (!_selectedBorderView) {
		_selectedBorderView = [[UIView alloc] init];
		_selectedBorderView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;

		_selectedBorderView.layer.borderColor = [self.class separatorLineColor].CGColor;
		_selectedBorderView.layer.cornerRadius = 3;
		_selectedBorderView.layer.masksToBounds = true;
	}
	return _selectedBorderView;
}

- (UIView *)whiteSeparatorView {
	if (!_whiteSeparatorView) {
		_whiteSeparatorView = [[UIView alloc] init];
		_whiteSeparatorView.backgroundColor = [UIColor whiteColor];
	}
	return _whiteSeparatorView;
}

@end
