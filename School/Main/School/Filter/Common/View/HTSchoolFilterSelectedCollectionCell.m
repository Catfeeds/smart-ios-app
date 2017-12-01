//
//  HTSchoolFilterSelectedCollectionCell.m
//  School
//
//  Created by hublot on 17/8/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolFilterSelectedCollectionCell.h"
#import "HTSchoolFilterModel.h"

@implementation HTSchoolFilterSelectedCollectionCell

- (void)didMoveToSuperview {
    [self addSubview:self.titleNameButton];
    [self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setModel:(HTSelectedModel *)model row:(NSInteger)row {
    NSString *titleName = model.name;
    [self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleNameButton.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.titleNameButton.selected = highlighted;
}

- (UIButton *)titleNameButton {
    if (!_titleNameButton) {
        _titleNameButton = [[UIButton alloc] init];
        _titleNameButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _titleNameButton.layer.cornerRadius = 3;
        _titleNameButton.layer.masksToBounds = true;
        [_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
        [_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        UIColor *normalColor = [UIColor ht_colorString:@"f3f4ec"];
        UIColor *selectedColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        UIImage *normalImage = [UIImage ht_pureColor:normalColor];
        UIImage *selectedImage = [UIImage ht_pureColor:selectedColor];
        [_titleNameButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_titleNameButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
        _titleNameButton.userInteractionEnabled = false;
    }
    return _titleNameButton;
}

@end
