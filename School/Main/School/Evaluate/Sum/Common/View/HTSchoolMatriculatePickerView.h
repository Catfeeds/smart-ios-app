//
//  HTSchoolMatriculatePickerView.h
//  School
//
//  Created by hublot on 2017/6/23.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolMatriculateModel.h"

@interface HTSchoolMatriculatePickerView : UIPickerView

+ (void)showModelArray:(NSArray <NSArray *> *)modelArray selectedRowArray:(NSArray <NSNumber *> *)selectedRowArray didSelectedBlock:(void(^)(NSArray <NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray <NSNumber *> *selectedRowArray))didSelectedBlock;

@end
