//
//  HTLibraryCell.m
//  School
//
//  Created by hublot on 17/8/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryCell.h"
#import "HTLibraryModel.h"

@interface HTLibraryCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTLibraryCell

- (void)didMoveToSuperview {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
}

- (void)setModel:(HTLibraryApplyContentModel *)model row:(NSInteger)row {
    self.titleNameLabel.text = model.name;
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _titleNameLabel.font = [UIFont systemFontOfSize:14.5f];
    }
    return _titleNameLabel;
}


@end
