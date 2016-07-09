# HFTimer
 自动释放的Timer
 
 想到做这个timer 是因为上周在改bug 的时候。发现很多同事在使用timer的时候，没有去销毁timer的意识，导致vc 和 timer 相互引用。
 所以当时就萌生了写一个会自动销毁timer的想法。。然后周末下午无事。就写了一个试试。。就是现在的HFTimer，
 里面的可能会有很多的坑。毕竟这是一时头脑发热做出来的。而且用的时间也不多，SO...欢迎提bug

  pod 'HFTimer', '~> 0.1.0'
 
 
  采用runloop 自己做的一个timer 。
  
  相对于NSTimer，HFTimer 有以下改变
  不会强引用 targer，当持有timer的对象释放时，timer会自动销毁
  支持block
  不支持 repeats ,timer多数需求都是需要重复，不重复的情况。为毛不用[target performSelector: withObject: afterDelay:]?
  
  使用HFTimer 需要注意的一点：必须要有对象持有它。否则将不会工作，当时做这个的初衷便是targer和timer 的相互持有造成的问题，如不持有，为毛不用NSTimer?
  
  因为是采用的runLoop，所以不需要使用RunLoopCommonModes 的，直接传入HFRunLoopMode即可，默认：kCFRunLoopDefaultMode

   
   使用：
    
     self.timer = [HFTimer timerWithTimeInterval:1 target:self selector:@selector()];
    
    或者
    
    self.timer = [HFTimer timerWithTimeInterval:1 block:^(HFTimer * _Nonnull timer) {
        
    }];
    
    
    
     
   
