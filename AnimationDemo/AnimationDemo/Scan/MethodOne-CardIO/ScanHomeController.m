//
//  ScanHomeController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/8/17.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ScanHomeController.h"
#import "ScanCardIOMethod2Controller.h"

#import "CardIO.h"

#import "CardIOPaymentViewController.h"
#import "CardIOPaymentViewControllerDelegate.h"


@interface ScanHomeController ()<CardIOPaymentViewControllerDelegate,ScanCardVCDelegate>

@property (nonatomic, strong) CardIOPaymentViewController *cardIOVC;
@property (nonatomic, strong) UILabel *cardNumLb;


@property (nonatomic, strong) UIButton *vcBaseButton;
@property (nonatomic, strong) UIButton *vBaseButton;


@end

@implementation ScanHomeController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    //扫描的预加载
    [CardIOUtilities preload];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.vcBaseButton];
    [self.view addSubview:self.vBaseButton];
}


//继承vc扫描
- (void)onScanOneBtnClicked:(id)sender{
    
    self.cardIOVC = [[CardIOPaymentViewController alloc]initWithPaymentDelegate:self];
    [self setCardIO];
    [self presentViewController:self.cardIOVC animated:YES completion:nil];
    
}

//继承view扫描

- (void)onScanTwoBtnClicked:(id)sender

{
    
    ScanCardIOMethod2Controller *vc = [ScanCardIOMethod2Controller new];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scanCardVC:(ScanCardIOMethod2Controller *)scanCardVC didScanSuceessBankInfo:(NSDictionary *)bankInfo

{
    
    NSString *cardNum = [self dealCardNumber:bankInfo[@"cardNum"]];
    
    NSString *cardType = bankInfo[@"cardType"];
    
    NSString *cardholderName = bankInfo[@"cardholderName"];
    
    self.cardNumLb.adjustsFontSizeToFitWidth = YES;
    
    self.cardNumLb.text = [NSString stringWithFormat:@"卡号：%@  卡类型：%@ 持卡人：%@",cardNum,cardType,cardholderName];
    
}

#pragma mark CardIOPaymentViewController Delegate Method

//扫描

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    
    NSLog(@"cardInfo%@",cardInfo);
    
    //扫描结果
    
    NSString *redactedCardNumber = cardInfo.cardNumber;    // 卡号
    
    NSUInteger expiryMonth = cardInfo.expiryMonth;          // 月
    
    NSUInteger expiryYear = cardInfo.expiryYear;            // 年
    
    NSString *cvv = cardInfo.cvv;                          // CVV 码
    
    // 显示扫描结果
    
    //    NSString *msg = [NSString stringWithFormat:@"Number: %@\n\n expiry: %02lu/%lu\n\n cvv: %@", [self dealCardNumber:redactedCardNumber], expiryMonth, expiryYear, cvv];
    
    //    [[[UIAlertView alloc] initWithTitle:@"获取卡信息:"
    
    //                                message:msg
    
    //                              delegate:nil
    
    //                      cancelButtonTitle:@"确定"
    
    //                      otherButtonTitles:nil, nil] show];
    
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", cardInfo.redactedCardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv);
    
    // Use the card info...
    
    [self.cardIOVC dismissViewControllerAnimated:YES completion:nil];
    
}

//取消扫描

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/******************************************************************************
 
 **** Default Lifecycle Method                                                                                     ****
 
 ******************************************************************************/

#pragma mark -

#pragma mark Default Lifecycle Method

- (void)setCardIO

{
    
    self.cardIOVC.languageOrLocale = @"zh-Hans";
    
    //隐藏PayPal的logo
    
    self.cardIOVC.hideCardIOLogo = YES;
    
    self.cardIOVC.useCardIOLogo = NO;
    
    self.cardIOVC.keepStatusBarStyleForCardIO = YES;
    
    self.cardIOVC.allowFreelyRotatingCardGuide = YES;
    
    //修改扫描边框颜色
    
    self.cardIOVC.guideColor = [UIColor lightGrayColor];
    
    //是否支持显示卡图标
    
    self.cardIOVC.suppressScannedCardImage = YES;
    
    self.cardIOVC.detectionMode = CardIODetectionModeAutomatic;
    
}



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



#pragma mark - Setter/Getter
- (UIButton *)vcBaseButton{

    if (_vcBaseButton == nil) {
        
        _vcBaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _vcBaseButton.backgroundColor = [UIColor blueColor];
        _vcBaseButton.frame = CGRectMake(30, 74, kWidth - 60, 40);
        [_vcBaseButton setTitle:@"基于VC的扫描" forState:UIControlStateNormal];
        [_vcBaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_vcBaseButton addTarget:self action:@selector(onScanOneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vcBaseButton;
}

- (UIButton *)vBaseButton{
    
    if (_vBaseButton == nil) {
        
        _vBaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _vBaseButton.frame = CGRectMake(30, 74 + 40 + 20, kWidth - 60, 40);
        _vBaseButton.backgroundColor = [UIColor blueColor];
        [_vBaseButton setTitle:@"基于V的扫描" forState:UIControlStateNormal];
        [_vBaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_vBaseButton addTarget:self action:@selector(onScanTwoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vBaseButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
