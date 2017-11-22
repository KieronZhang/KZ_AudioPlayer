//
//  ViewController.m
//  KZ_AudioPlayer
//
//  Created by Kieron Zhang on 2017/9/28.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import "ViewController.h"
#import <KZ_AudioPlayerFramework/KZ_AudioRecorder.h>
#import <KZ_AudioPlayerFramework/KZ_AudioPlayer.h>

typedef NS_ENUM(NSInteger, KZ_RecordingType) {
    KZ_RecordingType_Stop,
    KZ_RecordingType_Recording,
    KZ_RecordingType_Pause
};

@interface ViewController () <KZ_AudioRecorderDelegate, KZ_AudioPlayerDelegate>

@property (nonatomic, assign) KZ_RecordingType recording;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    recordArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    recordView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 200)];
    recordView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:recordView];
    
    timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(recordView.bounds), 50)];
    timerLabel.textColor = [UIColor lightGrayColor];
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.font = [UIFont systemFontOfSize:30.0f];
    timerLabel.text = @"00:00:00";
    [recordView addSubview:timerLabel];
    
    recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame = CGRectMake(CGRectGetWidth(recordView.bounds) / 2 - 120, 80, 80, 80);
    [recordButton setBackgroundImage:[UIImage imageNamed:@"transport_bg"] forState:UIControlStateNormal];
    [recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [recordView addSubview:recordButton];
    
    stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stopButton.frame = CGRectMake(CGRectGetWidth(recordView.bounds) / 2 + 40, 80, 80, 80);
    [stopButton setBackgroundImage:[UIImage imageNamed:@"transport_bg"] forState:UIControlStateNormal];
    [stopButton setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [recordView addSubview:stopButton];
    
    averagePowerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(recordView.bounds) - 10, 0, 5)];
    averagePowerView.backgroundColor = [UIColor redColor];
    [recordView addSubview:averagePowerView];
    
    peakPowerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(recordView.bounds) - 5, 0, 5)];
    peakPowerView.backgroundColor = [UIColor yellowColor];
    [recordView addSubview:peakPowerView];
    
    recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 264, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 264)];
    recordTableView.delegate = self;
    recordTableView.dataSource = self;
    [self.view addSubview:recordTableView];
}

- (void)setRecording:(KZ_RecordingType)recording {
    _recording = recording;
    switch (recording) {
        case KZ_RecordingType_Stop: {
            [recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
            stopButton.enabled = NO;
        }
            break;
        case KZ_RecordingType_Pause: {
            [recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
            stopButton.enabled = YES;
        }
            break;
        case KZ_RecordingType_Recording: {
            [recordButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            stopButton.enabled = YES;
        }
            break;
        default:
            break;
    }
}

- (void)recordButtonTapped {
    if ([KZ_AudioRecorder sharedRecorderWithDelegate:self].isRecording) {
        [[KZ_AudioRecorder sharedRecorderWithDelegate:self] pauseRecorder];
        return;
    }
    [[KZ_AudioRecorder sharedRecorderWithDelegate:self] startRecorder];
}

- (void)stopButtonTapped {
    if (self.recording == KZ_RecordingType_Stop) {
        return;
    }
    [[KZ_AudioRecorder sharedRecorderWithDelegate:self] stopRecorder];
}

- (void)playWithFilePath:(NSString *)filePath {
    if (self.recording != KZ_RecordingType_Stop) {
        return;
    }
    if ([[KZ_AudioPlayer sharedPlayerWithDelegate:self] isPlayingURL:filePath]) {
        [[KZ_AudioPlayer sharedPlayerWithDelegate:self] stopPlayer];
    }
    else {
        [[KZ_AudioPlayer sharedPlayerWithDelegate:self] playFilePath:filePath currentTime:0];
    }
}

#pragma mark KZ_AudioPlayerDelegate

#pragma mark KZ_AudioRecorderDelegate
- (void)audioRecorderDidStart {
    self.recording = KZ_RecordingType_Recording;
}

- (void)audioRecordingCurrentTime:(NSTimeInterval)currentTime peakPower:(float)peakPower averagePower:(float)averagePower {
    int time = (int)currentTime;
    int hours = time / 3600;
    int minutes = (time / 60) % 60;
    int seconds = time % 60;
    timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
    averagePowerView.frame = CGRectMake(0, CGRectGetHeight(recordView.bounds) - 10, CGRectGetWidth(recordView.bounds) * averagePower, 5);
    peakPowerView.frame = CGRectMake(0, CGRectGetHeight(recordView.bounds) - 5, CGRectGetWidth(recordView.bounds) * peakPower, 5);
}

- (void)audioRecorderDidPause {
    self.recording = KZ_RecordingType_Pause;
}

- (void)audioRecorderDidStopWithFilePath:(NSString *)filePath duration:(NSTimeInterval)duration {
    self.recording = KZ_RecordingType_Stop;
    [recordArray addObject:filePath];
    [recordTableView reloadData];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCell = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCell];
    }
    cell.textLabel.text = recordArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self playWithFilePath:recordArray[indexPath.row]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
