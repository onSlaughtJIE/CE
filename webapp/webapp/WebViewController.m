//
//  ViewController.m
//  webapp
//
//  Created by 郑超华 on 2017/9/11.
//  Copyright © 2017年 郑超华. All rights reserved.
//

#import "WebViewController.h"
#import "YZLocationManager.h"
#import "MapViewController.h"


@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) YZLocationManager *manager;

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToUrl:) name:@"jump" object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)jumpToUrl:(NSNotification *)noti {
    NSURL *url = [NSURL URLWithString:noti.object];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.backgroundColor = [UIColor clearColor];
    self.mainWebView.scrollView.showsVerticalScrollIndicator =NO;
    
    
    
    if ([self.urlString isEqualToString:@""] || self.urlString == nil) {
         self.urlString = @"http://www.bjdllt.com";
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:request];
    
    //    地图定位
    //    [self performSelector:@selector(startLocationService) withObject:nil afterDelay:0.5];
}


/*
- (void)startLocationService{
    
    YZLocationManager *manager = [YZLocationManager sharedLocationManager];
    manager.isBackGroundLocation = YES;
    manager.locationInterval = 10;
    
    //    @weakify(manager)
    [manager setYZBackGroundLocationHander:^(CLLocationCoordinate2D coordinate) {
        _plc(coordinate);
        YZLMLOG(@"纬度--%f,经度--%f",coordinate.latitude,coordinate.longitude);
    }];
    
    [manager setYZBackGroundGeocderAddressHander:^(NSString *address) {
        YZLMLOG(@"address:%@",address);
    }];
    [manager startLocationService];
}

*/


- (NSString *)dateString{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // 设置日期格式
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return dateString;
}


    
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
}
//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    JSContext *context = [self.mainWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    
    [self addPayActionWithContext:context];
    
    NSLog(@"%@",context);
}

//- (void)jump {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MapViewController *mapVC = [sb instantiateViewControllerWithIdentifier:@"MapViewController"];
//    [self.navigationController pushViewController:mapVC animated:YES];
//}
- (void)addPayActionWithContext:(JSContext *)context
{
//        LBWeakSelf(self);
//      大礼包
        //将context对象与js方法建立桥接联系  weixin_app_pay：表示我们js里面的方法名 和后台约定好
        context[@"weixin_app_pay"] = ^() {
            //通过Block成功的在JavaScript调用方法回到了Objective-C，而且依然遵循JavaScript方法的各种特点，比如方法参数不固定。也因为这样，JSContext提供了类方法来获取参数列表
            NSArray *args = [JSContext currentArguments];
            NSString *orderString = @"";
            for (id obj in args) {
                NSString *string = [NSString stringWithFormat:@"%@",obj];
                orderString = string;
            }
            [[NSUserDefaults standardUserDefaults] setObject:@[@"dalibao"] forKey:@"dalibao"];
            NSLog(@"%@---",orderString);
            [LBHTTPRequest getWechatParamsWithOIderId:@{@"orderid":orderString} resultBlock:^(NSDictionary *resultDic, NSError *error) {
                    NSLog(@"%@",resultDic);
                    NSMutableDictionary *Dic = resultDic[@"data"];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"appId"] = Dic[@"appid"];
                    dic[@"mch_id"] = Dic[@"partnerid"];
                    dic[@"prepayId"] = Dic[@"prepayid"];
                    dic[@"nonceStr"] = Dic[@"noncestr"];
                    dic[@"timeStamp"] = Dic[@"timestamp"];
                    dic[@"paySign"] = Dic[@"package"];
                    [MXWechatPayHandler jumpToWxPayWithDic:dic];
            }];
        };
//     抢购
        context[@"buy"] = ^() {
            NSArray *args = [JSContext currentArguments];
            NSMutableArray *arr = [NSMutableArray array];
            for (id obj in args) {
                NSString *string = [NSString stringWithFormat:@"%@",obj];
                [arr addObject:string];
            }
            LBLog(@"%@",arr);
            [LBHTTPRequest getBuyWithParam:@{@"name":arr[0],@"phone":arr[1],@"address":arr[2],@"goodsid":arr[3],@"uid":arr[4]} resultBlock:^(NSDictionary *resultDic, NSError *error) {
                NSLog(@"%@",resultDic);
                NSMutableDictionary *Dic = resultDic[@"data"];
                NSMutableArray *currentPrice = [NSMutableArray array];
                [currentPrice addObject: resultDic[@"currentprice"]];
                [currentPrice addObject:resultDic[@"money"]];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"appId"] = Dic[@"appid"];
                dic[@"mch_id"] = Dic[@"partnerid"];
                dic[@"prepayId"] = Dic[@"prepayid"];
                dic[@"nonceStr"] = Dic[@"noncestr"];
                dic[@"timeStamp"] = Dic[@"timestamp"];
                dic[@"paySign"] = Dic[@"package"];
                [[NSUserDefaults standardUserDefaults] setObject:currentPrice forKey:@"currentPrice"];
                [MXWechatPayHandler jumpToWxPayWithDic:dic];
            }];
        };
//     窥探
        context[@"see"] = ^() {
            NSArray *args = [JSContext currentArguments];
            NSMutableArray *arr = [NSMutableArray array];
            for (id obj in args) {
                NSString *string = [NSString stringWithFormat:@"%@",obj];
                [arr addObject:string];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"goodsid"];
            LBLog(@"%@",arr);
            [LBHTTPRequest getLookpayIdWithParam:@{@"goodsid":arr[0],@"price":arr[1],@"token":arr[2],@"uid":arr[3]} resultBlock:^(NSDictionary *resultDic, NSError *error) {
                    NSLog(@"%@",resultDic);
                    NSMutableDictionary *Dic = resultDic[@"data"];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"appId"] = Dic[@"appid"];
                    dic[@"mch_id"] = Dic[@"partnerid"];
                    dic[@"prepayId"] = Dic[@"prepayid"];
                    dic[@"nonceStr"] = Dic[@"noncestr"];
                    dic[@"timeStamp"] = Dic[@"timestamp"];
                    dic[@"paySign"] = Dic[@"package"];
                    [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"orderId"];
                    [MXWechatPayHandler jumpToWxPayWithDic:dic];
            }];
        };
  
}

-(void)asdfsdfa{
    AFHTTPSessionManager *mangr = [AFHTTPSessionManager manager];
    mangr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mangr GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

