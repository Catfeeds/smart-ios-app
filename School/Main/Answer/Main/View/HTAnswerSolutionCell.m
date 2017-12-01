//
//  HTAnswerSolutionCell.m
//  School
//
//  Created by hublot on 2017/8/29.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerSolutionCell.h"
#import "HTAnswerModel.h"
#import "HTImageTextView.h"
#import "HTWebController.h"
#import <UITableViewCell_HTSeparate.h>
#import <UIButton+HTButtonCategory.h>
#import <NSObject+HTTableRowHeight.h>
#import <UITableView+HTSeparate.h>
#import "HTAnswerReplyCell.h"
#import "HTAnswerKeboardManager.h"
#import "HTSomeoneController.h"

@interface HTAnswerSolutionCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UILabel *sendDateLabel;

@property (nonatomic, strong) UIButton *goodSolutionButton;

@property (nonatomic, strong) HTImageTextView *titleTextView;

@property (nonatomic, strong) UIView *separotLineView;

@property (nonatomic, strong) UITableView *replyTableView;

@property (nonatomic, strong) HTAnswerSolutionModel *solutionModel;

@end

@implementation HTAnswerSolutionCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.nicknameLabel];
	[self addSubview:self.sendDateLabel];
	[self addSubview:self.goodSolutionButton];
	[self addSubview:self.titleTextView];
	[self addSubview:self.separotLineView];
	[self addSubview:self.replyTableView];
	CGFloat line = 30;
	self.headImageView.layer.cornerRadius = line / 2;
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.width.height.mas_equalTo(line);
	}];
	[self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(self.goodSolutionButton.mas_left).offset(- 15);
	}];
	[self.sendDateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.bottom.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(self.goodSolutionButton.mas_left).offset(- 15);
	}];
	[self.goodSolutionButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self.headImageView);
	}];
	[self.titleTextView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15);
	}];
	[self.separotLineView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.titleTextView.mas_bottom).offset(15);
		make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
	}];
	[self.replyTableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.separotLineView.mas_bottom);
		make.left.mas_equalTo(self);
		make.right.mas_equalTo(self);
	}];
}

- (void)setModel:(HTAnswerSolutionModel *)model row:(NSInteger)row {
	if (_solutionModel == model) {
		return;
	}
    __weak typeof(self) weakSelf = self;
	_solutionModel = model;
	[self didMoveToSuperview];
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.nicknameLabel.text = HTPlaceholderString(model.nickname, model.username);
	self.sendDateLabel.text = model.addTime;
	[self.goodSolutionButton setTitle:model.praise forState:UIControlStateNormal];
	
	self.goodSolutionButton.selected = model.fabulous;
	[self.goodSolutionButton ht_whenTap:^(UIView *view) {
		if (weakSelf.goodSolutionButton.selected) {
			HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
			networkModel.autoAlertString = @"取消点赞中";
			networkModel.autoShowError = true;
			networkModel.offlineCacheStyle = HTCacheStyleNone;
			[HTRequestManager requestAnswerSolutionCancelLikeWithNetworkModel:networkModel solutionIdString:model.ID complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					return;
				}
				weakSelf.goodSolutionButton.selected = !weakSelf.goodSolutionButton.selected;
			}];

		} else {
			HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
			networkModel.autoAlertString = @"点赞中";
			networkModel.autoShowError = true;
			networkModel.offlineCacheStyle = HTCacheStyleNone;
			[HTRequestManager requestAnswerSolutionLikeWithNetworkModel:networkModel solutionIdString:model.ID complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					return;
				}
				weakSelf.goodSolutionButton.selected = !weakSelf.goodSolutionButton.selected;
			}];
		}
	}];
	[self.goodSolutionButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
		
	__block CGFloat tableHeight = 0;
	[self.replyTableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(model.reply);
	}];
	[self.replyTableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		tableHeight = sectionMaker.section.sumRowHeight;
	}];
	[weakSelf.replyTableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(tableHeight);
	}];
	
	[self.titleTextView setAttributedString:model.contentAttributedString textViewMaxWidth:HTSCREENWIDTH - 30 appendImageBaseURLBlock:^NSString *(UITextView *textView, NSString *imagePath) {
		if (![imagePath containsString:@"http"]) {
			return SmartApplyResourse(imagePath);
		}
		return imagePath;
	} reloadHeightBlock:^(UITextView *textView, CGFloat contentHeight) {
		
		[weakSelf.titleTextView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(contentHeight);
		}];
		
		CGFloat newModelHeight = 15;
		newModelHeight += 30;
		newModelHeight += 15;
		newModelHeight += contentHeight;
		newModelHeight += 15;
		if (model.reply.count > 0) {
			weakSelf.separotLineView.hidden = false;
			newModelHeight += tableHeight;
		} else {
			weakSelf.separotLineView.hidden = true;
		}
		
		NSNumber *oldModelHeightNumber = [model ht_rowHeightNumberForCellClass:weakSelf.class];
		[model ht_setRowHeightNumber:@(newModelHeight) forCellClass:weakSelf.class];
		if (oldModelHeightNumber) {
			if (weakSelf.reloadHeightBlock) {
				weakSelf.reloadHeightBlock();
			}
		}
		
	} didSelectedURLBlock:^(UITextView *textView, NSURL *URL, NSString *titleName) {
		HTWebController *webController = [[HTWebController alloc] initWithURL:URL];
		[weakSelf.ht_controller.navigationController pushViewController:webController animated:true];
	}];
	
    [self.headImageView ht_whenTap:^(UIView *view) {
        HTSomeoneController *someoneController = [[HTSomeoneController alloc] init];
        someoneController.userIdString = model.userid;
        [weakSelf.ht_controller.navigationController pushViewController:someoneController animated:true];
    }];
	
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.layer.masksToBounds = true;
	}
	return _headImageView;
}

