//
//  KZ_AudioRecorder.h
//  KZ_AudioPlayer
//
//  Created by Kieron Zhang on 2017/9/27.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZ_AudioPlayerUtils.h"

@protocol KZ_AudioRecorderDelegate <NSObject>

@optional
- (void)audioRecorderDidStart;
- (void)audioRecordingCurrentTime:(NSTimeInterval)currentTime peakPower:(float)peakPower averagePower:(float)averagePower;
- (void)audioRecorderDidPause;
- (void)audioRecorderDidStopWithFilename:(NSString *)filename duration:(NSTimeInterval)duration;
- (void)audioRecorderDidStopWithFilePath:(NSString *)filePath duration:(NSTimeInterval)duration;
- (void)audioRecorderDidFailed;

@end

@interface KZ_AudioRecorder : NSObject  {
    NSTimer *countDownTimer;
}
@property (nonatomic, weak) id<KZ_AudioRecorderDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isRecording;
@property (nonatomic, assign, readonly) float peakPower;
@property (nonatomic, assign, readonly) float averagePower;

+ (KZ_AudioRecorder *)sharedRecorderWithDelegate:(id<KZ_AudioRecorderDelegate>)delegate;

- (void)startRecorder;
- (void)startRecorderWithFilename:(NSString *)filename;
- (void)startRecorderWithFilePath:(NSString *)filePath;
- (void)pauseRecorder;
- (void)stopRecorder;

@end
