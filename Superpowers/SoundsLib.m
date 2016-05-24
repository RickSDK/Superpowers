//
//  SoundsLib.m
//  Superpowers
//
//  Created by Rick Medved on 7/1/13.
//
//

#import "SoundsLib.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@implementation SoundsLib

+(void)PlaySound:(NSString *)file type:(NSString *)type
{
    //	return;
        SystemSoundID soundID;
        NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
        NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
    
    
}

+(void)PlaySoundMp3:(NSString *)file
{
    return;
    NSString *path2 = [[NSBundle mainBundle] pathForResource:file ofType:@"mp3"];
    AVAudioPlayer *theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path2] error:nil];
    theAudio.numberOfLoops=-1;
    [theAudio play];
    
}


@end