//
//  HTIndexHeaderView.h
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HTScrollPageView.h>
#import "HTIndexModel.h"

@interface HTIndexHeaderView : UIView

@property (nonatomic, strong) HTScrollPageView *bannerBackgroundView;

@property (nonatomic, strong) UIPageControl *bannerPageControl;

@property (nonatomic, strong) UICollectionView *circelCollectionView;

- (void)setBannerModelArray:(NSArray *)bannerModelArray;

@end
