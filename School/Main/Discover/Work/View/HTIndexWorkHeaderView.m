//
//  HTIndexWorkHeaderView.m
//  School
//
//  Created by hublot on 2017/8/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexWorkHeaderView.h"
#import <UIButton+HTButtonCategory.h>
#import "HTWorkHeaderModel.h"

@interface HTIndexWorkHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTIndexWorkHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.bottom.mas_equalTo(self);
	}];
}

- (void)setModelArray:(HTWorkHeaderModel *)modelArray section:(NSInteger)section {
	[self.titleNameButton setTitle:modelArray.name forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:6];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		UIImage *image = [UIImage imageNamed:@"cn2_school_matriculate_work_header"];
		image = [image ht_resetSizeWithStandard:20 isMinStandard:false];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}


@end
