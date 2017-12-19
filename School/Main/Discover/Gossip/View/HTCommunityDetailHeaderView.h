//
//  HTCommunityDetailHeaderView.h
//  GMat
//
//  Created by hublot on 2016/11/22.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommunityLayoutModel.h"
#import "HTCommunityLayoutModel.h"
#import "HTCommunityUserView.h"
#import "HTCommunityReplyContentView.h"
#import "HTCommunityImageView.h"
#import "HTCommunityLikeReplyView.h"

#define DELETE  @"deleteGossip"

@interface HTCommunityDetailHeaderView : UIView

@property (nonatomic, strong) UIView *whiteContentView;

- (void)setModel:(HTCommunityLayoutModel *)model row:(NSInteger)row isShowDelete:(BOOL)isShowDelete;

@end
