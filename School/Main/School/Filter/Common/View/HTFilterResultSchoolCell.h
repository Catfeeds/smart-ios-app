//
//  HTFilterResultSchoolCell.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTFilterResultSchoolModel.h"


@interface HTFilterResultSchoolCell : UITableViewCell

@property (nonatomic, copy) void(^chooseMajorBlock)(HTFilterResultProfessionalModel *professional);

@end
