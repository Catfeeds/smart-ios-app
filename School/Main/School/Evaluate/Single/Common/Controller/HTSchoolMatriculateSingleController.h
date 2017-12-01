//
//  HTSchoolMatriculateSingleController.h
//  School
//
//  Created by hublot on 2017/6/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTReuseController.h"
#import "HTSchoolModel.h"

@interface HTSchoolMatriculateSingleController : HTReuseController

@property (nonatomic, copy) NSString *schoolIdString;

//要测评的学校
@property (nonatomic, strong) HTSchoolModel *evaluationSchool;

@end
