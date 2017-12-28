//
//  HTRankYearCollectionCell.h
//  School
//
//  Created by Charles Cao on 2017/12/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolRankModel.h"

@interface HTRankYearCollectionCell : UICollectionViewCell

@property (nonatomic, strong) HTYearModel *year;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end
