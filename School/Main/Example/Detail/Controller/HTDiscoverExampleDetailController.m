//
//  HTDiscoverExampleDetailController.m
//  School
//
//  Created by hublot on 2017/8/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverExampleDetailController.h"
#import "HTImageTextView.h"
#import <UIScrollView+HTRefresh.h>
#import "HTDiscoverExampleModel.h"
#import "HTWebController.h"

@interface HTDiscoverExampleDetailController ()

@property (nonatomic, strong) HTImageTextView *textView;

@end

@implementation HTDiscoverExampleDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	__weak typeof(self) weakSelf = self;
	[self.textView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
		[HTRequestManager requestExampleDetailWithNetworkModel:networkModel contentIdString:weakSelf.exampleIdString catIdString:weakSelf.exampleCatIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.textView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTDiscoverExampleModel *model = [HTDiscoverExampleModel mj_objectWithKeyValues:[response firstObject]];
			weakSelf.navigationItem.title = model.name;
			NSAttributedString *attributedString = [[model.alternatives ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE];
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
	self.navigationItem.title = @"案例详情";
	[self.view addSubview:self.textView];
}

- (HTImageTextView *)textView {
	if (!_textView) {
		_textView = [[HTImageTextView alloc] initWithFrame:self.view.bounds];
		_textView.alwaysBounceVertical = true;
		_textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
		_textView.scrollEnabled = true;
	}
	return _textView;
}

@end
