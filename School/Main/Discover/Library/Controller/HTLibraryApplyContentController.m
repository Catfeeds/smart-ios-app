//
//  HTLibraryApplyContentController.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryApplyContentController.h"
#import "HTImageTextView.h"
#import <UIScrollView+HTRefresh.h>
#import "HTLibraryModel.h"
#import "HTWebController.h"
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreManager.h"
#import "HTStoreBarButtonItem.h"

@interface HTLibraryApplyContentController ()

@property (nonatomic, strong) HTImageTextView *textView;

@end

@implementation HTLibraryApplyContentController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	
	__weak typeof(self) weakSelf = self;
	[self.textView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestLibrarayDetailWithNetworkModel:networkModel contentIdString:weakSelf.libraryIdString catIdString:weakSelf.libraryCatIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.textView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTLibraryApplyContentModel *model = [HTLibraryApplyContentModel mj_objectWithKeyValues:[response firstObject]];
			weakSelf.navigationItem.title = model.name;
			NSAttributedString *attributedString = [[model.answer ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE];
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
			
			
			NSString *libraryIdString = HTPlaceholderString(weakSelf.libraryIdString, @"");
			[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitLibraryDetail keyValue:@{@"id":libraryIdString}];
			[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeLibraryDetail lookId:libraryIdString titleName:model.name]];
            
            HTUserStoreModel *storeModel = [HTUserStoreModel packStoreModelType:HTUserStoreTypeLibrary lookId:model.ID titleName:model.name];
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
	self.navigationItem.title = @"知识库详情";
	[self.view addSubview:self.textView];
}

- (void)setNavigationItemTitle:(NSString *)navigationItemTitle {
	self.navigationItem.title = navigationItemTitle;
}

- (void)setAttributedString:(NSAttributedString *)attributedString {
	[self.view addSubview:self.textView];
	self.textView.attributedText = attributedString;
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
