//
//  CustomKeyBoardView.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/30.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "CustomKeyBoardView.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width

enum {
    NumberPadViewImageLeft = 0,
    NumberPadViewImageInner,
    NumberPadViewImageRight,
    NumberPadViewImageMax
};

@interface CustomKeyBoardView()<UIInputViewAudioFeedback>

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) NSDictionary      *charDic;

@property (nonatomic, strong) UITextField       *currentTextField;

@property (nonatomic, assign) BOOL              isNumberKeyBoard;

@end

@implementation CustomKeyBoardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.height = 200;
        self.width = kWidth;
        
        self.frame = CGRectMake(0, 0, self.width, self.height);
        self.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:self.inputAccessoryView];
        
        self.charDic = @{@"0":@"a",@"1":@"b",@"2":@"c",@"3":@"d",@"4":@"e",
                         @"5":@"f",@"6":@"g",@"7":@"h",@"8":@"i",@"9":@"j",
                         @"10":@"k",@"11":@"l",@"12":@"m",@"13":@"n",@"14":@"o",
                         @"15":@"p",@"16":@"q",@"17":@"r",@"18":@"s",@"19":@"t",
                         @"20":@"u",@"21":@"v",@"22":@"w",@"23":@"x",@"24":@"y",@"25":@"z"};
        
        [self configUIWithShowNumber:NO];
        
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUIWithShowNumber:(BOOL)showNumber{

    self.isNumberKeyBoard = showNumber;
    
    for (UIView *button in self.subviews) {
        
        if ([button isKindOfClass:[UIButton class]]) {
            
            [UIView animateWithDuration:0.2 animations:^{
                button.alpha = 0;
            }completion:^(BOOL finished) {
                [button removeFromSuperview];
            }];
        }
    }
    
    CGFloat originY = CGRectGetMaxY(self.inputAccessoryView.frame);
    
    if (showNumber) {
        
        NSMutableArray *numberArray = [[NSMutableArray alloc] init];
        while (numberArray.count < 10) {
            
            NSInteger number = arc4random() % 10;
            if (![numberArray containsObject:@(number)]) {
                
                [numberArray addObject:@(number)];
            }
        }
        
        CGFloat space = 5;
        CGFloat buttonWidth = (self.width - space * 4) / 3;
        CGFloat buttonHeight = (self.height - space * 5 - CGRectGetHeight(self.inputAccessoryView.frame))/4;
        
        NSInteger index = 0;
        for (NSInteger row = 0; row < 4; row ++) {
            
            
            for (NSInteger column = 0; column < 3; column ++) {
                
                NSString *title = nil;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(space * (column + 1) + buttonWidth *column, originY + space * (row + 1) + buttonHeight * row, buttonWidth, buttonHeight)];
                if (index == 9) {

                    title = @".";
                    button.userInteractionEnabled = NO;
                }else if(index == 11){

                    title = @"Del";
                    button.userInteractionEnabled = NO;
                }else if(index == 10){

                    title = [NSString stringWithFormat:@"%@",numberArray.lastObject];
                    button.userInteractionEnabled = NO;
                }else{

                    title = [NSString stringWithFormat:@"%@",numberArray[index]];
                    button.userInteractionEnabled = NO;
                }

                [button setTitle:title forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setBackgroundImage:[CustomKeyBoardView imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]]
                                            forState:UIControlStateHighlighted];
                button.backgroundColor = [UIColor darkGrayColor];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                button.layer.cornerRadius = 6;
                button.tag = 1000 + index;
//                [button addTarget:self action:@selector(keyBoardClickAction:) forControlEvents:UIControlEventTouchUpInside];
               
                [self addSubview:button];
                index ++;
            }
        }
        
    }else{
    
        NSMutableArray  *charArray = [[NSMutableArray alloc] init];
        while (charArray.count < 26) {
            
            NSInteger number = arc4random() % 26;
            if (![charArray containsObject:@(number)]) {
                
                [charArray addObject:@(number)];
            }
        }
        
        CGFloat space = 5;
        CGFloat buttonWidth = (self.width - space * 11) / 10;
        CGFloat buttonHeight = (self.height - space * 4 - CGRectGetHeight(self.inputAccessoryView.frame))/3;
        
        NSInteger index = 0;
        for (NSInteger row = 0; row < 3; row ++) {
            
            //10|9|7
            NSInteger maxColumn = row == 0? 10:(row == 1?9:7);
            CGFloat leftSpace = 0;
            if (row == 1) {
                
                leftSpace = (buttonWidth + space) / 2;//9按钮居中
            }
            if (row == 2) {
                
                leftSpace = (buttonWidth * 3 + space * 3) / 2;
            }
            for (NSInteger column = 0; column < maxColumn; column ++) {
                
                
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(leftSpace + space * (column + 1) + buttonWidth *column, originY + space * (row + 1) + buttonHeight * row, buttonWidth, buttonHeight)];
                NSString *title = nil;
                NSString *key = [NSString stringWithFormat:@"%@",charArray[index]];
                title = [NSString stringWithFormat:@"%@",[self.charDic valueForKey:key]];
                [button setTitle:title forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setBackgroundImage:[CustomKeyBoardView imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]]
                                  forState:UIControlStateHighlighted];
                button.backgroundColor = [UIColor darkGrayColor];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                button.layer.cornerRadius = 6;
                button.tag = 1000 + index;
                button.userInteractionEnabled = NO;
//                [button addTarget:self action:@selector(keyBoardClickAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                index ++;
                
                if (row == 2 && (column == 0 || column == 6)) {
                    
                    UIButton *otherButton = [[UIButton alloc] init];
                    
                    [otherButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [otherButton setBackgroundImage:[CustomKeyBoardView imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]]
                                           forState:UIControlStateHighlighted];
                    otherButton.backgroundColor = [UIColor darkGrayColor];
                    otherButton.titleLabel.font = [UIFont systemFontOfSize:18];
                    otherButton.layer.cornerRadius = 6;
                    otherButton.userInteractionEnabled = NO;
//                    [otherButton addTarget:self action:@selector(keyBoardClickAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:otherButton];
                    
                    if (column == 0) {
                        
                        otherButton.frame = CGRectMake(space, originY + space * (row + 1) + buttonHeight * row, CGRectGetMinX(button.frame) - space * 2, buttonHeight);
                        otherButton.tag = 1000 + 26 + 1;
                        [otherButton setTitle:@"Caps" forState:UIControlStateNormal];
                        otherButton.userInteractionEnabled = NO;
                    }else{
                        
                        otherButton.frame = CGRectMake(CGRectGetMaxX(button.frame) + space, originY + space * (row + 1) + buttonHeight * row, self.width - CGRectGetMaxX(button.frame) - space * 2, buttonHeight);
                        otherButton.tag = 1000 + 26 + 2;
                        [otherButton setTitle:@"Del" forState:UIControlStateNormal];
                        otherButton.userInteractionEnabled = NO;
                    }
                    
                }
                
            }
        }
    }
}

