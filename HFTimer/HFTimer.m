//
//  HFTimer.m
//  helfyAppDemo
//
//  Created by helfy on 16/7/9.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFTimer.h"
#import <objc/message.h>

@implementation HFTimer
{
    CFRunLoopTimerRef _runLoopTimerRef;
    CFRunLoopTimerContext _runLoopTtimerContext;
    CFRunLoopRef _runLoop;
    CFStringRef _runLoopMode;  // kCFRunLoopDefaultMode  or kCFRunLoopCommonModes;
    
    __weak id _target;
    SEL _selector;
 
    void (^_timerBlock) (HFTimer *timer);
}

+ (HFTimer *) timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector {
    return [self timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:nil runLoopMode:HFRunLoopModeDefaultMode];
}

+ (HFTimer *_Nonnull)timerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector userInfo:(nullable id)userInfo {
    return [self timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo runLoopMode:HFRunLoopModeDefaultMode];
}

+ (HFTimer *_Nonnull)timerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector userInfo:(nullable id)userInfo runLoopMode:(HFRunLoopMode)mode {
    HFTimer *timer = [[HFTimer alloc] initWithInterval:ti target:aTarget selector:aSelector userInfo:userInfo runLoopMode:mode];
    [timer startRunLoopTimer];
    return timer;
}

#pragma mark -- block 回调方式
+ (HFTimer * _Nonnull) timerWithTimeInterval:(NSTimeInterval)ti block: (void (^ _Nonnull)(HFTimer *_Nonnull timer))block{
   
    return [self timerWithTimeInterval:ti block:block runLoopMode:HFRunLoopModeDefaultMode];
    
}

+ (HFTimer * _Nonnull) timerWithTimeInterval:(NSTimeInterval)ti block: (void (^ _Nonnull)(HFTimer *_Nonnull timer))block runLoopMode:(HFRunLoopMode)mode{
    HFTimer *timer = [[HFTimer alloc] initWithInterval:ti block:block userInfo:nil runLoopMode:mode];
    [timer startRunLoopTimer];
    return timer;

}


- (instancetype)initWithInterval:(NSTimeInterval)interval
                          block:(void (^)(HFTimer *timer))block
                        userInfo:(nullable id)userInfo
                     runLoopMode:(HFRunLoopMode)mode {
    
    self = [super init];
    if(self) {
        _timerBlock = block;
        [self setupWithInterval:interval userInfo:userInfo runLoopMode:mode];
    }
    return self;
    
}
- (instancetype)initWithInterval:(NSTimeInterval)interval
                          target:(id)target
                        selector:(SEL)selector
                        userInfo:(nullable id)userInfo
                        runLoopMode:(HFRunLoopMode)mode {
    
    self = [super init];
    if(self) {
        _target = target;
        _selector = selector;
        [self setupWithInterval:interval userInfo:userInfo runLoopMode:mode];
    }
    return self;

}

- (void)setupWithInterval:(NSTimeInterval)interval
                 userInfo:(nullable id)userInfo
              runLoopMode:(HFRunLoopMode)mode {
    _runLoop = CFRunLoopGetCurrent();
    _timeInterval = interval;
    _userInfo = userInfo;
    switch (mode) {
        case HFRunLoopModeDefaultMode:
            _runLoopMode = kCFRunLoopDefaultMode;
            break;
        case HFRunLoopCommonModes:
            _runLoopMode = kCFRunLoopCommonModes;
            break;
            
        default:
            break;
    }
}

- (void) dealloc {
    [self invalidate];
}

- (void) timerResopne {
    
    @autoreleasepool {
        if(_target && _selector) {
            void (*hfMessageSend)(id self, SEL _cmd, id _ddservice) = (void*)objc_msgSend;
            hfMessageSend(_target,_selector,self);
        }
        else {
            !_timerBlock?:_timerBlock(self);
        }
    }
  
}

void hfTimerCallback(CFRunLoopTimerRef timer, void *info) {

    HFTimer *hfTimer = (__bridge HFTimer *)(info);
    [hfTimer timerResopne];
}

- (void)startRunLoopTimer {
    [self invalidate];
    _runLoopTtimerContext.info = (__bridge void *)(self);
    _runLoopTimerRef = CFRunLoopTimerCreate(CFAllocatorGetDefault(), CFAbsoluteTimeGetCurrent()+_timeInterval, _timeInterval?:0.02, 0, 0, hfTimerCallback, &_runLoopTtimerContext);
    CFRunLoopAddTimer(_runLoop?:CFRunLoopGetCurrent(), _runLoopTimerRef, _runLoopMode?:kCFRunLoopDefaultMode);
    
}

- (void)fire {
    [self timerResopne];
}

- (void)invalidate {
    if(_runLoopTimerRef) {
        CFRunLoopTimerInvalidate(_runLoopTimerRef);
        CFRelease(_runLoopTimerRef);
        _runLoopTimerRef = nil;
        
    }
    _runLoopTtimerContext.info = nil;
}

- (BOOL)isValid{
    
    if(_runLoopTimerRef) {
        return CFRunLoopTimerIsValid(_runLoopTimerRef);
    }
    return NO;
}
@end
