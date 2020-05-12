//
//  FlutterSingleton.h
//  OCAndFlutter
//
//  Created by liudefu on 2020/4/7.
//  Copyright © 2020 ZGW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterSingleton : NSObject

+(instancetype)shared;

@property (nonatomic, strong) FlutterViewController *flutterVC;

@property (nonatomic, copy) FlutterMethodCallHandler handler;

@property (nonatomic, copy) FlutterEventSink eventSink;

@end

NS_ASSUME_NONNULL_END
