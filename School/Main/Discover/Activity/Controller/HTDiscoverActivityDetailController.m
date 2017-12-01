//
//  HTDiscoverActivityDetailController.m
//  School
//
//  Created by hublot on 17/8/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverActivityDetailController.h"
#import "HTDiscoverActivityModel.h"
#import "HTImageTextView.h"
#import <UIScrollView+HTRefresh.h>
#import "HTWebController.h"
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreManager.h"
#import "HTStoreBarButtonItem.h"

@interface HTDiscoverActivityDetailController ()

@property (nonatomic, strong) HTImageTextView *textView;

@end

@implementation HTDiscoverActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.textView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
		[HTRequestManager requestActivityDetailWithNetworkModel:networkModel contentIdString:weakSelf.activityIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.textView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTDiscoverActivityModel *model = [HTDiscoverActivityModel mj_objectWithKeyValues:[response[@"data"] firstObject]];
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
			
			
			NSString *activityIdString = HTPlaceholderString(weakSelf.activityIdString, @"");
			[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitActivityDetail keyValue:@{@"id":activityIdString}];
			[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeActivityDetail lookId:activityIdString titleName:model.name]];
            
            HTUserStoreModel *storeModel = [HTUserStoreModel packStoreModelType:HTUserStoreTypeActivity lookId:model.ID titleName:model.name];
            HTStoreBarButtonItem *storeBarButtonItem = [[HTStoreBarButtonItem alloc] initWithTapHandler:^(HTStoreBarButtonItem *item) {
                [HTUserStoreManager switchStoreStateWithModel:storeModel];
                item.selected = [HTUserStoreManager isStoredWithModel:storeModel];
            }];
            storeBarButtonItem.selected = [HTUserStoreManager isStoredWithModel:storeModel];
            weakSelf.navigationItem.rightBarButtonItem = storeBarButtonItem;
		}];
	}];
	[self.textView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"资讯详情";
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
