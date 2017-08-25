//
//  DTImageManager.m
//  AnimationDemo
//
//  Created by dengtao on 2017/8/21.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "DTImageManager.h"
//#import <opencv2/opencv.hpp>

@implementation DTImageManager


#pragma mark - 图像灰度处理(二值化)
//方法一：OpenCV  导入openCV开发包
//- (UIImage*)imageToGrayImage:(UIImage*)image{
//    
//    //image源文件
//    
//    // 1.将iOS的UIImage转成c++图片（数据：矩阵）
//    
//    Mat mat_image_gray;
//    
//    UIImageToMat(image, mat_image_gray);
//    
//    
//    // 2. 将c++彩色图片转成灰度图片
//    
//    // 参数一：数据源
//    
//    // 参数二：目标数据
//    
//    // 参数三：转换类型
//    
//    Mat mat_image_dst;
//    
//    cvtColor(mat_image_gray, mat_image_dst, COLOR_BGRA2GRAY);
//    
//    
//    // 3.灰度 -> 可显示的图片
//    
//    cvtColor(mat_image_dst, mat_image_gray, COLOR_GRAY2BGR);
//    
//    
//    // 4. 将c++处理之后的图片转成iOS能识别的UIImage
//    
//    return MatToUIImage(mat_image_gray);
//}

//方法二：采用系统自带的库进行实现
+ (UIImage*)systemImageToGrayImage:(UIImage*)image{
    
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


@end
