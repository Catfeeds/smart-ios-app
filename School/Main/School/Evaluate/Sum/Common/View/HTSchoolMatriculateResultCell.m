//
//  HTSchoolMatriculateResultCell.m
//  School
//
//  Created by hublot on 2017/6/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateResultCell.h"
#import "HTSchoolResultCircleView.h"
#import "HTSchoolModel.h"
#import <UITableViewCell_HTSeparate.h>

@interface HTSchoolMatriculateResultCell ()

@property (nonatomic, strong) HTSchoolResultCircleView *progressView;

@property (nonatomic, strong) UILabel *progressTitltLabel;

@property (nonatomic, strong) UILabel *progressDetailLabel;

@end

@implementation HTSchoolMatriculateResultCell

- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	
	[self addSubview:self.progressView];
//	[self addSubview:self.progressTitltLabel];
	[self addSubview:self.progressDetailLabel];
	
//	[self.progressTitltLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(self).offset(- 15);
//		make.bottom.mas_equalTo(self.progressView.mas_top).offset(- 10);
//	}];
	[self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self).offset(- 15);
		make.centerY.mas_equalTo(self);
		make.width.height.mas_equalTo(40);
	}];
	[self.progressDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(self.progressView);
	}];
//	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(self.progressView.mas_left).offset(- 15);
//	}];
}

- (void)setModel:(HTSchoolModel *)model row:(NSInteger)row {
	[super setModel:model row:row];
	
	CGFloat progress = arc4random() % 100 / 100.0;
	self.progressView.progress = progress;
	self.progressDetailLabel.text = [NSString stringWithFormat:@"%.0lf%%", progress * 100];
}

- (HTSchoolResultCircleView *)progressView {
	if (!_progressView) {
		_progressView = [[HTSchoolResultCircleView alloc] init];
	}
	return _progressView;
}

- (UILabel *)progressTitltLabel {
	if (!_progressTitltLabel) {
		_progressTitltLabel = [[UILabel alloc] init];
		_progressTitltLabel.textColor = [UIColor redColor];
		_progressTitltLabel.font = [UIFont systemFontOfSize:14];
		_progressTitltLabel.text = @"申请录取几率";
	}
	return _progressTitltLabel;
}

- (UILabel *)progressDetailLabel {
	if (!_progressDetailLabel) {
		_progressDetailLabel = [[UILabel alloc] init];
		_progressDetailLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_progressDetailLabel.font = [UIFont systemFontOfSize:13];
		_progressDetailLabel.text = @"0 %";
	}
	return _progressDetailLabel;
}



@end
