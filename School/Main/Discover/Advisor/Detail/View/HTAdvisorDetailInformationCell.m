//
//  HTAdvisorDetailInformationCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailInformationCell.h"
#import <NSString+HTString.h>
#import <NSAttributedString+HTAttributedString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTAdvisorDetailInformationCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTAdvisorDetailInformationCell

- (void)didMoveToSuperview {
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
}

- (void)setModel:(NSString *)model row:(NSInteger)row {
    NSMutableAttributedString *attributedString = [[[model ht_htmlDecodeString] ht_attributedStringNeedDispatcher:nil] mutableCopy];
    self.titleNameLabel.text = attributedString.string;
    CGFloat modelHeight = 15;
    CGFloat contentHeight = [self.titleNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.titleNameLabel.font textView:nil];
    modelHeight += contentHeight;
    modelHeight += 30;
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.numberOfLines = 0;
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

@end
