//
//  HTAnswerReplyCell.m
//  School
//
//  Created by hublot on 2017/8/29.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerReplyCell.h"
#import "HTAnswerModel.h"
#import <NSString+HTString.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTSomeoneController.h"

@interface HTAnswerReplyCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UILabel *sendDateLabel;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTAnswerReplyCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.headImageView];
	[self addSubview:self.nicknameLabel];
	[self addSubview:self.sendDateLabel];
	[self addSubview:self.titleNameLabel];
	CGFloat line = 25;
	self.headImageView.layer.cornerRadius = line / 2;
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(45);
		make.top.mas_equalTo(15);
		make.width.height.mas_equalTo(line);
	}];
	[self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(- 15);
	}];
	[self.sendDateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.bottom.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(- 15);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15);
		make.bottom.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTAnswerReplyModel *)model row:(NSInteger)row {
    
    __weak typeof(self) weakSelf = self;
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self createNameWithModel:model];
	self.sendDateLabel.text = model.addTime;
	self.titleNameLabel.text = model.content;
	CGFloat contentTextHeight = [self.titleNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 - 30 font:self.titleNameLabel.font textView:nil];
	CGFloat modelHeight = 15;
	modelHeight += 25;
	modelHeight += 15;
	modelHeight += contentTextHeight;
	modelHeight += 15;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
    
    [self.headImageView ht_whenTap:^(UIView *view) {
        HTSomeoneController *someoneController = [[HTSomeoneController alloc] init];
        someoneController.userIdString = model.userid;
        [weakSelf.ht_controller.navigationController pushViewController:someoneController animated:true];
    }];
}

- (void)createNameWithModel:(HTAnswerReplyModel *)model {
	NSString *sendName = HTPlaceholderString(model.nickname, model.username);
	NSDictionary *normalDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
									   NSFontAttributeName:[UIFont systemFontOfSize:10]};
	NSDictionary *selectedDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor],
										 NSFontAttributeName:[UIFont systemFontOfSize:10]};
	NSMutableAttributedString *attribtuedString = [[[NSAttributedString alloc] initWithString:sendName attributes:selectedDictionary] mutableCopy];
	if (model.replyUser.length) {
		NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:@" 回复 " attributes:normalDictionary];
		[attribtuedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:model.replyUser attributes:selectedDictionary];
		[attribtuedString appendAttributedString:appendAttributedString];
	}
	self.nicknameLabel.attributedText = attribtuedString;
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
	}
	return _nicknameLabel;
}

- (UILabel *)sendDateLabel {
	if (!_sendDateLabel) {
		_sendDateLabel = [[UILabel alloc] init];
		_sendDateLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_sendDateLabel.font = [UIFont systemFontOfSize:10];
	}
	return _sendDateLabel;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:13];
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}


@end
