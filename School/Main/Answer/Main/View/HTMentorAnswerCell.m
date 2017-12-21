//
//  HTMentorAnswerCell.m
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMentorAnswerCell.h"
#import "HTMentorAnswerCollectionCell.h"
#import "HTAnswerTagCollectionViewLayout.h"
#import "HTAnswerSingleController.h"
#import "HTAnswerModel.h"

#define tagViewHeight 15

@interface HTMentorAnswerCell ()

@property (nonatomic , strong) NSArray <HTAnswerTagModel *> *tagModelArray;

@end

@implementation HTMentorAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	[self.tagCollectionView registerNib:[UINib nibWithNibName:@"HTMentorAnswerCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HTMentorAnswerCollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(HTAnswerModel *)model row:(NSInteger)row {
	
	self.tagModelArray = model.tags;
	
	self.usernameLabel.text = HTPlaceholderString(model.nickname, model.username);
	self.dateLabel.text = model.addTime;
	self.answerLabel.text = model.question;
	self.answerContentLabel.text = model.contentAttributedString.string;
	NSURL *url = [NSURL URLWithString:SmartApplyResourse(model.image)];
	[self.userHeadImageView sd_setImageWithURL:url placeholderImage:HTPLACEHOLDERIMAGE];
	
	NSString *lookAndReplayStr = [NSString stringWithFormat:@"查看 : %@ | %ld人回答",model.browse,model.answer.count];
	self.attentionAndAnswerNumLabel.text = lookAndReplayStr;
	
	if (ArrayNotEmpty(model.tags)) {
		self.tagViewHeightLayoutConstraint.constant = tagViewHeight;
		HTAnswerTagCollectionViewLayout *layout = (HTAnswerTagCollectionViewLayout *)self.tagCollectionView.collectionViewLayout;
	//	layout.itemSize = CGSizeMake(60, 80);
		layout.minimumLineSpacing = 10;
		layout.minimumInteritemSpacing = 0;
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		[self.tagCollectionView reloadData];
		[self.tagCollectionView.collectionViewLayout invalidateLayout];
	}else{
		self.tagViewHeightLayoutConstraint.constant = 0;
	}
	
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return self.tagModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	HTMentorAnswerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTMentorAnswerCollectionCell" forIndexPath:indexPath];
	cell.tagLabel.text = self.tagModelArray[indexPath.row].name;
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	HTAnswerTagModel *model = self.tagModelArray[indexPath.row];
	HTAnswerSingleController *singleController = [[HTAnswerSingleController alloc] init];
	singleController.answerTagModel = model;
	UIViewController *controller = self.ht_controller;
	UINavigationController *navigationController = controller.navigationController;
	if (!navigationController) {
		navigationController = controller.view.superview.ht_controller.navigationController;
	}
	[navigationController pushViewController:singleController animated:true];
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString *tagStr = self.tagModelArray[indexPath.row].name;
	CGFloat itemWidth = [tagStr boundingRectWithSize:CGSizeMake(MAXFLOAT, tagViewHeight)
											 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
										  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width + 5 ;
	return CGSizeMake(itemWidth, tagViewHeight);
}

@end
