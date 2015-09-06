//
//  LWMaskAlertView.h
//  Mobile110
//
//  Copyright (c) 2014年 lvwan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LWCancelButtonIndex   0

@class LWMaskAlertView;
@class TTTAttributedLabel;

@protocol LWMaskAlertViewDelegate <NSObject>

@optional

-(void)maskAlertView:(LWMaskAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

-(void)maskAlertViewCancel:(LWMaskAlertView *)alertView;

@end


@interface LWMaskAlertView : UIView

@property(nonatomic, strong) id context;

-(id)initWithTitle:(NSString *)title imageString:(NSString *)imageString message:(NSString *)message delegate:(id/*<LWMaskAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(id)initWithTitleLabel:(UILabel *)titleLabel imageString:(NSString *)imageString message:(NSString *)message delegate:(id/*<LWMaskAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,weak)id<LWMaskAlertViewDelegate> delegate;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initHighLevelWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
           cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title imageString:(NSString *)imageString messageLabel:(TTTAttributedLabel *)messageLabel delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(void)updateTitleLabel:(NSString *)titleString;

+ (void)showWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;

-(void)updateContentLabel:(NSString *)contentString;

-(void)show;

-(void)reShow;

-(void)hideWindow;

-(void)hide;

- (void)dismiss;
@end

