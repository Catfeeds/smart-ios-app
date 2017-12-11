//
//  HTSelectSchoolController.h
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolMatriculateController.h"
#import "HTMatriculateSearchController.h"

@interface HTSelectSchoolController : HTSchoolMatriculateController

@property (nonatomic, strong) HTSchoolModel *selectedSchool;
@property (nonatomic, strong) HTSchoolProfessionalModel *selectedMajor;

@property (weak, nonatomic) IBOutlet UITextField *selectSchoolField;
@property (weak, nonatomic) IBOutlet UITextField *selectMajorField;

@end
