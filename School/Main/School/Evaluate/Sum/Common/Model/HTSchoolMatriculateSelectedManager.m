//
//  HTSchoolMatriculateSelectedManager.m
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSelectedManager.h"
#import "HTSchoolMatriculateSelectedController.h"
#import "HTMatriculateDynamicModel.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTSchoolMatriculatePickerView.h"
#import "HTRootNavigationController.h"
#import "HTMatriculateSearchController.h"

@implementation HTSchoolMatriculateSelectedManager

+ (void)pushSelectedManagerFromController:(UIViewController *)controller matriculateModel:(HTSchoolMatriculateModel *)matriculateModel completeSelectedBlock:(void(^)(void))completeSelectedBlock {
	switch (matriculateModel.inputType) {
		case HTSchoolMatriculateInputTypePickerViewVertical:
		case HTSchoolMatriculateInputTypePickerViewTextViewVertical: {
			NSMutableArray *titleNameArray = [@[] mutableCopy];
			[matriculateModel.pickerModelArray enumerateObjectsUsingBlock:^(HTSelectedModel *pickerModel, NSUInteger index, BOOL * _Nonnull stop) {
				[titleNameArray addObject:pickerModel.name];
			}];
			[HTSchoolMatriculatePickerView showModelArray:@[titleNameArray] selectedRowArray:@[@(matriculateModel.pickerSelectedIndex)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
				NSInteger selectedRowIndex = [selectedRowArray.firstObject integerValue];
				matriculateModel.pickerModelArray[selectedRowIndex].isSelected = true;
				if (completeSelectedBlock) {
					completeSelectedBlock();
				}
			}];
			break;
		}
		case HTSchoolMatriculateInputTypeSingleSelectedVertical:
		case HTSchoolMatriculateInputTypeMutableSelectedVertical: {
			switch (matriculateModel.type) {
				case HTSchoolMatriculateTypeDreamCountry: {
                    [self pushSelectedManagerFromController:controller localSelectedModel:matriculateModel networkSelectedModel:^HTSchoolMatriculateSelectedModel *(HTMatriculateDynamicModel *dynamicModel) {
                        matriculateModel.pickerModelArray = dynamicModel.country;
                        return matriculateModel;
                    } navigationTitle:@"意向国家" didSelectedBlock:^{
						[controller.navigationController popToViewController:[controller.navigationController.childViewControllers containsObject:controller] ? controller : controller.parentViewController animated:true];
                    } completeSelectedBlock:completeSelectedBlock];
					break;
				}
				case HTSchoolMatriculateTypeSingleMajor: {
					[self pushSelectedManagerFromController:controller localSelectedModel:matriculateModel networkSelectedModel:^HTSchoolMatriculateSelectedModel *(HTMatriculateDynamicModel *dynamicModel) {
						return matriculateModel;
					} navigationTitle:@"测评专业" didSelectedBlock:^{
						[controller.navigationController popToViewController:[controller.navigationController.childViewControllers containsObject:controller] ? controller : controller.parentViewController animated:true];
					} completeSelectedBlock:completeSelectedBlock];
					break;
				}
				case HTSchoolMatriculateTypeProfessional:
				case HTSchoolMatriculateTypeDreamProfessional: {
                    [self pushSelectedManagerFromController:controller localSelectedModel:matriculateModel networkSelectedModel:^HTSchoolMatriculateSelectedModel *(HTMatriculateDynamicModel *dynamicModel) {
                        matriculateModel.pickerModelArray = dynamicModel.major;
                        return matriculateModel;
                    } navigationTitle:@"专业方向" didSelectedBlock:^{
                        HTSchoolMatriculateSelectedModel *selectedModel = matriculateModel.pickerModelArray[matriculateModel.pickerSelectedIndex];
                        [self pushSelectedManagerFromController:controller localSelectedModel:selectedModel networkSelectedModel:^HTSchoolMatriculateSelectedModel *(HTMatriculateDynamicModel *dynamicModel) {
                            HTSchoolMatriculateSelectedModel *selectedModel = matriculateModel.pickerModelArray[matriculateModel.pickerSelectedIndex];
                            return selectedModel;
                        } navigationTitle:@"专业名称" didSelectedBlock:^{
							[controller.navigationController popToViewController:[controller.navigationController.childViewControllers containsObject:controller] ? controller : controller.parentViewController animated:true];
                        } completeSelectedBlock:completeSelectedBlock];
                    } completeSelectedBlock:completeSelectedBlock];
					break;
				}
				case HTSchoolMatriculateBackgroundTypeQuestion: {
                    [self pushSelectedManagerFromController:controller localSelectedModel:matriculateModel networkSelectedModel:^HTSchoolMatriculateSelectedModel *(HTMatriculateDynamicModel *dynamicModel) {
                        return matriculateModel;
                    } navigationTitle:@"提交问题" didSelectedBlock:^{
                        
                    } completeSelectedBlock:completeSelectedBlock];
					break;
				}
				default:
					break;
			}
			break;
		}
		case HTSchoolMatriculateInputTypeSearchSelected: {
			[HTMatriculateSearchController presentSearchControllerAnimated:true matriculateModel:matriculateModel selectedBlock:^(HTSchoolModel *schoolModel) {
				if (completeSelectedBlock) {
					completeSelectedBlock();
				}
			}];
			break;
		}
		default:
			break;
	}
}

