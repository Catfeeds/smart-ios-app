//
//  HTSchoolMatriculatePickerView.m
//  School
//
//  Created by hublot on 2017/6/23.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculatePickerView.h"

@interface HTSchoolMatriculatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIToolbar *toolButtonBar;

@property (nonatomic, strong) NSArray <NSArray *> *modelArray;

@property (nonatomic, strong) NSArray <NSNumber *> *selectedRowArray;

@property (nonatomic, copy) void(^didSelectedBlock)(NSArray <NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray <NSNumber *> *selectedRowArray);

@end


@implementation HTSchoolMatriculatePickerView

- (void)dealloc {
	
}

+ (void)showModelArray:(NSArray <NSArray *> *)modelArray selectedRowArray:(NSArray <NSNumber *> *)selectedRowArray didSelectedBlock:(void(^)(NSArray <NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray <NSNumber *> *selectedRowArray))didSelectedBlock {
	HTSchoolMatriculatePickerView *pickerView = [[HTSchoolMatriculatePickerView alloc] init];
	pickerView.modelArray = modelArray;
	NSMutableArray *defaultSelectedRowArray = [selectedRowArray mutableCopy];
	if (!defaultSelectedRowArray.count) {
		for (NSInteger index = 0; index < modelArray.count; index ++) {
			[defaultSelectedRowArray addObject:@(0)];
		}
	}
	pickerView.selectedRowArray = defaultSelectedRowArray;
	pickerView.didSelectedBlock = didSelectedBlock;
	[[UIApplication sharedApplication].keyWindow addSubview:pickerView.backgroundView];
	[pickerView.backgroundView addSubview:pickerView];
	[pickerView.backgroundView addSubview:pickerView.toolButtonBar];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	self.delegate = self;
	self.dataSource = self;
	self.backgroundColor = [UIColor whiteColor];
	[self setAnimationWillShow:!newSuperview];
	[UIView animateWithDuration:0.25 animations:^{
		[self setAnimationWillShow:newSuperview];
	} completion:^(BOOL finished) {
		if (!newSuperview) {
			[self removeFromSuperview];
			[self.backgroundView removeFromSuperview];
			[self.toolButtonBar removeFromSuperview];
		} else {
			
		}
	}];
	[self selectedDefaultRow];
}

- (void)setAnimationWillShow:(BOOL)willShow {
	CGFloat height = 300;
	if (willShow) {
		self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, HTSCREENWIDTH, height);
		self.toolButtonBar.ht_y = self.ht_y - self.toolButtonBar.ht_h;
		self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
	} else {
		self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, HTSCREENWIDTH, height);
		self.toolButtonBar.ht_y = self.ht_y - self.toolButtonBar.ht_h;
		self.backgroundView.backgroundColor = [UIColor clearColor];
	}
}

- (void)selectedDefaultRow {
	NSInteger componentsCount = self.numberOfComponents;
	for (NSInteger component = 0; component < componentsCount; component ++) {
		NSInteger rowCount = [self numberOfRowsInComponent:component];
		NSInteger selectedRow = [self.selectedRowArray[component] integerValue];
		if (selectedRow < rowCount) {
			[self selectRow:selectedRow inComponent:component animated:false];
		}
	}
}

- (void)removePickerViewWithSaveSelected:(BOOL)saveSelected {
	if (saveSelected && self.didSelectedBlock) {
		NSMutableArray *selectedRowArray = [@[] mutableCopy];
		NSMutableArray *selectedModelArray = [@[] mutableCopy];
		NSInteger componentsCount = self.numberOfComponents;
		for (NSInteger component = 0; component < componentsCount; component ++) {
			NSInteger selectedRow = [self selectedRowInComponent:component];
			[selectedRowArray addObject:@(selectedRow)];
			
			NSArray *rowModelArray = self.modelArray[component];
			NSObject *model = rowModelArray[selectedRow];
			[selectedModelArray addObject:model];
		}
		self.didSelectedBlock(self.modelArray, selectedModelArray, selectedRowArray);
	}
	[self willMoveToSuperview:nil];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	// MARK
	// ...
	component = MAX(0, component);
	NSArray *rowModelArray = self.modelArray[component];
	return rowModelArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return self.modelArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSArray *rowModelArray = self.modelArray[component];
	NSObject *model = rowModelArray[row];
	return model.description;
}

- (UIView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		
	//	__weak typeof(self) weakSelf = self;
//        [_backgroundView ht_whenTap:^(UIView *view) {
//        //    [weakSelf removePickerViewWithSaveSelected:true];
//        }];
	}
	return _backgroundView;
}

- (UIToolbar *)toolButtonBar {
	if (!_toolButtonBar) {
		_toolButtonBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 44)];
		_toolButtonBar.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
		UIImage *image = [[UIImage alloc] init];
		[_toolButtonBar setShadowImage:image forToolbarPosition:UIBarPositionAny];
		
        __weak typeof(self) weakSelf = self;
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"     取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
            [weakSelf removePickerViewWithSaveSelected:false];
        }];
        
		UIBarButtonItem *centerBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace handler:^(id sender) {
			
		}];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"完成     " style:UIBarButtonItemStylePlain handler:^(id sender) {
            [weakSelf removePickerViewWithSaveSelected:true];
        }];
        
		_toolButtonBar.items = @[leftBarButtonItem, centerBarButtonItem, rightBarButtonItem];
	}
	return _toolButtonBar;
}

@end
