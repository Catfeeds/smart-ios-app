//
//  HTSchoolRankFilterModel.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTSchoolRankSelectedModel;

typedef NS_ENUM(NSInteger, HTSchoolRankFilterType) {
	HTSchoolRankFilterTypeCategory,
	HTSchoolRankFilterTypeYear,
};

typedef NS_ENUM(NSInteger, HTSchoolRankInputType) {
	HTSchoolRankInputTypePicker,
	HTSchoolRankInputTypeSelected
};

@interface HTSchoolRankFilterModel : NSObject

@property (nonatomic, assign) HTSchoolRankFilterType type;

@property (nonatomic, assign) HTSchoolRankInputType inputType;

@property (nonatomic, strong) NSArray <HTSchoolRankSelectedModel *> *modelArray;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

+ (NSArray *)packModelArray;

@end


@interface HTSchoolRankSelectedModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) BOOL isSelected;

+ (NSArray *)packSelectedModelArrayForRankType:(HTSchoolRankFilterType)type;

@end
