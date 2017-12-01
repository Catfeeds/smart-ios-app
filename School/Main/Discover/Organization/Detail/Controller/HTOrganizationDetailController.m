//
//  HTOrganizationDetailController.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationDetailController.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTOrganizationDetialModel.h"
#import "HTOrganizationTextCell.h"
#import "HTOrganizationAdvisorCell.h"
#import "HTWebController.h"
#import "HTOrganizationSectionHeader.h"

@interface HTOrganizationDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *contactAdvisorButton;

@end

@implementation HTOrganizationDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestOrganizationDetailWithNetworkModel:networkModel organizationId:weakSelf.organizationIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTOrganizationDetialModel *detailModel = [HTOrganizationDetialModel mj_objectWithKeyValues:[response firstObject]];
			weakSelf.navigationItem.title = detailModel.name;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:detailModel ? 1 : 0];
			[detailModel.headerModelArray enumerateObjectsUsingBlock:^(HTOrganizationSectionModel *headerModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[[sectionMaker.cellClass(headerModel.cellClass).rowHeight(headerModel.cellHeigith).modelArray(headerModel.modelArray).headerClass(headerModel.headerClass).headerHeight(headerModel.headerHeight).footerHeight(headerModel.footerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTOrganizationSectionHeader *reuseView, __kindof NSArray *modelArray) {
						[reuseView setTitleName:headerModel.titleName];
					}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						cell.separatorInset = headerModel.cellSeparatorHidden ? UIEdgeInsetsMake(0, HTSCREENWIDTH, 0, 0) : UIEdgeInsetsZero;
						if ([cell isKindOfClass:[HTOrganizationTextCell class]]) {
							HTOrganizationTextCell *textCell = (HTOrganizationTextCell *)cell;
							if (!textCell.reloadTableRowBlock) {
								[textCell setReloadTableRowBlock:^{
									@try {
										[weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:index]] withRowAnimation:UITableViewRowAnimationNone];
									} @catch (NSException *exception) {
										
									} @finally {
										
									}
								}];
							}
						}
					}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						if ([cell isKindOfClass:[HTOrganizationAdvisorCell class]]) {
							HTWebController *webController = [HTWebController contactAdvisorWebController];
							[weakSelf.navigationController pushViewController:webController animated:true];
						}
					}];
				}];
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"机构详情";
	[self.view addSubview:self.tableView];
	[self.view addSubview:self.contactAdvisorButton];
	[self.contactAdvisorButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self.view);
		make.height.mas_equalTo(49);
	}];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.contactAdvisorButton.mas_top);
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
		_tableView.separatorColor = _tableView.backgroundColor;
	}
	return _tableView;
}

- (UIButton *)contactAdvisorButton {
	if (!_contactAdvisorButton) {
		_contactAdvisorButton = [[UIButton alloc] init];
		[_contactAdvisorButton setTitle:@"预约咨询" forState:UIControlStateNormal];
		_contactAdvisorButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_contactAdvisorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *highlightColor = [normalColor colorWithAlphaComponent:0.5];
		[_contactAdvisorButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_contactAdvisorButton setBackgroundImage:[UIImage ht_pureColor:highlightColor] forState:UIControlStateHighlighted];
		
		__weak typeof(self) weakSelf = self;
		[_contactAdvisorButton ht_whenTap:^(UIView *view) {
			HTWebController *webController = [HTWebController contactAdvisorWebController];
			[weakSelf.navigationController pushViewController:webController animated:true];
		}];
	}
	return _contactAdvisorButton;
}

@end
