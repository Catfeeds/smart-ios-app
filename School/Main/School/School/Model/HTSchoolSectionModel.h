//
//  HTSchoolSectionModel.h
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolModel.h"

typedef NS_ENUM(NSInteger, HTSchoolSectionType) {
	HTSchoolSectionTypeBaseInformation,
	HTSchoolSectionTypeDescription,
	HTSchoolSectionTypeBaseData,
	HTSchoolSectionTypeMajorList,
};

@interface HTSchoolSectionModel : NSObject

@property (nonatomic, assign) HTSchoolSectionType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) BOOL separatorLineHidden;

@property (nonatomic, strong) NSArray *modelArray;

+ (NSArray *)packModelArrayWithSchoolModel:(HTSchoolModel *)schoolModel;

@end
