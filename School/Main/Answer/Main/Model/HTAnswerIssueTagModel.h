//
//  HTAnswerIssueTagModel.h
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAnswerTagModel.h"

@interface HTAnswerIssueTagModel : NSObject

@property (nonatomic, strong) NSArray <HTAnswerTagModel *> *tagModelArray;

@property (nonatomic, strong) NSMutableArray <NSNumber *> *selectedIndexArray;

@end
