//
//  HTSchoolMatriculateModel.m
//  School
//
//  Created by hublot on 2017/7/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateModel.h"
#import "HTSchoolModel.h"
#import <HTValidateManager.h>

@interface HTSchoolMatriculateSectionModel ()

@property (nonatomic, strong) NSArray *visibleMatriculateModelArray;

@end

@implementation HTSchoolMatriculateSectionModel

@synthesize matriculateModelArray = _matriculateModelArray;

+ (NSArray <HTSchoolMatriculateSectionModel *> *)packSectionModelArrayOnlyForSingleSchool:(BOOL)onlyForSingleSchool {
	NSString *sectionTypeKey = @"sectionTypeKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *isSelectedKey = @"isSelectedKey";
	NSMutableArray *keyValueArray = [@[
							 	 		@{sectionTypeKey:@(HTSchoolMatriculateSectionTypeScore), titleNameKey:@"个人成绩", imageNameKey:@"cn2_school_matriculate_score_header", isSelectedKey:@(false)},
								 		@{sectionTypeKey:@(HTSchoolMatriculateSectionTypeSchool), titleNameKey:@"学校背景", imageNameKey:@"cn2_school_matriculate_school_header", isSelectedKey:@(false)},
							 		] mutableCopy];
	if (!onlyForSingleSchool) {
		NSArray *appendKeyValueArray = @[
									       @{sectionTypeKey:@(HTSchoolMatriculateSectionTypeWork), titleNameKey:@"个人软背景", imageNameKey:@"cn2_school_matriculate_work_header", isSelectedKey:@(false)},
									       @{sectionTypeKey:@(HTSchoolMatriculateSectionTypeDream), titleNameKey:@"申请方向", imageNameKey:@"cn2_school_matriculate_dream_header", isSelectedKey:@(false)},
									   ];
		[keyValueArray addObjectsFromArray:appendKeyValueArray];
	} else {
		NSArray *appendKeyValueArray = @[
											 @{sectionTypeKey:@(HTSchoolMatriculateSectionTypeSingle), titleNameKey:@"申请专业", imageNameKey:@"cn2_school_matriculate_dream_header", isSelectedKey:@(false)},
										];
		[keyValueArray insertObjects:appendKeyValueArray atIndexes:[NSIndexSet indexSetWithIndex:0]];
	}
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSchoolMatriculateSectionModel *model = [[HTSchoolMatriculateSectionModel alloc] init];
		HTSchoolMatriculateSectionType sectionType = [dictionary[sectionTypeKey] integerValue];
		model.sectionType = sectionType;
		model.sectionTitleName = dictionary[titleNameKey];
		model.sectionImageName = dictionary[imageNameKey];
		model.isSelected = [dictionary[isSelectedKey] boolValue];
		model.matriculateModelArray = [HTSchoolMatriculateModel packModelArrayForSectionType:sectionType];
		[modelArray addObject:model];
	}];
	return modelArray;
}

+ (NSArray <HTSchoolMatriculateSectionModel *> *)packBackgroundSectionModelArray {
	HTSchoolMatriculateSectionModel *model = [[HTSchoolMatriculateSectionModel alloc] init];
	model.sectionType = HTSchoolMatriculateSectionTypeBackground;
	model.matriculateModelArray = [HTSchoolMatriculateModel packModelArrayForSectionType:model.sectionType];
	return @[model];
}



