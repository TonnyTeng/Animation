//
//  FaceDetector.m
//  AnimationDemo
//
//  Created by dengtao on 2017/7/19.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "FaceDetector.h"

@implementation FaceDetector


+(NSArray *)faceImagesByFaceRecognitionWithImage:(UIImage *)image{
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:image.CGImage];
    
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    
    NSMutableArray * imagesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< detectResult.count; i++) {
        
        CIImage * faceImage = [cImage imageByCroppingToRect:[[detectResult objectAtIndex:i] bounds]];
        [imagesArr addObject:[UIImage imageWithCIImage:faceImage]];
    }
    
    return [NSArray arrayWithArray:imagesArr];
}

+(NSInteger)totalNumberOfFacesByFaceRecognitionWithImage:(UIImage *)image{
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:image.CGImage];
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    
    return detectResult.count;
}

@end
