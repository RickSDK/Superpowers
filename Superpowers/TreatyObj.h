//
//  TreatyObj.h
//  Superpowers
//
//  Created by Rick Medved on 5/4/16.
//
//

#import <Foundation/Foundation.h>

@interface TreatyObj : NSObject

@property (nonatomic, strong) NSString *player1;
@property (nonatomic, strong) NSString *player2;
@property (nonatomic, strong) NSString *type;

@property (nonatomic) int nation;
@property (nonatomic) int roundAccepted;
@property (nonatomic) int peaceOffers;
@property (nonatomic) int allyOffers;

+(TreatyObj *)objectFromLine:(NSString *)line;

@end
