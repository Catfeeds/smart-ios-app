//
//  HTAnswerCell.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerCell.h"
#import "HTAnswerModel.h"
#import <NSObject+HTTableRowHeight.h>
#import <UIButton+HTButtonCategory.h>
#import <UIView+WebCache.h>
#import <NSString+HTString.h>
#import "HTAnswerTagCell.h"
#import <UICollectionViewCell+HTSeparate.h>
#import "HTSchoolFilterSelectedCollectionCell.h"
#import "HTAnswerSingleController.h"
#import "HTCommunityReplyKeyBoardView.h"
#import "HTAnswerKeboardManager.h"
#import "HTSomeoneController.h"

@interface HTAnswerCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *headImageButton;

@property (nonatomic, strong) UILabel *sendTimeLabel;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UICollectionView *tagCollectionView;

@property (nonatomic, strong) UIButton *attentionCountButton;

@property (nonatomic, strong) UIButton *replyCountButton;

@property (nonatomic, strong) HTAnswerModel *model;

@property (nonatomic, strong) NSArray *modelSizeArray;

@end

static NSString *kHTAnswerTagCollectionCellIdentifier = @"kHTAnswerTagCollectionCellIdentifier";

@implementation HTAnswerCell

+ (CGFloat)itemHeight {
	return 23;
}

- (void)didMoveToSuperview {
	[self addSubview:self.headImageButton];
    [self addSubview:self.nicknameLabel];
	[self addSubview:self.sendTimeLabel];
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.detailNameLabel];
	[self addSubview:self.tagCollectionView];
	[self addSubview:self.attentionCountButton];
	[self addSubview:self.replyCountButton];
	[self.headImageButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.left.mas_equalTo(15);
	}];
    [self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageButton.mas_right).offset(15);
        make.top.mas_equalTo(self.headImageButton).offset(2);
        make.right.mas_equalTo(- 15);
    }];
	[self.sendTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nicknameLabel);
        make.bottom.mas_equalTo(self.headImageButton).offset(- 2);
	}];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageButton);
        make.right.mas_equalTo(- 15);
        make.top.mas_equalTo(self.headImageButton.mas_bottom).offset(15);
    }];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
	}];
	[self.tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
	}];
	[self.attentionCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(self.tagCollectionView.mas_bottom).offset(15);
	}];
	[self.replyCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self.attentionCountButton);
	}];
}

