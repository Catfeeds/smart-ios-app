//
//  HTStudyAbroadCell.h
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTStudyAbroadModel.h"

@interface HTStudyAbroadCell : UITableViewCell

@property (nonatomic, strong) HTStudyAbroadData *studyAbroadData;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;

@end
