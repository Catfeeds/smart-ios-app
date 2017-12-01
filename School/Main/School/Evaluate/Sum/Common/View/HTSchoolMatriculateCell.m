//
//  HTSchoolMatriculateCell.m
//  School
//
//  Created by hublot on 2017/7/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateCell.h"
#import "HTSchoolMatriculateModel.h"
#import <IQKeyboardManager.h>
#import <NSObject+HTTableRowHeight.h>
#import <HTPlaceholderTextView.h>
#import "HTSchoolMatriculateSelectedManager.h"

@interface HTSchoolMatriculateCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UITextField *detailTextField;

@property (nonatomic, strong) HTPlaceholderTextView *detailTextView;

@property (nonatomic, strong) UIButton *detailNameButton;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@end

@implementation HTSchoolMatriculateCell

- (void)didMoveToSuperview {
	
}

- (void)setModel:(HTSchoolMatriculateModel *)model row:(NSInteger)row {
	__weak typeof(self) weakSelf = self;
	switch (model.inputType) {
		case HTSchoolMatriculateInputTypeTextFieldHorizontal: {
			self.titleNameLabel.hidden = self.detailTextField.hidden = false;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = true;
			self.detailTextView.hidden = true;
			break;
		}
		case HTSchoolMatriculateInputTypeTextFieldVertical: {
			self.titleNameLabel.hidden = self.detailTextField.hidden = false;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = true;
			self.detailTextView.hidden = true;
			break;
		}
		case HTSchoolMatriculateInputTypeSearchSelected:
		case HTSchoolMatriculateInputTypeSingleSelectedVertical:
		case HTSchoolMatriculateInputTypeMutableSelectedVertical:
		case HTSchoolMatriculateInputTypePickerViewVertical: {
			self.titleNameLabel.hidden = false;
			self.detailTextField.hidden = true;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = false;
			self.detailTextView.hidden = true;
			break;
		}
		case HTSchoolMatriculateInputTypePickerViewTextViewVertical:
			self.titleNameLabel.hidden = false;
			self.detailTextField.hidden = true;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = false;
			self.detailTextView.hidden = false;
			break;
		case HTSchoolMatriculateInputTypeTextFieldHorizontalPickerViewVertical: {
			self.titleNameLabel.hidden = false;
			self.detailTextField.hidden = false;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = false;
			self.detailTextView.hidden = true;
			break;
		}
		case HTSchoolMatriculateInputTypeTextViewVertical: {
			self.titleNameLabel.hidden = false;
			self.detailTextField.hidden = true;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = true;
			self.detailTextView.hidden = false;
			break;
		}
	}
	if (!self.titleNameLabel.hidden) {
		NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
										   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]};
		NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
											 NSForegroundColorAttributeName:[UIColor redColor]};
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.titleNameText attributes:normalDictionary] mutableCopy];
		if (!model.optionValue) {
			NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:@" *" attributes:selectedDictionary];
			[attributedString appendAttributedString:appendAttributedString];
		}
		self.titleNameLabel.attributedText = attributedString;
	}
	if (!self.detailTextView.hidden) {
		NSString *placeholderTempString = @"temp";
		self.detailTextField.placeholder = placeholderTempString;
		NSMutableAttributedString *placeholderAttributedString = [self.detailTextField.attributedPlaceholder mutableCopy];
		NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
		[placeholderAttributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, placeholderAttributedString.length)];
		
		self.detailTextField.placeholder = nil;
		[placeholderAttributedString replaceCharactersInRange:NSMakeRange(0, placeholderTempString.length) withString:model.placeHolderText];
		self.detailTextView.ht_attributedPlaceholder = placeholderAttributedString;
		self.detailTextView.attributedText = [[NSAttributedString alloc] initWithString:HTPlaceholderString(model.currentInputText, @"") attributes:@{
																																					  NSFontAttributeName:self.detailTextField.font,
																																					  NSForegroundColorAttributeName:self.detailTextField.textColor}];
		[self.detailTextView bk_addObserverForKeyPath:NSStringFromSelector(@selector(ht_currentText)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			model.currentInputText = weakSelf.detailTextView.ht_currentText;
		}];
		self.detailTextView.keyboardType = model.keyboardType;
	}
	if (!self.detailTextField.hidden) {
		self.detailTextField.placeholder = model.placeHolderText;
		self.detailTextField.text = model.currentInputText;
		
		[self.detailTextField bk_removeEventHandlersForControlEvents:UIControlEventEditingChanged];
		[self.detailTextField bk_addEventHandler:^(id sender) {
			model.currentInputText = weakSelf.detailTextField.text;
		} forControlEvents:UIControlEventEditingChanged];
		self.detailTextField.keyboardType = model.keyboardType;
	}
	if (!self.detailNameButton.hidden) {
	
		[self reloadTitleNameButtonWithModel:model];
		[self.detailNameButton ht_whenTap:^(UIView *view) {
			[[IQKeyboardManager sharedManager] resignFirstResponder];

			[HTSchoolMatriculateSelectedManager pushSelectedManagerFromController:weakSelf.ht_controller matriculateModel:model completeSelectedBlock:^{
				[weakSelf reloadTitleNameButtonWithModel:model];
			}];
			
		}];
	
		
	}
	CGFloat modelHeight = [self reloadLayoutHeightWithModel:model];
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (CGFloat)reloadLayoutHeightWithModel:(HTSchoolMatriculateModel *)model {
	
	CGFloat modelHeight = 0;
	
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailTextField];
	[self addSubview:self.detailTextView];
	[self addSubview:self.detailNameButton];
	[self addSubview:self.accessoryImageView];
	
	switch (model.inputType) {
		case HTSchoolMatriculateInputTypeTextFieldHorizontal: {
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.top.bottom.mas_equalTo(self);
				make.width.mas_equalTo(100);
			}];
			[self.detailTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.titleNameLabel.mas_right).offset(0);
				make.right.mas_equalTo(- 15);
				make.top.bottom.mas_equalTo(self);
			}];
			modelHeight = 55;
			break;
		}
		case HTSchoolMatriculateInputTypeTextFieldVertical: {
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.right.mas_equalTo(- 15);
				make.top.mas_equalTo(15);
			}];
			[self.detailTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(self.titleNameLabel);
				make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(10);
				make.height.mas_equalTo(40);
			}];
			modelHeight = 85;
			break;
		}
		case HTSchoolMatriculateInputTypeSearchSelected:
		case HTSchoolMatriculateInputTypeSingleSelectedVertical:
		case HTSchoolMatriculateInputTypeMutableSelectedVertical:
		case HTSchoolMatriculateInputTypePickerViewVertical: {
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.right.mas_equalTo(- 15);
				make.top.mas_equalTo(10);
			}];
			[self.detailNameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(self.titleNameLabel);
				make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
				make.height.mas_equalTo(40);
			}];
			[self.accessoryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.detailNameButton).offset(- 10);
				make.centerY.mas_equalTo(self.detailNameButton);
			}];
			modelHeight = 100;
			break;
		}
		case HTSchoolMatriculateInputTypePickerViewTextViewVertical: {
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.right.mas_equalTo(- 15);
				make.top.mas_equalTo(15);
			}];
			[self.detailNameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(self.titleNameLabel);
				make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
				make.height.mas_equalTo(40);
			}];
			[self.accessoryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.detailNameButton).offset(- 10);
				make.centerY.mas_equalTo(self.detailNameButton);
			}];
			[self.detailTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.titleNameLabel).offset(- 4);
				make.right.mas_equalTo(self.titleNameLabel).offset(4);
				make.top.mas_equalTo(self.detailNameButton.mas_bottom).offset(10);
				make.bottom.mas_equalTo(self).offset(- 15);
			}];
			modelHeight = 245;
			break;
		}
		case HTSchoolMatriculateInputTypeTextFieldHorizontalPickerViewVertical: {
			[self.detailNameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.titleNameLabel);
				make.right.mas_equalTo(self.detailTextField);
				make.top.mas_equalTo(self).offset(10);
				make.height.mas_equalTo(40);
			}];
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.top.mas_equalTo(self.detailNameButton.mas_bottom).offset(10);
				make.width.mas_equalTo(80);
				make.height.mas_equalTo(42);
			}];
			[self.detailTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.titleNameLabel.mas_right).offset(0);
				make.right.mas_equalTo(self).offset(- 15);
				make.top.mas_equalTo(self.titleNameLabel);
				make.height.mas_equalTo(self.titleNameLabel);
			}];
			[self.accessoryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.detailNameButton).offset(- 10);
				make.centerY.mas_equalTo(self.detailNameButton);
			}];
			modelHeight = 110;
			break;
		}
		case HTSchoolMatriculateInputTypeTextViewVertical: {
			[self.titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.right.mas_equalTo(- 15);
				make.top.mas_equalTo(15);
			}];
			[self.detailTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.titleNameLabel).offset(- 4);
				make.right.mas_equalTo(self.titleNameLabel).offset(4);
				make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(10);
				make.bottom.mas_equalTo(self).offset(- 15);
			}];
			modelHeight = 200;
			break;
		}
	}
	return modelHeight;
}