+ (void)pushSelectedManagerFromController:(UIViewController *)controller localSelectedModel:(HTSchoolMatriculateSelectedModel *)localSelectedModel networkSelectedModel:(HTSchoolMatriculateSelectedModel *(^)(HTMatriculateDynamicModel *dynamicModel))networkSelectedModel navigationTitle:(NSString *)navigationTitle didSelectedBlock:(void(^)(void))didSelectedBlock completeSelectedBlock:(void(^)(void))completeSelectedBlock {
	
    if (!localSelectedModel || !networkSelectedModel) {
        return;
    }
    
	HTSchoolMatriculateSelectedController *selectedController = [[HTSchoolMatriculateSelectedController alloc] init];
	[controller.navigationController pushViewController:selectedController animated:true];
	selectedController.navigationItem.title = navigationTitle;
	__weak typeof(selectedController) weakSelectedController = selectedController;
	__block HTMatriculateDynamicModel *dynamicModel;
	__block HTSchoolMatriculateSelectedModel *displaySelectedModel;
	[selectedController.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		void(^findSelectedModelComplete)(void) = ^() {
			weakSelectedController.tableView.allowsMultipleSelection = displaySelectedModel.allowMutableSelected;
			[weakSelectedController.tableView ht_endRefreshWithModelArrayCount:1];
			
			[weakSelectedController.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(displaySelectedModel.pickerModelArray);
			}];
			[weakSelectedController.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				[[sectionMaker didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolMatriculateSelectedModel *model) {
					model.isSelected = true;
					if (didSelectedBlock) {
						didSelectedBlock();
					}
				}] diddeSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolMatriculateSelectedModel *model) {
					model.isSelected = false;
				}];
			}];
			[displaySelectedModel.pickerModelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSelectedModel *model, NSUInteger index, BOOL * _Nonnull stop) {
				if (model.isSelected) {
					[weakSelectedController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:false scrollPosition:UITableViewScrollPositionMiddle];
				}
			}];
		};
		if (!localSelectedModel.pickerModelArray.count) {
			HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
			[HTRequestManager requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					[weakSelectedController.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
					return;
				}
				dynamicModel = [HTMatriculateDynamicModel mj_objectWithKeyValues:response];
                displaySelectedModel = networkSelectedModel(dynamicModel);
				findSelectedModelComplete();
			}];
		} else {
            displaySelectedModel = localSelectedModel;
			findSelectedModelComplete();
		}
	}];
	[selectedController.tableView ht_startRefreshHeader];
	[selectedController setEndSelectedBlock:^() {
		if (completeSelectedBlock) {
			completeSelectedBlock();
		}
	}];
	
}

@end
