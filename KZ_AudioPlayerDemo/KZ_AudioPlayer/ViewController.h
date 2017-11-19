//
//  ViewController.h
//  KZ_AudioPlayer
//
//  Created by Kieron Zhang on 2017/9/28.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIView *recordView;
    UILabel *timerLabel;
    UIButton *recordButton;
    UIButton *stopButton;
    UIView *averagePowerView;
    UIView *peakPowerView;
    UITableView *recordTableView;
    NSMutableArray *recordArray;
}

@end
