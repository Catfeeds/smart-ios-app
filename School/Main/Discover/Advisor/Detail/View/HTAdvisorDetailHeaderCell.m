//
//  HTAdvisorDetailHeaderCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailHeaderCell.h"
#import "HTIndexAdvisorDetailModel.h"

@interface HTAdvisorDetailHeaderCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTAdvisorDetailHeaderCell

- (void)didMoveToSuperview {
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

- (void)setModel:(HTIndexAdvisorDetailCircelModel *)model row:(NSInteger)row {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:0.4],
                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:8 weight:0.1],
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.detailName attributes:normalDictionary] mutableCopy];
    NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", model.titleName] attributes:selectedDictionary];
    [attributedString appendAttributedString:appendAttributedString];
    self.titleNameLabel.attributedText = attributedString;
    self.backgroundColor = model.backgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = self.bounds.size.width / 2;
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.numberOfLines = 0;
    }
    return _titleNameLabel;
}


@end
