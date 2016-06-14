//
//  GameObj.h
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import <Foundation/Foundation.h>

@interface GameObj : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *turn;
@property (nonatomic, strong) NSString *timeLeft;
@property (nonatomic, strong) NSString *highlight;
@property (nonatomic, strong) NSString *gameType;
@property (nonatomic, strong) NSString *turnName;
@property (nonatomic, strong) NSString *playerListString;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *userTop1;
@property (nonatomic, strong) NSString *userTop2;
@property (nonatomic, strong) NSString *userStatus;
@property (nonatomic, strong) NSString *countryAttacked;
@property (nonatomic, strong) NSString *cancelFlg;
@property (nonatomic, strong) NSString *lastLogin;
@property (nonatomic, strong) NSString *accountSitReason;

@property (nonatomic, strong) NSMutableArray *playerList;

@property (nonatomic) int gameId;
@property (nonatomic) int round;
@property (nonatomic) int attackRound;
@property (nonatomic) int height;
@property (nonatomic) int size;
@property (nonatomic) int flag;
@property (nonatomic) int numPlayers;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int maxAllies;
@property (nonatomic) int victoryRound;
@property (nonatomic) int currentTurnUserId;

@property (nonatomic) BOOL autoStartFlg;
@property (nonatomic) BOOL autoSkipFlg;
@property (nonatomic) BOOL fogOfWarFlg;

@property (nonatomic) BOOL turnFlg;
@property (nonatomic) BOOL chatFlg;
@property (nonatomic) BOOL skipFlg;
@property (nonatomic) BOOL startGameFlg;

+(GameObj *)objectFromLine:(NSString *)line;
+(GameObj *)objectDetailsFromLine:(NSString *)line;

@end
