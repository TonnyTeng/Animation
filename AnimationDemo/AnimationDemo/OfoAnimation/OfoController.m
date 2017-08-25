//
//  OfoController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/6.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "OfoController.h"
#import "OfoView.h"
#import "MessageButton.h"

#define kOfoHeight   280
#define kButtonWidth  50

@interface OfoController ()

@property (nonatomic, strong) OfoView *ofoView;
@property (nonatomic, strong) MessageButton  *messageButton;

@end

@implementation OfoController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ofo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ofoView];
    [self.view addSubview:self.messageButton];
    [self.messageButton setup];
    
}

#pragma mark - Action


#pragma mark - Setter/Getter
- (OfoView *)ofoView{

    if (_ofoView == nil) {
        
        _ofoView = [[OfoView alloc] initWithFrame:CGRectMake(0, kHeight - kOfoHeight, kWidth, kOfoHeight)];
        _ofoView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self)weakSelf = self;
        _ofoView.BlcokType = ^(NSString *type) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _ofoView;
}


- (MessageButton *)messageButton{

    if (_messageButton == nil) {
        
        _messageButton = [[MessageButton alloc] initWithFrame:CGRectMake(0,0,kButtonWidth,kButtonWidth)];
        _messageButton.center = self.view.center;
    }
    return _messageButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
