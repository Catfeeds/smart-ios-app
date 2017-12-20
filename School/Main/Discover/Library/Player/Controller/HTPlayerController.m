//
//  HTPlayerController.m
//  GMat
//
//  Created by hublot on 2017/9/25.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "HTPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "RTRootNavigationController.h"
#import "HTPlayerManager.h"
#import "HTPlayerView.h"
#import "HTPlayerView+HTSwitch.h"
#import "HTManagerController+HTRotate.h"
#import "HTImageTextView.h"
#import "HTWebController.h"
#import <UIScrollView+HTRefresh.h>
#import "HTSellerModel.h"

@interface HTPlayerController () <HTRotateScrren>

@property (nonatomic, strong) HTPlayerView *playerView;

@property (nonatomic, strong) HTImageTextView *textView;
@property (nonatomic, strong) UIButton *lineAdvisorButton;

@end

@implementation HTPlayerController

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.playerView.playerModel reloadWillSeekRateWillPlay:false];
}

- (BOOL)shouldAutorotate {
	return self.playerView.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	[self loadStoreDetail];
	[self.playerView shouldStartLoading:true];
	__weak typeof(self) weakself = self;
	self.view.reloadNetworkBlock = ^() {
//		weakself.view.placeHolderState = HTPlaceholderStateFirstRefresh;
		[[[NSOperationQueue alloc] init] addOperationWithBlock:^{
			[HTPlayerManager findPlayerXMLURLFromCourseURLString:weakself.courseURLString complete:^(NSString *playerXMLString) {
				[HTPlayerManager findM3U8URLFromXMLURLString:playerXMLString complete:^(HTPlayerModel *model) {
					model.titleName = weakself.courseTitleString;
					[[NSOperationQueue mainQueue] addOperationWithBlock:^{
						if (!model.m3u8URLString.length) {
							[HTAlert title:@"获取视频源失败"];
						
						} else {
							weakself.view.placeHolderState = HTPlaceholderStateNone;
							[weakself reloadPlayerModel:model];
						}
					}];
				}];
			}];
		}];
	};
	self.view.reloadNetworkBlock();
}

- (void)loadStoreDetail {
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
	self.view.backgroundColor = [UIColor blackColor];
	self.automaticallyAdjustsScrollViewInsets = false;
	UIImage *image = [[UIImage alloc] init];
	[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:image];
	self.navigationController.navigationBar.userInteractionEnabled = false;
	[self reloadLayoutFromStatusBar];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLayoutFromStatusBar) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)reloadLayoutFromStatusBar {
	[self.view addSubview:self.textView];
	[self.view addSubview:self.lineAdvisorButton];
	[self.view addSubview:self.playerView];
	BOOL isPortrait = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
	self.rt_navigationController.interactivePopGestureRecognizer.enabled = isPortrait;
	if (isPortrait) {
		CGFloat height = HTSCREENWIDTH * (9 / 16.0);
		[self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(MAX(20, [UIApplication sharedApplication].statusBarFrame.size.height));
			make.left.right.mas_equalTo(self.view);
			make.height.mas_equalTo(height);
		}];
	} else {
		[self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(self.view);
		}];
	}
	
	[self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.playerView.mas_bottom);
		make.left.right.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.lineAdvisorButton.mas_top);
	}];
	[self.lineAdvisorButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.right.mas_equalTo(self.view);
		make.height.mas_equalTo(49);
	}];
	
	[self.view layoutIfNeeded];
	self.playerView.isPortrait = isPortrait;
	
}

- (void)reloadPlayerModel:(HTPlayerModel *)playModel {
	[self.playerView setPlayerModel:playModel];
}

- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
	return nil;
}

- (HTPlayerView *)playerView {
	if (!_playerView) {
		_playerView = [[HTPlayerView alloc] init];
		_playerView.backgroundColor = [UIColor blackColor];
	}
	return _playerView;
}

- (HTImageTextView *)textView {
	if (!_textView) {
		_textView = [[HTImageTextView alloc] init];
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
