//
//  HTSchoolRankSelecetdManager.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankSelecetdManager.h"
#import "HTSchoolMatriculatePickerView.h"
#import "HTSchoolMatriculateSelectedController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>

@implementation HTSchoolRankSelecetdManager

+ (void)pushSelectedManagerFromController:(UIViewController *)controller filterModel:(HTSchoolRankFilterModel *)filterModel completeSelectedBlock:(void(^)(void))completeSelectedBlock {
	switch (filterModel.inputType) {
		case HTSchoolRankInputTypePicker: {
			NSMutableArray *titleNameArray = [@[] mutableCopy];
			[filterModel.modelArray enumerateObjectsUsingBlock:^(HTSchoolRankSelectedModel *pickerModel, NSUInteger index, BOOL * _Nonnull stop) {
				[titleNameArray addObject:pickerModel.name];
			}];
			[HTSchoolMatriculatePickerView showModelArray:@[titleNameArray] selectedRowArray:@[@(filterModel.selectedIndex)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
				NSInteger selectedRowIndex = [selectedRowArray.firstObject integerValue];
				[filterModel.modelArray enumerateObjectsUsingBlock:^(HTSchoolRankSelectedModel *model, NSUInteger index, BOOL * _Nonnull stop) {
					model.isSelected = false;
				}];
				filterModel.modelArray[selectedRowIndex].isSelected = true;
				if (completeSelectedBlock) {
					completeSelectedBlock();
				}
			}];
			break;
		}
		case HTSchoolRankInputTypeSelected: {
			HTSchoolMatriculateSelectedController *selectedController = [[HTSchoolMatriculateSelectedController alloc] init];
			[controller.navigationController pushViewController:selectedController animated:true];
			selectedController.navigationItem.title = @"排名类型";
			__weak typeof(selectedController) weakSelectedController = selectedController;
			
			[selectedController.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
				void(^findSelectedModelComplete)(void) = ^() {
					[weakSelectedController.tableView ht_endRefreshWithModelArrayCount:1];
					
					[weakSelectedController.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
						sectionMaker.modelArray(filterModel.modelArray);
					}];
					[weakSelectedController.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
						[[sectionMaker didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolMatriculateSelectedModel *model) {
							model.isSelected = true;
							[controller.navigationController popToViewController:controller animated:true];
						}] diddeSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolMatriculateSelectedModel *model) {
							model.isSelected = false;
						}];
					}];
					[filterModel.modelArray enumerateObjectsUsingBlock:^(HTSchoolRankSelectedModel *model, NSUInteger index, BOOL * _Nonnull stop) {
						if (model.isSelected) {
							[weakSelectedController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:false scrollPosition:UITableViewScrollPositionMiddle];
						}
					}];
				};
				if (!filterModel.modelArray.count) {
					HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
					[HTRequestManager requestRankClassListWithNetworkModel:networkModel currentPage:nil pageSize:nil complete:^(id response, HTError *errorModel) {
						if (errorModel.existError) {
							[weakSelectedController.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
							return;
						}
						filterModel.modelArray = [HTSchoolRankSelectedModel mj_objectArrayWithKeyValuesArray:response[@"classes"]];
						findSelectedModelComplete();
					}];
				} else {
					findSelectedModelComplete();
				}
			}];
			[selectedController.tableView ht_startRefreshHeader];
			[selectedController setEndSelectedBlock:^() {
				if (completeSelectedBlock) {
					completeSelectedBlock();
				}
			}];
			break;
		}
	}
}

@end
