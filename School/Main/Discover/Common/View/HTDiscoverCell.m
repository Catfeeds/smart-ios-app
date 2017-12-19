//
//  HTDiscoverCell.m
//  School
//
//  Created by Charles Cao on 2017/12/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverCell.h"
#import "HTDiscoverImageCollectionCell.h"
#import "HTDiscoverImageCollectionLayout.h"

@implementation HTDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageConllectionView registerNib:[UINib nibWithNibName:@"HTDiscoverImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HTDiscoverImageCollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(THToeflDiscoverModel *)model row:(NSInteger)row {
	self.discoverMode = model;

	self.toeflTitleLabel.text = model.title;
	self.toeflContentLabel.text = model.cnContent;
	self.usernameLabel.text = HTPlaceholderString(model.nickname, model.username);
	self.createTimeLabel.text = model.dateTime;
	NSString *lookAndReplayStr = [NSString stringWithFormat:@"查看 : %@ | 回复 : %@",model.viewCount,model.replyNum];
	self.lookAndReplyLabel.text = lookAndReplayStr;
	
	if (model.hot.integerValue == 1) {
		self.hotLabelWidthConstraint.constant = 35;
		self.hotLabelLeftConstraint.constant = 10;
	}else{
		self.hotLabelWidthConstraint.constant = 0;
		self.hotLabelLeftConstraint.constant = 0;
	}
	
    if (ArrayNotEmpty(model.imageContent)) {
		
        self.imageConllectionHeight.constant = 80;
        [self.imageConllectionView reloadData];
		[self.imageConllectionView.collectionViewLayout invalidateLayout];
		HTDiscoverImageCollectionLayout *layout = (HTDiscoverImageCollectionLayout *)self.imageConllectionView.collectionViewLayout;
		
		CGFloat itemWidth;
		if ([[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
			itemWidth = 100;
		}else{
			itemWidth = (HTSCREENWIDTH - 40) / 3.0f;
		}
		layout.itemSize = CGSizeMake(itemWidth, 80);
		layout.minimumLineSpacing = 10;
		layout.minimumInteritemSpacing = 0;
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		

    }else{
        self.imageConllectionHeight.constant = 0;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.discoverMode.imageContent.count > 3 ? 3 : self.discoverMode.imageContent.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	HTDiscoverImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTDiscoverImageCollectionCell" forIndexPath:indexPath];
	
	NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.viplgw.cn/%@",self.discoverMode.imageContent[indexPath.row]]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    
    [cell.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"cn_placeholder"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"图片错误%@ URL %@",error,imageURL);
    }];
	return cell;
}

//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
//
//	NSMutableArray* attributes = [NSMutableArray array];
//
//		for (NSInteger j=0 ; j < [self.collectionView numberOfItemsInSection:i]; j++) {
//			NSIndexPath* indexPath = [NSIndexPath indexPathForItem:j inSection:i];
//			[attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
//		}
//
//	return attributes;
//}

@end
