//
//  HTAnswerDetailController.h
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAnswerModel.h"

@interface HTAnswerDetailController : UIViewController

@property (nonatomic, strong) NSString *answerIdString;

@property (nonatomic, strong) void(^reloadAnswerModel)(HTAnswerModel *answerModel);

@end
