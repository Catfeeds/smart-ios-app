//
//  HTIndexHeaderCollectionCell.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexHeaderCollectionCell.h"
#import "HTIndexHeaderCollectionModel.h"
#import <UIButton+HTButtonCategory.h>

@interface HTIndexHeaderCollectionCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTIndexHeaderCollectionCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(HTIndexHeaderCollectionModel *)model row:(NSInteger)row {
	UIImage *image = [UIImage imageNamed:model.imageName];
	image = [image ht_resetSize:CGSizeMake(45, 45)];
	self.titleNameButton.imageView.layer.cornerRadius = image.size.width / 2;
	self.titleNameButton.imageView.layer.masksToBounds = true;
	[self.titleNameButton setImage:image forState:UIControlStateNormal];
	[self.titleNameButton setTitle:model.titleName forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionVertical imageViewToTitleLabelSpeceOffset:9];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.titleNameButton.highlighted = highlighted;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:12];
		_titleNameButton.userInteractionEnabled = false;
		_titleNameButton.titleLabel.numberOfLines = 0;
		_titleNameButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameButton;
}

@end
