//
//  HTGossIPItemModel.h
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTGossIPItemType) {
	HTGossIPItemTypeSum,
	HTGossIPItemTypeSchool,
	HTGossIPItemTypeWork,
	HTGossIPItemTypeCircel,
	HTGossIPItemTypeCourse
};

@interface HTGossIPItemModel : NSObject

//@property (nonatomic, assign) HTGossIPItemType type;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *catIdString;

+ (NSArray *)packModelArray;

@end
