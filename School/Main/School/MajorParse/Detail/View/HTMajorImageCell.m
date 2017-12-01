//
//  HTMajorImageCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorImageCell.h"
#import "HTMajorDetailModel.h"
#import "HTWebController.h"
#import <UIButton+HTButtonCategory.h>

@interface HTMajorImageCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIButton *goodMajorButton;

@property (nonatomic, strong) UIButton *contactMajorButton;

@end

@implementation HTMajorImageCell

+ (Class)layerClass {
	return [CAGradientLayer class];
}

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self createBackgroundGradientLayer];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.goodMajorButton];
	[self addSubview:self.contactMajorButton];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.centerY.mas_equalTo(- 30);
	}];
	[self.goodMajorButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(- 60);
		make.centerY.mas_equalTo(30);
	}];
	[self.contactMajorButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(60);
		make.centerY.mas_equalTo(30);
	}];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.goodMajorButton.layer.cornerRadius = self.goodMajorButton.bounds.size.height / 2;
	self.contactMajorButton.layer.cornerRadius = self.contactMajorButton.bounds.size.height / 2;
}

- (void)setModel:(HTMajorDetailModel *)model row:(NSInteger)row {
	[self createTitleAttributedStringWithModel:model];
	[self setGoodMajorButtonWithModel:model];
}

- (void)createBackgroundGradientLayer {
	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
	gradientLayer.colors = @[(id)[UIColor ht_colorString:@"00c9ff"].CGColor,
							 (id)[UIColor ht_colorString:@"7eff9d"].CGColor];
	gradientLayer.locations = @[@(0), @(1)];
	gradientLayer.startPoint = CGPointMake(0, 0);
	gradientLayer.endPoint = CGPointMake(1, 1);
}

- (void)createTitleAttributedStringWithModel:(HTMajorDetailModel *)model {
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.alignment = NSTextAlignmentCenter;
	paragraphStyle.lineSpacing = 15;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
									   NSForegroundColorAttributeName:[UIColor whiteColor],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
										 NSForegroundColorAttributeName:[UIColor whiteColor],
										 NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.name attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n(%@)", model.title] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.titleNameLabel.attributedText = attributedString;
}

- (void)setGoodMajorButtonWithModel:(HTMajorDetailModel *)model {
	NSString *goodTitle = [NSString stringWithFormat:@"点赞 (%@)", model.fabulous];
	[self.goodMajorButton setTitle:goodTitle forState:UIControlStateNormal];
	[self.goodMajorButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
	
	__weak typeof(self) weakSelf = self;
	[self.goodMajorButton ht_whenTap:^(UIView *view) {
		HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
		networkModel.autoAlertString = @"点赞中";
		networkModel.offlineCacheStyle = HTCacheStyleNone;
		networkModel.autoShowError = true;
		[HTRequestManager requestMajorGoodWithNetworkModel:networkModel majorIdString:model.ID complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			model.fabulous = [NSString stringWithFormat:@"%ld", model.fabulous.integerValue + 1];
			[weakSelf setGoodMajorButtonWithModel:model];
		}];
	}];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}

- (UIButton *)goodMajorButton {
	if (!_goodMajorButton) {
		UIImage *image = [UIImage imageNamed:@"cn_mine_good"];
		_goodMajorButton = [self createBorderButtonWithImage:image];
	}
	return _goodMajorButton;
}

- (UIButton *)contactMajorButton {
	if (!_contactMajorButton) {
		UIImage *image = [UIImage imageNamed:@"cn_mine_service"];
		_contactMajorButton = [self createBorderButtonWithImage:image];
		[_contactMajorButton setTitle:@"在线咨询" forState:UIControlStateNormal];
		[_contactMajorButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
		
		__weak typeof(self) weakSelf = self;
		[_contactMajorButton ht_whenTap:^(UIView *view) {
			HTWebController *webController = [HTWebController contactAdvisorWebController];
			[weakSelf.ht_controller.navigationController pushViewController:webController animated:true];
		}];
	}
	return _contactMajorButton;
}

- (UIButton *)createBorderButtonWithImage:(UIImage *)image {
	image = [image ht_tintColor:[UIColor whiteColor]];
	image = [image ht_resetSizeWithStandard:17 isMinStandard:false];
	UIButton *button = [[UIButton alloc] init];
	[button setImage:image forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:13];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
	button.layer.masksToBounds = true;
	button.layer.borderColor = [UIColor whiteColor].CGColor;
	button.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
	return button;
}

@end
