//
//  HTIndexSectionHeaderView.h
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTIndexSectionHeaderView : UITableViewHeaderFooterView

- (void)setTitleName:(NSString *)titleName imageName:(NSString *)imageName separatorLineHidden:(BOOL)separatorLineHidden;

@property (nonatomic, strong) void(^headerRightDetailTapedBlock)(void);

@end
