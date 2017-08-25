
//
//  CustomKeyBoardController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/30.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "CustomKeyBoardController.h"
#import "CustomKeyBoardView.h"
#import "RollingSubtitles.h"

@interface CustomKeyBoardController ()<UITextFieldDelegate>{
    RollingSubtitles *rolling;
    NSArray *ary;
    int u;
}

@property (nonatomic, strong) UITextField              *textField;

@end

@implementation CustomKeyBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义安全键盘";
    [self.view addSubview:self.textField];
    [self configRollingSubtitles];
}


- (void)configRollingSubtitles
{

    //初始化字幕类
    rolling = [[RollingSubtitles alloc] init];
    
    //设置滚动速度
    rolling.scrollSpeed = 0.05;
    
    //设置新文字出现的速度
    rolling.textSpeed = 0.5;
    
    //设置是否循环
    rolling.isScroll = YES;
    
    //设置字幕的行数
    rolling.scrollHeightCount = 3;
    
    //设置内容
    rolling.aryText = [[NSMutableArray alloc] initWithObjects:
                       @"王者心，青铜手，哟呀哟呀哟！",
                       @"充钱有只小猫路我从来都不起",
                       @"充钱！充钱！",
                       @"tish is very good howll doe hdhafhd",
                       @"就是垃圾卡和格拉",
                       @"咖喱的价格两个垃圾卡古拉就饿了GIA两个就阿里时间过来上课的价格拉萨价格拉时间管理和",
                       @"嘎达干撒吧",
                       @"搜噶带个娃",
                       @"好的撒",
                       nil];
    
    //设置字体颜色
    rolling.aryColor = [[NSArray alloc] initWithObjects:
                        [UIColor brownColor],
                        [UIColor purpleColor],
                        [UIColor redColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        nil];
    
    //设置字体大小
    rolling.aryFont = [[NSArray alloc] initWithObjects:
                       @"15",
                       @"16",
                       @"17",
                       @"18",
                       @"19",
                       @"15",
                       @"16",
                       nil];
    
    //设置添加字幕的视图
    rolling.RootView = self.view;
    
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    //    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    [self.view addSubview:view];
    //    
    //    rolling.RootView = view;
    
    
    
    //加添字幕
    [rolling initAddRollingSubtitles];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter/Getter
- (UITextField *)textField{

    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 64 + 15, kWidth - 30, 30)];
        _textField.layer.cornerRadius = 4;
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        _textField.layer.borderWidth = 0.4;
        _textField.layer.masksToBounds = YES;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        CustomKeyBoardView *keyBoardView = [[CustomKeyBoardView alloc] init];
//        keyBoardView.currentTextField = _textField;
        _textField.inputView = keyBoardView;//自定义键盘
        _textField.delegate = self;
        [_textField becomeFirstResponder];
//        _textField.inputAccessoryView = self.keyBoardView;//系统键盘上的自定义视图
    }
    return _textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSLog(@"%@++++%@",textField.text, string);
    return YES;
}


@end
