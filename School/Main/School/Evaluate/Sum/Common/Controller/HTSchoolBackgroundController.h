//
//  HTSchoolBackgroundController.h
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolController.h"

@interface HTSchoolBackgroundController : HTChooseSchoolController

//目前学历
@property (weak, nonatomic) IBOutlet UITextField *currenRducationalField;
// 就读/毕业院校
@property (weak, nonatomic) IBOutlet UITextField *currenSchoolField;
//详细填写学校名称
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
//专业
@property (weak, nonatomic) IBOutlet UITextField *professionField;

@end
