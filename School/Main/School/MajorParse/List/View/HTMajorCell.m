//
//  HTMajorCell.m
//  School
//
//  Created by hublot on 17/9/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorCell.h"
#import "HTMajorModel.h"
#import <NSString+HTString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTMajorCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTMajorCell

- (void)didMoveToSuperview {
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.detailNameLabel];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(- 15);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleNameLabel);
        make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
    }];
}

- (void)setModel:(HTMajorModel *)model row:(NSInteger)row {
    NSDictionary *normalDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSDictionary *selectedDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
                                       NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.name attributes:normalDictionary] mutableCopy];
    NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)", model.title] attributes:selectedDictionary];
    [attributedString appendAttributedString:appendAttributedString];
    self.titleNameLabel.attributedText = attributedString;
    
    self.detailNameLabel.text = [model.introduce ht_htmlDecodeString];
    
    CGFloat detailHeight = [self.detailNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.detailNameLabel.font textView:nil];
    detailHeight = MIN(detailHeight, (self.detailNameLabel.font.pointSize + 4) * self.detailNameLabel.numberOfLines);
    CGFloat modelHeight = 15;
    modelHeight += 15;
    modelHeight += 15;
    modelHeight += detailHeight;
    modelHeight += 15;
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
    }
    return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
        _detailNameLabel.font = [UIFont systemFontOfSize:14];
        _detailNameLabel.numberOfLines = 3;
    }
    return _detailNameLabel;
}


@end