- (void)reloadTitleNameButtonWithModel:(HTSchoolMatriculateModel *)model {
	NSMutableArray *selectedModelTitleArray = [@[] mutableCopy];
	HTSchoolMatriculateSelectedModel *selectedModel = model;
	while (selectedModel.pickerSelectedIndex < selectedModel.pickerModelArray.count && selectedModel.pickerSelectedIndex >= 0) {
		selectedModel = selectedModel.pickerModelArray[selectedModel.pickerSelectedIndex];
		[selectedModelTitleArray addObject:HTPlaceholderString(selectedModel.name, @"")];
	}
	NSString *selectedTitleString = [selectedModelTitleArray componentsJoinedByString:@" - "];
	[self.detailNameButton setTitle:selectedTitleString forState:UIControlStateNormal];
}

- (UITextField *)detailTextField {
	if (!_detailTextField) {
		_detailTextField = [[UITextField alloc] init];
		_detailTextField.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailTextField.font = [UIFont systemFontOfSize:15];
	}
	return _detailTextField;
}

- (HTPlaceholderTextView *)detailTextView {
	if (!_detailTextView) {
		_detailTextView = [[HTPlaceholderTextView alloc] init];
		_detailTextView.textContainerInset = UIEdgeInsetsZero;
		_detailTextView.textColor = self.detailTextField.textColor;
		_detailTextView.font = self.detailTextField.font;
	}
	return _detailTextView;
}


- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
	}
	return _titleNameLabel;
}

- (UIButton *)detailNameButton {
	if (!_detailNameButton) {
		_detailNameButton = [[UIButton alloc] init];
		[_detailNameButton setTitleColor:[UIColor ht_colorString:@"666666"] forState:UIControlStateNormal];
		_detailNameButton.titleLabel.font = [UIFont systemFontOfSize:15];
		_detailNameButton.layer.cornerRadius = 2;
		_detailNameButton.layer.masksToBounds = true;
		_detailNameButton.backgroundColor = [UIColor ht_colorString:@"f6f6f6"];
		_detailNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		_detailNameButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate].CGColor;
		_detailNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		_detailNameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
	}
	return _detailNameButton;
}

- (UIImageView *)accessoryImageView {
	if (!_accessoryImageView) {
		_accessoryImageView = [[UIImageView alloc] init];
//		UIImage *image = [UIImage imageNamed:@"cn2_school_professional_section_header_triangle"];
//		image = [image ht_resetSizeWithStandard:10 isMinStandard:false];
//		_accessoryImageView.image = image;
//		_accessoryImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
		_accessoryImageView.image = [UIImage imageNamed:@"sjx"];
	}
	return _accessoryImageView;
}

- (void)setFrame:(CGRect)frame {
	frame.origin.y += self.cellEdgeInsets.top;
	frame.size.height -= self.cellEdgeInsets.top;
	frame.origin.x += self.cellEdgeInsets.left;
	frame.size.width -= self.cellEdgeInsets.left + self.cellEdgeInsets.right;
	[super setFrame:frame];
}

@end