- (void)setModel:(HTAnswerModel *)model row:(NSInteger)row {
	
	[self didMoveToSuperview];
	
    __weak typeof(self) weakSelf = self;
    [self.headImageButton sd_internalSetImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE options:kNilOptions operationKey:nil setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
        UIImage *smallImage = [image ht_resetSize:CGSizeMake(40, 40)];
        [weakSelf.headImageButton setImage:smallImage forState:UIControlStateNormal];
    } progress:nil completed:nil];

    self.nicknameLabel.text = HTPlaceholderString(model.nickname, model.username);
    self.sendTimeLabel.text = model.addTime;
    self.titleNameLabel.text = model.question;
	
	self.detailNameLabel.text = model.contentAttributedString.string;
	CGFloat detailTextHeight = 0;
	if (model.isDetailModel) {
		self.detailNameLabel.numberOfLines = 0;
		detailTextHeight = [self.detailNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.detailNameLabel.font textView:nil];
	} else {
		self.detailNameLabel.numberOfLines = 1;
		detailTextHeight = 15;
	}
	
	[self.attentionCountButton setTitle:[NSString stringWithFormat:@"关注度 %@", model.browse] forState:UIControlStateNormal];
	[self.replyCountButton setTitle:[NSString stringWithFormat:@"%ld 个回答", model.answer.count] forState:UIControlStateNormal];
	[self.replyCountButton ht_whenTap:^(UIView *view) {
		[HTAnswerKeboardManager beginKeyboardWithAnswerModel:model success:^{
			[HTAnswerKeboardManager tryRefreshWithView:weakSelf];
		}];
	}];
	
	
	CGRect collectionFrame = CGRectZero;
	collectionFrame.size.width = HTSCREENWIDTH - 30;
	self.tagCollectionView.frame = collectionFrame;
	_model = model;
	NSMutableArray *modelSizeArray = [@[] mutableCopy];
	HTSchoolFilterSelectedCollectionCell *cell = [[HTSchoolFilterSelectedCollectionCell alloc] init];
	cell.titleNameButton.titleLabel.font = [UIFont systemFontOfSize:12];
	UIFont *titleNameFont = cell.titleNameButton.titleLabel.font;
	[_model.tags enumerateObjectsUsingBlock:^(HTAnswerTagModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		CGSize itemSize = CGSizeZero;
		itemSize.height = [self.class itemHeight];
		NSString *titleName = model.name;
		itemSize.width = [titleName boundingRectWithSize:CGSizeMake(MAXFLOAT, itemSize.height)
												 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
											  attributes:@{NSFontAttributeName:titleNameFont} context:nil].size.width;
		itemSize.width += 12;
		[modelSizeArray addObject:[NSValue valueWithCGSize:itemSize]];
	}];
	self.modelSizeArray = modelSizeArray;
	
	[self.tagCollectionView reloadData];
	

	CGFloat modelHeight = 15;
	modelHeight += 40;
	modelHeight += 15;
	modelHeight += 15;
	modelHeight += detailTextHeight;
	modelHeight += 13;
	modelHeight += 15;
	if (model.tags.count) {
		modelHeight += 15;
		CGFloat collectionHeight = self.tagCollectionView.collectionViewLayout.collectionViewContentSize.height;
		modelHeight += collectionHeight;
		[self.tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(15);
			make.height.mas_equalTo(collectionHeight);
		}];
	} else {
		[self.tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(0);
			make.height.mas_equalTo(0);
		}];
	}
	modelHeight += 15;
	modelHeight += 20;
	
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
    
    [self.headImageButton ht_whenTap:^(UIView *view) {
        HTSomeoneController *someoneController = [[HTSomeoneController alloc] init];
		someoneController.userIdString = model.userId;
        [weakSelf.ht_controller.navigationController pushViewController:someoneController animated:true];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [self.modelSizeArray[indexPath.row] CGSizeValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTSchoolFilterSelectedCollectionCell *cell = (HTSchoolFilterSelectedCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kHTAnswerTagCollectionCellIdentifier forIndexPath:indexPath];
	id model = self.model.tags[indexPath.row];
	cell.titleNameButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[cell setModel:model row:indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	HTAnswerTagModel *model = self.model.tags[indexPath.row];
	HTAnswerSingleController *singleController = [[HTAnswerSingleController alloc] init];
	singleController.answerTagModel = model;
	UIViewController *controller = self.ht_controller;
	UINavigationController *navigationController = controller.navigationController;
	if (!navigationController) {
		navigationController = controller.view.superview.ht_controller.navigationController;
	}
	[navigationController pushViewController:singleController animated:true];
	[collectionView deselectItemAtIndexPath:indexPath animated:true];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.headImageButton.imageView.layer.cornerRadius = self.headImageButton.imageView.bounds.size.width / 2;
}

- (UIButton *)headImageButton {
	if (!_headImageButton) {
		_headImageButton = [[UIButton alloc] init];
		_headImageButton.titleLabel.font = [UIFont systemFontOfSize:13];
		[_headImageButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		[_headImageButton setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
		[_headImageButton setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _headImageButton;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:14];
        _nicknameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
    }
    return _nicknameLabel;
}


- (UILabel *)sendTimeLabel {
	if (!_sendTimeLabel) {
		_sendTimeLabel = [[UILabel alloc] init];
		_sendTimeLabel.font = [UIFont systemFontOfSize:12];
		_sendTimeLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
	}
	return _sendTimeLabel;
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
    }
    return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailNameLabel;
}

- (UICollectionView *)tagCollectionView {
	if (!_tagCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumLineSpacing = 5;
		flowLayout.minimumInteritemSpacing = 5;
		flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		_tagCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_tagCollectionView.scrollEnabled = false;
		_tagCollectionView.delegate = self;
		_tagCollectionView.dataSource = self;
		[_tagCollectionView registerClass:[HTSchoolFilterSelectedCollectionCell class] forCellWithReuseIdentifier:kHTAnswerTagCollectionCellIdentifier];
		_tagCollectionView.backgroundColor = [UIColor clearColor];
	}
	return _tagCollectionView;
}


- (UIButton *)attentionCountButton {
	if (!_attentionCountButton) {
		_attentionCountButton = [[UIButton alloc] init];
		_attentionCountButton.titleLabel.font = [UIFont systemFontOfSize:13];
		[_attentionCountButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		
		UIImage *normalImage = [UIImage imageNamed:@"cn_answer_hot"];
		normalImage = [normalImage ht_resetSizeWithStandard:17 isMinStandard:false];
		UIColor *tintColor = [UIColor ht_colorString:@"8a8a8a"];
		normalImage = [normalImage ht_tintColor:tintColor];
		normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		
		[_attentionCountButton setImage:normalImage forState:UIControlStateNormal];
		
		[_attentionCountButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:3];
		[_attentionCountButton setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
		[_attentionCountButton setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _attentionCountButton;
}

- (UIButton *)replyCountButton {
	if (!_replyCountButton) {
		_replyCountButton = [[UIButton alloc] init];
		_replyCountButton.titleLabel.font = [UIFont systemFontOfSize:13];
		[_replyCountButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		
		UIImage *normalimage = [UIImage imageNamed:@"cn2_index_answer_reply"];
		normalimage = [normalimage ht_resetSizeWithStandard:14 isMinStandard:false];
        UIColor *tintColor = [UIColor ht_colorString:@"8a8a8a"];
        normalimage = [normalimage ht_tintColor:tintColor];
		normalimage = [normalimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		
		[_replyCountButton setImage:normalimage forState:UIControlStateNormal];
		[_replyCountButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
	}
	return _replyCountButton;
}

@end
