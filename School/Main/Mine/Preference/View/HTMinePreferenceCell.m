//
//  HTMinePreferenceCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMinePreferenceCell.h"
#import "HTMinePreferenceModel.h"
#import "HTMineFontSizeController.h"
#import "HTLoginManager.h"
#import <NSObject+HTTableRowHeight.h>

@interface HTMinePreferenceCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation HTMinePreferenceCell

- (void)didMoveToSuperview {
    self.layer.masksToBounds = true;
    UIView *selectedDisplayView = [[UIView alloc] init];
    selectedDisplayView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
    self.selectedBackgroundView = [[UIView alloc] init];
    [self.selectedBackgroundView addSubview:selectedDisplayView];
    [selectedDisplayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.contentView addSubview:self.titleNameLabel];
    [self.contentView addSubview:self.detailNameLabel];
    [self.contentView addSubview:self.headImageView];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 15);
        make.centerY.mas_equalTo(self);
        make.left.mas_greaterThanOrEqualTo(self.titleNameLabel.mas_right).offset(10).priority(900);
    }];
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 15);
        make.width.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self);
        make.left.mas_greaterThanOrEqualTo(self.titleNameLabel.mas_right).offset(10).priority(950);
    }];
}

- (void)setModel:(HTMinePreferenceModel *)model row:(NSInteger)row {
    
    self.titleNameLabel.text = model.titleName;
    self.detailNameLabel.text = model.detailName;
    
    self.detailNameLabel.font = [UIFont systemFontOfSize:14];
    
    CGFloat modelHeight = 0;
    
    switch (model.interfaceType) {
        case HTMinePreferenceModelInterfaceTypeTitleDetail: {
            self.selectionStyle = UITableViewCellSelectionStyleGray;
            self.headImageView.hidden = true;
            self.titleNameLabel.font = [UIFont systemFontOfSize:14];
            self.titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
            self.backgroundColor = [UIColor ht_colorStyle:HTColorStyleBackground];
            modelHeight = HTADAPT568(45);
            break;
        }
        case HTMinePreferenceModelInterfaceTypeSectionTitle: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.headImageView.hidden = true;
            self.titleNameLabel.font = [UIFont systemFontOfSize:14];
            self.titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
            self.backgroundColor = [UIColor clearColor];
            modelHeight = HTADAPT568(35);
            break;
        }
        case HTMinePreferenceModelInterfaceTypeRightImage: {
            self.selectionStyle = UITableViewCellSelectionStyleGray;
            self.detailNameLabel.text = @"";
            self.headImageView.hidden = false;
            self.titleNameLabel.font = [UIFont systemFontOfSize:14];
            self.titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
            self.backgroundColor = [UIColor ht_colorStyle:HTColorStyleBackground];
            modelHeight = HTADAPT568(45);
			
			__weak typeof(self) weakSelf = self;
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.headImageName)] placeholderImage:[[HTPLACEHOLDERIMAGE ht_resetSize:CGSizeMake(44, 44)] ht_imageByRoundCornerRadius:22 corners:UIRectCornerAllCorners borderWidth:0 borderColor:nil borderLineJoin:kCGLineJoinRound] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf layoutSubviews];
            }];
            break;
        }
    }
    if (model.accessoryAble) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        [_titleNameLabel setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisHorizontal];
        [_titleNameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
    }
    return _detailNameLabel;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 40 / 2;
        _headImageView.layer.masksToBounds = true;
    }
    return _headImageView;
}

@end