- (UILabel *)nicknameLabel {
	if (!_nicknameLabel) {
		_nicknameLabel = [[UILabel alloc] init];
		_nicknameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_nicknameLabel.font = [UIFont systemFontOfSize:14];
	}
	return _nicknameLabel;
}

- (UILabel *)sendDateLabel {
	if (!_sendDateLabel) {
		_sendDateLabel = [[UILabel alloc] init];
		_sendDateLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_sendDateLabel.font = [UIFont systemFontOfSize:12];
	}
	return _sendDateLabel;
}

- (UIButton *)goodSolutionButton {
	if (!_goodSolutionButton) {
		_goodSolutionButton = [[UIButton alloc] init];
		_goodSolutionButton.titleLabel.font = [UIFont systemFontOfSize:14];
		
		
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleSpecialTitle];
		UIColor *selectedColor = [UIColor orangeColor];
		
		UIImage *image = [UIImage imageNamed:@"cn2_index_answer_like"];
		image = [image ht_resetSizeWithStandard:18 isMinStandard:false];
		
		[_goodSolutionButton setTitleColor:normalColor forState:UIControlStateNormal];
		[_goodSolutionButton setTitleColor:selectedColor forState:UIControlStateSelected];
		
		UIImage *normalImage = [image ht_tintColor:normalColor];
		UIImage *selectedImage = [normalImage ht_tintColor:selectedColor];
		[_goodSolutionButton setImage:normalImage forState:UIControlStateNormal];
		[_goodSolutionButton setImage:selectedImage forState:UIControlStateSelected];
		
		[_goodSolutionButton setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
		[_goodSolutionButton setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _goodSolutionButton;
}


- (HTImageTextView *)titleTextView {
	if (!_titleTextView) {
		_titleTextView = [[HTImageTextView alloc] init];
		_titleTextView.alwaysBounceVertical = false;
		_titleTextView.textContainerInset = UIEdgeInsetsZero;
		_titleTextView.scrollEnabled = false;
		_titleTextView.backgroundColor = [UIColor clearColor];
	}
	return _titleTextView;
}

- (UIView *)separotLineView {
	if (!_separotLineView) {
		_separotLineView = [[UIView alloc] init];
		_separotLineView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
	}
	return _separotLineView;
}


- (UITableView *)replyTableView {
	if (!_replyTableView) {
		_replyTableView = [[UITableView alloc] init];
		_replyTableView.separatorColor = [UIColor ht_colorString:@"eeeeee"];
		_replyTableView.backgroundColor = [UIColor clearColor];
		_replyTableView.scrollEnabled = false;
		
		__weak typeof(self) weakSelf = self;
		[_replyTableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTAnswerReplyCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerReplyModel *model) {
				[HTAnswerKeboardManager beginKeyboardWithAnswerSolutionModel:weakSelf.solutionModel answerReplyModel:model success:^{
					[HTAnswerKeboardManager tryRefreshWithView:weakSelf];
				}];
			}];
		}];
	}
	return _replyTableView;
}


@end
