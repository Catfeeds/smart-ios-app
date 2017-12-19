//
//  HTBroadCastController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBroadCastController.h"
#import "HTBroadCastModel.h"
#import "HTManagerController.h"
#import "HTWebController.h"
#import <HTEncodeDecodeManager.h>

@interface HTBroadCastController ()

@property (nonatomic, strong) HTBroadCastModel *advertModel;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIButton *disableAdvertButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HTBroadCastController

- (void)dealloc {
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.timer invalidate];
	[[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationNone];
	[[HTManagerController defaultManagerController].tabBarController viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[[HTManagerController defaultManagerController].tabBarController viewDidAppear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if (self.loadViewBlock) {
		self.loadViewBlock(self.view);
	}
	
	[self initializeDataSource];
	[self initializeUserInterface];
	
	[self removeBroadCastController];
}

- (void)initializeDataSource {
	[self.view addSubview:self.backgroundView];
	[self.view addSubview:self.disableAdvertButton];
	
	__weak typeof(self) weakSelf = self;
	[HTRequestManager requestBroadcastComplete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[self removeBroadCastController];
			return;
		}
		weakSelf.advertModel = [HTBroadCastModel mj_objectWithKeyValues:response];
		NSData *data = [HTEncodeDecodeManager ht_decodeWithBase64:weakSelf.advertModel.ht_image_64];
		UIImage *image = [UIImage imageWithData:data];
		if (image.size.width > 0 && image.size.height > 0) {
			self.backgroundView.image = image;
			[self.backgroundView ht_whenTap:^(UIView *view) {
				HTWebController *webController = [[HTWebController alloc] initWithAddress:weakSelf.advertModel.url];
				[MTA trackCustomKeyValueEvent:@"openBroadCastDetail" props:weakSelf.advertModel.mj_keyValues];
				[weakSelf removeBroadCastController];
				UINavigationController *currentNavigationController = [HTManagerController defaultManagerController].tabBarController.selectedViewController;
				if ([currentNavigationController isKindOfClass:[UINavigationController class]]) {
					[currentNavigationController pushViewController:webController animated:true];
				}
			}];
			
#ifdef DEBUG
			//				self.advertModel.time = 0;
#endif
			
			[self.timer invalidate];
			self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
				NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"跳过( %ld )", weakSelf.advertModel.time] attributes:nil];
				[attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(4, [NSString stringWithFormat:@"%ld", weakSelf.advertModel.time].length)];
				weakSelf.advertModel.time --;
				dispatch_async(dispatch_get_main_queue(), ^{
					[weakSelf.disableAdvertButton setAttributedTitle:attributedString forState:UIControlStateNormal];
					weakSelf.disableAdvertButton.hidden = false;
					if (weakSelf.advertModel.time < 0 || weakSelf.advertModel.time > 5) {
						[weakSelf removeBroadCastController];
					}
				});
			} repeats:true];
			dispatch_async(dispatch_get_global_queue(0, 0), ^{
				[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
				//崩溃问题
				[self.timer fire];

			});
		}
	}];
}

- (void)initializeUserInterface {
	
}

- (void)removeBroadCastController {
	[self viewWillDisappear:true];
	[self.backgroundView removeFromSuperview];
	[self.disableAdvertButton removeFromSuperview];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
	[self didMoveToParentViewController:nil];
	[self viewDidDisappear:true];
}

- (UIImageView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	}
	return _backgroundView;
}

- (UIButton *)disableAdvertButton {
	if (!_disableAdvertButton) {
		_disableAdvertButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_disableAdvertButton.frame = CGRectMake(self.view.bounds.size.width - HTADAPT568(90), self.view.bounds.size.height - HTADAPT568(50), HTADAPT568(70), HTADAPT568(28));
		_disableAdvertButton.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.2];
		_disableAdvertButton.layer.cornerRadius = 4;
		_disableAdvertButton.layer.masksToBounds = true;
		_disableAdvertButton.titleLabel.font = [UIFont systemFontOfSize:HTADAPT568(12)];
		_disableAdvertButton.titleLabel.textColor = [UIColor whiteColor];
		[_disableAdvertButton addTarget:self action:@selector(removeBroadCastController) forControlEvents:UIControlEventTouchUpInside];
		_disableAdvertButton.hidden = true;
	}
	return _disableAdvertButton;
}

@end