#pragma mark - Events

- (void)addPopupToButton:(UIButton *)b {
    
    UIImageView *keyPop;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 52, 60)];
    
    CGFloat originX = b.frame.origin.x;
    
    
    if (self.isNumberKeyBoard) {
        
        keyPop = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[self createKeytopImageWithKind:NumberPadViewImageInner] scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown]];
        keyPop.frame = CGRectMake((b.frame.size.width - keyPop.frame.size.width ) / 2, -80 , keyPop.frame.size.width, keyPop.frame.size.height);
        
    }else{
    
        if (b.frame.origin.x < 30.0) {
            
            keyPop = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[self createKeytopImageWithKind:NumberPadViewImageRight] scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown]];
            keyPop.frame = CGRectMake(-16, -68, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        if (b.frame.origin.x > 30.0 && CGRectGetMaxX(b.frame) < (kWidth - 30)) {
            
            keyPop = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[self createKeytopImageWithKind:NumberPadViewImageInner] scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown]];
            keyPop.frame = CGRectMake((b.frame.size.width - keyPop.frame.size.width ) / 2, -68, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        
        if (CGRectGetMaxX(b.frame) > (kWidth - 30)) {
            
            keyPop = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[self createKeytopImageWithKind:NumberPadViewImageLeft] scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown]];
            keyPop.frame = CGRectMake(-38, -68, keyPop.frame.size.width, keyPop.frame.size.height);
        }
    }
    
    
    [text setFont:[UIFont systemFontOfSize:44]];
    
    text.textAlignment = NSTextAlignmentCenter;
    [text setBackgroundColor:[UIColor clearColor]];
    [text setShadowColor:[UIColor whiteColor]];
    [text setText:b.titleLabel.text];
    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 3.0);
    keyPop.layer.shadowOpacity = 1;
    keyPop.layer.shadowRadius = 5.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];
    if ([b.titleLabel.text isEqualToString:@"Caps"] ||
        [b.titleLabel.text isEqualToString:@"Del"] ||
        [b.titleLabel.text isEqualToString:@"."]) {
        
//        [b setBackgroundImage:[CustomKeyBoardView imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]] forState:UIControlStateNormal];
        keyPop.hidden = YES;
    }
    
}

