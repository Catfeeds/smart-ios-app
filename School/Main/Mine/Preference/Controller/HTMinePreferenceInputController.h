//
//  HTMinePreferenceInputController.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTMinePreferenceInputType) {
    HTMinePreferenceInputTypeName,
    HTMinePreferenceInputTypePhone,
    HTMinePreferenceInputTypeEmail,
    HTMinePreferenceInputTypePassword
};

@interface HTMinePreferenceInputController : UIViewController

@property (nonatomic, assign) HTMinePreferenceInputType type;

@end
