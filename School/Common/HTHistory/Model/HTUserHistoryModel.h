//
//  HTUserHistoryModel.h
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTUserHistoryType) {
	HTUserHistoryTypeSchoolDetail,
	HTUserHistoryTypeProfessionalDetail,
	HTUserHistoryTypeAnswerDetail,
	HTUserHistoryTypeActivityDetail,
	HTUserHistoryTypeLibraryDetail,
};

@interface HTUserHistoryModel : NSObject

@property (nonatomic, assign) HTUserHistoryType type;

@property (nonatomic, strong) NSString *lookId;

@property (nonatomic, strong) NSString *titleName;

+ (instancetype)packHistoryModelType:(HTUserHistoryType)type lookId:(NSString *)lookId titleName:(NSString *)titleName;


@property (nonatomic, assign) NSInteger lookTime;

@property (nonatomic, assign) NSInteger ID;

@end
