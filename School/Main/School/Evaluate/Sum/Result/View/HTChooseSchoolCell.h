//
//  HTChooseSchoolCell.h
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolEvaluationResultModel.h"

@interface HTChooseSchoolCell : UITableViewCell

@property (nonatomic, strong) HTResultSchool *school;
@property (weak, nonatomic) IBOutlet UIImageView *schoolImageView;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *EnglishNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
