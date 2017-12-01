//
//  HTMatriculateSearchController.h
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolModel.h"

typedef void(^HTMatriculateSearchSelectedBlock)(HTSchoolModel *schoolModel);

@interface HTMatriculateSearchController : UIViewController

+ (void)presentSearchControllerAnimated:(BOOL)animated matriculateModel:(HTSchoolMatriculateSelectedModel *)matriculateModel selectedBlock:(HTMatriculateSearchSelectedBlock)selectedBlock;

@end
