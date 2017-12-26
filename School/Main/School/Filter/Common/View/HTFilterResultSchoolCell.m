//
//  HTFilterResultSchoolCell.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFilterResultSchoolCell.h"
#import "HTFilterResultSchoolModel.h"
#import <NSObject+HTTableRowHeight.h>
#import "HTFilterResultProfessionalCell.h"
#import <UICollectionViewCell+HTSeparate.h>
#import "HTProfessionalController.h"
#import "HTProfessionDetailController.h"

@interface HTFilterResultSchoolCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *rankingLabel;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) HTFilterResultSchoolModel *model;

@property (nonatomic, strong) NSArray *modelSizeArray;

@end

static NSString *kHTFilterResultCollectionCellIdentifier = @"kHTFilterResultCollectionCellIdentifier";

@implementation HTFilterResultSchoolCell

+ (CGFloat)itemHeight {
	return 25;
}

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self addSubview:self.addressLabel];
	[self addSubview:self.rankingLabel];
	
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor redColor];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.width.height.mas_equalTo(75);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView.mas_top);
		make.right.mas_equalTo(- 15);
        
	}];
	
	
	[self.rankingLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(4);
        
	}];
	
	[self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.rankingLabel.mas_bottom).offset(4);
        
	}];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleNameLabel);
       // make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(4);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleNameLabel);
     //   make.bottom.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(4);
    }];
}

- (void)setModel:(HTFilterResultSchoolModel *)model row:(NSInteger)row {
	_model = model;
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.titleNameLabel.text = model.name;
	self.detailNameLabel.text = model.title;
	self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",model.place];
	self.rankingLabel.text = [NSString stringWithFormat:@"排名:%@",model.rank];
//	self.collectionView.ht_w = HTSCREENWIDTH - 30;
//
    
    CGFloat modelHeight = 0;
    modelHeight += 15;
    modelHeight += 75;
    modelHeight += 15;

    if (model.isSelectedMajor) {
        self.collectionView.hidden = NO;
        NSMutableArray *modelSizeArray = [@[] mutableCopy];
        [self.model.major enumerateObjectsUsingBlock:^(HTFilterResultProfessionalModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            CGSize itemSize = CGSizeZero;
            itemSize.height = 15;
            NSString *titleName = model.title;
            itemSize.width = [titleName boundingRectWithSize:CGSizeMake(MAXFLOAT, itemSize.height)
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
            itemSize.width += 10;
            [modelSizeArray addObject:[NSValue valueWithCGSize:itemSize]];
        }];
        self.modelSizeArray = modelSizeArray;
        [self.collectionView reloadData];
//        modelHeight += self.collectionView.collectionViewLayout.collectionViewContentSize.height + 4;
        modelHeight += 24;
    }else{
        self.collectionView.hidden = YES;
    }
//
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.major.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < self.modelSizeArray.count) {
		return [self.modelSizeArray[indexPath.row] CGSizeValue];
	}
	return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTFilterResultCollectionCellIdentifier forIndexPath:indexPath];
	if (indexPath.row < self.model.major.count) {
		id model = self.model.major[indexPath.row];
		[cell setModel:model row:indexPath.row];
	}
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < self.model.major.count) {
		HTFilterResultProfessionalModel *model = self.model.major[indexPath.row];
	//	HTProfessionalController *professionalController = [[HTProfessionalController alloc] init];
		HTProfessionDetailController *professionalController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTProfessionDetailController");
		professionalController.professionalId = model.ID;
		[self.ht_controller.navigationController pushViewController:professionalController animated:true];
	}
	[collectionView deselectItemAtIndexPath:indexPath animated:true];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	[self.collectionView ht_setBackgroundColor:highlighted ? self.selectedBackgroundView.backgroundColor : [UIColor whiteColor]];
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
//        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
		_headImageView.clipsToBounds = true;
	}
	return _headImageView;
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
		_detailNameLabel.font = [UIFont systemFontOfSize:15];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
	}
	return _detailNameLabel;
}

- (UILabel *)addressLabel{
	if (!_addressLabel) {
		_addressLabel = [[UILabel alloc] init];
		_addressLabel.font = [UIFont systemFontOfSize:12];
		_addressLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
	}
	return _addressLabel;
}

- (UILabel *)rankingLabel{
	if (!_rankingLabel) {
		_rankingLabel = [[UILabel alloc] init];
		_rankingLabel.font = [UIFont systemFontOfSize:12];
		_rankingLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
	}
	return _rankingLabel;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumLineSpacing = 0;
		flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        _collectionView.scrollEnabled = false;
        _collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[HTFilterResultProfessionalCell class] forCellWithReuseIdentifier:kHTFilterResultCollectionCellIdentifier];
	}
	return _collectionView;
}

@end
