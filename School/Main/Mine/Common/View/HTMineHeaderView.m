//
//  HTMineHeaderView.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMineHeaderView.h"
#import "HTMineHeaderSeparateView.h"
#import <UIButton+HTButtonCategory.h>
#import "HTUserManager.h"
#import "HTLoginManager.h"
#import "HTFansController.h"
#import "HTLikeController.h"
#import "HTMinePreferenceController.h"

@interface HTMineHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UIButton *fansCountButton;

@property (nonatomic, strong) UIButton *likeCountButton;

@property (nonatomic, strong) HTMineHeaderSeparateView *separateView;

@property (nonatomic, strong) CAShapeLayer *headImageBorderLayer;

@property (nonatomic, strong) CAShapeLayer *headImageCircelLayer;

@end

@implementation HTMineHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.nickNameLabel];
	[self addSubview:self.headImageView];
	[self addSubview:self.fansCountButton];
	[self addSubview:self.likeCountButton];
	[self addSubview:self.separateView];
	[self.layer addSublayer:self.headImageBorderLayer];
	[self.layer addSublayer:self.headImageCircelLayer];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.separateView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self);
		make.height.mas_equalTo(80);
	}];
	[self.nickNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(50);
		make.centerX.mas_equalTo(self);
	}];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(20);
		make.centerX.mas_equalTo(self);
		make.width.height.mas_equalTo(90);
	}];
	[self.fansCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15);
		make.left.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(0.5);
	}];
	[self.likeCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.fansCountButton);
		make.right.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(0.5);
	}];
	[self.separateView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self);
		make.height.mas_equalTo(70);
	}];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateModel) name:kHTLoginNotification object:nil];
	[self updateModel];
}

- (void)updateModel {
    __weak typeof(self) weakSelf = self;
	HTUser *user = [HTUserManager currentUser];
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(user.image)] placeholderImage:[UIImage imageNamed:@"defaultHeader"]];
	self.nickNameLabel.text = user.uid.integerValue > 0 ? (user.nickname.length ? user.nickname : user.userName) : @"未登录";
	[self.fansCountButton setTitle:[NSString stringWithFormat:@"粉丝: %ld", user.fans.integerValue] forState:UIControlStateNormal];
	[self.fansCountButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:10];
	[self.likeCountButton setTitle:[NSString stringWithFormat:@"关注: %ld", user.follow.integerValue] forState:UIControlStateNormal];
	[self.likeCountButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:10];
	[self.separateView updateModel];
    
    [self.likeCountButton ht_whenTap:^(UIView *view) {
        HTLikeController *likeController = [[HTLikeController alloc] init];
        likeController.uidString = user.uid;
        [weakSelf.ht_controller.navigationController pushViewController:likeController animated:true];
    }];
    [self.fansCountButton ht_whenTap:^(UIView *view) {
        HTFansController *fansController = [[HTFansController alloc] init];
        fansController.uidString = user.uid;
        [weakSelf.ht_controller.navigationController pushViewController:fansController animated:true];
    }];
    
    [self.nickNameLabel ht_whenTap:^(UIView *view) {
        if (user.permission < HTUserPermissionExerciseAbleUser) {
            [HTLoginManager presentAndLoginSuccess:nil];
        }
    }];
    
    [self.headImageView ht_whenTap:^(UIView *view) {
		if (user.permission < HTUserPermissionExerciseAbleUser) {
			[HTLoginManager presentAndLoginSuccess:nil];
		} else {
			HTMinePreferenceController *preferenceController = [[HTMinePreferenceController alloc] init];
			[weakSelf.ht_controller.navigationController pushViewController:preferenceController animated:true];
		}
    }];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGPoint center = self.headImageView.center;
	CGFloat width = self.headImageView.bounds.size.width;
	CGPoint right = CGPointMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width, center.y);
	CGFloat distance = 4;
	
	self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.width / 2;
	UIBezierPath *borderBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(width / 2) + distance startAngle:0 endAngle:M_PI * 2 clockwise:true];
	self.headImageBorderLayer.path = borderBezierPath.CGPath;
	
	UIBezierPath *circelBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(right.x + distance, right.y) radius:distance - 1 startAngle:0 endAngle:M_PI * 2 clockwise:true];
	self.headImageCircelLayer.path = circelBezierPath.CGPath;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		_backgroundImageView.layer.masksToBounds = true;
		UIImage *image = [UIImage imageNamed:@"cn_mine_header_background"];
		UIImage *darkImage = [UIImage ht_pureColor:[UIColor colorWithWhite:0 alpha:0.7]];
		darkImage = [darkImage ht_resetSize:image.size];
		image = [image ht_appendImage:darkImage atRect:CGRectMake(0, 0, darkImage.size.width, darkImage.size.height)];
		_backgroundImageView.image = image;
	}
	return _backgroundImageView;
}

- (UILabel *)nickNameLabel {
	if (!_nickNameLabel) {
		_nickNameLabel = [[UILabel alloc] init];
		_nickNameLabel.font = [UIFont systemFontOfSize:18];
		_nickNameLabel.textColor = [UIColor whiteColor];
	}
	return _nickNameLabel;
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.layer.masksToBounds = true;
	}
	return _headImageView;
}

- (UIButton *)fansCountButton {
	if (!_fansCountButton) {
		NSString *imageName = @"cn_mine_header_fans";
		_fansCountButton = [self createButtonWithImageName:imageName];
	}
	return _fansCountButton;
}

- (UIButton *)likeCountButton {
	if (!_likeCountButton) {
		NSString *imageName = @"cn_mine_header_like";
		_likeCountButton = [self createButtonWithImageName:imageName];
	}
	return _likeCountButton;
}

- (HTMineHeaderSeparateView *)separateView {
	if (!_separateView) {
		_separateView = [[HTMineHeaderSeparateView alloc] init];
	}
	return _separateView;
}

- (CAShapeLayer *)headImageBorderLayer {
	if (!_headImageBorderLayer) {
		_headImageBorderLayer = [CAShapeLayer layer];
		_headImageBorderLayer.fillColor = [UIColor clearColor].CGColor;
		_headImageBorderLayer.strokeColor = [UIColor whiteColor].CGColor;
		_headImageBorderLayer.strokeStart = 0.04;
		_headImageBorderLayer.strokeEnd = 0.96;
		_headImageBorderLayer.lineWidth = 1 / [UIScreen mainScreen].scale;
		_headImageBorderLayer.lineCap = kCALineCapRound;
		_headImageBorderLayer.lineJoin = kCALineJoinRound;
	}
	return _headImageBorderLayer;
}

- (CAShapeLayer *)headImageCircelLayer {
	if (!_headImageCircelLayer) {
		_headImageCircelLayer = [CAShapeLayer layer];
		_headImageCircelLayer.fillColor = [UIColor ht_colorString:@"ffb54e"].CGColor;
	}
	return _headImageCircelLayer;
}


- (UIButton *)createButtonWithImageName:(NSString *)imageName {
	UIButton *button = [[UIButton alloc] init];
	button.titleLabel.font = [UIFont systemFontOfSize:14];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:imageName];
	image = [image ht_resetSizeWithStandard:17 isMinStandard:false];
	[button setImage:image  forState:UIControlStateNormal];
	return button;
}

@end
