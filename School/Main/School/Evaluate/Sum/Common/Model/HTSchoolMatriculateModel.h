//
//  HTSchoolMatriculateModel.h
//  School
//
//  Created by hublot on 2017/7/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolFilterModel.h"

@class HTSchoolMatriculateModel, HTSchoolMatriculatePickerModel;

typedef NS_ENUM(NSInteger, HTSchoolMatriculateSectionType) {
	HTSchoolMatriculateSectionTypeScore,
	HTSchoolMatriculateSectionTypeSchool,
	HTSchoolMatriculateSectionTypeWork,
	HTSchoolMatriculateSectionTypeDream,
	
	HTSchoolMatriculateSectionTypeSingle,
	
	HTSchoolMatriculateSectionTypeBackground,
};

typedef NS_ENUM(NSInteger, HTSchoolMatriculateType) {
	HTSchoolMatriculateTypeGpa,
//	HTSchoolMatriculateTypeGmat,
//	HTSchoolMatriculateTypeGre,
//	HTSchoolMatriculateTypeToefl,
//	HTSchoolMatriculateTypeIelts,
	HTSchoolMatriculateTypeGmatGre,
	HTSchoolMatriculateTypeToeflIelts,
	
	HTSchoolMatriculateTypeEducation,
	HTSchoolMatriculateTypeGrade,
	HTSchoolMatriculateTypeSchool,
	HTSchoolMatriculateTypeProfessional,
	HTSchoolMatriculateTypeWork,
	HTSchoolMatriculateTypeProject,
	HTSchoolMatriculateTypeOverSea,
	HTSchoolMatriculateTypeVolunteer,
	HTSchoolMatriculateTypePrize,
	HTSchoolMatriculateTypeDreamCountry,
	HTSchoolMatriculateTypeDreamProfessional,
	
	
	
	HTSchoolMatriculateTypeSingleSchool,
	HTSchoolMatriculateTypeSingleMajor,
	
	
	HTSchoolMatriculateBackgroundTypeTime,
	HTSchoolMatriculateBackgroundTypeDreamCountry,
	HTSchoolMatriculateBackgroundTypeDreamPorfessional,
	HTSchoolMatriculateBackgroundTypeGmat,
	HTSchoolMatriculateBackgroundTypeToefl,
	HTSchoolMatriculateBackgroundTypeIelts,
	HTSchoolMatriculateBackgroundTypeWork,
	HTSchoolMatriculateBackgroundTypeQuestion,
	HTSchoolMatriculateBackgroundTypeQuestionAppend,
	HTSchoolMatriculateBackgroundTypeName,
	HTSchoolMatriculateBackgroundTypePhone,
	HTSchoolMatriculateBackgroundTypeContact,
};

typedef NS_ENUM(NSInteger, HTSchoolMatriculateInputType) {
	HTSchoolMatriculateInputTypeTextFieldHorizontal,
	HTSchoolMatriculateInputTypeTextFieldVertical,
	HTSchoolMatriculateInputTypePickerViewVertical,
	HTSchoolMatriculateInputTypePickerViewTextViewVertical,
	HTSchoolMatriculateInputTypeSingleSelectedVertical,
	HTSchoolMatriculateInputTypeMutableSelectedVertical,
	HTSchoolMatriculateInputTypeTextFieldHorizontalPickerViewVertical,
	HTSchoolMatriculateInputTypeTextViewVertical,
	HTSchoolMatriculateInputTypeSearchSelected,
};

@interface HTSchoolMatriculateSectionModel : NSObject

@property (nonatomic, assign) HTSchoolMatriculateSectionType sectionType;

@property (nonatomic, strong) NSString *sectionImageName;

@property (nonatomic, strong) NSString *sectionTitleName;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSArray <HTSchoolMatriculateModel *> *matriculateModelArray;

+ (NSArray <HTSchoolMatriculateSectionModel *> *)packSectionModelArrayOnlyForSingleSchool:(BOOL)onlyForSingleSchool;

+ (NSArray <HTSchoolMatriculateSectionModel *> *)packBackgroundSectionModelArray;



+ (void)packResultRequestParameterWithSectionModelArray:(NSArray <HTSchoolMatriculateSectionModel *> *)sectionModelArray onlyForSingleSchool:(BOOL)onlyForSingleSchool completeBlock:(void(^)(NSDictionary *parameter, NSString *errorString, NSIndexPath *errorIndexPath))completeBlock;


@end


@interface HTSchoolMatriculateSelectedModel : HTSelectedModel

@property (nonatomic, assign, readonly) NSInteger pickerSelectedIndex;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@property (nonatomic, strong) NSArray <HTSchoolMatriculateSelectedModel *> *pickerModelArray;

+ (NSArray <HTSchoolMatriculateSelectedModel *> *)packPickerModelArrayFromType:(HTSchoolMatriculateType)type;

@end


@interface HTSchoolMatriculateModel : HTSchoolMatriculateSelectedModel

@property (nonatomic, assign) HTSchoolMatriculateType type;

@property (nonatomic, assign) HTSchoolMatriculateInputType inputType;

@property (nonatomic, strong) NSString *titleNameText;

@property (nonatomic, strong) NSString *placeHolderText;

@property (nonatomic, strong) NSString *currentInputText;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) BOOL optionValue;

+ (NSArray <HTSchoolMatriculateModel *> *)packModelArrayForSectionType:(HTSchoolMatriculateSectionType)sectionType;

@end

