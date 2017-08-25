//
//  FaceDetectorController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/19.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "FaceDetectorController.h"

#define CellIdentifier @"cellIdentifier"

@interface FaceDetectorCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;

@end


@implementation FaceDetectorCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 20)];
        _imageView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_imageView];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_label];
    }
    return self;
}


@end

@interface FaceDetectorController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray    *dateScource;


@property (nonatomic, strong) UIImageView   *inputImageView;
@property (nonatomic, strong) UIImage       *inputImag;
@property (nonatomic, strong) UIButton      *recognitionButton;
@property (nonatomic, strong) UILabel       *recognitionFacesNumLabel;



@end

@implementation FaceDetectorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统人脸识别";
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.collectionView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载图片" style:UIBarButtonItemStylePlain target:self action:@selector(configData)];
 
    self.inputImag = [UIImage imageNamed:@"faces5"];
    
    [self.view addSubview:self.inputImageView];
    [self.view addSubview:self.recognitionButton];
    [self.view addSubview:self.recognitionFacesNumLabel];
    
}

- (void)configData{

    self.inputImageView.hidden = !self.inputImageView.hidden;
    
    [SVProgressHUD showWithStatus:@"处理中..."];
    // 异步  全局并发队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作放在这里
        NSArray *categoryArray = @[kCICategoryDistortionEffect,kCICategoryGeometryAdjustment,kCICategoryCompositeOperation,
                                   kCICategoryHalftoneEffect,kCICategoryColorAdjustment,kCICategoryColorEffect,
                                   kCICategoryTransition,kCICategoryTileEffect,kCICategoryGenerator,
                                   kCICategoryReduction,kCICategoryGradient,kCICategoryStylize,
                                   kCICategorySharpen,kCICategoryBlur,kCICategoryVideo,
                                   kCICategoryVideo,kCICategoryStillImage,kCICategoryInterlaced,
                                   kCICategoryNonSquarePixels,kCICategoryHighDynamicRange,kCICategoryBuiltIn,
                                   kCICategoryFilterGenerator];
        
        [self.dateScource addObject:@{@"key":kCICategoryColorEffect,@"dataArray":[self getImageWithCategory:kCICategoryColorEffect]}];
        
        //    for (NSString *key in categoryArray) {
        //
        //        [self.dateScource addObject:@{@"key":key,@"dataArray":[self getImageWithCategory:key]}];
        //        if (self.dateScource.count == 1) {
        //            
        //            break;
        //        }
        //    }
        
        
        // 回到主线程处理UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 在主线程上添加图片
           [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        });
    });
}


/**
 *  人脸识别综合示例代码（包括人脸图片提取、人脸个数、人脸定位）
 */
- (void)recognitionFaces{
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    UIImage * imageInput = [_inputImageView image];
    CIImage * image = [CIImage imageWithCGImage:imageInput.CGImage];
    
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    
    NSArray * detectResult = [faceDetector featuresInImage:image];
    
    
    UIView * resultView = [[UIView alloc] initWithFrame:_inputImageView.frame];
    [self.view addSubview:resultView];
    
    for (CIFaceFeature * faceFeature in detectResult) {
        
        UIView *faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.layer.borderColor = [UIColor redColor].CGColor;
        faceView.layer.borderWidth = 1;
        [resultView addSubview:faceView];
        
        
        if (faceFeature.hasLeftEyePosition) {
            
            UIView * leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            leftEyeView.layer.borderWidth = 1;
            leftEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:leftEyeView];
        }
        
        
        if (faceFeature.hasRightEyePosition) {
            UIView * rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [rightEyeView setCenter:faceFeature.rightEyePosition];
            rightEyeView.layer.borderWidth = 1;
            rightEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:rightEyeView];
        }
        
        if (faceFeature.hasMouthPosition) {
            UIView * mouthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
            [mouthView setCenter:faceFeature.mouthPosition];
            mouthView.layer.borderWidth = 1;
            mouthView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:mouthView];
        }
        
        
    }
    [resultView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    //显示人脸
    for (int i = 0; i< detectResult.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 105 * i, CGRectGetMaxY(self.inputImageView.frame) + 10, 100, 100)];
        CIImage * faceImage = [image imageByCroppingToRect:[[detectResult objectAtIndex:i] bounds]];
        [imageView setImage:[UIImage imageWithCIImage:faceImage]];
        [self.view addSubview:imageView];
        
    }
    
    if ([detectResult count] > 0) {
        _recognitionFacesNumLabel.text = [NSString stringWithFormat:@"人脸数：%lu",(unsigned long)detectResult.count];
    }
    
}


