//
//  HTAllSchoolCell.h
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTAllSchoolCellDelegate <NSObject>

- (void)shareAction;
- (void)resetAction;

@end

@interface HTAllSchoolCell : UITableViewCell

@property (nonatomic, assign) id<HTAllSchoolCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *schoolNumberlabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end
