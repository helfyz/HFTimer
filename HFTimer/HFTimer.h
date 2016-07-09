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

/**
 *  采用runloop 自己做的一个timer 。与NSTimer 相比。
 *  不会强引用 targer，当持有timer的对象释放时，timer会自动销毁
 *  支持block
 *  不支持 repeats ,timer多数需求都是需要重复，不重复的情况。为毛不用[target performSelector: withObject: afterDelay:]?
 *
 *  使用HFTimer 需要注意的一点：必须要有对象持有它。否则将不会工作，当时做这个的初衷便是targer和timer 的相互持有造成的问题，如不持有，为毛不用NSTimer?
 *  
 *  可能会有很多的坑。这毕竟是一时头脑发热做出来的。而且用的时间也不多，SO..欢迎提bug
 */
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