+ (void)packResultRequestParameterWithSectionModelArray:(NSArray <HTSchoolMatriculateSectionModel *> *)sectionModelArray onlyForSingleSchool:(BOOL)onlyForSingleSchool completeBlock:(void(^)(NSDictionary *parameter, NSString *errorString, NSIndexPath *errorIndexPath))completeBlock {
	if (!completeBlock) {
		return;
	}
	NSMutableDictionary *parameter = [@{} mutableCopy];
	for (NSInteger section = 0; section < sectionModelArray.count; section ++) {
		HTSchoolMatriculateSectionModel *sectionModel = sectionModelArray[section];
		NSArray <HTSchoolMatriculateModel *> *visibleMatriculateModelArray = sectionModel.visibleMatriculateModelArray;
		for (NSInteger row = 0; row < visibleMatriculateModelArray.count; row ++) {
			HTSchoolMatriculateModel *model = visibleMatriculateModelArray[row];
			switch (model.type) {
				case HTSchoolMatriculateTypeGpa: {
					CGFloat currentInputTextValue = model.currentInputText.floatValue;
					if (currentInputTextValue >= 2.5 && currentInputTextValue <= 4.0) {
						if (onlyForSingleSchool) {
							[parameter setValue:model.currentInputText forKey:@"gpa"];
						} else {
							[parameter setValue:model.currentInputText forKey:@"result_gpa"];
						}
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"gpa 成绩在 2.5 至 4.0 之间", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeGmatGre: {
					CGFloat currentInputTextValue = model.currentInputText.floatValue;
					if (currentInputTextValue >= 200 && currentInputTextValue <= 340) {
						[parameter setValue:model.currentInputText forKey:@"gre"];
					} else if (currentInputTextValue >= 400 && currentInputTextValue <= 780) {
						if (onlyForSingleSchool) {
							[parameter setValue:model.currentInputText forKey:@"gmat"];
						} else {
							[parameter setValue:model.currentInputText forKey:@"result_gmat"];
						}
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"gmat 成绩在 400 至 700 之间, gre 成绩在 200 至 340 之间", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeToeflIelts: {
					CGFloat currentInputTextValue = model.currentInputText.floatValue;
					if (currentInputTextValue >= 60 && currentInputTextValue <= 120) {
						if (onlyForSingleSchool) {
							[parameter setValue:model.currentInputText forKey:@"toefl"];
						} else {
							[parameter setValue:model.currentInputText forKey:@"result_toefl"];
						}
					} else if (currentInputTextValue >= 5.0 && currentInputTextValue <= 9.0) {
						[parameter setValue:model.currentInputText forKey:@"ielts"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"toefl 成绩在 60 至 120 之间, ielts 成绩在 5.0 至 9.0 之间", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeEducation: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *selectedModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:selectedModel.ID forKey:@"education"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择你的目前学历", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeGrade: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *selectedModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:selectedModel.ID forKey:@"school"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择你的院校等级", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeSchool: {
					if (model.currentInputText.length) {
						if (onlyForSingleSchool) {
							[parameter setValue:model.currentInputText forKey:@"attendSchool"];
						} else {
							[parameter setValue:model.currentInputText forKey:@"schoolName"];
						}
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的学校名称", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeProfessional: {
					BOOL passValidate = false;
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *majorFieldModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:majorFieldModel.ID forKey:@"major_top"];
						
						if (majorFieldModel.pickerSelectedIndex >= 0 && majorFieldModel.pickerSelectedIndex < majorFieldModel.pickerModelArray.count) {
							HTSchoolMatriculateSelectedModel *specificMajorModel = majorFieldModel.pickerModelArray[majorFieldModel.pickerSelectedIndex];
							if (onlyForSingleSchool) {
								[parameter setValue:specificMajorModel.name forKey:@"major"];
							} else {
								[parameter setValue:specificMajorModel.name forKey:@"major_name1"];
								[parameter setValue:specificMajorModel.ID forKey:@"school_major"];
							}
							passValidate = true;
						}
					}
					if (passValidate) {
						
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择你的当前专业", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeWork: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count && model.currentInputText.length) {
						HTSchoolMatriculateSelectedModel *selectedModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:selectedModel.ID forKey:@"work"];
						[parameter setValue:model.currentInputText forKey:@"live"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的工作经验", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeProject: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"project"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的项目经验", errorIndexPath);
						return;
					}
					break;
				} 
				case HTSchoolMatriculateTypeOverSea: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"studyTour"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的海外留学经历", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeVolunteer: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"active"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你参加的公益活动", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypePrize: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"price"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你参加的获奖经历", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeDreamCountry: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *selectedModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:selectedModel.ID forKey:@"destination"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的留学目的地", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeDreamProfessional: {
					BOOL passValidate = false;
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *majorFieldModel = model.pickerModelArray[model.pickerSelectedIndex];
						if (majorFieldModel.pickerSelectedIndex >= 0 && majorFieldModel.pickerSelectedIndex < majorFieldModel.pickerModelArray.count) {
							HTSchoolMatriculateSelectedModel *specificMajorModel = majorFieldModel.pickerModelArray[majorFieldModel.pickerSelectedIndex];
							[parameter setValue:specificMajorModel.ID forKey:@"major"];
							[parameter setValue:specificMajorModel.name forKey:@"major_name2"];
							passValidate = true;
						}
					}
					if (passValidate) {
						
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择你的目标专业", errorIndexPath);
						return;
					}
					break;
				}
					
				
					
				case HTSchoolMatriculateTypeSingleSchool: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolModel *selectedModel = (HTSchoolModel *)model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:selectedModel.article forKey:@"schoolRank"];
						[parameter setValue:selectedModel.country forKey:@"country"];
						[parameter setValue:selectedModel.name forKey:@"schoolName"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择要进行测评的学校", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateTypeSingleMajor: {
					BOOL passValidate = false;
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						HTSchoolMatriculateSelectedModel *majorFieldModel = model.pickerModelArray[model.pickerSelectedIndex];
						[parameter setValue:majorFieldModel.name forKey:@"majorName"];
						passValidate = true;
					}
					if (passValidate) {
						
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择要进行测评的专业", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeTime: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"planTime"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的计划出国时间", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeDreamCountry: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"country"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的意向国家", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeDreamPorfessional: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"major"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的意向专业", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeGmat: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"gmat"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的 gmat 成绩", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeToefl: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"toefl"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的 Toefl 成绩", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeIelts: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"ielts"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的 Ielts 成绩", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeWork: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"experience"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的软背景经历", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeQuestion: {
					if (model.pickerSelectedIndex >= 0 && model.pickerSelectedIndex < model.pickerModelArray.count) {
						NSMutableArray *titleNameArray = [@[] mutableCopy];
						[model.pickerModelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSelectedModel *pickerModel, NSUInteger idx, BOOL * _Nonnull stop) {
							if (pickerModel.isSelected) {
								[titleNameArray addObject:pickerModel.name];
							}
						}];
						[parameter setValue:titleNameArray forKey:@"emphases"];
					} else if (!model.optionValue) {
						sectionModel.isSelected = false;
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请选择你最关心的问题", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeQuestionAppend: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"supplement"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请补充你最想了解的问题", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeName: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"uName"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的名字", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypePhone: {
					if (model.currentInputText.length && [HTValidateManager ht_validateMobile:model.currentInputText]) {
						[parameter setValue:model.currentInputText forKey:@"phone"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请正确填写你的电话信息", errorIndexPath);
						return;
					}
					break;
				}
				case HTSchoolMatriculateBackgroundTypeContact: {
					if (model.currentInputText.length) {
						[parameter setValue:model.currentInputText forKey:@"weChat"];
					} else if (!model.optionValue) {
						NSIndexPath *errorIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
						completeBlock(@{}, @"请填写你的联系方式", errorIndexPath);
						return;
					}
					break;
				}
			}
		}
	}
	completeBlock(parameter, nil, nil);
}

- (void)setMatriculateModelArray:(NSArray<HTSchoolMatriculateModel *> *)matriculateModelArray {
	_matriculateModelArray = matriculateModelArray;
	_visibleMatriculateModelArray = matriculateModelArray;
}

- (NSArray<HTSchoolMatriculateModel *> *)matriculateModelArray {
	if (self.isSelected) {
		return @[];
	} else {
		return _matriculateModelArray;
	}
}

@end

@implementation HTSchoolMatriculateModel

+ (NSArray <HTSchoolMatriculateModel *> *)packModelArrayForSectionType:(HTSchoolMatriculateSectionType)sectionType {
	NSString *singleTypeKey = @"singleTypeKey";
	NSString *inputTypeKey = @"inputTypeKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *placeHolderKey = @"placeHolderKey";
	NSString *currentInputKey = @"currentInputKey";
	NSString *optionValueKey = @"optionValueKey";
	NSString *allowMutableSelectedKey = @"allowMutableSelectedKey";
	NSString *keyboardTypekey = @"keyboardTypekey";
	NSArray *keyValueArray;
	NSMutableArray *modelArray = [@[] mutableCopy];
	switch (sectionType) {
		case HTSchoolMatriculateSectionTypeScore: {
			keyValueArray = @[
								   @{
									   singleTypeKey:@(HTSchoolMatriculateTypeGpa),
									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									   titleNameKey:@"GPA",
									   placeHolderKey:@"(2.5 - 4.0)",
									   currentInputKey:@"",
									   optionValueKey:@(false),
									   allowMutableSelectedKey:@(false),
									   keyboardTypekey:@(UIKeyboardTypeDecimalPad),
									},
//								   @{
//									   singleTypeKey:@(HTSchoolMatriculateTypeGmat),
//									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
//									   titleNameKey:@"GMAT",
//									   placeHolderKey:@"GMAT",
//									   currentInputKey:@"",
//									   optionValueKey:@(true),
//									   pickerSelectedIndexKey:@(- 1),
//									},
//								   @{
//									   singleTypeKey:@(HTSchoolMatriculateTypeGre),
//									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
//									   titleNameKey:@"GRE",
//									   placeHolderKey:@"GRE",
//									   currentInputKey:@"",
//									   optionValueKey:@(true),
//									   pickerSelectedIndexKey:@(- 1),
//									},
//								   @{
//									   singleTypeKey:@(HTSchoolMatriculateTypeToefl),
//									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
//									   titleNameKey:@"TOEFL",
//									   placeHolderKey:@"TOEFL",
//									   currentInputKey:@"",
//									   optionValueKey:@(true),
//									   pickerSelectedIndexKey:@(- 1),
//									},
//								   @{
//									   singleTypeKey:@(HTSchoolMatriculateTypeIelts),
//									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
//									   titleNameKey:@"IELTS",
//									   placeHolderKey:@"IELTS",
//									   currentInputKey:@"",
//									   optionValueKey:@(true),
//									   pickerSelectedIndexKey:@(- 1),
//									},
								   @{
									   singleTypeKey:@(HTSchoolMatriculateTypeGmatGre),
									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									   titleNameKey:@"GMAT/GRE",
									   placeHolderKey:@"(400 - 780 | 200 - 340)",
									   currentInputKey:@"",
									   optionValueKey:@(true),
									   allowMutableSelectedKey:@(false),
									   keyboardTypekey:@(UIKeyboardTypeDecimalPad),
								   },
								   @{
									   singleTypeKey:@(HTSchoolMatriculateTypeToeflIelts),
									   inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									   titleNameKey:@"TOEFL/IELTS",
									   placeHolderKey:@"(60 - 120 | 5.0 - 9.0)",
									   currentInputKey:@"",
									   optionValueKey:@(false),
									   allowMutableSelectedKey:@(false),
									   keyboardTypekey:@(UIKeyboardTypeDecimalPad),
								   },
							];
			break;
		}
		case HTSchoolMatriculateSectionTypeSchool: {
			keyValueArray = @[
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeEducation),
									  inputTypeKey:@(HTSchoolMatriculateInputTypePickerViewVertical),
									  titleNameKey:@"目前学历",
									  placeHolderKey:@"目前学历",
									  currentInputKey:@"",
									  optionValueKey:@(true),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
									  },
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeGrade),
									  inputTypeKey:@(HTSchoolMatriculateInputTypePickerViewVertical),
									  titleNameKey:@"就读/毕业院校等级",
									  placeHolderKey:@"就读/毕业院校等级",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
									  },
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeSchool),
									  inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									  titleNameKey:@"学校名称",
									  placeHolderKey:@"学校名称",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
									  },
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeProfessional),
									  inputTypeKey:@(HTSchoolMatriculateInputTypeSingleSelectedVertical),
									  titleNameKey:@"当前专业",
									  placeHolderKey:@"当前专业",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
									  },
							];
			break;
		}
		case HTSchoolMatriculateSectionTypeWork: {
			keyValueArray = @[
							    @{
									singleTypeKey:@(HTSchoolMatriculateTypeWork),
									inputTypeKey:@(HTSchoolMatriculateInputTypePickerViewTextViewVertical),
									titleNameKey:@"实习/工作经验",
									placeHolderKey:@"请如实填写跟申请方向相关的工作经验, 若没有完整工作经验, 请填写相关实习经验, 描述不少于30字, 可不填",
									currentInputKey:@"",
									optionValueKey:@(true),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
								@{
									singleTypeKey:@(HTSchoolMatriculateTypeProject),
									inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									titleNameKey:@"项目经验",
									placeHolderKey:@"请如实填写跟申请方向相关的项目经验, 如比赛经历, 商业项目, 试验项目, 论文发表等, 描述不少于30字, 可不填",
									currentInputKey:@"",
									optionValueKey:@(true),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
								@{
									singleTypeKey:@(HTSchoolMatriculateTypeOverSea),
									inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									titleNameKey:@"海外留学",
									placeHolderKey:@"请如实填写海外留学经历, 如交换项目, 海外实践课程等, 可不填",
									currentInputKey:@"",
									optionValueKey:@(true),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
								@{
									singleTypeKey:@(HTSchoolMatriculateTypeVolunteer),
									inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									titleNameKey:@"公益活动",
									placeHolderKey:@"请如实填写所参与公益项目, 可不填",
									currentInputKey:@"",
									optionValueKey:@(true),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
								@{
									singleTypeKey:@(HTSchoolMatriculateTypePrize),
									inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									titleNameKey:@"获奖经历",
									placeHolderKey:@"请如实填写获奖经历, 可不填",
									currentInputKey:@"",
									optionValueKey:@(true),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
							];

			break;
		}
		case HTSchoolMatriculateSectionTypeDream: {
			keyValueArray = @[
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeDreamCountry),
									  inputTypeKey:@(HTSchoolMatriculateInputTypeSingleSelectedVertical),
									  titleNameKey:@"留学目的地",
									  placeHolderKey:@"",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
								  },
								  @{
									  singleTypeKey:@(HTSchoolMatriculateTypeDreamProfessional),
									  inputTypeKey:@(HTSchoolMatriculateInputTypeSingleSelectedVertical),
									  titleNameKey:@"目标专业",
									  placeHolderKey:@"想要报读的专业",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault),
								  },
							];
			break;
		}
		case HTSchoolMatriculateSectionTypeSingle: {
			keyValueArray = @[
							 	@{
									singleTypeKey:@(HTSchoolMatriculateTypeSingleSchool),
									inputTypeKey:@(HTSchoolMatriculateInputTypeSearchSelected),
									titleNameKey:@"要进行测评的学校",
									placeHolderKey:@"",
									currentInputKey:@"",
									optionValueKey:@(false),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
								@{
									singleTypeKey:@(HTSchoolMatriculateTypeSingleMajor),
									inputTypeKey:@(HTSchoolMatriculateInputTypeSingleSelectedVertical),
									titleNameKey:@"要进行测评的专业",
									placeHolderKey:@"",
									currentInputKey:@"",
									optionValueKey:@(false),
									allowMutableSelectedKey:@(false),
									keyboardTypekey:@(UIKeyboardTypeDefault),
								},
							 ];
			break;
		}
		case HTSchoolMatriculateSectionTypeBackground: {
			keyValueArray = @[
							  	@{
									  singleTypeKey:@(HTSchoolMatriculateBackgroundTypeTime),
									  inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									  titleNameKey:@"计划出国时间",
									  placeHolderKey:@"例如\"2018年春季\"",
									  currentInputKey:@"",
									  optionValueKey:@(false),
									  allowMutableSelectedKey:@(false),
									  keyboardTypekey:@(UIKeyboardTypeDefault)
								  },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeDreamCountry),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									 titleNameKey:@"意向国家",
									 placeHolderKey:@"意向国家",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeDreamPorfessional),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									 titleNameKey:@"意向专业",
									 placeHolderKey:@"意向专业",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeGmat),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									 titleNameKey:@"GMAT",
									 placeHolderKey:@"GMAT 成绩",
									 currentInputKey:@"",
									 optionValueKey:@(true),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDecimalPad)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeToefl),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									 titleNameKey:@"Toefl",
									 placeHolderKey:@"Toefl 成绩",
									 currentInputKey:@"",
									 optionValueKey:@(true),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDecimalPad)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeIelts),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldHorizontal),
									 titleNameKey:@"Ielts",
									 placeHolderKey:@"Ielts 成绩",
									 currentInputKey:@"",
									 optionValueKey:@(true),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDecimalPad)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeWork),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									 titleNameKey:@"软背景经历",
									 placeHolderKey:@"请如实填写跟申请方向相关的软背景经历。如实习/工作经验、项目比赛经验、海外游学经验、公益活动 、获奖经历等。",
									 currentInputKey:@"",
									 optionValueKey:@(true),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeQuestion),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeMutableSelectedVertical),
									 titleNameKey:@"你最关心的问题",
									 placeHolderKey:@"",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(true),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeQuestionAppend),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextViewVertical),
									 titleNameKey:@"请补充你想了解的问题",
									 placeHolderKey:@"",
									 currentInputKey:@"",
									 optionValueKey:@(true),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeName),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									 titleNameKey:@"你的名字",
									 placeHolderKey:@"你的名字",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypePhone),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									 titleNameKey:@"你的电话",
									 placeHolderKey:@"你的电话",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeNumberPad)
									 },
								 @{
									 singleTypeKey:@(HTSchoolMatriculateBackgroundTypeContact),
									 inputTypeKey:@(HTSchoolMatriculateInputTypeTextFieldVertical),
									 titleNameKey:@"QQ / 微信",
									 placeHolderKey:@"你的联系方式",
									 currentInputKey:@"",
									 optionValueKey:@(false),
									 allowMutableSelectedKey:@(false),
									 keyboardTypekey:@(UIKeyboardTypeDefault)
									},
							  ];
			break;
		}
	}
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
		HTSchoolMatriculateModel *model = [[HTSchoolMatriculateModel alloc] init];
		HTSchoolMatriculateType type = [dictionary[singleTypeKey] integerValue];
		model.type = type;
		model.inputType = [dictionary[inputTypeKey] integerValue];
		model.titleNameText = dictionary[titleNameKey];
		model.placeHolderText = dictionary[placeHolderKey];
		model.currentInputText = dictionary[currentInputKey];
		model.optionValue = [dictionary[optionValueKey] boolValue];
		model.allowMutableSelected = [dictionary[allowMutableSelectedKey] boolValue];
		model.keyboardType = [dictionary[keyboardTypekey] integerValue];
		model.pickerModelArray = [HTSchoolMatriculateSelectedModel packPickerModelArrayFromType:type];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end



