//
//  HFTimer.h
//  helfyAppDemo
//
//  Created by helfy on 16/7/9.
//  Copyright © 2016年 helfy. All rights reserved.
//
///
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HFRunLoopMode) {
    HFRunLoopModeDefaultMode,   //kCFRunLoopDefaultMode
    HFRunLoopCommonModes,   //kCFRunLoopCommonModes
};

@interface HFTimer : NSObject


+ (HFTimer * _Nonnull) timerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector;

+ (HFTimer * _Nonnull)timerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector userInfo:(nullable id)userInfo;

+ (HFTimer *_Nonnull)timerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector userInfo:(nullable id)userInfo runLoopMode:(HFRunLoopMode)mode;

//block
+ (HFTimer * _Nonnull) timerWithTimeInterval:(NSTimeInterval)ti block: (void (^ _Nonnull)(HFTimer *_Nonnull timer))block;

+ (HFTimer * _Nonnull) timerWithTimeInterval:(NSTimeInterval)ti block: (void (^ _Nonnull)(HFTimer *_Nonnull timer))block runLoopMode:(HFRunLoopMode)mode;
// 同NSTimer
@property (nonatomic, readonly) NSTimeInterval timeInterval;
@property (nonatomic, readonly, getter=isValid) BOOL valid;
@property (nonatomic, nullable, readonly, retain) id userInfo;

@end
