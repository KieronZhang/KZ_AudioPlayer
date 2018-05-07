//
//  KZ_AudioPlayerUtils.h
//  KZ_AudioPlayer
//
//  Created by Kieron Zhang on 2017/9/27.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZ_AudioPlayerUtils : NSObject

+ (NSURL *)temporaryAudioPath;
+ (NSString *)createAudioPath;

+ (NSString *)audioFilePathWithFilename:(NSString *)filename;

+ (void)removeAudioFileWithFilename:(NSString *)filename;
+ (void)removeAudioFileWithFilePath:(NSString *)filePath;

@end
