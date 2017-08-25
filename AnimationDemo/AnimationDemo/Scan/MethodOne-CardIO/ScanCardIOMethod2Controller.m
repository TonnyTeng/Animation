//
//  ScanCardIOMethod2Controller.m
//  AnimationDemo
//
//  Created by dengtao on 2017/8/17.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScanCardIOMethod2Controller.h"
#import "CardIO.h"

#import "CardIOView.h"

@interface ScanCardIOMethod2Controller ()<CardIOViewDelegate>

@property (strong, nonatomic) CardIOView         *scanView;

@end

@implementation ScanCardIOMethod2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [CardIOUtilities preloadCardIO];
    [self initScanView];
}

#pragma mark - Method1 - CardIO
//初始化扫描View

- (void)initScanView

{
    
    //设置扫描的语言环境
    
    self.scanView.languageOrLocale = @"zh-Hans";
    
    //设置扫描的代理
    
    self.scanView.delegate = self;
    
    self.scanView.hideCardIOLogo = YES;//是否隐藏扫描的logo
    
    self.scanView.useCardIOLogo = YES;
    
    //修改扫描框里面的提示文字，设置为nil，则显示sdk默认的文字
    
    self.scanView.scanInstructions = @"请将卡片放置框内进行扫描";
    
    //    self.scanV.frame = self.scanV.cameraPreviewFrame;
    
    // 默认情况下,在相机视图卡指南和按钮总是匹配设备的方向旋转
    
    self.scanView.allowFreelyRotatingCardGuide = YES;
    
    //设置在扫描成功后多长时间展现扫描成功界面
    
    self.scanView.scannedImageDuration = 0.2f;
    
    self.scanView.guideColor = [UIColor lightGrayColor];
    
}

#pragma mark  CardIOViewDelegate Method

- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)cardInfo

{
    
    cardInfo.scanned = YES;
    
    NSString *cardNum = [NSString stringWithFormat:@"%@", cardInfo.cardNumber];
    
    NSLog(@"cardNum %@",cardNum);
    
    //卡类型
    
    NSString *cardType = [CardIOCreditCardInfo displayStringForCardType:cardInfo.cardType
                          
                                                  usingLanguageOrLocale:@"zh-Hans"];
    
    //卡logo
    
    UIImage *bankLogo = [CardIOCreditCardInfo logoForCardType:cardInfo.cardType];
    
    //持卡人
    
    NSString *cardholderName = cardInfo.cardholderName;
    
    //扫描结果
    
    NSString *redactedCardNumber = cardInfo.redactedCardNumber;    // 卡号
    
    NSString *expiryMonth = [NSString stringWithFormat:@"%lu",(unsigned long)cardInfo.expiryMonth];          // 月
    
    NSString *expiryYear  = [NSString stringWithFormat:@"%lu",(unsigned long)cardInfo.expiryYear];            // 年
    
    NSString *cvv = cardInfo.cvv;                          // CVV 码
    
    // 显示扫描结果
    
    //    NSString *msg = [NSString stringWithFormat:@"Number: %@\n\n expiry: %2@/%@\n\n cvv: %@", [self dealCardNumber:redactedCardNumber], expiryMonth, expiryYear, cvv];
    
    //    [[[UIAlertView alloc] initWithTitle:@"获取卡信息:"
    
    //                                message:msg
    
    //                              delegate:nil
    
    //                      cancelButtonTitle:@"确定"
    
    //                      otherButtonTitles:nil, nil] show];
    
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", cardInfo.redactedCardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv);
    
    NSMutableDictionary *bankInfo = [NSMutableDictionary dictionary];
    
    [bankInfo setValue:cardNum forKey:@"cardNum"];
    
    [bankInfo setValue:expiryYear forKey:@"expiryYear"];
    
    [bankInfo setValue:expiryMonth forKey:@"expiryMonth"];
    
    [bankInfo setValue:cardType forKey:@"cardType"];
    
    [bankInfo setValue:cardholderName forKey:@"cardholderName"];
    
        if (self.delegate)
    
        {
    
            [self.delegate scanCardVC:self didScanSuceessBankInfo:bankInfo];
    
        }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




// 对银行卡号进行每隔四位加空格处理，自定义方法

- (NSString *)dealCardNumber:(NSString *)cardNumber

{
    
    //CardIOCreditCardInfo *info里面包含了银行卡的一些信息，如info.cardNumber是扫描的银行卡号，现实的是完整号码，而info.redactedCardNumber只显示银行卡后四位，前面的用*代替了，返回的银行卡号都没有空格
    
    //可以用下面注释的方法来加空格
    
    NSString *strTem = [cardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *strTem2 = @"";
    
    if (strTem.length % 4 == 0)
        
    {
        
        NSUInteger count = strTem.length / 4;
        
        for (int i = 0; i < count; i++)
            
        {
            
            NSString *str = [strTem substringWithRange:NSMakeRange(i * 4, 4)];
            
            strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
            
        }
        
    }
    
    else
        
    {
        
        NSUInteger count = strTem.length / 4;
        
        for (int j = 0; j <= count; j++)
            
        {
            
            if (j == count)
                
            {
                
                NSString *str = [strTem substringWithRange:NSMakeRange(j * 4, strTem.length % 4)];
                
                strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
                
            }
            
            else
                
            {
                
                NSString *str = [strTem substringWithRange:NSMakeRange(j * 4, 4)];
                
                strTem2 = [strTem2 stringByAppendingString:[NSString stringWithFormat:@"%@ ", str]];
                
            }
            
        }
        
    }
    
    return strTem2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
