//
//  Board.h
//  Superpowers
//
//  Created by Rick Medved on 2/24/13.
//
//

#import <Foundation/Foundation.h>

@interface Board : NSObject {
    
}

+(NSString *)getTerrDetailsFromId:(int)terrId;
+(int)getTerrFromGrid:(int)grid;
+(int)getNationFromId:(int)terrId;
+(NSString *)getNationNameFromId:(int)terrId;
+(NSString *)getSuperpowerNameFromId:(int)nation;
+(NSArray *)getNationArray;
+(NSArray *)getNationsForSuperpower:(int)nation;
+(NSString *)getTechnologyNameFromId:(int)techId;

@end
