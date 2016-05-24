//
//  PlayerObj.h
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import <Foundation/Foundation.h>

@interface PlayerObj : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *status;

@property (nonatomic) int user_id;
@property (nonatomic) int nukeCount;
@property (nonatomic) int team;
@property (nonatomic) int nation;
@property (nonatomic) int player_id;

@property (nonatomic) BOOL satFlg;
@property (nonatomic) BOOL generalFlg;
@property (nonatomic) BOOL leaderFlg;

+(PlayerObj *)objectFromLine:(NSString *)line;

@end
