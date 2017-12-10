//
//  HTSchoolMatriculateSchoolBackgroundController.h
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateController.h"

@interface HTSchoolMatriculateSchoolBackgroundController : HTSchoolMatriculateController

//目前学历
@property (weak, nonatomic) IBOutlet UITextField *currenRducationalField;
// 就读/毕业院校
@property (weak, nonatomic) IBOutlet UITextField *currenSchoolField;
//详细填写学校名称
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
//专业
@property (weak, nonatomic) IBOutlet UITextField *professionField;

@end