@implementation HTSchoolMatriculateSelectedModel

- (NSInteger)pickerSelectedIndex {
	
	__block NSInteger selectedIndex = - 1;
	[self.pickerModelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSelectedModel *selectedModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (selectedModel.isSelected) {
			selectedIndex = index;
			*stop = true;
		}
	}];
	return selectedIndex;
}

+ (NSArray <HTSchoolMatriculatePickerModel *> *)packPickerModelArrayFromType:(HTSchoolMatriculateType)type {
	NSString *titleNameKey = @"titleNameKey";
	NSString *IDStringKey = @"IDStringKey";
	NSString *isSelectedKey = @"isSelectedKey";
	NSArray *keyValueArray = @[];
	switch (type) {
		case HTSchoolMatriculateTypeEducation: {
			keyValueArray = @[
							  @{titleNameKey:@"博士", IDStringKey:@"博士", isSelectedKey:@(false)},
							  @{titleNameKey:@"硕士", IDStringKey:@"硕士", isSelectedKey:@(false)},
							  @{titleNameKey:@"本科", IDStringKey:@"本科", isSelectedKey:@(false)},
							  @{titleNameKey:@"专科", IDStringKey:@"专科", isSelectedKey:@(false)},
							  @{titleNameKey:@"高中", IDStringKey:@"高中", isSelectedKey:@(false)},
							  @{titleNameKey:@"初中", IDStringKey:@"初中", isSelectedKey:@(false)},
							  ];
			break;
		}
		case HTSchoolMatriculateTypeGrade: {
			keyValueArray = @[
							  @{titleNameKey:@"清北复交浙大", IDStringKey:@"1", isSelectedKey:@(false)},
							  @{titleNameKey:@"985学校", IDStringKey:@"2", isSelectedKey:@(false)},
							  @{titleNameKey:@"211学校", IDStringKey:@"3", isSelectedKey:@(false)},
							  @{titleNameKey:@"非211本科", IDStringKey:@"4", isSelectedKey:@(false)},
							  @{titleNameKey:@"专科", IDStringKey:@"5", isSelectedKey:@(false)},
							  ];
			break;
		}
		case HTSchoolMatriculateTypeGpa:
//			keyValueArray = @[
//							  @{titleNameKey:@"平均 gpa 分数", IDStringKey:@"0", isSelectedKey:@(false)},
//							  @{titleNameKey:@"四分制 gpa 分数", IDStringKey:@"0", isSelectedKey:@(false)},
//							];
			break;
		case HTSchoolMatriculateTypeDreamCountry:
//			keyValueArray = @[
//								@{titleNameKey:@"美国", IDStringKey:@"0", isSelectedKey:@(false)},
//								@{titleNameKey:@"英国", IDStringKey:@"0", isSelectedKey:@(false)},
//								@{titleNameKey:@"加拿大", IDStringKey:@"0", isSelectedKey:@(false)},
//								@{titleNameKey:@"澳洲", IDStringKey:@"0", isSelectedKey:@(false)},
//								@{titleNameKey:@"新加坡", IDStringKey:@"0", isSelectedKey:@(false)},
//								@{titleNameKey:@"香港", IDStringKey:@"0", isSelectedKey:@(false)},
//							];
			break;
		case HTSchoolMatriculateTypeWork:
			keyValueArray = @[
								@{titleNameKey:@"国内四大", IDStringKey:@"1", isSelectedKey:@(false)},
								@{titleNameKey:@"500强", IDStringKey:@"2", isSelectedKey:@(false)},
								@{titleNameKey:@"外企", IDStringKey:@"3", isSelectedKey:@(false)},
								@{titleNameKey:@"国企", IDStringKey:@"4", isSelectedKey:@(false)},
								@{titleNameKey:@"私企", IDStringKey:@"5", isSelectedKey:@(false)},
							];
			break;
		case HTSchoolMatriculateBackgroundTypeQuestion: {
			keyValueArray = @[
							  @{titleNameKey:@"服务流程", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"出国考试课程", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"选校定位", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"申请步骤", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"申请费用", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"奖学金", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"推荐顾问", IDStringKey:@"0", isSelectedKey:@(false)},
							  @{titleNameKey:@"其他", IDStringKey:@"0", isSelectedKey:@(false)},
							  ];
			break;
		}
		default: {
			break;
		}
	}
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSchoolMatriculateSelectedModel *pickerModel = [[HTSchoolMatriculateSelectedModel alloc] init];
		pickerModel.name = dictionary[titleNameKey];
		pickerModel.ID = dictionary[IDStringKey];
		pickerModel.isSelected = [dictionary[isSelectedKey] boolValue];
		[modelArray addObject:pickerModel];
	}];
	return modelArray;
}

@end
