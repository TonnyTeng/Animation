//
//  DynamicsController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "DynamicsController.h"
#import "DynamicsAnimationController.h"

@interface DynamicsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSourceArray;

@end

@implementation DynamicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动力学动画";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
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
    NSLog(@"\n你选择的是：%@",[self.dataSourceArray objectAtIndex:indexPath.row]);
    DynamicsAnimationController *vc = [[DynamicsAnimationController alloc] init];
    vc.title = [self.dataSourceArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
            
        case 0:
        {
            vc.type = DynamicsGravity;
        }
            break;
        case 1:
        {
            vc.type = DynamicsCollision;
        }
            break;
            
        case 2:
        {
            vc.type = DynamicsScram;
        }
            break;
            
        case 3:
        {
            vc.type = DynamicsForce;
        }
            break;
        case 4:
        {
            vc.type = DynamicsCat;
        }
            break;
        case 5:
        {
            
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
            
        case 10:
        {
            NSLog(@"待添加...");
            
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
        [_dataSourceArray addObject:@"重力"];
        [_dataSourceArray addObject:@"碰撞"];
        [_dataSourceArray addObject:@"急停"];
        [_dataSourceArray addObject:@"施力"];
        [_dataSourceArray addObject:@"喵神"];
        [_dataSourceArray addObject:@"待添加..."];
    }
    return _dataSourceArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
