//
//  WebServicesFunctions.h
//  PokerTracker
//
//  Created by Rick Medved on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebServicesFunctions : NSObject {

}

+(NSString *)getResponseFromWeb:(NSString *)webAddressLink;
+(NSString *)formatEmailForUrl:(NSString *)email;
+(NSString *)getResponseFromServerUsingPost:(NSString *)weblink:(NSArray *)fieldList:(NSArray *)valueList;
+(BOOL)validateStandardResponse:(NSString *)responseStr:(id)delegate;
+(NSString *)parseCoord:(NSString *)line;
+(NSString *)getFormattedAddress:(NSString *)response value:(NSString *)value;
+(NSString *)getAddressFromGPS:(float)lat:(float)lng:(int)type;
+(BOOL)sendRequestToServer:(NSString *)file
                   forGame:(int)game_id
                 andString:(NSString *)bonusString
                andMessage:(NSString *)message
                  delegate:(id)delegate;

@end
