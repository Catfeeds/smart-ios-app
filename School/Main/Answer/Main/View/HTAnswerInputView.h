//
//  HTAnswerInputView.h
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTInputTextView : UITextView

@end

@protocol HTInputTextViewDelegate <NSObject>

- (void)sendText:(NSString *)text;

@end


@interface HTAnswerInputView : UIView <UITextViewDelegate>

@property (nonatomic, assign) id<HTInputTextViewDelegate> delegate;
@property (nonatomic, strong) NSString *placeholder;
@property (weak, nonatomic) IBOutlet HTInputTextView *inputTextView;

- (void)showInputViewWithPlaceholder:(NSString *)placeholder;

@end
