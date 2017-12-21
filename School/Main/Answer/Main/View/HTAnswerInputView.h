//
//  HTAnswerInputView.h
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTAnswerInputView : UIView <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightLayoutConstraint;

@end
