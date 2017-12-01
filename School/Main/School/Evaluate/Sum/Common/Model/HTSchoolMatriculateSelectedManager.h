//
//  HTSchoolMatriculateSelectedManager.h
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolMatriculateModel.h"

@interface HTSchoolMatriculateSelectedManager : NSObject

+ (void)pushSelectedManagerFromController:(UIViewController *)controller matriculateModel:(HTSchoolMatriculateModel *)matriculateModel completeSelectedBlock:(void(^)(void))completeSelectedBlock;

@end
