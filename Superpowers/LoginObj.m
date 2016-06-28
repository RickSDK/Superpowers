//
//  LoginObj.m
//  Superpowers
//
//  Created by Rick Medved on 5/24/16.
//
//

#import "LoginObj.h"

@implementation LoginObj

+(LoginObj *)objectFromLine:(NSString *)line {
	LoginObj *obj = [LoginObj new];
	NSArray *components = [line componentsSeparatedByString:@"|"];
	if(components.count>17) {
		obj.successFlg = [@"Superpowers" isEqualToString:[components objectAtIndex:0]];
		obj.level = [[components objectAtIndex:1] intValue];
		obj.user_id = [[components objectAtIndex:2] intValue];
		obj.count = [[components objectAtIndex:3] intValue];
		obj.gamesMax = [[components objectAtIndex:4] intValue];
		obj.mailFlg = [@"Y" isEqualToString:[components objectAtIndex:5]];
		obj.chatMessage = [components objectAtIndex:6];

		obj.wins = [[components objectAtIndex:7] intValue];
		obj.losses = [[components objectAtIndex:8] intValue];
		obj.games = [[components objectAtIndex:9] intValue];
		obj.streak = [components objectAtIndex:10];
		obj.last10 = [components objectAtIndex:11];
		obj.rating = [[components objectAtIndex:12] intValue];
		obj.version = [[components objectAtIndex:13] floatValue];
		obj.phone = [components objectAtIndex:14];
		obj.text_msg = [components objectAtIndex:15];
		obj.numWaiting = [[components objectAtIndex:16] intValue];
		obj.announementMsg = [components objectAtIndex:17];
	}
	return obj;
}

@end
