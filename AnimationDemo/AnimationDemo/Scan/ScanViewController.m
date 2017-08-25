//
//  ScanViewController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/18.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage                 *image;

@end

@implementation ScanViewController


//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"银行卡";
    if (self.scanType == ScanTypeBank) {
        
        title = @"银行卡";
    }else if(self.scanType == ScanTypeIDCard){
        
        title = @"身份证";
    }else{
        
        title = @"其他";
    }
    self.title = title;
    [self actionWithEnterCamera];
    
//    [self actionWithEnterLibrary];
}

//进入相册
- (void)actionWithEnterLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:^{
        
    }];
}

//进入相机
- (void)actionWithEnterCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:NO completion:^{
            
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image = info[UIImagePickerControllerEditedImage];
    
    //处理完毕，回到个人信息页面
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
        
        _GetPicture(_image);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
