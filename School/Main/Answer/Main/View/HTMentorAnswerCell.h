//
//  HTMentorAnswerCell.h
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMentorAnswerCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerContentLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionAndAnswerNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightLayoutConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

@end
