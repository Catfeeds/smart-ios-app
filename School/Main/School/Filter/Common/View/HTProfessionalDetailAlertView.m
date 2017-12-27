//
//  HTProfessionalDetailAlertView.m
//  School
//
//  Created by Charles Cao on 2017/12/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalDetailAlertView.h"
#import "HTUserActionManager.h"
#import "HTWebController.h"
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreModel.h"
#import "HTUserStoreManager.h"

@implementation HTProfessionalDetailAlertView

- (void)awakeFromNib{
	[super awakeFromNib];
	self.detailButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStylePrimaryTheme].CGColor;
}
- (IBAction)tapBackground:(UITapGestureRecognizer *)sender {
	self.alertViewBottomLayoutConstraint.constant = -144;
	[UIView animateWithDuration:0.2 animations:^{
		[self layoutIfNeeded];
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}] ;
	
}

- (IBAction)collectionAction:(UIButton *)sender {
	
	HTProfessionalDetailModel *detailModel = self.professionalModel.data.firstObject;
	HTUserStoreModel *model = [HTUserStoreModel packStoreModelType:HTUserStoreTypeProfessional lookId:detailModel.ID titleName:detailModel.name];
	[HTUserStoreManager switchStoreStateWithModel:model];
	sender.selected = [HTUserStoreManager isStoredWithModel:model];
}

- (IBAction)oddsTestAction:(UIButton *)sender{
	[self.delegate oddsTestAction:self.professionalModel];
}
- (IBAction)detailAction:(id)sender {
	[self.delegate detailAction:self.professionalModel];
}

- (void)didMoveToSuperview{
	self.alertViewBottomLayoutConstraint.constant = 0;
	[UIView animateWithDuration:0.2 animations:^{
		[self layoutIfNeeded];
	}];
}

- (void)setProfessionalModel:(HTProfessionalModel *)professionalModel{
	_professionalModel = professionalModel;
	HTProfessionalDetailModel *detailModel = professionalModel.data.firstObject;
	self.professionalTitleLabel.text = detailModel.name;
	self.professionalEnglishNameLabel.text = detailModel.title;
	[self setHistory:professionalModel];
}

- (void)setHistory:(HTProfessionalModel *) professionalModel {
	
	HTProfessionalDetailModel *detailModel = professionalModel.data.firstObject;
	NSString *professionalIdString =  HTPlaceholderString(detailModel.ID, @"");
	[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitProfessionalDetail keyValue:@{@"id":professionalModel}];
	[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeProfessionalDetail lookId:professionalIdString titleName:detailModel.name]];
	HTUserStoreModel *model = [HTUserStoreModel packStoreModelType:HTUserStoreTypeProfessional lookId:detailModel.ID titleName:detailModel.name];
	self.collectionButton.selected = [HTUserStoreManager isStoredWithModel:model];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
