//
//  HTAnswerInputView.h
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendTextBlock)(NSString *text);
@interface HTInputTextView : UITextView

@end

@interface HTAnswerInputView : UIView <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, copy) SendTextBlock sendTextBlock;
@property (nonatomic, copy) void(^resignFirstResponderBlock)(void);
@property (nonatomic, strong) NSString *placeholder;
@property (weak, nonatomic) IBOutlet HTInputTextView *inputTextView;

- (void)showInputViewWithPlaceholder:(NSString *)placeholder sendText:(SendTextBlock)completeBlock;



@end
