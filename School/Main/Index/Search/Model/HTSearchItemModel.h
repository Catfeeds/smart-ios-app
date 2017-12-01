//
//  HTSearchItemModel.h
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTSearchType) {
	HTSearchTypeSchool,
	HTSearchTypeProfessional,
	HTSearchTypeAnswer,
	HTSearchTypeActivity,
	HTSearchTypeLibrary,
};

@interface HTSearchItemModel : NSObject

@property (nonatomic, assign) HTSearchType type;

@property (nonatomic, strong) NSString *titleName;


@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat cellHeight;

+ (NSArray *)packModelArray;

@end
