//
//  HTConditionCell.h
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolEvaluationResultModel.h"

@interface HTConditionCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) HTCompareResult *result;

@end
