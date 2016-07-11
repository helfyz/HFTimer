# HFTimer
 自动释放的Timer
    
    pod 'HFTimer', '~> 0.1.1'
    
 想到做这个timer 是因为上周在改项目bug的时候 的时候。发现很多同事在使用timer的时候，没有去销毁timer的意识，还有的是完全不知道timer会对target强引用。。。
 
 最后导致的问题就是 targer 和 timer 循环引用，不能释放。当然，在ARC模式下，这是很容易被忽略的问题，
 然后知道这问题，但是在什么地方进行销毁？这也是一个问题。。
  我看到的做法基本是，
  
      如果在VC里面，在disappear里面进行销毁， 但是，这样做又会引发其他问题。因为pop 和 push 都会触发这个方法。
      然后又需要在appear里面重新开始，根据本身的需求，可能还需要加入启动的条件判断
         
       如果是在View里面，情况和VC差不多。只是方法不同
       
       最后，就是在model里面(比如一个model需要定时去获取服务器数据等)。这情况就尴尬了。。因为它没有类似VC和View 的方法。
       只能手动去销毁。
 
 所以当时就萌生了写一个会自动销毁timer的想法。。然后周末下午无事。就写了一个试试。。就是现在的HFTimer，
 当然，里面的可能会有很多的坑。毕竟这是一时头脑发热做出来的。而且用的时间也不多，SO...欢迎提bug


  
  相对于NSTimer，HFTimer 有以下改变
  
     不会强引用 targer，当持有timer的对象释放时，timer会自动销毁
  
     支持block
  
     不支持 repeats ,timer多数需求都是需要重复，不重复的情况。为什么不用performSelector: withObject: afterDelay:?
  
  使用HFTimer 需要注意的一点：必须要有对象持有它。否则将不会工作，当时做这个的初衷便是targer和timer 的相互持有造成的问题，如不持有，可以考虑 HFPrettyTimer(https://github.com/helfyz/HFPrettyTimer)?
  
  因为是采用的runLoop，所以需要使用RunLoopCommonModes 的，直接传入HFRunLoopMode即可，默认：kCFRunLoopDefaultMode

   
   使用：
    
     self.timer = [HFTimer timerWithTimeInterval:1 target:self selector:@selector(XXX)];
    
    或者
    
    self.timer = [HFTimer timerWithTimeInterval:1 block:^(HFTimer * _Nonnull timer) {
        
    }];
    
    
    
    喜欢 NSTimer的同学。。基于NSTimer 的自动释放
    HFPrettyTimer (https://github.com/helfyz/HFPrettyTimer)
   
