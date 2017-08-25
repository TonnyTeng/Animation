//
//  ScanOpenCVController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/8/18.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScanOpenCVController.h"
#import "DTImageManager.h"

@interface ScanOpenCVController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIImageView        *imageView;
@property (strong, nonatomic) UILabel            *titleLabel;
@property (strong, nonatomic) UITableView        *tableView;
@property (strong, nonatomic) NSMutableArray     *dataSourceArray;

@end

@implementation ScanOpenCVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OpenCV Scan";
    [self.view addSubview:self.tableView];
    [self configData];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
//    [self.view addSubview:self.imageView];
//    [self.view addSubview:self.titleLabel];
//    self.imageView.image = [DTImageManager systemImageToGrayImage:self.image];
    
}

- (void)configData{

    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObject:self.image];
    
    [self.tableView reloadData];
}

- (void)sureAction:(UIButton *)sender{

    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    NSInteger index = sender.tag;
    switch (index) {
        case 0:
        {
            
            [self.dataSourceArray addObject:[DTImageManager systemImageToGrayImage:self.image]];
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
    
}



#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"银行卡识别：原图";
           break;
        case 1:{
             title = @"1.二值化(灰度处理)：对摄像头拍摄的图片，大多数是彩色图像，彩色图像所含信息量巨大，对于图片的内容，可以简单的分为前景与背景，为了让计算机更快的，更好的识别文字，需要先对彩色图进行处理，使图片只前景信息与背景信息，可以简单的定义前景信息为黑色，背景信息为白色，这就是二值化图了";
        }
            break;
        case 2:{
            title = @"2.噪声去除：对于不同的文档，我们对噪声的定义可以不同，根据噪声的特征进行去噪，就叫做噪声去除";
        }
            break;
        case 3:{
            title = @"3.倾斜较正：由于一般用户，在拍照文档时，都比较随意，因此拍照出来的图片不可避免的产生倾斜，这就需要文字识别软件进行较正";
        }
            break;
        case 4:{
            title = @"4.版面分析：将文档图片分段落，分行的过程就叫做版面分析，由于实际文档的多样性，复杂性，因此，目前还没有一个固定的，最优的切割模型";
        }
            break;
        case 5:{
            title = @"5.字符切割：由于拍照条件的限制，经常造成字符粘连，断笔，因此极大限制了识别系统的性能，这就需要文字识别软件有字符切割功能";
        }
            break;
        case 6:{
            title = @"6.字符识别：比较早有模板匹配，后来以特征提取为主，由于文字的位移，笔画的粗细，断笔，粘连，旋转等因素的影响，极大影响特征的提取的难度";
        }
            break;
        case 7:{
            title = @"7.版面恢复：人们希望识别后的文字，仍然像原文档图片那样排列着，段落不变，位置不变，顺序不变，的输出到word文档,pdf文档等，这一过程就叫做版面恢复";
        }
            break;
            
        case 8:{
            title = @"8.后处理、校对：根据特定的语言上下文的关系，对识别结果进行较正，就是后处理";
        }
            break;
        case 9:{
            title = @"9.识别结果：";
        }
            break;
        default:
            break;
    }
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kWidth - 30 - 50, 50)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.text = title;
    [headerView addSubview:titleLabel];
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(kWidth - 50, 5, 45, 40);
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureButton setTitle:@"下一步" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = [UIColor blueColor];
    sureButton.layer.cornerRadius = 4;
    sureButton.tag = section;
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sureButton];

    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"imageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.dataSourceArray[indexPath.section]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, kWidth, 150);
    [cell.contentView addSubview:imageView];
    return cell;
}

#pragma mark - Settter/Getter
- (UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStyleGrouped];
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0.1)];
//        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0.1)];
        _tableView.rowHeight = 150;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)imageView{
    
    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 64 + 10, kWidth - 60, kWidth - 60)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMidY(self.imageView.frame) + 10, kWidth - 60, kHeight - CGRectGetMidY(self.imageView.frame) - 20)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"无扫描信息...";
    }
    return _titleLabel;
}

- (NSMutableArray *)dataSourceArray{

    if (_dataSourceArray == nil) {
        
        _dataSourceArray = [NSMutableArray new];
    }
    return _dataSourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
