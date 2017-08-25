//
//  WebViewController.m
//  AnimationDemo
//
//  Created by dengtao on 2017/8/3.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:self.webView];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL* url2 = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url2];
    [self.webView loadRequest:request];
    
    
    self.webView.delegate = self;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL * url = [request URL];
    NSLog(@"\nurl = >%@\n\n\n",url);
    
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked:
        {
            
            NSLog(@"\n\n111111\n\n\n%@",url);
        }
            break;
        case UIWebViewNavigationTypeFormSubmitted:
        {
            
            NSLog(@"\n\n22222222\n\n\n%@",url);
            
            NSString * bankId = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bankId').value;"];
            NSString * bankAcctId = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bankAcctId').value;"];
            NSString * bankAcctName = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bankAcctName').value;"];
            NSString * cvv2 = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('cvv2').value;" ];
            NSString * expDate = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('expDate').value;" ];
            NSString * legalCertNo = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('legalCertNo').value;"];
            NSString * bankMobile = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bankMobile').value;"];
            
            
            if ([[url scheme] isEqualToString:@"test"]) {//file
                
                NSArray *params =[url.query componentsSeparatedByString:@"&"];
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
                for (NSString *paramStr in params) {
                    NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
                    if (dicArray.count > 1) {
                        NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        [tempDic setObject:decodeValue forKey:dicArray[0]];
                    }
                }
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式一" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
                [alertView show];
                NSLog(@"tempDic:%@",tempDic);
                return NO;
            }
            
            //requestString
            //前端把数据放到requestString中，通过;区分
            //有时候根据需要，对url string进行encode和decode
            NSArray *components = [url.absoluteString componentsSeparatedByString:@";"];
            //web:getperfectclick 这种协议定义，ios和android统一
            if([components count]>1 && ([[components objectAtIndex:0] isEqualToString:@"web:getperfectclick"]))
            {
                NSString *element = [components objectAtIndex:1];
                //element转成字典
                
//                NSDictionary *elementsDic = [element JSONValue];
//                NSLog(@"%@",elementsDic);
                
                //下面根据字典信息做相应动作
                //获取参数后调用OC客户端逻辑
                //将OC端获取数据返回给web即手动调用web代码,需要web定义方法,iOS调用
            }
            
        }
            break;
        case UIWebViewNavigationTypeBackForward:
        {
            
            NSLog(@"\n\n33333333\n\n\n%@",url);
        }
            break;
        case UIWebViewNavigationTypeReload:
        {
            NSLog(@"\n\n4444444444\n\n\n%@",url);
            
        }
            break;
        case UIWebViewNavigationTypeFormResubmitted:
        {
            
            NSLog(@"\n\n5555555555\n\n\n%@",url);
        }
            break;
        case UIWebViewNavigationTypeOther:
        {
            
            NSLog(@"\n\n66666666666\n\n\n%@",url);
        }
            break;
            
        default:
            break;
    }
    
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, nextPhone就是调用的nextPhone方法名
//    self.context[@"nextPhone"] = ^() {
//        NSLog(@"+++++++Begin Log+++++++");
//        NSArray *args = [JSContext currentArguments];
//        
//        
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal.toString);
//        }
//        
//        NSLog(@"-------End Log-------");
//    };
   
    [SVProgressHUD dismiss];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
