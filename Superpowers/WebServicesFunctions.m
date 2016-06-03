    //
//  WebServicesFunctions.m
//  PokerTracker
//
//  Created by Rick Medved on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "NSArray+ATTArray.h"


@implementation WebServicesFunctions

+(NSString *)getResponseFromWeb:(NSString *)webAddressLink
{
	
	NSURL *url = [NSURL URLWithString:[webAddressLink stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url
												  cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval: 40];

	NSData *response=nil;
   response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

	if(response.length==0) { // Try again!!!
		[NSThread sleepForTimeInterval:1];
		response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	}
	NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	return responseString;
}

+(NSString *)formatEmailForUrl:(NSString *)email
{
	return [[email stringByReplacingOccurrencesOfString:@"@" withString:@"%%40"] stringByReplacingOccurrencesOfString:@"." withString:@"%%23"];
}

+(NSString *)getResponseFromServerUsingPost:(NSString *)weblink:(NSArray *)fieldList:(NSArray *)valueList
{
	if([fieldList count] != [valueList count]) {
		return [NSString stringWithFormat:@"Invalid value list! (%d, %d) %@", (int)[fieldList count], (int)[valueList count], weblink];
	}
	int i=0;
	NSMutableString *fieldStr= [NSMutableString stringWithCapacity:256];
	for(NSString *name in fieldList)
		[fieldStr appendFormat:@"&%@=%@", name, [valueList objectAtIndex:i++]];
	
	NSString *responseString = nil;
	NSData *postData = [fieldStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", (int)[postData length]];
	NSURL *url = [NSURL URLWithString:weblink];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
																cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval: 30];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
	[request setHTTPBody:postData];
	NSData *response=nil;
	
	
	response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	if(response.length==0) { // Try again!!!
		[NSThread sleepForTimeInterval:1];
		response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	}
	
		NSString *reString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
		responseString = [NSString stringWithFormat:@"%@", reString];
	return responseString;
}

+(BOOL)validateStandardResponse:(NSString *)responseStr:(id)delegate
{
	if(responseStr==nil || [responseStr length]==0)
		responseStr = @"No response received from server.";
	
	if([responseStr length]>=7 && [[responseStr substringToIndex:7] isEqualToString:@"Success"]) {
		return YES;
	}
	else {
		if([responseStr length]>100)
			responseStr = [responseStr substringToIndex:100];
		[ObjectiveCScripts showAlertPopupWithDelegate:@"ERROR" :[NSString stringWithFormat:@"%@", responseStr]:(id)delegate];
		return NO;
	}
}

+(NSString *)parseCoord:(NSString *)line
{
	NSString *final = @"";
	NSArray *components = [line componentsSeparatedByString:@":"];
	if([components count]>1) {
		final = [components objectAtIndex:1];
		NSArray *groups = [final componentsSeparatedByString:@"\""];
		if([groups count]>1) {
			NSString *goodstuff = [groups objectAtIndex:1];
			NSArray *mixes = [goodstuff componentsSeparatedByString:@", "];
			if([mixes count]>3) {
				NSArray *stateZip = [[mixes objectAtIndex:2] componentsSeparatedByString:@" "];
				final = [NSString stringWithFormat:@"%@|%@|%@|%@|%@", [mixes stringAtIndex:3], [mixes stringAtIndex:0], [mixes stringAtIndex:1], [stateZip stringAtIndex:0], [stateZip stringAtIndex:1]];
			}
		}
	}
	return final;
}

+(NSString *)getFormattedAddress:(NSString *)response:(NSString *)value
{
	NSArray *lines = [response componentsSeparatedByString:@"\n"];
	for(NSString *line in lines) {
		NSString *newline = [line stringByReplacingOccurrencesOfString:@" " withString:@""];
		if([newline length]>19) {
			if([[newline substringToIndex:19] isEqualToString:[NSString stringWithFormat:@"\"%@\"", value]])
				return [WebServicesFunctions parseCoord:line];
		}
	}
	return @"";
}


+(NSString *)getAddressFromGPS:(float)lat:(float)lng:(int)type
{
	
	NSString *latitude = [NSString stringWithFormat:@"%.6f", lat];
	NSString *longitutde = [NSString stringWithFormat:@"%.6f", lng];
	NSString *googleAPI = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true", latitude, longitutde];
	NSString *response = [WebServicesFunctions getResponseFromWeb:googleAPI];
	
	NSString *address = [WebServicesFunctions getFormattedAddress:response:@"formatted_address"];
	if(type==0) // full address
		return address;
	if(type==1 && [address length]>7) {
		NSArray *elements = [address componentsSeparatedByString:@"|"];
		return [elements stringAtIndex:2];
	}
	return @"";
}

+(BOOL)sendRequestToServer:(NSString *)file
                   forGame:(int)game_id
                 andString:(NSString *)bonusString
                andMessage:(NSString *)message
                  delegate:(id)delegate
{
    
    NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"bonusString", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", game_id], bonusString, nil];
    NSString *weblike = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/%@", file];
	NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:weblike:nameList:valueList];
    
    NSLog(@"response: %@", response);
    
    NSArray *components = [response componentsSeparatedByString:@"|"];
    if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
        if([[components stringAtIndex:1] isEqualToString:@"Success"]) {
            [ObjectiveCScripts showAlertPopupWithDelegate:message :@"" :delegate];
            return YES;
        } else
            [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
    } else
        [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
    return NO;
}






@end
