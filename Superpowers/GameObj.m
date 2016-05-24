//
//  GameObj.m
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import "GameObj.h"
#import "PlayerObj.h"

@implementation GameObj

+(GameObj *)objectFromLine:(NSString *)line {
	GameObj *obj = [GameObj new];
	NSLog(@"GameObj Line: %@", line);
	NSArray *components = [line componentsSeparatedByString:@"|"];
	if(components.count>17) {
		obj.gameId = [[components objectAtIndex:0] intValue];
		obj.name = [components objectAtIndex:1];
		obj.turn = [components objectAtIndex:2];
		obj.round = [[components objectAtIndex:3] intValue];
		obj.attackRound = [[components objectAtIndex:4] intValue];
		obj.timeLeft = [components objectAtIndex:5];
		obj.height = [[components objectAtIndex:6] intValue];
		obj.playerListString = [components objectAtIndex:7];
		obj.playerList = [NSMutableArray arrayWithArray:[obj.playerListString componentsSeparatedByString:@","]];
		obj.numPlayers = (int)obj.playerList.count-1;
		obj.flag = [[components objectAtIndex:8] intValue];
		obj.highlight = [components objectAtIndex:9];
		obj.status = [components objectAtIndex:10];
		obj.gameType = [components objectAtIndex:11];
		obj.size = [[components objectAtIndex:12] intValue];
		obj.autoStartFlg = [[components objectAtIndex:13] isEqualToString:@"Y"];
		obj.autoSkipFlg = [[components objectAtIndex:14] isEqualToString:@"Y"];
		obj.fogOfWarFlg = [[components objectAtIndex:15] isEqualToString:@"Y"];
		obj.lastLogin = [components objectAtIndex:17];
	}
	return obj;
}

+(GameObj *)objectDetailsFromLine:(NSString *)line {
//	NSLog(@"+++%@", line);
	GameObj *obj = [GameObj new];
	NSArray *sections = [line componentsSeparatedByString:@"<br>"];
	if(sections.count>1) {
		NSArray *components = [[sections objectAtIndex:0] componentsSeparatedByString:@"|"];
		if(components.count>24) {
			obj.name = [components objectAtIndex:0];
			obj.status = [components objectAtIndex:1];
			obj.host = [components objectAtIndex:2];
			obj.round = [[components objectAtIndex:3] intValue];
			obj.turn = [components objectAtIndex:4];
			obj.turnName = [components objectAtIndex:5];
			obj.turnFlg = [[components objectAtIndex:6] isEqualToString:@"Y"];
			obj.maxPlayers = [[components objectAtIndex:7] intValue];
			obj.gameType = [components objectAtIndex:8];
			obj.fogOfWarFlg = [[components objectAtIndex:9] isEqualToString:@"Y"];
			obj.autoSkipFlg = [[components objectAtIndex:10] isEqualToString:@"Y"];
			obj.numPlayers = [[components objectAtIndex:11] intValue];
			obj.maxAllies = [[components objectAtIndex:12] intValue];
			obj.userTop1 = [components objectAtIndex:13];
			obj.userTop2 = [components objectAtIndex:14];
			obj.userStatus = [components objectAtIndex:15];
			obj.turn = [components objectAtIndex:16];
			obj.chatFlg = [[components objectAtIndex:17] isEqualToString:@"Y"];
			obj.attackRound = [[components objectAtIndex:18] intValue];
			obj.timeLeft = [components objectAtIndex:19];
			obj.victoryRound = [[components objectAtIndex:20] intValue];
			obj.countryAttacked = [components objectAtIndex:21];
			obj.skipFlg = [[components objectAtIndex:22] isEqualToString:@"Y"];
			obj.startGameFlg = [[components objectAtIndex:23] isEqualToString:@"Y"];
			obj.cancelFlg = [components objectAtIndex:24];
		}
		obj.playerList = [NSMutableArray new];
		NSArray *players = [[sections objectAtIndex:1] componentsSeparatedByString:@"<li>"];
		for (NSString *player in players) {
			if(player.length>5) {
				PlayerObj *playerObj = [PlayerObj objectFromLine:player];
				[obj.playerList addObject:playerObj];
			}
		}
	}
	return obj;
}

@end
