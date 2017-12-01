//
//  HTSchoolRankFilterCell.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTSchoolRankFilterCell : UITableViewCell

@property (nonatomic, strong) void(^reloadRankSelected)(void);

@end
