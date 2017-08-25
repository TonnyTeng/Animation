//
//  RollingSubtitles.m
//  字幕组
//
//  Created by Allen_12138 on 15-3-3.
//  Copyright (c) 2015年 mushroom_yan@foxmail.com-八爷. All rights reserved.
//

#import "RollingSubtitles.h"

@interface RollingSubtitles (){
    
    NSMutableArray *aryLabel1;
    NSMutableArray *aryLabel2;
    NSMutableArray *aryLabel3;
    NSMutableArray *aryLabel4;
    NSMutableArray *aryLabel5;
    NSMutableArray *aryLabel6;
    NSMutableArray *aryLabel7;
    NSMutableArray *aryLabel8;
    NSMutableArray *aryLabel9;
    
    int i;
    float labHeght;
    
}
@end

@implementation RollingSubtitles

- (void)initAddRollingSubtitles
{
    
    i = 0;
    
    //新文字出现的速度
    if(_textSpeed == 0){
        _textSpeed = 1;
    }
    
    //滚动速度
    if(_scrollSpeed == 0){
        _scrollSpeed = 0.05;
    }
    
    labHeght = _RootView.bounds.size.height/(float)_scrollHeightCount;
    
    NSTimer *updateCarTimer = [NSTimer scheduledTimerWithTimeInterval:_scrollSpeed target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    [updateCarTimer fire];
    
    NSTimer *updateCar = [NSTimer scheduledTimerWithTimeInterval:_textSpeed target:self selector:@selector(doTi:) userInfo:nil repeats:YES];
    [updateCar fire];
    
    aryLabel1 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel2 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel3 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel4 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel5 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel6 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel7 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel8 = [[NSMutableArray alloc] initWithCapacity:0];
    aryLabel9 = [[NSMutableArray alloc] initWithCapacity:0];
    
}

//添加新字幕
- (void)doTi:(NSTimer *)timer{
    
    if(_aryText.count == 0){
        return;
    }
    
    //是否循环
    if(!_isScroll && i > _aryText.count-1){
        return;
    }
    
    //如果超过最后一个
    if(i > _aryText.count-1){
        i = 0;
    }
    
    //随机字体大小、颜色、y坐标
    NSInteger fx = _aryFont.count-1;
    NSInteger fy = _aryColor.count-1;
    int xx = [self getRandomNumber:0 to:(int)fx];
    int yy = [self getRandomNumber:0 to:(int)fy];
    int hh = [self getRandomNumber:0 to:_scrollHeightCount];
    
    //创建标签
    UILabel *labCountent = [[UILabel alloc] init];
    labCountent.lineBreakMode = NSLineBreakByWordWrapping;
    labCountent.numberOfLines = 1;
    labCountent.backgroundColor = [UIColor clearColor];
    
    labCountent.font = [UIFont systemFontOfSize:[_aryFont[xx] intValue]];
    labCountent.textColor = _aryColor[yy];
    
    NSString *s = _aryText[i];
    
    //是否循环
    if(!_isScroll){
        [_aryText removeObjectAtIndex:i];
    }else{
        i++;
    }
    
    labCountent.text = s;
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize size = [labCountent sizeThatFits:CGSizeMake(5000,20)];
    [_RootView addSubview:labCountent];
    
    //添加到字幕数组
    [self addArryLabel:labCountent andHH:hh andCGSize:size];
    
}

//添加字幕到数组
- (void)addArryLabel:(UILabel *)label andHH:(int)hh andCGSize:(CGSize)size{
    
    switch (hh) {
        case 1:
            
            if(aryLabel1.count == 0){
                //如果是第一个数据
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                //如果不是第一个数据
                UILabel *labCon = aryLabel1[aryLabel1.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    //如果前一个字幕在屏幕外，这条字幕添加到前一个字幕后面
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    //如果前一个字幕在屏幕内，这条字幕添加到屏幕外
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            //把字幕添加到字幕数组
            [aryLabel1 addObject:label];
            
            break;
        case 2:
            
            if(aryLabel2.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel2[aryLabel2.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel2 addObject:label];
            
            break;
        case 3:
            
            if(aryLabel3.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel3[aryLabel3.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel3 addObject:label];
            
            break;
        case 4:
            
            if(aryLabel4.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel4[aryLabel4.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel4 addObject:label];
            
            break;
        case 5:
            
            if(aryLabel5.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel5[aryLabel5.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel5 addObject:label];
            
            break;
        case 6:
            
            if(aryLabel6.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel6[aryLabel6.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel6 addObject:label];
            
            break;
        case 7:
            
            if(aryLabel7.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel7[aryLabel7.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel7 addObject:label];
            
            break;
        case 8:
            
            if(aryLabel8.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel8[aryLabel8.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel8 addObject:label];
            
            break;
        case 9:
            
            if(aryLabel9.count == 0){
                label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
            }else{
                UILabel *labCon = aryLabel9[aryLabel9.count-1];
                if(labCon.frame.origin.x+labCon.frame.size.width > _RootView.frame.size.width){
                    label.frame =CGRectMake(labCon.frame.origin.x+labCon.frame.size.width+size.width, hh*labHeght, size.width, size.height);
                }else{
                    label.frame =CGRectMake(_RootView.bounds.size.width, hh*labHeght, size.width, size.height);
                }
            }
            [aryLabel9 addObject:label];
            
            break;
            
        default:
            break;
    }
    
}

//改变字幕位置（滚动效果）
- (void)doTimer:(NSTimer *)timer{
    
    //循环改变字幕x坐标
    for (int y=0; y<aryLabel1.count; y++) {
        //获取字幕
        UILabel *labCountent = aryLabel1[y];
        //改变字幕的x坐标
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        //如果字幕超出屏幕则删除字幕
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel1[y] removeFromSuperview];
            [aryLabel1 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel2.count; y++) {
        UILabel *labCountent = aryLabel2[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel2[y] removeFromSuperview];
            [aryLabel2 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel3.count; y++) {
        UILabel *labCountent = aryLabel3[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel3[y] removeFromSuperview];
            [aryLabel3 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel4.count; y++) {
        UILabel *labCountent = aryLabel4[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel4[y] removeFromSuperview];
            [aryLabel4 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel5.count; y++) {
        UILabel *labCountent = aryLabel5[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel5[y] removeFromSuperview];
            [aryLabel5 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel6.count; y++) {
        UILabel *labCountent = aryLabel6[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel6[y] removeFromSuperview];
            [aryLabel6 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel7.count; y++) {
        UILabel *labCountent = aryLabel7[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel7[y] removeFromSuperview];
            [aryLabel7 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel8.count; y++) {
        UILabel *labCountent = aryLabel8[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel8[y] removeFromSuperview];
            [aryLabel8 removeObjectAtIndex:y];
            y--;
        }
    }
    for (int y=0; y<aryLabel9.count; y++) {
        UILabel *labCountent = aryLabel9[y];
        labCountent.frame = CGRectMake(labCountent.frame.origin.x-2, labCountent.frame.origin.y, labCountent.frame.size.width, labCountent.frame.size.height);
        if(labCountent.frame.origin.x+labCountent.frame.size.width < 0){
            [aryLabel9[y] removeFromSuperview];
            [aryLabel9 removeObjectAtIndex:y];
            y--;
        }
    }
    
}

//获取一个xx-xx间的随机数(包括xx-xx)
-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}


@end
