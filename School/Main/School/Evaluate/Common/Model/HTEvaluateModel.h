//
//  HTEvaluateModel.h
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTEvaluateType) {
	HTEvaluateTypeBackground,
	HTEvaluateTypeSum,
	HTEvaluateTypeSingle
};

@interface HTEvaluateModel : NSObject

@property (nonatomic, assign) HTEvaluateType type;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *detailName;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *backgroundImageName;

+ (NSArray <HTEvaluateModel *> *)packModelArray;

@end
