//
//  LWMaskAlertView.m
//  Mobile110
//
//  Copyright (c) 2014年 lvwan. All rights reserved.
//

#import "LWMaskAlertView.h"
#import "TTTAttributedLabel.h"
#import "NSAttributedString+LWAddition.h"

@interface LWMaskAlertButton ()

@property(nonatomic, strong) UIView *verticalLine;

@end


@interface LWMaskAlertView ()

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) TTTAttributedLabel *messageLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIView *horizonLineView;
@property(nonatomic, strong) LWMaskAlertButton *cancelButton;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSString *imageString;
@property(nonatomic, strong) NSString *cancelTitle;
@property(nonatomic, strong) NSArray *otherTitles;

@property(nonatomic, assign) BOOL isHighLevel;

@end


@implementation LWMaskAlertView {
}


- (id)initWithTitle:(NSString *)title imageString:(NSString *)imageString message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle _otherButtonTitles:(NSArray *)otherButtonTitles {
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _delegate = delegate;
        _cancelTitle = cancelButtonTitle;
        _otherTitles = otherButtonTitles;
        [self initViews];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title imageString:(NSString *)imageString message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {

    NSMutableArray *arrays = [NSMutableArray array];
    va_list argList;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        id arg;
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    return [self initWithTitle:title imageString:imageString message:message
                      delegate:delegate cancelButtonTitle:cancelButtonTitle _otherButtonTitles:arrays];

}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {

    NSMutableArray *arrays = [NSMutableArray array];
    va_list argList;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        id arg;
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    return [self initWithTitle:title imageString:nil message:message
                      delegate:delegate cancelButtonTitle:cancelButtonTitle _otherButtonTitles:arrays];
}


- (id)initWithTitleLabel:(UILabel *)titleLabel imageString:(NSString *)imageString message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {

    NSMutableArray *arrays = [NSMutableArray array];
    va_list argList;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        id arg;
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    self = [self initWithTitle:titleLabel.text imageString:imageString message:message
                      delegate:delegate cancelButtonTitle:cancelButtonTitle _otherButtonTitles:arrays];
    if (self) {
        _titleLabel = titleLabel;
        [self initViews];
    }

    return self;
}

- (id)initWithTitle:(NSString *)title imageString:(NSString *)imageString messageLabel:(TTTAttributedLabel *)messageLabel delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    NSMutableArray *arrays = [NSMutableArray array];
    va_list argList;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        id arg;
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    self = [self initWithTitle:title imageString:imageString message:messageLabel.text
                      delegate:delegate cancelButtonTitle:cancelButtonTitle _otherButtonTitles:arrays];
    if (self) {
        _messageLabel = messageLabel;
        [self initViews];
    }
    
    return self;
}

- (id)initHighLevelWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
           cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    NSMutableArray *arrays = [NSMutableArray array];
    va_list argList;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        id arg;
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    
    self.isHighLevel = YES;
    return [self initWithTitle:title imageString:nil message:message
                      delegate:delegate cancelButtonTitle:cancelButtonTitle _otherButtonTitles:arrays];
}

