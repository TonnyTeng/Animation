//
//  ScoreController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/23.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScoreController.h"
#import "ScoreView.h"


@interface ScoreController ()<ScoreViewDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation ScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评分动画";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self configUI];
    
    
    UIStepper *stepper2 = [[UIStepper alloc] initWithFrame:CGRectMake(50, kHeight - 100, kWidth - 100, 40)];//frame = (50 636; 94 29)
    [stepper2 addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper2];
    
    
    _stepper = [[UIStepper alloc]initWithFrame:CGRectMake(50, 200, 8, 5)];
    _stepper.backgroundColor = [UIColor redColor];
    _stepper.tintColor = [UIColor clearColor];
    _stepper.minimumValue = 0;
    _stepper.maximumValue = 1000;
    _stepper.stepValue = 1;
    [_stepper addTarget:self action:@selector(valuechange) forControlEvents:UIControlEventValueChanged];
    //    step.wraps = YES;  //写了这个属性从0递减是100，从100递增是0
    [self.view addSubview:_stepper];
    
//    UIButton *decrementImgView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 29, 29)];
////    decrementImgView.image = [UIImage imageNamed:@"reduce"];
//    [decrementImgView setTitle:@"-" forState:UIControlStateNormal];
//    [_stepper addSubview:decrementImgView];

    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.text = @"-";
    [_stepper addSubview:leftLabel];
    
    
//    UIButton *incrementImgView = [[UIButton alloc]initWithFrame:CGRectMake(65, 0, 29, 29)];
////    incrementImgView.image = [UIImage imageNamed:@"add"];
//    [incrementImgView setTitle:@"+" forState:UIControlStateNormal];
//    [_stepper addSubview:incrementImgView];
   
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 29, 29)];
    rightLabel.text = @"+";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = [UIColor whiteColor];
    [_stepper addSubview:rightLabel];
   
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(29, 0, CGRectGetWidth(self.stepper.frame) - 29 * 2, 29)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.text = @"0";
    _textField.textAlignment = NSTextAlignmentCenter;
    [_stepper addSubview:_textField];
    
    
//    _label = [[UILabel alloc]initWithFrame:CGRectMake(50 + 29, kHeight - 50, 36, 29)];
//    _label.backgroundColor = [UIColor whiteColor];
//    _label.textAlignment = NSTextAlignmentCenter;
//    _label.text = @"0";
//    [self.view addSubview:_label];
    
}

- (void)valuechange{
    
//    _label.text = [NSString stringWithFormat:@"%d",(int)_stepper.value];
    _textField.text = [NSString stringWithFormat:@"%d",(int)_stepper.value];
    
}

- (void)valueChange:(UIStepper *)stepper{

    NSLog(@"当前的值：%f",stepper.value);
    
}







#pragma mark - ConfigUI
- (void)configUI{

    NSArray *titleArray = @[@"综合评价",@"响应速度",@"帮助指数"];
    NSArray *indexArray = @[@(4),@(3),@(2)];
    CGFloat origin_x = 15;
    CGFloat origin_y = 100;
    for (int i = 0; i < 3; i ++) {
        
        UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, origin_y + i * (20 + 15), kWidth - 30, 20)];
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.text = titleArray[i];
        [self.view addSubview:leftLabel];
        
        ScoreView *starView = [[ScoreView alloc] initWithFrame:CGRectMake(kWidth / 2, origin_y + i * (20 + 15), kWidth / 2 - 15, 20) numberOfStars:5];
        starView.scorePercent = [indexArray[i] floatValue] / 5.0;
        starView.allowIncompleteStar = YES;//允许半星
        starView.hasAnimation = YES;
        starView.delegate = self;
        starView.tag = 100 + i;
        [self.view addSubview:starView];
    }
}

#pragma mark - ScoreViewDelegate
- (void)starRateView:(ScoreView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
    if (starRateView.tag == 100) {
        //综合评价
        NSLog(@"综合评价：%.2lf",newScorePercent * 5);
    }
    if (starRateView.tag == 101) {
        //响应速度
        NSLog(@"响应速度：%.2lf",newScorePercent * 5);
    }
    if (starRateView.tag == 102) {
        //帮组指数
        NSLog(@"帮组指数：%.2lf",newScorePercent * 5);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
