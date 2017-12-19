//
//  HTDiscoverCell.h
//  School
//
//  Created by Charles Cao on 2017/12/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THToeflDiscoverModel.h"

@interface HTDiscoverCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) THToeflDiscoverModel *discoverMode;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotLabelLeftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConllectionHeight;
@property (weak, nonatomic) IBOutlet UILabel *toeflTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toeflContentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageConllectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookAndReplyLabel;

@end