#pragma mark - 使用滤镜
- (NSArray *)getImageWithCategory:(NSString *)category{

    NSMutableArray *dataArray = [NSMutableArray new];
    
    NSArray* filters =  [CIFilter filterNamesInCategory:category];
    for (NSString* filterName in filters) {
        
        
        
        // 创建输入CIImage对象
        CIImage * inputImg = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"1"]];
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

        
        [dataArray addObject:@{@"key":filterName,@"image":resultImg?resultImg:[UIImage imageNamed:@"1"]}];
    }
    return dataArray;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

   
    return self.dateScource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSDictionary *dic = self.dateScource[section];
    NSArray *dataArray = dic[@"dataArray"];
    
    return dataArray.count;
}
/* 设置顶部视图和底部视图，通过kind参数分辨是设置顶部还是底部 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"HeadView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        
         NSDictionary *dic = self.dateScource[indexPath.section];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 20)];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = dic[@"key"];
        [header addSubview:titleLabel];
        
        return header;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    FaceDetectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = self.dateScource[indexPath.section];
    NSArray *dataArray = dic[@"dataArray"];
    NSDictionary *rowDic = dataArray[indexPath.row];
    
    cell.imageView.image = rowDic[@"image"];
    cell.label.text = rowDic[@"key"];
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kWidth, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5,5,5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((_collectionView.frame.size.width-15)/2, (_collectionView.frame.size.width-15)/2);
}


#pragma mark - Setter/Getter
- (UICollectionView *)collectionView{

    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 10, kWidth, kHeight - 64 - 10) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
        [_collectionView registerClass:[FaceDetectorCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return _collectionView;
}


- (NSMutableArray *)dateScource{

    if (_dateScource == nil) {
        
        _dateScource = [NSMutableArray new];
    }
    return _dateScource;
}

- (UIImageView *)inputImageView{

    if (_inputImageView == nil) {

        _inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 10, _inputImag.size.width,  _inputImag.size.height  )];
//        _inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 10, kWidth, (kWidth * _inputImag.size.height) / _inputImag.size.width)];
//        _inputImageView.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFill;
        [_inputImageView setImage:_inputImag];
    }
    return _inputImageView;
}

- (UIButton *)recognitionButton{

    if (_recognitionButton == nil) {
        _recognitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recognitionButton setTitle:@"识别" forState:UIControlStateNormal];
        [_recognitionButton setBackgroundColor:[UIColor lightGrayColor]];
        [_recognitionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recognitionButton setFrame:CGRectMake(20, kHeight - 35, kWidth - 40, 30)];
        [_recognitionButton addTarget:self action:@selector(recognitionFaces) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recognitionButton;
}

- (UILabel *)recognitionFacesNumLabel{

    if (_recognitionFacesNumLabel == nil) {
        
        _recognitionFacesNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight - 70, kWidth, 20)];
        _recognitionFacesNumLabel.text = @"人脸数：--";
        _recognitionFacesNumLabel.textColor = [UIColor blackColor];
        _recognitionFacesNumLabel.textAlignment = NSTextAlignmentCenter;
        _recognitionFacesNumLabel.font = [UIFont systemFontOfSize:18];
    }
    return _recognitionFacesNumLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
