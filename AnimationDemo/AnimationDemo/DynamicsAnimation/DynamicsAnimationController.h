//
//  DynamicsAnimationController.h
//  AnimationDemo
//
//  Created by dengtao on 2017/6/26.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "XTViewController.h"
typedef NS_ENUM(NSInteger, DynamicsType) {
    
    DynamicsGravity,    //重力
    DynamicsCollision,  //碰撞
    DynamicsScram,      //急停
    DynamicsForce,      //施力
    DynamicsCat,        //喵神
};            

@interface DynamicsAnimationController : XTViewController

@property (nonatomic, assign) DynamicsType type;

@end
