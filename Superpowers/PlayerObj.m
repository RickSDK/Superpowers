//
//  PlayerObj.m
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import "PlayerObj.h"

@implementation PlayerObj

+(PlayerObj *)objectFromLine:(NSString *)line {
	PlayerObj *obj = [PlayerObj new];
	NSArray *components = [line componentsSeparatedByString:@"|"];
	if(components.count>11) {
		obj.username = [components objectAtIndex:0];
		obj.user_id = [[components objectAtIndex:1] intValue];
		obj.nation = [[components objectAtIndex:2] intValue];
		obj.income = [components objectAtIndex:3];
		obj.money = [components objectAtIndex:4];
		obj.player_id = [[components objectAtIndex:5] intValue];
		obj.nukeCount = [[components objectAtIndex:6] intValue];
		obj.satFlg = [[components objectAtIndex:7] isEqualToString:@"Y"];
		obj.generalFlg = [[components objectAtIndex:8] isEqualToString:@"1"];
		obj.leaderFlg = [[components objectAtIndex:9] isEqualToString:@"1"];
		obj.status = [components objectAtIndex:10];
		obj.team = [[components objectAtIndex:11] intValue];
	}
	return obj;
}

@end
