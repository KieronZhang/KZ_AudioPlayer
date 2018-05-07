//
//  ViewController.h
//  KZ_AudioPlayer_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
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
