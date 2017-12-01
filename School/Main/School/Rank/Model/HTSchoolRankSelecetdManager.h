//
//  HTSchoolRankSelecetdManager.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolRankFilterModel.h"

@interface HTSchoolRankSelecetdManager : NSObject

+ (void)pushSelectedManagerFromController:(UIViewController *)controller filterModel:(HTSchoolRankFilterModel *)filterModel completeSelectedBlock:(void(^)(void))completeSelectedBlock;

@end
