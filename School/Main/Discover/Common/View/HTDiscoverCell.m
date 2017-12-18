//
//  HTDiscoverCell.m
//  School
//
//  Created by Charles Cao on 2017/12/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverCell.h"
#import "HTDiscoverImageCollectionCell.h"

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
	NSString *lookAndReplayStr = [NSString stringWithFormat:@"查看:%@ | 回复:%@",model.viewCount,@"没有"];
	self.lookAndReplyLabel.text = lookAndReplayStr;
	
    if (ArrayNotEmpty(model.imageContent)) {
        self.imageConllectionHeight.constant = 80;
        [self.imageConllectionView reloadData];

    }else{
        self.imageConllectionHeight.constant = 0;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.discoverMode.imageContent.count;
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

@end
