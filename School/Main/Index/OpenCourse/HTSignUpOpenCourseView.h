//
//  HTSignUpOpenCourseView.h
//  School
//
//  Created by Charles Cao on 2017/12/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTSignUpOpenCourseViewDelegate <NSObject>

- (void)submit:(NSString *)name phone:(NSString *)phone;

@end

@interface HTSignUpOpenCourseView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) id<HTSignUpOpenCourseViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end