//在键盘上滑动
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in self.subviews) {
        
        if ([b isKindOfClass:[UIButton class]]) {
            
            if ([b subviews].count > 1) {
                [[[b subviews] objectAtIndex:1] removeFromSuperview];
            }
        }

        if(CGRectContainsPoint(b.frame, location))
        {
            [self addPopupToButton:b];
            [[UIDevice currentDevice] playInputClick];
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            
            if ([b subviews].count > 1) {
                [[[b subviews] objectAtIndex:1] removeFromSuperview];
            }
        }
        if(CGRectContainsPoint(b.frame, location))
        {
            [self addPopupToButton:b];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            
            if ([b subviews].count > 1) {
                [[[b subviews] objectAtIndex:1] removeFromSuperview];
            }
        }
        if(CGRectContainsPoint(b.frame, location))
        {
            [self keyBoardClickAction:b];
        }
    }
}

//切换字母|数字键盘
- (void)exchangeAction:(UIButton *)sender{
    
    [[UIDevice currentDevice] playInputClick];//键盘音效
    self.currentTextField = (UITextField *)self.nextResponder;
    sender.selected = !sender.selected;
    self.isNumberKeyBoard = sender.selected;
    [self configUIWithShowNumber:sender.selected];
}

//完成
- (void)doneAction:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];//键盘音效
    [self.currentTextField resignFirstResponder];
}

//按钮键盘点击事件
- (void)keyBoardClickAction:(UIButton *)sender{

    [[UIDevice currentDevice] playInputClick];//键盘音效
    if ([sender.titleLabel.text isEqualToString:@"." ]||
        [sender.titleLabel.text isEqualToString:@"Del" ]) {
        
        if ([sender.titleLabel.text isEqualToString:@"Del"] && self.currentTextField.text.length > 0) {
            
            self.currentTextField.text = [self.currentTextField.text substringToIndex:self.currentTextField.text.length - 1];
        }
    }else if([sender.titleLabel.text isEqualToString:@"Caps" ]){
    
        //大小写切换
        sender.selected = !sender.selected;
        
        for (UIView *button in self.subviews) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                if (button.tag != 1000 + 26 + 1 &&
                    button.tag != 1000 + 26 + 2) {
                    
                    NSString *title = ((UIButton *)button).titleLabel.text;
                    if (sender.selected) {//大写
                        
                        title = [title uppercaseString];
                    }else{
                        //小写
                        title = [title lowercaseString];
                    }
                    [(UIButton *)button setTitle:title forState:UIControlStateNormal];
                }
            }
        }
    }else{
    
        self.currentTextField.text = [NSString stringWithFormat:@"%@%@",self.currentTextField.text,sender.titleLabel.text];
    }
    NSLog(@"键盘:%@",sender.titleLabel.text);
}

#pragma mark - UIInputViewAudioFeedback
//键盘音效
- (BOOL)enableInputClicksWhenVisible
{
    return YES;
}

#pragma mark - Setter/Getter
-(UIView *)inputAccessoryView{

    if (_inputAccessoryView == nil) {
        
        _inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
        _inputAccessoryView.backgroundColor = [UIColor greenColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, kWidth - 160, 40)];
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.text = @"京县支付安全键盘";
        titleLabel.tag = 100;
        [_inputAccessoryView addSubview:titleLabel];
        
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [rightButton setTitle:@"Abc" forState:UIControlStateNormal];
        [rightButton setTitle:@"123" forState:UIControlStateSelected];
        [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputAccessoryView addSubview:rightButton];
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 80, 0, 80, 40)];
        [leftButton setTitle:@"完成" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputAccessoryView addSubview:leftButton];
    }
    return _inputAccessoryView;
}

- (void)setTitle:(NSString *)title{

    if (title) {
        
        UILabel *titleLabel = [_inputAccessoryView viewWithTag:100];
        titleLabel.text = title;
    }
}

-(UITextField *)currentTextField{

    if (_currentTextField == nil) {
        
        if (self.nextResponder) {
            
            _currentTextField = (UITextField *)self.nextResponder;
        }else{
        
            _currentTextField = [[UITextField alloc] init];
        }
        
    }
    return _currentTextField;
}