- (void)initViews {

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self.isHighLevel) {
        _window.windowLevel = UIWindowLevelAlert+1;
    }else{
        _window.windowLevel = UIWindowLevelAlert;
    }
    _window.backgroundColor = [UIColor colorWithHex:0xb3000000];

    UIControl *contentView = [[UIControl alloc] initWithFrame:_window.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    [contentView addTarget:self action:@selector(contentControlPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_window addSubview:contentView];
    contentView.exclusiveTouch = YES;
    [contentView setMultipleTouchEnabled:NO];

    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:0.92];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 5.0f;
    [contentView addSubview:_backgroundView];


    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor colorWithHex:0xff5c5c5e];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    [_backgroundView addSubview:_titleLabel];

    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    [_backgroundView addSubview:_imageView];

    if (!_messageLabel) {
        _messageLabel = [[TTTAttributedLabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor colorWithHex:0xff5c5c5e];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
        _messageLabel.numberOfLines = 0;
    }
    
    [_backgroundView addSubview:_messageLabel];

    _horizonLineView = [[UIView alloc] init];
    _horizonLineView.backgroundColor = [UIColor colorWithHex:0xffd4d4d4];
    [_backgroundView addSubview:_horizonLineView];

    _cancelButton = [[LWMaskAlertButton alloc] init];
    _cancelButton.backgroundColor = [UIColor clearColor];
    [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitleColor:[UIColor colorWithHex:0xff5897d5] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
    [_backgroundView addSubview:_cancelButton];
}

- (void)updateViews {

    CGFloat width = UIScreenWidth - _scale*20;
    CGFloat originY = 20;

    if (![NSString stringIsNullOrEmpty:self.imageString]) {
        UIImage *image = LW_IMAGE(self.imageString);
        [_imageView setImage:image];
        CGSize imageSize = image.size;
        _imageView.frame = CGRectMake((width - imageSize.width) / 2, originY, imageSize.width, imageSize.height);
        originY += imageSize.height;
        originY += 20;
    } else {
        _imageView.hidden = YES;
    }

    if (![NSString stringIsNullOrEmpty:self.title]) {
        _titleLabel.text = self.title;

        CGSize size = _titleLabel.frame.size;
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            size = CGSizeMake(width - 40, 17);
        }
        _titleLabel.frame = CGRectMake((width - size.width) / 2, originY, size.width, size.height);
        originY += size.height;
        originY += 20;
    }

    if (![NSString stringIsNullOrEmpty:self.message]) {
        if ([NSString stringIsNullOrEmpty:_messageLabel.text]) {
            _messageLabel.text = self.message;
        }
        
        CGSize size = [_messageLabel.attributedText sizeWithConstrainedToSize:CGSizeMake(width - 40, MAXFLOAT)];

        if (![NSString stringIsNullOrEmpty:self.title]) {
            originY -= 10;
        }
        _messageLabel.frame = CGRectMake(20, originY, width - 40, size.height);
        originY += size.height;
        originY += 20;
    }


    CGFloat lineHeight = 1 / [[UIScreen mainScreen] scale];
    _horizonLineView.frame = CGRectMake(0, originY, width, lineHeight);
    originY += lineHeight;

    int buttonCount = 1 + [_otherTitles count];
    CGFloat buttonWidth = width / buttonCount;

    _cancelButton.frame = CGRectMake(0, originY, buttonWidth, 50);
    _cancelButton.isVerticalLineHidden = buttonWidth > 1 ? NO : YES;

    if (_otherTitles && [_otherTitles count] > 0) {
        for (int i = 0; i < [_otherTitles count]; i++) {

            NSString *titleString = [_otherTitles safeObjectAtIndex:i];

            LWMaskAlertButton *button = [[LWMaskAlertButton alloc] initWithFrame:CGRectMake(buttonWidth + i * buttonWidth, originY, buttonWidth, 50)];
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:titleString forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHex:0xff5897d5] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            button.tag = 101 + i;
            [button addTarget:self action:@selector(otherButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundView addSubview:button];

        }
    }


    originY += 50;

    _backgroundView.frame = CGRectMake((UIScreenWidth - width)/2, (UIScreenHeight - originY) / 2, width, originY);
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    LWMaskAlertView *maskAlertView = [[LWMaskAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    [maskAlertView show];
}


- (void)show {

    [self updateViews];
    _window.hidden = NO;
    [[LWMaskAlertViewManager sharedInstance] addAlertView:self];
}

- (void)reShow {

    _window.hidden = NO;
}

- (void)hideWindow {
    _window.hidden = YES;
}

- (void)hide {
    _delegate = nil;
    _window.hidden = YES;
    [[LWMaskAlertViewManager sharedInstance] removeAlertView];
}

- (void)dismiss {
    [self hide];
}

- (void)updateTitleLabel:(NSString *)titleString {

    if (_titleLabel) {
        _titleLabel.text = titleString;
    }

}

- (void)updateContentLabel:(NSString *)contentString {

    if (_messageLabel) {
        _messageLabel.text = contentString;
    }
}

- (void)otherButtonClicked:(id)sender {
    UIButton *button = (UIButton *) sender;
    int index = button.tag - 100;

    [self callPressedButtonAtIndex:index];
    
    [self hide];

}

- (void)contentControlPressed:(id)sender {

//    [self callCancelled];
//    [self hide];
}

- (void)cancelButtonPressed:(id)sender {

    [self callCancelled];
    [self callPressedButtonAtIndex:0];
    [self hide];
    
}

- (void)callCancelled {
    if ([self.delegate respondsToSelector:@selector(maskAlertViewCancel:)]
            ) {
        [self.delegate maskAlertViewCancel:self];
    }
}

- (void)callPressedButtonAtIndex:(int)index {
    if ([self.delegate respondsToSelector:@selector(maskAlertView:clickedButtonAtIndex:)]) {
        [self.delegate maskAlertView:self clickedButtonAtIndex:index];
    }
}

- (void)dealloc {
    self.delegate = nil;
    self.context = nil;
}

@end
