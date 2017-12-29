//
//  HTSearchController.m
//  School
//
//  Created by hublot on 2017/7/25.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchController.h"
#import "HTManagerController.h"
#import "HTRootNavigationController.h"
#import <NSObject+HTObjectCategory.h>
#import <HTKeyboardController.h>
#import "HTSearchRequestManager.h"
#import "HTSearchContentController.h"
#import "HTSearchResultModel.h"

@interface HTSearchController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray <HTSearchItemModel *> *itemModelArray;

@end

@implementation HTSearchController

+ (void)presentSearchControllerAnimated:(BOOL)animated defaultSelectedType:(HTSearchType)defaultSelectedType {
	HTSearchController *searchController = [[HTSearchController alloc] init];
	[searchController.searchBar becomeFirstResponder];
	HTRootNavigationController *navigationController = [[HTRootNavigationController alloc] initWithRootViewController:searchController];
	NSArray *itemModelArray = searchController.itemModelArray;
	[[HTManagerController defaultManagerController] presentViewController:navigationController animated:animated completion:^{
		[itemModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
			HTSearchItemModel  *itemModel = obj;
			if (itemModel.type == defaultSelectedType) {
				[searchController switchToPage:index animated:false];
				*stop = true;
			}
		}];
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar endEditing:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	[self packPageModelArray];
}

- (void)initializeUserInterface {
	self.navigationItem.titleView = self.searchBar;
	[self.searchBar sizeToFit];
	[self.navigationItem.titleView sizeToFit];
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
}

- (UISearchBar *)searchBar {
	if (!_searchBar) {
		_searchBar = [[UISearchBar alloc] init];
		_searchBar.placeholder = @"搜索感兴趣的内容";
		_searchBar.tintColor = [UIColor whiteColor];
		_searchBar.showsCancelButton = true;
		_searchBar.delegate = self;
		
		UIButton *cancelButton = [_searchBar ht_valueForSelector:NSSelectorFromString(@"_cancelButton") runtime:false];
		[cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	return _searchBar;
}

- (void)searchDispatchTimeSelector {
	[self packPageModelArray];
}

- (void)packPageModelArray {
	
	NSArray *itemModelArray = self.itemModelArray;
	NSMutableArray *pageModelArray = [@[] mutableCopy];
	[itemModelArray enumerateObjectsUsingBlock:^(HTSearchItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		HTPageModel *pageModel = [[HTPageModel alloc] init];
		pageModel.selectedTitle = model.titleName;
		pageModel.reuseControllerClass = [HTSearchContentController class];
		[pageModelArray addObject:pageModel];
	}];
	self.pageModelArray = pageModelArray;
	NSString *keyWord = self.searchBar.text;
	[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<NSString *> *, HTError *)) {
		HTSearchItemModel *model = itemModelArray[pageIndex.integerValue];
		HTSearchType type = model.type;
		if (!StringNotEmpty(keyWord)) {
			return ;
		}
		[HTSearchRequestManager searchItemType:type keyWord:keyWord pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				modelArrayStatus(nil, errorModel);
				return;
			}
			NSArray *modelArray = [HTSearchResultModel packModelArrayWithResponse:response type:type];
			modelArrayStatus(modelArray, nil);
		}];
	}];
	[self.magicView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchDispatchTimeSelector) object:nil];
	[self performSelector:@selector(searchDispatchTimeSelector) withObject:nil afterDelay:0.3];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[HTKeyboardController resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self dismissViewControllerAnimated:true completion:nil];
}

- (NSArray *)itemModelArray {
	if (!_itemModelArray) {
		_itemModelArray = [HTSearchItemModel packModelArray];
	}
	return _itemModelArray;
}

@end
