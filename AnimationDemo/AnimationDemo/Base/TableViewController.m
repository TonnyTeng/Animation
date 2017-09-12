//
//  TableViewController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/22.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "TableViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "CircleProgressController.h"
#import "RadarController.h"
#import "HeartbeatController.h"
#import "ScoreController.h"
#import "TransitionsController.h"
#import "PullPictureController.h"
#import "FilpAnimationController.h"
#import "SnowAnimationController.h"
#import "DynamicsController.h"
#import "CustomKeyBoardController.h"
#import "OfoController.h"
#import "LottieAnimationController.h"
#import "ScanBaseController.h"
#import "FaceDetectorController.h"
#import "WebViewController.h"

#define kButtonWidth  50

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSourceArray;
@property (nonatomic, strong) UIButton          *button;


@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
   
//    [self.view addSubview:self.button];
}

#pragma mark - Action
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    //locationInView是指当前点击在指定视图中的位置，translationInView是在指定的坐标系中移动
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerX = recognizer.view.center.x + translation.x;
    
    CGFloat thecenter = 0;
    
    recognizer.view.center = CGPointMake(centerX,
                                       
                                         recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded ||
       recognizer.state == UIGestureRecognizerStateCancelled) {
        
        if(centerX > kWidth / 2) {
            
            thecenter = kWidth - kButtonWidth / 2;
            
        }else{
            
            thecenter = kButtonWidth / 2;
            
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            recognizer.view.center = CGPointMake(thecenter,
                                               
                                                 recognizer.view.center.y+ translation.y);
            
        }];
        
    }
}

- (void)clickAction:(UIButton *)sender{

//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]
    NSLog(@"--------------------------");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"animationDemo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#pragma mark - 播放点击的文本
    static int start = 0;
    if (start == 1) {
        
        AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:[self.dataSourceArray objectAtIndex:indexPath.row]];
        [synthesizer speakUtterance:utterance];
        
    }
    NSLog(@"\n你选择的是：%@",[self.dataSourceArray objectAtIndex:indexPath.row]);
    id vc;
    switch (indexPath.row) {
            
        case 0:
        {
            
            vc = [[CircleProgressController alloc] init];
        }
            break;
        case 1:
        {
            
            vc = [[RadarController alloc] init];
        }
            break;
        
        case 2:
        {
            
            vc = [[HeartbeatController alloc] init];
            ((HeartbeatController *)vc).type = 0;
        }
            break;
        
        case 3:
        {
            vc = [[HeartbeatController alloc] init];
            ((HeartbeatController *)vc).type = 1;
        }
            break;
        case 4:
        {
            vc = [[ScoreController alloc] init];
        }
            break;
        case 5:
        {
            
            vc = [[TransitionsController alloc] init];
            
        }
            break;
        case 6:
        {
            vc = [[PullPictureController alloc] init];
            
        }
            break;
        case 7:
        {
            vc = [[FilpAnimationController alloc] init];
        }
            break;
        case 8:
        {
            vc = [[SnowAnimationController alloc] init];
            
        }
            break;
        case 9:
        {
            vc = [[DynamicsController alloc] init];
        }
            break;
        case 10:
        {
            vc = [[CustomKeyBoardController alloc] init];
        }
            break;
            case 11:
        {
            vc = [[OfoController alloc] init];
        }
            break;
        
        case 12:
        {
            vc = [[LottieAnimationController alloc] init];
        }
            break;
            
        case 13:
        {
            vc = [[ScanBaseController alloc] init];
        }
            break;
            case 14:
        {
            vc = [[FaceDetectorController alloc] init];
        }
            break;
        case 15:
        {
            vc = [[WebViewController alloc] init];
        }
            break;
        case 16:
        {
            NSLog(@"待添加...");
            
        }
            break;
        default:
            break;
    }
    if (vc) {
        
        if (indexPath.row == 5) {
            
            [self presentViewController:vc animated:YES completion:nil];
        }else{
        
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Setter/Getter

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 44;
    }
    return _tableView;
}
- (NSMutableArray *)dataSourceArray{
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [[NSMutableArray alloc] init];
        [_dataSourceArray addObject:@"圆形进度动画"];
        [_dataSourceArray addObject:@"雷达动画"];
        [_dataSourceArray addObject:@"心跳动画"];
        [_dataSourceArray addObject:@"心跳轨迹动画"];
        [_dataSourceArray addObject:@"评分"];
        [_dataSourceArray addObject:@"自定义模态跳转动画"];
        [_dataSourceArray addObject:@"图片拉伸动画"];
        [_dataSourceArray addObject:@"翻转动画"];
        [_dataSourceArray addObject:@"雪花动画"];
        [_dataSourceArray addObject:@"动力学动画"];
        [_dataSourceArray addObject:@"自定义键盘"];
        [_dataSourceArray addObject:@"ofo动画"];
        [_dataSourceArray addObject:@"Lottie动画"];
        [_dataSourceArray addObject:@"扫描识别"];
        [_dataSourceArray addObject:@"系统人脸识别"];
        [_dataSourceArray addObject:@"酷播365-JS|OC"];
        
        
        
        [_dataSourceArray addObject:@"待添加..."];
    }
    return _dataSourceArray;
}

- (UIButton *)button{

    if (_button == nil) {
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,kButtonWidth,kButtonWidth)];
        
        _button.backgroundColor = [UIColor orangeColor];
        
        _button.layer.cornerRadius = kButtonWidth / 2;
        
        _button.center = self.view.center;
        [_button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        [_button addGestureRecognizer:panGestureRecognizer];
    }
    return _button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
