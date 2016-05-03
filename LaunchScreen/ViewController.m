//
//  ViewController.m
//  ssrjWeb
//
//  Created by Fei Cao on 16/1/15.
//  Copyright © 2016年 ssrj. All rights reserved.
//

#import "ViewController.h"

#define StoreAppID   @"1035505672"  //umappid 4 ssrj

//字符串比较方式
typedef NS_ENUM(NSUInteger, SSRJNSNSOrderedComparisonResult){

    SSRJNSOrderedAscending = -1,
    SSRJNSOrderedSame = 0,
    SSRJNSOrderedDescending = 1
};

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    NSString *urlStr = @"http://m.ssrj.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //NSURLRequestReloadIgnoringCacheData 忽略缓存直接从原始地址下载。
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0f];
    
    [webView loadRequest:request];
    webView.delegate = self;
    
    [self checkAppUpdate];
    
}

-(void)checkAppUpdate
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", StoreAppID]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    //取版本号
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange range1 = NSMakeRange(substr.location+substr.length,10);
    NSRange substr2 =[file rangeOfString:@"\"" options:NSLiteralSearch range:range1];
    NSRange range2 = NSMakeRange(substr.location+substr.length, substr2.location-substr.location-substr.length);
    NSString *newVersion =[file substringWithRange:range2];
    
    if([nowVersion compare:newVersion] == SSRJNSOrderedAscending)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"版本有更新"delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"去App Store更新",nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/shi-shang-ri-ji/id1035505672?l=en&mt=8"];
        [[UIApplication sharedApplication] openURL:url];
        
    }
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return  YES;
    
}

//自动旋转(未使用)
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //内存警告，删除缓存
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    
}

@end
