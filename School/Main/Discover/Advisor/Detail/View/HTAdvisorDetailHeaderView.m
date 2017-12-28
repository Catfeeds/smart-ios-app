//
//  HTAdvisorDetailHeaderView.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailHeaderView.h"
#import <UICollectionView+HTSeparate.h>
#import "HTAnimatorCollectionFlowLayout.h"
#import "HTAdvisorDetailHeaderCell.h"

@interface HTAdvisorDetailHeaderView ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UICollectionView *animatorCollectionView;

@end

@implementation HTAdvisorDetailHeaderView

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor ht_colorString:@"00b3ff"];
    [self addSubview:self.animatorCollectionView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.titleNameButton];
    [self addSubview:self.detailNameLabel];
    [self.animatorCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    CGFloat line = 100;
    self.headImageView.layer.cornerRadius = line / 2;
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
		make.top.mas_equalTo(30);
        make.width.height.mas_equalTo(line);
    }];
    [self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.headImageView);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.nicknameLabel.mas_bottom).offset(10);
    }];
    [self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nicknameLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(- 15);
        make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(10);
    }];
}

- (void)setModel:(HTIndexAdvisorDetailModel *)model {
    self.titleNameButton.hidden = false;
    HTIndexAdvisorModel *advisorModel = model.data.firstObject;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(advisorModel.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.nicknameLabel.text = advisorModel.name;
    [self.titleNameButton setTitle:advisorModel.A forState:UIControlStateNormal];
    self.detailNameLabel.text = [NSString stringWithFormat:@"%@, 从业%@年", advisorModel.alternatives, advisorModel.article];
    [self.animatorCollectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
        [sectionMaker.modelArray(model.circelModelArray) didSelectedCellBlock:^(UICollectionView *collectionView, NSInteger item, __kindof UICollectionViewCell *cell, __kindof NSObject *model) {
            
        }];
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
        _nicknameLabel.textColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:20 weight:0.4];
    }
    return _nicknameLabel;
}

- (UIButton *)titleNameButton {
    if (!_titleNameButton) {
        _titleNameButton = [[UIButton alloc] init];
        _titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateHighlighted];
        [_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        _titleNameButton.layer.cornerRadius = 3;
        _titleNameButton.layer.masksToBounds = true;
        _titleNameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _titleNameButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [_titleNameButton setContentEdgeInsets:UIEdgeInsetsMake(3, 7, 3, 7)];
        [_titleNameButton setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        [_titleNameButton setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        _titleNameButton.hidden = true;
    }
    return _titleNameButton;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor whiteColor];
        _detailNameLabel.font = [UIFont systemFontOfSize:15 weight:0.2];
    }
    return _detailNameLabel;
}

- (UICollectionView *)animatorCollectionView {
    if (!_animatorCollectionView) {
//        HTAnimatorCollectionFlowLayout *flowLayout = [[HTAnimatorCollectionFlowLayout alloc] init];
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _animatorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _animatorCollectionView.backgroundColor = [UIColor clearColor];
		UIEdgeInsets sectionEdge = UIEdgeInsetsMake(120, 130, 0, 15);
		CGFloat itemHorizontalSpacing = 15;
		CGFloat colCount = 3;
        CGFloat itemLine = (HTSCREENWIDTH - sectionEdge.left - sectionEdge.right - (colCount - 1) * itemHorizontalSpacing) / colCount;
        CGSize itemSize = CGSizeMake(itemLine, itemLine);
        [_animatorCollectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
            sectionMaker.cellClass([HTAdvisorDetailHeaderCell class]).itemSize(itemSize).itemHorizontalSpacing(itemHorizontalSpacing).sectionInset(sectionEdge);
        }];
    }
    return _animatorCollectionView;
}


@end