- (void)drawRect:(CGRect)rect {
    
}


+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#define _UPPER_WIDTH   (52.0 * [[UIScreen mainScreen] scale])
#define _LOWER_WIDTH   (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])
#define _PAN_LOWER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPDER_WIDTH   (_UPPER_WIDTH-_PAN_UPPER_RADIUS*2)
#define _PAN_UPPER_HEIGHT    (61.0 * [[UIScreen mainScreen] scale])

#define _PAN_LOWER_WIDTH     (_LOWER_WIDTH-_PAN_LOWER_RADIUS*2)
#define _PAN_LOWER_HEIGHT    (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UL_WIDTH        ((_UPPER_WIDTH-_LOWER_WIDTH)/2)

#define _PAN_MIDDLE_HEIGHT    (11.0 * [[UIScreen mainScreen] scale])

#define _PAN_CURVE_SIZE      (7.0 * [[UIScreen mainScreen] scale])

#define _PADDING_X     (15 * [[UIScreen mainScreen] scale])
#define _PADDING_Y     (10 * [[UIScreen mainScreen] scale])
#define _WIDTH   (_UPPER_WIDTH + _PADDING_X*2)
#define _HEIGHT   (_PAN_UPPER_HEIGHT + _PAN_MIDDLE_HEIGHT + _PAN_LOWER_HEIGHT + _PADDING_Y*2)


#define _OFFSET_X    -25 * [[UIScreen mainScreen] scale])
#define _OFFSET_Y    59 * [[UIScreen mainScreen] scale])


- (CGImageRef)createKeytopImageWithKind:(int)kind
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p = CGPointMake(_PADDING_X, _PADDING_Y);
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    
    p.x += _PAN_UPPER_RADIUS;
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    p.x += _PAN_UPPDER_WIDTH;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y += _PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_UPPER_RADIUS,
                 3.0*M_PI/2.0,
                 4.0*M_PI/2.0,
                 false);
    
    p.x += _PAN_UPPER_RADIUS;
    p.y += _PAN_UPPER_HEIGHT - _PAN_UPPER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y + _PAN_CURVE_SIZE);
    switch (kind) {
        case NumberPadViewImageLeft:
            p.x -= _PAN_UL_WIDTH*2;
            break;
            
        case NumberPadViewImageInner:
            p.x -= _PAN_UL_WIDTH;
            break;
            
        case NumberPadViewImageRight:
            break;
    }
    
    p.y += _PAN_MIDDLE_HEIGHT + _PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y - _PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y += _PAN_LOWER_HEIGHT - _PAN_CURVE_SIZE - _PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x -= _PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_LOWER_RADIUS,
                 4.0*M_PI/2.0,
                 1.0*M_PI/2.0,
                 false);
    
    p.x -= _PAN_LOWER_WIDTH;
    p.y += _PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y -= _PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_LOWER_RADIUS,
                 1.0*M_PI/2.0,
                 2.0*M_PI/2.0,
                 false);
    
    p.x -= _PAN_LOWER_RADIUS;
    p.y -= _PAN_LOWER_HEIGHT - _PAN_LOWER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y - _PAN_CURVE_SIZE);
    
    switch (kind) {
        case NumberPadViewImageLeft:
            break;
            
        case NumberPadViewImageInner:
            p.x -= _PAN_UL_WIDTH;
            break;
            
        case NumberPadViewImageRight:
            p.x -= _PAN_UL_WIDTH*2;
            break;
    }
    
    p.y -= _PAN_MIDDLE_HEIGHT + _PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y + _PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y -= _PAN_UPPER_HEIGHT - _PAN_UPPER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x += _PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_UPPER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);
    //----
    CGContextRef context;
    UIGraphicsBeginImageContext(CGSizeMake(_WIDTH,
                                           _HEIGHT));
    context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, _HEIGHT);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    //----
    
    // draw gradient
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGFloat components[] = {
        0.95f, 1.0f,
        0.85f, 1.0f,
        0.675f, 1.0f,
        0.8f, 1.0f};
    
    
    size_t count = sizeof(components)/ (sizeof(CGFloat)* 2);
    
    CGRect frame = CGPathGetBoundingBox(path);
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
    endPoint.y = frame.origin.y + frame.size.height;
    
    CGGradientRef gradientRef =
    CGGradientCreateWithColorComponents(colorSpaceRef, components, NULL, count);
    
    CGContextDrawLinearGradient(context,
                                gradientRef,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    CFRelease(path);
    
    return imageRef;
}

@end
