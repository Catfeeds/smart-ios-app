//
//  HTMatriculateResultSectionModel.h
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTMatriculateResultSectionType) {
	HTMatriculateResultSectionTypeAnalysis,
	HTMatriculateResultSectionTypeSchool,
};

@interface HTMatriculateResultSectionModel : NSObject

@property (nonatomic, assign) HTMatriculateResultSectionType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) Class footerClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) BOOL separatorLineHidden;

@property (nonatomic, strong) NSArray *modelArray;

+ (NSArray *)packModelArrayWithResponse:(id)response;

@end
