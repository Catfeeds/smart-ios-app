//
//  HTSellerDetailController.m
//  School
//
//  Created by hublot on 2017/8/30.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSellerDetailController.h"
#import "HTWebController.h"
#import "HTImageTextView.h"
#import <UIScrollView+HTRefresh.h>
#import "HTSellerModel.h"

@interface HTSellerDetailController ()

@property (nonatomic, strong) HTImageTextView *textView;

@property (nonatomic, strong) UIButton *lineAdvisorButton;

@end

@implementation HTSellerDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	__weak typeof(self) weakSelf = self;
	[self.textView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestStoreDetailWithNetworkModel:networkModel storeIdString:weakSelf.sellerIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.textView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTSellerModel *model = [HTSellerModel mj_objectWithKeyValues:response[@"data"]];
			weakSelf.navigationItem.title = model.name;
			NSAttributedString *attributedString = [[model.detailed ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE];
			[weakSelf.textView ht_endRefreshWithModelArrayCount:1];
			[weakSelf.textView setAttributedString:attributedString textViewMaxWidth:HTSCREENWIDTH - 30 appendImageBaseURLBlock:^NSString *(UITextView *textView, NSString *imagePath) {
				if (![imagePath containsString:@"http"]) {
					return SmartApplyResourse(imagePath);
				}
				return imagePath;
			} reloadHeightBlock:^(UITextView *textView, CGFloat contentHeight) {
				
			} didSelectedURLBlock:^(UITextView *textView, NSURL *URL, NSString *titleName) {
				HTWebController *webController = [[HTWebController alloc] initWithURL:URL];
				[weakSelf.navigationController pushViewController:webController animated:true];
			}];
		}];
	}];
	[self.textView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"商品详情";
	[self.view addSubview:self.textView];
	[self.view addSubview:self.lineAdvisorButton];
	[self.lineAdvisorButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.right.mas_equalTo(self.view);
		make.height.mas_equalTo(49);
	}];
}

- (HTImageTextView *)textView {
	if (!_textView) {
		_textView = [[HTImageTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.lineAdvisorButton.ht_h)];
		_textView.alwaysBounceVertical = true;
		_textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
		_textView.scrollEnabled = true;
	}
	return _textView;
}

- (UIButton *)lineAdvisorButton {
	if (!_lineAdvisorButton) {
		_lineAdvisorButton = [[UIButton alloc] init];
		_lineAdvisorButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_lineAdvisorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_lineAdvisorButton setTitle:@"点击咨询" forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *selectedColor = [normalColor colorWithAlphaComponent:0.5];
		[_lineAdvisorButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_lineAdvisorButton setBackgroundImage:[UIImage ht_pureColor:selectedColor] forState:UIControlStateSelected];
		
		__weak typeof(self) weakSelf = self;
		[_lineAdvisorButton ht_whenTap:^(UIView *view) {
			HTWebController *webController = [HTWebController contactAdvisorWebController];
			[weakSelf.navigationController pushViewController:webController animated:true];
		}];
	}
	return _lineAdvisorButton;
}


@end
