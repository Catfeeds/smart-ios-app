//
//  HTUserHistoryModel.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserHistoryModel.h"

@implementation HTUserHistoryModel

+ (instancetype)packHistoryModelType:(HTUserHistoryType)type lookId:(NSString *)lookId titleName:(NSString *)titleName {
	HTUserHistoryModel *model = [[HTUserHistoryModel alloc] init];
	model.type = type;
	model.lookId = lookId;
	model.titleName = titleName;
	return model;
}

@end
