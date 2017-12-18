//
//  HTHeadlineHeaderView.m
//  School
//
//  Created by Charles Cao on 2017/12/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTHeadlineHeaderView.h"
#import "HTHeadlineCollectionCell.h"

@implementation HTHeadlineHeaderView

- (void)awakeFromNib{
	[super awakeFromNib];
	[self.headlineCollectionView registerNib:[UINib nibWithNibName:@"HTHeadlineCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HTHeadlineCollectionCell"];
}

- (void)setActivityModelArray:(NSArray *)activityModelArray{
	_activityModelArray = activityModelArray;
	[self.headlineCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.activityModelArray.count > 3 ? 3 : self.activityModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	HTHeadlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTHeadlineCollectionCell" forIndexPath:indexPath];
	HTDiscoverActivityModel *model = self.activityModelArray[indexPath.row];
	cell.titleLabel.text = model.title;
	cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"discover_headline_bg_%ld",(long)indexPath.row+1]];
	return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
