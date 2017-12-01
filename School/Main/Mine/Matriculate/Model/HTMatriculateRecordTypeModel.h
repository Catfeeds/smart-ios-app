//
//  HTMatriculateRecordTypeModel.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTMatriculateRecordType) {
    HTMatriculateRecordTypeAll,
    HTMatriculateRecordTypeSingle,
};

@interface HTMatriculateRecordTypeModel : NSObject

@property (nonatomic, assign) HTMatriculateRecordType type;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *modelArray;

@property (nonatomic, assign) BOOL showDetail;

+ (NSArray <HTMatriculateRecordTypeModel *> *)packModelArrayWithResponse:(id)response;

@end
