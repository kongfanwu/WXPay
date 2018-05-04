//
//  FWWebViewController.m
//  FWWXPay
//
//  Created by 孔凡伍 on 2018/5/4.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "FWWebViewController.h"
#import <WebKit/WebKit.h>

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

@interface FWWebViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
/** <##> */
@property (nonatomic, strong) UIScrollView *scr;

@end

@implementation FWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    
    [self loadRequestUrl:@"http://www.hao123.com"];
//    if(@available(iOS 11.0, *)) {
//        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.extendedLayoutIncludesOpaqueBars = NO;

//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = [UIColor redColor];
//    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIEdgeInsets safeArea = VIEWSAFEAREAINSETS(self.view);
    if(@available(iOS 11.0, *)) {
    } else {
        safeArea.top = [UIApplication sharedApplication].statusBarFrame.size.height;
    }

    _webView.frame = CGRectMake(0, safeArea.top, self.view.frame.size.width, self.view.frame.size.height - safeArea.top - safeArea.bottom);
}

- (void)loadRequestUrl:(NSString *)url {
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:req];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {
        [self handleCustomAction:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - private method
- (void)handleCustomAction:(NSURL *)URL
{
    NSString *host = [URL host];
    if ([host isEqualToString:@"scanClick"]) {
        NSLog(@"扫一扫");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
