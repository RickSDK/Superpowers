//
//  SoundsLib.h
//  Superpowers
//
//  Created by Rick Medved on 7/1/13.
//
//	1.	In the project navigator, select your project
//	2.	Select your target
//	3.	Select the 'Build Phases' tab
//	4.	Open 'Link Binaries With Libraries' expander
//	5.	Click the '+' button
//	6.	Select framework AudioToolbox.framework, also AVFoundation

#import <Foundation/Foundation.h>

@interface SoundsLib : NSObject {
    
}

+(void)PlaySound:(NSString *)file type:(NSString *)type;
+(void)PlaySoundMp3:(NSString *)file;

@end

