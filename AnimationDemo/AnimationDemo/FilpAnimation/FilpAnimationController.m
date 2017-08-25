
//
//  FilpAnimationController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "FilpAnimationController.h"


/** transition.type
 私有效果
     //1、suckEffect 抽纸效果
     //2、cube 方块翻转效果
     //3、oglFlip 平面翻转效果
     //4、rippleEffect 水波纹效果
     //5、cameraIrisHollowOpen 开关相机效果
     //6、pageCurl 翻书效果
 */

/**
 // Common transition types.

 NSString * const kCATransitionFade
 NSString * const kCATransitionMoveIn
 NSString * const kCATransitionPush
 NSString * const kCATransitionReveal

// Common transition subtypes.

 NSString * const kCATransitionFromRight
 NSString * const kCATransitionFromLeft
 NSString * const kCATransitionFromTop
 NSString * const kCATransitionFromBottom
 */

@interface FilpAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton *currentButton;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) NSArray  *typeArray;

@end


@implementation FilpAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻转动画";
    
    self.typeArray = @[kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal,
                       kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromRight,kCATransitionFromBottom];
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.tipsLabel];
}

- (void)startAniamtion:(UIButton *)sender{

    NSArray *typeArray = @[@"suckEffect",@"cube",@"oglFlip",@"rippleEffect",@"cameraIrisHollowOpen",@"pageCurl"];
    self.currentButton = sender;
    sender.userInteractionEnabled = NO;
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = typeArray[sender.tag - 100];                
    transition.subtype = self.typeArray[arc4random() % self.typeArray.count];
    transition.duration = 1.5;
    transition.delegate = self;
    [self.redView.layer addAnimation:transition forKey:nil];
    
    self.tipsLabel.text = [NSString stringWithFormat:@"%@: %@  %@",sender.titleLabel.text,transition.type,transition.subtype];
}

- (void)handleSwipeFromRight{
    
    //转场动画
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";                //立方体翻转
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.5;
    transition.delegate = self;
    [self.redView.layer addAnimation:transition forKey:nil];
    
    
}
- (void)handleSwipeFromLeft{
    
    CATransition *transition2 = [[CATransition alloc] init];
    transition2.type = @"cube";
    transition2.subtype = kCATransitionFromLeft;
    transition2.duration = 1.5;
    transition2.delegate = self;
    [self.redView.layer addAnimation:transition2 forKey:nil];
}
#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{

    self.redView.backgroundColor = [UIColor colorWithDisplayP3Red:(arc4random()% 255)/255.0 green:(arc4random()% 255)/255.0 blue:(arc4random()% 255)/255.0 alpha:1];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;{

    if (flag) {
        
        self.currentButton.userInteractionEnabled = YES;
    }
}

#pragma mark - Setter/Getter
- (UIView *)redView{

    if (!_redView) {
        
        _redView = [[UIView alloc] initWithFrame:CGRectMake(40, 64 + 50, kWidth - 160, kHeight - 64 - 100)];
        _redView.layer.cornerRadius = 8;
        _redView.backgroundColor = [UIColor redColor];
        
        UISwipeGestureRecognizer *fromRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight)];
        [fromRightRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [_redView addGestureRecognizer:fromRightRecognizer];
        
        UISwipeGestureRecognizer *fromLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft)];
        [fromLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [_redView addGestureRecognizer:fromLeftRecognizer];
        
        NSArray *typeArray = @[@"抽纸效果",@"方块翻转",@"平面翻转",@"水波纹",@"开关相机",@"翻书效果"];
        CGFloat oringinY = 64 + 50;
        CGFloat space = (kHeight - 64 - 100 - 30 * typeArray.count)/typeArray.count;
        
        for (NSInteger i = 0;i < typeArray.count; i ++) {
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 85, oringinY + i * (30 + space), 80, 30)];
            button.layer.cornerRadius = 4;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            button.layer.borderWidth = 1;
            [button setTitle:typeArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(startAniamtion:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
        }
    }
    return  _redView;
}

- (UILabel *)tipsLabel{

    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kHeight - 30, kWidth - 20, 20)];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor grayColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14];
    }
    return _tipsLabel;
}

- (UIView *)greenView{
    
    if (!_greenView) {
        
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(50 + kWidth, 64 + 50, kWidth - 100, kHeight - 64 - 100)];
        _greenView.layer.cornerRadius = 8;
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return  _greenView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
