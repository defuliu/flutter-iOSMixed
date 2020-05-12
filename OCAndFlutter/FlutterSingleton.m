//
//  FlutterSingleton.m
//  OCAndFlutter
//
//  Created by liudefu on 2020/4/7.
//  Copyright © 2020 ZGW. All rights reserved.
//

#import "FlutterSingleton.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

#define Channel_message = @"com.pages.your/native_get"
#define Channel_event = @"com.pages.your/native_post"


@interface FlutterSingleton()<FlutterStreamHandler>

@end

@implementation FlutterSingleton


+ (instancetype )shared{
    static FlutterSingleton *shared;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        shared = [[FlutterSingleton alloc] init];
        
        FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
        [flutterEngine runWithEntrypoint:nil];
        [GeneratedPluginRegistrant registerWithRegistry:flutterEngine];
        
        FlutterViewController *vc = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        shared.flutterVC = vc;
        FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:@"com.pages.your/native_get" binaryMessenger:vc];
        
        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"com.pages.your/native_post" binaryMessenger:vc];
        [eventChannel setStreamHandler:shared];
        
        [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            if (shared.handler) {
                shared.handler(call, result);
            }
        }];
        
    });
    return shared;
}

#pragma -mark FlutterStreamHandler

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        self.eventSink  = events;
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    NSLog(@"----%@", arguments);
    return nil;
}


@end
