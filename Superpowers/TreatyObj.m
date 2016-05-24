//
//  TreatyObj.m
//  Superpowers
//
//  Created by Rick Medved on 5/4/16.
//
//

#import "TreatyObj.h"

@implementation TreatyObj

+(TreatyObj *)objectFromLine:(NSString *)line {
	TreatyObj *obj = [TreatyObj new];
	NSArray *components = [line componentsSeparatedByString:@"|"];
	if(components.count>6) {
		obj.player1 = [components objectAtIndex:0];
		obj.player2 = [components objectAtIndex:1];
		obj.nation = [[components objectAtIndex:2] intValue];
		obj.type = [components objectAtIndex:3];
		obj.roundAccepted = [[components objectAtIndex:4] intValue];
		obj.peaceOffers = [[components objectAtIndex:5] intValue];
		obj.allyOffers = [[components objectAtIndex:6] intValue];
	}
	return obj;
}



@end
