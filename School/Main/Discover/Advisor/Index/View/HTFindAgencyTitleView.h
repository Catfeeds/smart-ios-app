//
//  HTFindAgencyTitleView.h
//  School
//
//  Created by Charles Cao on 2017/12/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTFindAgencyTitleViewDelegate <NSObject>

- (void)clickAction:(UIButton *)button;

@end

@interface HTFindAgencyTitleView : UIView

@property (nonatomic, assign) id<HTFindAgencyTitleViewDelegate> delegate;

@property (nonatomic, strong) UIButton *currentSelectButton;

@property (weak, nonatomic) IBOutlet UIButton *leftItem;
@property (weak, nonatomic) IBOutlet UIButton *rightItem;

- (void)setSelectIndex:(NSInteger)index;

@end
