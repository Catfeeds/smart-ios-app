//
//  HTUniversityRankCell.h
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTUniversityRankClassModel.h"

@interface HTUniversityRankClassCell : UITableViewCell

@property (nonatomic, strong) HTUniversityRankClassModel *rankClass;

@property (weak, nonatomic) IBOutlet UIImageView *rankBackgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *rankTitleLabel;

@end
