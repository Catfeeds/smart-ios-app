//
//  HTHeadlineHeaderView.h
//  School
//
//  Created by Charles Cao on 2017/12/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDiscoverActivityModel.h"

@interface HTHeadlineHeaderView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *activityModelArray;
@property (weak, nonatomic) IBOutlet UICollectionView *headlineCollectionView;

@end
