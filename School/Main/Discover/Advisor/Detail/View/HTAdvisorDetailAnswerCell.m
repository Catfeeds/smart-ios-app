//
//  HTAdvisorDetailAnswerCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailAnswerCell.h"
#import "HTImageTextView.h"
#import "HTIndexAdvisorDetailModel.h"
#import <NSString+HTString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTAdvisorDetailAnswerCell ()

@property (nonatomic, strong) UILabel *questionLabel;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UILabel *sendDateLabel;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTAdvisorDetailAnswerCell

- (void)didMoveToSuperview {
    [self addSubview:self.questionLabel];
    [self addSubview:self.headImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.sendDateLabel];
    [self addSubview:self.titleNameLabel];
    [self.questionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(- 15);
        make.top.mas_equalTo(15);
    }];
    CGFloat line = 35;
    self.headImageView.layer.cornerRadius = line / 2;
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.questionLabel.mas_bottom).offset(15);
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
        make.left.mas_equalTo(self.nicknameLabel);
        make.right.mas_equalTo(- 15);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10);
    }];
}

- (void)setModel:(HTIndexAdvisorDetailAnswerModel *)model row:(NSInteger)row {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.questionLabel.text = model.question;
    self.nicknameLabel.text = model.username;
    self.sendDateLabel.text = model.addtime;
    
    self.titleNameLabel.text = [model.content ht_htmlDecodeString];
    CGFloat modelHeight = 15;
    CGFloat questionHeight = 15;
    modelHeight += questionHeight;
    modelHeight += 15;
    CGFloat headImageHeight = 35;
    modelHeight += headImageHeight;
    modelHeight += 10;
    CGFloat contentHeight = [self.titleNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 15 - 35 - 15 - 15 font:self.titleNameLabel.font textView:nil];
    modelHeight += contentHeight;
    modelHeight += 15;
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _questionLabel.font = [UIFont systemFontOfSize:15];
    }
    return _questionLabel;
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

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
        _titleNameLabel.numberOfLines = 0;
    }
    return _titleNameLabel;
}

@end
