//
//  LoginObj.h
//  Superpowers
//
//  Created by Rick Medved on 5/24/16.
//
//

#import <Foundation/Foundation.h>

@interface LoginObj : NSObject

@property (nonatomic) BOOL successFlg;
@property (nonatomic) int level;
@property (nonatomic) int user_id;
@property (nonatomic) int count;
@property (nonatomic) int gamesMax;
@property (nonatomic) BOOL mailFlg;
@property (nonatomic, strong) NSString *chatMessage;

@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) int games;
@property (nonatomic, strong) NSString *streak;
@property (nonatomic, strong) NSString *last10;
@property (nonatomic) int rating;

@property (nonatomic) float version;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *text_msg;
@property (nonatomic) int numWaiting;

+(LoginObj *)objectFromLine:(NSString *)line;

@end
