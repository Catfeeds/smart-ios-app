//
//  HTUniversityRankCell.h
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolRankModel.h"

@interface HTUniversityRankCell : UITableViewCell

@property (nonatomic, strong) HTSchoolRankModel *rankModel;
@property (nonatomic, assign) NSInteger rankNum;  //排名

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *universityIconView;
@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end
