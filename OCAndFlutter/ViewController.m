//
//  ViewController.m
//  OCAndFlutter
//
//  Created by liudefu on 2020/3/24.
//  Copyright © 2020 ZGW. All rights reserved.
//

#import "ViewController.h"
#import "FlutterSingleton.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleSingleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"用力点" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}
- (void)handleSingleButtonAction{
    __weak ViewController *weakself = self;
    [FlutterSingleton shared].handler = ^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"result=====:%@",result);
    };
    
    if ( [FlutterSingleton shared].eventSink) {
        [FlutterSingleton shared].eventSink([self currentRouteName]);
    }
    [FlutterSingleton shared].handler = ^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"flutter传来的方法名:%@,flutter传来的参数:%@",call.method,call.arguments);
        
        if (result) {
            result(@"native 给到flutter 哈哈哈哈");
        }
        
        if ([call.method isEqualToString:@"naviToBack"]) {
            BOOL animate = [[call.arguments objectForKey:@"animate"] isEqualToString:@"1"];
            [weakself.navigationController popViewControllerAnimated:animate];
        }
    };
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:[FlutterSingleton shared].flutterVC animated:YES];
    
}

- (NSString *)currentRouteName{
    NSArray *arrRoute = @[@"MethodChannel",@"EventChannel"];
    
    if (self.index >= arrRoute.count) {
        self.index = 0;
    }
    
    
    NSString *routeName = arrRoute[self.index];
    self.index += 1;
    
    return routeName;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

@end
