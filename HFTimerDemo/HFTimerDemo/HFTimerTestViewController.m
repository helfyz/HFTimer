//
//  HFTimerTestViewController.m
//  HFTimerDemo
//
//  Created by helfy on 16/7/9.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFTimerTestViewController.h"
#import "HFTimer.h"
@interface HFTimerTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic)  HFTimer *timer;

@end

@implementation HFTimerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"dealloc");
}

- (void)numberAddForLabel
{
    self.numberLabel.text = @([self.numberLabel.text integerValue] + 1).stringValue;
}

- (IBAction)startTimer:(id)sender {
    
    self.timer = [HFTimer timerWithTimeInterval:1 target:self selector:@selector(numberAddForLabel)];
    
//    or
//    self.timer = [HFTimer timerWithTimeInterval:1 block:^(HFTimer * _Nonnull timer) {
//        
//    }];

}

@end
