//
//  HTProfessionalSectionModel.h
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTProfessionalModel.h"

typedef NS_ENUM(NSInteger, HTProfessionalSectionType) {
	HTProfessionalSectionTypeBase,
	HTProfessionalSectionTypeRequire,
	HTProfessionalSectionTypeDecription,
	HTProfessionalSectionTypeLink
};

@interface HTProfessionalSectionModel : NSObject

@property (nonatomic, assign) HTProfessionalSectionType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) BOOL separatorLineHidden;

@property (nonatomic, strong) NSArray *modelArray;

+ (NSArray *)packModelArrayWithProfessionalModel:(HTProfessionalModel *)professionalModel;

@end
