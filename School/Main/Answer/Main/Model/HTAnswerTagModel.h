//
//  HTAnswerTagModel.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolFilterModel.h"

@interface HTAnswerTagModel : HTSelectedModel

@property (nonatomic, assign) BOOL isEnable;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *userId;

@end
