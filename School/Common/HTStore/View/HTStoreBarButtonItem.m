//
//  HTStoreBarButtonItem.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStoreBarButtonItem.h"

@interface HTStoreBarButtonItem ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation HTStoreBarButtonItem

- (instancetype)initWithTapHandler:(void (^)(HTStoreBarButtonItem *item))action {
    
    self.customView = self.button;
    
    __weak typeof(self) weakSelf = self;
    [self.customView ht_whenTap:^(UIView *view) {
        if (action) {
            action(weakSelf);
        }
    }];
    self.enabled = true;
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.button.selected = selected;
}

- (BOOL)selected {
    return self.button.selected;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"cn_navigation_right_store"];
        image = [image ht_resetSizeWithStandard:22 isMinStandard:true];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *normalImage = [image ht_tintColor:[UIColor whiteColor]];
        UIImage *selectedImage = [image ht_tintColor:[UIColor orangeColor]];
        [_button setImage:normalImage forState:UIControlStateNormal];
        [_button setImage:selectedImage forState:UIControlStateSelected];
        [_button sizeToFit];
    }
    return _button;
}

@end
