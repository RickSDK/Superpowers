//
//  UserObj.m
//  Superpowers
//
//  Created by Rick Medved on 5/25/16.
//
//

#import "UserObj.h"

@implementation UserObj

+(UserObj *)objectFromLine:(NSString *)line {
	UserObj *obj = [UserObj new];
	NSArray *components = [line componentsSeparatedByString:@"|"];
	if(components.count>4) {
		obj.name = [components objectAtIndex:0];
		obj.userId = [[components objectAtIndex:1] intValue];
		obj.rank = [[components objectAtIndex:2] intValue];
		obj.created = [components objectAtIndex:3];
		obj.lastLogin = [components objectAtIndex:4];
	}
	return obj;
}

@end
