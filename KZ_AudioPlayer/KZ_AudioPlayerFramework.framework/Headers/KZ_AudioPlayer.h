//
//  KZ_AudioPlayer.h
//  KZ_AudioPlayer
//
//  Created by Kieron Zhang on 2017/9/27.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZ_AudioPlayerUtils.h"

@protocol KZ_AudioPlayerDelegate <NSObject>

@optional
- (void)audioPlayingDuration:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime peakPower:(float)peakPower averagePower:(float)averagePower;
- (void)audioPlayerDidStop;
- (void)audioPlayerDidStart;
- (void)audioPlayerDidFailed;

@end

@interface KZ_AudioPlayer : NSObject {
    NSTimer *countDownTimer;
}
@property (nonatomic, weak) id<KZ_AudioPlayerDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign, readonly) float peakPower;
@property (nonatomic, assign, readonly) float averagePower;

+ (KZ_AudioPlayer *)sharedPlayerWithDelegate:(id<KZ_AudioPlayerDelegate>)delegate;

- (void)playFilename:(NSString *)filename currentTime:(NSTimeInterval)currentTime;
- (void)playFilePath:(NSString *)filePath currentTime:(NSTimeInterval)currentTime;
- (BOOL)isPlayingURL:(NSString *)url;
- (void)pausePlayer;
- (void)stopPlayer;

@end
