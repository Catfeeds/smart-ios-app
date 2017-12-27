//
//  HTSchoolMatriculateContainerController.h
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HTSchoolModel.h"

@interface HTSchoolMatriculateContainerController : UIViewController

//要测评的学校
@property (nonatomic, strong) HTSchoolModel *evaluationSchool;

//要测评学校ID
@property (nonatomic, strong) NSString *schoolID;
@end
