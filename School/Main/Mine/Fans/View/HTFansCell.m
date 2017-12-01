//
//  HTFansCell.m
//  School
//
//  Created by hublot on 17/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFansCell.h"
#import "HTFansModel.h"

@interface HTFansCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIButton *rightLikeButton;

@end

@implementation HTFansCell

- (void)didMoveToSuperview {
    [self addSubview:self.headImageView];
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.rightLikeButton];
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(- 15);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.rightLikeButton.mas_left).offset(- 15);
        make.centerY.mas_equalTo(self.headImageView);
    }];
    [self.rightLikeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setModel:(HTFansModel *)model row:(NSInteger)row {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.titleNameLabel.text = HTPlaceholderString(model.nickname, model.username);
    self.rightLikeButton.selected = model.boolean;
    
    __weak typeof(self) weakSelf = self;
    [self.rightLikeButton ht_whenTap:^(UIView *view) {
        if (weakSelf.rightLikeButton.selected) {
			[HTAlert title:@"确定取消关注" sureAction:^{
				HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
				networkModel.autoAlertString = @"关注用户";
				networkModel.autoShowError = true;
				networkModel.offlineCacheStyle = HTCacheStyleNone;
				[HTRequestManager requestCancelAttentionUserWithNetworkModel:networkModel toUidString:model.uid complete:^(id response, HTError *errorModel) {
					if (errorModel.existError) {
						return;
					}
					[HTAlert title:@"取消关注成功"];
					weakSelf.rightLikeButton.selected = true;
				}];
			}];
        } else {
			[HTAlert title:@"确定取消关注" sureAction:^{
				HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
				networkModel.autoAlertString = @"关注用户";
				networkModel.autoShowError = true;
				networkModel.offlineCacheStyle = HTCacheStyleNone;
				[HTRequestManager requestAttentionUserWithNetworkModel:networkModel toUidString:model.uid complete:^(id response, HTError *errorModel) {
					if (errorModel.existError) {
						return;
					}
					weakSelf.rightLikeButton.selected = false;
				}];
			}];
        }
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.height / 2;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = true;
    }
    return _headImageView;
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

- (UIButton *)rightLikeButton {
    if (!_rightLikeButton) {
        _rightLikeButton = [[UIButton alloc] init];
        _rightLikeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightLikeButton.layer.cornerRadius = 3;
        _rightLikeButton.layer.masksToBounds = true;
        NSString *normalTitltString = @"关注";
        UIColor *normalBakcgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        UIColor *normalForegroundColor = [UIColor whiteColor];
        [_rightLikeButton setTitle:normalTitltString forState:UIControlStateNormal];
        [_rightLikeButton setBackgroundImage:[UIImage ht_pureColor:normalBakcgroundColor] forState:UIControlStateNormal];
        [_rightLikeButton setTitleColor:normalForegroundColor forState:UIControlStateNormal];
        
        
        NSString *selectedTitleString = @"已关注";
        UIColor *selectedBackgroundColor = [UIColor ht_colorString:@"f3f4ec"];
        UIColor *selectedForegroundColor = [UIColor ht_colorStyle:HTColorStyleSpecialTitle];
        
        [_rightLikeButton setTitle:selectedTitleString forState:UIControlStateSelected];
        [_rightLikeButton setBackgroundImage:[UIImage ht_pureColor:selectedBackgroundColor] forState:UIControlStateSelected];
        [_rightLikeButton setTitleColor:selectedForegroundColor forState:UIControlStateSelected];

    }
    return _rightLikeButton;
}


@end
