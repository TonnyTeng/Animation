//
//  ScanBaseController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/18.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScanBaseController.h"
#import "ScanViewController.h"

#import "CardIO.h"
#import "CardIOView.h"

#import "ScanCardIOController.h"
#import "ScanCardIOMethod2Controller.h"
#import "ScanHomeController.h"
#import "ScanOpenCVController.h"

typedef NS_ENUM(NSInteger, UIButtonUseType) {
    UIButtonUseTypeStart = 100,
    UIButtonUseTypeOpenCV,
    UIButtonUseTypeCardIO,
    UIButtonUseTypeOther,
};

@interface ScanBaseController ()<CardIOViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (strong, nonatomic) UIButton           *startButton;
@property (assign, nonatomic) CGFloat            originY;
@property (assign, nonatomic) NSInteger          currentSelected;

@property (strong, nonatomic) UIImageView        *imageView;
@property (strong, nonatomic) UILabel            *titleLabel;



@end

@implementation ScanBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描识别";
//    [self.view addSubview:self.segmentControl];
//    [self.view addSubview:self.startButton];
    
    _originY = 74 + 30;
    
    NSArray *titleArray = @[@"Start",@"OpenCV",@"CardIO",@"Other"];
    NSArray *buttonTypeArray = @[@(UIButtonUseTypeStart),@(UIButtonUseTypeOpenCV),@(UIButtonUseTypeCardIO),@(UIButtonUseTypeOther)];
    CGFloat width = (kWidth - 30 - 5 * titleArray.count)/titleArray.count;
    CGFloat height = 30;
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(15 + (width + 5) * i, 64 + 10, width, height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 4;
        button.tag = [buttonTypeArray[i] integerValue];
        [button addTarget:self action:@selector(startSacnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    
    self.imageView.image = [UIImage imageNamed:@"bank4"];//[self getImageWithFilterImage:[UIImage imageNamed:@"1.png"]];
    
    self.currentSelected = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"拍照" style:UIBarButtonItemStylePlain target:self action:@selector(getPicture)];
    
}

- (void)getPicture{
    
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    scanVC.scanType = ScanTypeBank;
    __weak typeof(self)weakSelf = self;
    scanVC.GetPicture = ^(UIImage *image) {
        
        weakSelf.imageView.image = [weakSelf systemImageToGrayImage:image];
        
    };
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)startSacnAction:(UIButton *)sender{

    self.startButton.selected = !self.startButton.selected;
    NSLog(@"开始扫描");
    if (self.imageView.image == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请拍照"];
    }
    
    switch (sender.tag) {
        case UIButtonUseTypeStart:{
            
            
        }
            break;
        case UIButtonUseTypeOpenCV:{
        
            ScanOpenCVController *vc = [[ScanOpenCVController alloc] init];
            vc.image = self.imageView.image;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UIButtonUseTypeCardIO:{
        
            ScanCardIOMethod2Controller *vc = [[ScanCardIOMethod2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case UIButtonUseTypeOther:{
        
            ScanHomeController *vc = [[ScanHomeController alloc] init];
            //            ScanCardIOController *vc = [[ScanCardIOController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}


















































- (void)segmentAction:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 1) {
        
       
    }
    
    if (sender.selectedSegmentIndex == 2) {
        //生成二维码：
        //经过这样的处理，基本上二维码就成型了，如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影：
        self.imageView.layer.shadowOffset = CGSizeMake(0, 0.5);  // 设置阴影的偏移量
        self.imageView.layer.shadowRadius = 1;  // 设置阴影的半径
        self.imageView.layer.shadowColor = [UIColor blackColor].CGColor; // 设置阴影的颜色为黑色
        self.imageView.layer.shadowOpacity = 0.3; // 设置阴影的不透明度
        
        CIImage *ciimage = [self createQRForString:@"testdemo"];
        UIImage *codeImage = [self createNonInterpolatedUIImageFormCIImage:ciimage withSize:kWidth - 60];
        
        self.imageView.image = [self imageBlackToTransparent:codeImage withRed:255/255.0 andGreen:182/255.0 andBlue:193/255.0];
        
    }
    
    
    if (sender.selectedSegmentIndex == 0) {
    
        
        self.imageView.image = [UIImage imageNamed:@"bank1"];
        return;
        
        ScanViewController *scanVC = [[ScanViewController alloc] init];
        scanVC.scanType = sender.selectedSegmentIndex;
        NSString *title = @"银行卡";
        if (sender.selectedSegmentIndex == 0) {
            
            
            title = @"银行卡";
        }else if(sender.selectedSegmentIndex == 1){
            
            title = @"身份证";
        }else{
            
            title = @"其他";
        }
        NSLog(@"点击了：%@",title);
        __weak typeof(self)weakSelf = self;
        scanVC.GetPicture = ^(UIImage *image) {
            
            weakSelf.imageView.image = image;
            
        };
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    
}


#pragma mark - 使用滤镜
-(UIImage *)getImageWithFilterImage:(UIImage *)image{

    NSMutableArray *filtersArray = [[NSMutableArray alloc] init];
    
    NSArray* filters =  [CIFilter filterNamesInCategory:kCICategoryDistortionEffect];
    for (NSString* filterName in filters) {
        NSLog(@"filter name:%@",filterName);
        [filtersArray addObject:filterName];
        
        // 我们可以通过filterName创建对应的滤镜对象
        CIFilter* filter = [CIFilter filterWithName:filterName];
        NSDictionary* attributes = [filter attributes];
        // 获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
        NSLog(@"filter attributes:%@",attributes);
    }
    
    NSInteger index = arc4random() % filtersArray.count;
    NSString *filterName = filtersArray[index];
    NSLog(@"当前的filterName：%@",filterName);
    // 创建输入CIImage对象
    CIImage * inputImg = [[CIImage alloc] initWithImage:image];
    // 创建滤镜
    CIFilter * filter = [CIFilter filterWithName:filterName];//@"CIColorInvert"
    // 设置滤镜属性值为默认值
    [filter setDefaults];
    // 设置输入图像
    [filter setValue:inputImg forKey:@"inputImage"];
    // 获取输出图像
    CIImage * outputImg = [filter valueForKey:@"outputImage"];
    
    // 创建CIContex上下文对象
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef cgImg = [context createCGImage:outputImg fromRect:outputImg.extent];
    UIImage *resultImg = [UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    
    return resultImg;
}

#pragma mark - 采用系统自带的库进行实现
- (UIImage*)systemImageToGrayImage:(UIImage*)image{
    int width  = image.size.width;
    int height = image.size.height;
    //第一步：创建颜色空间(说白了就是开辟一块颜色内存空间)
    CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceGray();
    
    //第二步：颜色空间上下文(保存图像数据信息)
    //参数一：指向这块内存区域的地址（内存地址）
    //参数二：要开辟的内存的大小，图片宽
    //参数三：图片高
    //参数四：像素位数(颜色空间，例如：32位像素格式和RGB的颜色空间，8位）
    //参数五：图片的每一行占用的内存的比特数
    //参数六：颜色空间
    //参数七：图片是否包含A通道（ARGB四个通道）
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorRef, kCGImageAlphaNone);
    //释放内存
    CGColorSpaceRelease(colorRef);
    
    if (context == nil) {
        return  nil;
    }
    
    //渲染图片
    //参数一：上下文对象
    //参数二：渲染区域
    //源图片
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);;
    
    //将绘制的颜色空间转成CGImage
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    
    //将c/c++图片转成iOS可显示的图片
    UIImage *dstImage = [UIImage imageWithCGImage:grayImageRef];
    
    //释放内存
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return dstImage;
}


#pragma mark - 采用系统的(iOS7+)方法生产二维码 http://www.jianshu.com/p/3ba8825c0a49

//首先是二维码的生成，使用CIFilter很简单，直接传入生成二维码的字符串即可：
- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}

//因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage：

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//因为生成的二维码是黑白的，所以还要对二维码进行颜色填充，并转换为透明背景，使用遍历图片像素来更改图片颜色，因为使用的是CGContext，速度非常快：
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}


#pragma mark - Setter/Getter
- (UISegmentedControl *)segmentControl{

    if (_segmentControl == nil) {
        
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"银行卡",@"身份证",@"系统二维码"]];
        _segmentControl.frame = CGRectMake(30, 64 + 10, kWidth - 60, 30);
        _originY = CGRectGetMaxY(_segmentControl.frame);
        [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UIButton *)startButton{

    if (_startButton == nil) {
        
        _startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _startButton.frame = CGRectMake(kWidth / 2 - 40, 64 + 10, 80, 30);
        [_startButton setTitle:@"开始扫描" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startButton.backgroundColor = [UIColor blueColor];
        _startButton.layer.cornerRadius = 4;
        _originY = CGRectGetMaxY(_startButton.frame);
        [_startButton addTarget:self action:@selector(startSacnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, _originY + 10, kWidth - 60, kWidth - 60)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
