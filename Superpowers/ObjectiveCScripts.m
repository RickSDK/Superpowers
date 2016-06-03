//
//  ObjectiveCScripts.m
//  iBabyBook
//
//  Created by Rick Medved on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// These scripts are NOT project dependant

#import "ObjectiveCScripts.h"
#import "NSDate+ATTDate.h"
#import "NSString+ATTString.h"


@implementation ObjectiveCScripts

+(int)getProductionMode
{
	return kPRODMode;
}

+(NSString *)getProjectVersion
{
	return @"Version 1.0";
}

+(NSString *)getProjectDisplayVersion
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *model = [device model];
    
    
    NSString *softwareVersion = (__bridge NSString *)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey);
 
	NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
	NSString *version = infoDictionary[@"CFBundleShortVersionString"];

     return [NSString stringWithFormat:@"%@", version];
}

+(float)screenWidth {
	return [[UIScreen mainScreen] bounds].size.width;
}

+(float)screenHeight {
	return [[UIScreen mainScreen] bounds].size.height;
}


+(NSArray *)sortArray:(NSMutableArray *)list ascendingFlg:(BOOL)ascendingFlg
{
	if(ascendingFlg) {
		[list sortUsingSelector:@selector(compare:)];
		return list;
	}
	
	return [list sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]]];
}

+ (NSString *)escapeQuotes:(NSString *)string 
{
	return [string stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
}

+(NSDate *)getFirstDayOfMonth:(NSDate *)thisDay
{
	NSString *currentMonth = [thisDay convertDateToStringWithFormat:@"MM"];
	NSString *currentYear = [thisDay convertDateToStringWithFormat:@"yyyy"];
	NSString *Day1 = [NSString stringWithFormat:@"%@/01/%@ 12:00:00 AM", currentMonth, currentYear];
	return [Day1 convertStringToDateWithFormat:nil];
}

+(NSString *)convertNumberToMoneyString:(int)money
{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	//	[formatter setGeneratesDecimalNumbers:NO];
	//	[formatter setRoundingMode:NSNumberFormatterRoundUp];
	NSNumber *c = [NSNumber numberWithInt:money];
	NSString *moneyStr = [formatter stringFromNumber:c];
	return moneyStr;	
}

+(NSString *)convertIntToMoneyString:(int)money
{
	if(money>100000000)
		return [NSString stringWithFormat:@"$%dM", money/1000000];
	if(money>1000000)
		return [NSString stringWithFormat:@"$%.1fM", (float)money/1000000];
	if(money>100000)
		return [NSString stringWithFormat:@"$%dK", money/1000];
	//	if(money>10000)
	//		return [NSString stringWithFormat:@"$%.1fK", (float)money/1000];
	
	return [ObjectiveCScripts convertNumberToMoneyString:money];
}

+(void)setUserDefaultValue:(NSString *)value forKey:(NSString *)key
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:value forKey:key];
}

+(NSString *)getUserDefaultValue:(NSString *)key
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *result = [userDefaults stringForKey:key];
	return result;
}

+(void)showAlertPopup:(NSString *)title:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles: nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}	

+(void)showAlertPopupWithDelegate:(NSString *)title:(NSString *)message:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:@"OK"
										  otherButtonTitles: nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
	//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
}	

+(void)showConfirmationPopup:(NSString *)title:(NSString *)message:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles: @"OK", nil];
	
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
	//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
}	

+(void)showAcceptDeclinePopup:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:@"Decline"
										  otherButtonTitles: @"Accept", nil];
	
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
	//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
}	

+(NSArray *)getContentsOfFlatFile:(NSString *)filename
{
	NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
	NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:defaultPath];
	if(!fh)
		[ObjectiveCScripts showAlertPopup:@"File not Found!" :[NSString stringWithFormat:@"File: %@ not found.", filename]];
	[fh closeFile];
	
	NSString *contents = [NSString stringWithContentsOfFile:defaultPath encoding:NSUTF8StringEncoding error:nil];
	NSArray *lines = [contents componentsSeparatedByString:@"\n"];
	return lines;
}
/*
+(BOOL)limitTextViewLength:(UITextView *)textViewLocal:(NSString *)currentText:(NSString *)string:(int)limit:(UIBarButtonItem *)saveButton:(BOOL)resignOnReturn
{
	if([string isEqualToString:@"|"])
		return NO;
	if([string isEqualToString:@"`"])
		return NO;
	
	if(saveButton != nil) {
		if([string length]==0 && [currentText length]==1)
			saveButton.enabled = NO;
		else 
			saveButton.enabled = YES;
	}
	
	if(resignOnReturn && [string isEqualToString:@"\n"]) {
		[textViewLocal resignFirstResponder];
		return NO;
	}
	
	if( [string length]==0)
		return YES;
	
	if([textViewLocal.text length]>=limit)
		return NO;  //prevents change
	else {
		return YES;
	}
}
 */
/*
+(BOOL)limitTextFieldLength:(UITextField *)textViewLocal:(NSString *)currentText:(NSString *)string:(int)limit:(UIBarButtonItem *)saveButton:(BOOL)resignOnReturn
{
	if([string isEqualToString:@"|"])
		return NO;
	if([string isEqualToString:@"`"])
		return NO;
	
	if(saveButton != nil) {
		if([string length]==0 && [currentText length]==1)
			saveButton.enabled = NO;
		else 
			saveButton.enabled = YES;
	}
	
	if(resignOnReturn && [string isEqualToString:@"\n"]) {
		[textViewLocal resignFirstResponder];
		return NO;
	}
	
	if( [string length]==0)
		return YES;
	
	if([textViewLocal.text length]>=limit)
		return NO;  //prevents change
	else {
		return YES;
	}
}
*/
+(NSString *)formatForDataBase:(NSString *)str
{
	str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
	str = [str stringByReplacingOccurrencesOfString:@"`" withString:@"\\'"];
	return [str stringByReplacingOccurrencesOfString:@"\"" withString:@"\\'"];
}

+(NSString *)getDayTimeFromDate:(NSDate *)localDate
{
	int hour = [[localDate convertDateToStringWithFormat:@"H"] intValue];
	if(hour>=4 && hour < 12)
		return @"Morning";
	else if(hour>=12 && hour < 16)
		return @"Afternoon";
	else if(hour>=16 && hour < 20)
		return @"Evening";
	else 
		return @"Night";
	
}

+(int)getMoneyValueFromText:(NSString *)money 
{
	if([[money substringToIndex:1] isEqualToString:@"$"])
		money = [money substringFromIndex:1];
	return [money intValue];
}

+ (UIImage *)imageWithImage:(UIImage *)image newSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString *)convertImgToBase65String:(NSData *)data height:(int)height
{
	UIImage *img = [UIImage imageWithData:data];
	CGSize newSize;
	newSize.height=height;
	newSize.width=height;
	
	UIImage *newImg = [ObjectiveCScripts imageWithImage:img newSize:newSize];
	NSData *imgData = UIImageJPEGRepresentation(newImg, 1.0);
	return [NSString base64StringFromData:imgData length:(int)[imgData length]];
}

+(void)showActionSheet:(id)delegate view:(UIView *)view title:(NSString *)title buttons:(NSArray *)buttons
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	for(NSString *buttonName in buttons)
		[actionSheet addButtonWithTitle:buttonName];
	[actionSheet addButtonWithTitle:@"Cancel"];
	[actionSheet showInView:view];
	
	//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
}

int randomSort(id obj1, id obj2, void *context) {
	return random()%3-1;
}

-(NSArray *)shuffle:(NSMutableArray *)array
{
	[array sortUsingFunction:randomSort context:nil];
	return array;
}

+(NSArray *)getPiecesArray
{
    NSArray *sp_pieces = [NSArray arrayWithObjects:@"Empty|||",
                          @"1|Artillery|art.gif|Ground|5||1|2|1|0|2|Y||Launch a powerful bombardment of an adjacent land or sea zone. Does not face counter-attack.|2|vehicle|3|",
                          @"2|Infantry|infantry.gif|Ground|3|Y|1|1|2|0|1|Y||Inexpensive and relatively good at defense. Weak attack value.|1|soldier|0|",
                          @"3|Tank|tank.gif|Ground|5||2|3|2|0|2|Y||Powerful attack piece and can move up to 2 spaces per turn.|4|vehicle||",
                          @"4|Transport|transport.gif|Sea|8|Y|2|0|1|4|0|Y||Used to carry troops over water|6|transport||",
                          @"5|Submarine|sub.gif|Sea|8|Y|2|2|2|1|0|Y||Attacks and defends sea zones.|7|ship||",
                          @"6|Fighter|fighter.gif|Air|10||4|3|4|0|2|Y||Good at attack and defense. Must return to the same territory after attacking.|8|fighter|0|",
                          @"7|Bomber|bomber.gif|Air|15||6|4|1|2|0|Y||Powerful attack, but weak defense. Can also carry up to 2 infantry as paratroopers.|9|bomber||",
                          @"8|Aircraft Carrier|carrier.gif|Sea|12|Y|2|1|3|4|0|Y||Strong defense plus can carry up to 2 fighter planes.|9|transport|0|",
                          @"9|Battle Cruiser|battleship.gif|Sea|15||2|4|4|1|0|Y||Kings of the sea, have extremely strong attack and defend capabilities.|10|ship|0|",
                          @"10|General|general.gif|Ground|0||1|0|3|0|1|N||Doubles the attack strength of all infantry in the battle.|12|hero||",
                          @"11|National Ruler|ruler.gif|Ground|0||1|0|1|0|1|N||Boosts income by 10 I.C. as long as he is alive and outside the capital. Also all tanks & infantry defend at 3 if leader is present.|12|hero||",
                          @"12|Super Battle Cruiser|s_battleship.gif|Sea|15||2|4|4|1|0|Y||Mighty upgradable battleship. Limit 1 per player.|11|ship||",
                          @"13|Air Defense|ad.gif|Ground|5||1|0|0|0|2|Y||Defense against planes and nukes.|99|aa||N",
                          @"14|Nuclear Missile|nuke.gif|Ground|20||1|4|0|0|2|Y||Destroys between 4-24 pieces instantly when used.|99|missile|4|N",
                          @"15|Factory|factory.gif|Building|15||0|0|0|0|0|Y||Acts as gateway for new pieces. Add a second factory to boost your income by 5 IC per turn.|99|building||N",
                          @"16|Upgd - Railway|upgrade.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"17|Upgd - Balistics|upgrade.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"18|Technology|tech.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"19|Economic Center|econ.gif|Building|15||0|0|0|0|0|Y||Boosts income by 5 IC per turn.|99|building||N",
                          @"20|Humvee|humvee.gif|Ground|4|N|2|2|3|0|2|N||United States: Inexpensive, mobile with a strong defense.|3|vehicle||",
                          @"21|Sniper|sniper.gif|Ground|3|N|1|3|1|0|1|N||European Union: Can only hit soldiers. Casualties do not get to return fire.|0|soldier|0|",
                          @"22|Mig 29|mig29.gif|Air|5|N|2|3|2|0|0|N||Russian Republic: Inexpensive with half the range of a fighter.|4|fighter||",
                          @"23|Kamakazi Plane|jap_fighter.gif|Air|5|N|4|6|1|0|0|N||Imperial Empire: Attacks a single transport, plane or vehicle choosing a target at random. No other ships or pieces can be targets. Both units are casualties.|1|fighter|0|",
                          @"24|Missile Launcher|nuke_cannon.gif|Ground|7|N|1|2|1|0|2|N||Communist Dynasty: Attacks same as artillery except 5 dice needing 2 or less to hit. Upgradable with technology. Requires Infantry or tanks as spotters.|3|vehicle|5|",
                          @"25|Jihad Bomber|terrorist.gif|Ground|5|N|1|6|1|0|1|N||Middle East Federation: Instantly kills self and 2-4 enemy units when attacking. They can attack from transports and no longer require spotters.|2|soldier|0|",
                          @"26|RPG Soldier|rpg.gif|Ground|4|N|1|2|2|0|1|N||African Coalition: Targets tanks on attack and defense.|3|soldier|0|",
                          @"27|Destroyer|destroyer.gif|Sea|10|N|3|3|3|0|0|N||Latin Alliance: Fast with strong attack and defense. All ships in fleet Can return fire when hit by a submarine.|8|ship||",
                          @"28|Medic||Ground|5|N|1|0|1|0|2|N||United States: Heals 1 infantry casualty per battle on offense or defense. Will return to previous country after healing a unit. Once used, he will not be able to heal again until your next turn.|3|soldier||",
                          @"29|Helicopter||Air|6|N|2|2|1|0|1|N||European Union: Attacks on land, sea and air. Subject to air defense. Can occupy a territory by itself.|5|chopper|0|",
                          @"30|Stinger Soldier||Ground|4|N|1|2|2|0|0|N||Russian Republic: Will target planes first, but can hit any piece encountered.|3|soldier||",
                          @"31|Flame Thrower||Ground|3|N|1|2|1|0|0|N||Imperial Empire: Strong attack piece with 2 dice, but can only hit soldiers.|0|soldier|2|",
                          @"32|Insurgent Mob||Ground|2|N|1|0|1|0|2|N||Communist Dynasty: Cheap, disposable pieces used for cannon fodder that can only hit soldiers. When accompanied by a general or when attacking with 8 or more, they will attack at a 1, otherwise no attack at all.|0|soldier|0|",
                          @"33|Scud Launcher||Ground|8|N|1|3|1|0|1|N||Middle East Federation: Fights like artillery only with 4 dice needing 3 to hit. Upgradable with technology. Requires infantry or tank spotters.|3|vehicle|4|",
                          @"34|Rocket Buggy||Ground|6|N|2|4|2|0|1|N||African Coalition: Strong attack piece and weak defender. Targets tanks when fighting.|4|vehicle|0|",
                          @"35|Special Ops||Ground|3|N|1|4|1|0|0|N||Latin Alliance: These units sneak into enemy territory and place exposives then return before the battle begins. They are immune to enemy fire and cannot occupy a territory. Since they have to return, they are unable to attack from ships.|2|soldier|0|",
                          @"36|Apache||Air|10|N|2|3|3|0|2|N||United States: Attacks in air, sea and land. Can occupy a territory by itself.|8|chopper|0|",
                          @"37|Nuke Cannon||Ground|10|N|1|4|1|0|1|N||Russian Republic: Rolls 4 dice needing 4 or less to hit.|3|vehicle|4|",
                          @"38|Cruiser||Sea|10|N|2|3|3|0|0|N||Imperial Empire: Attacks and defends at a 3. Comes equiped with an AD gun and cruise missiles.|8|ship||",
                          @"39|Chemical Bomb||Ground|10|N|1|6|3|0|0|N||African Coalition: Destroys itself and 5-9 enemy infantry in the first round of attack. Targets all soldier class units but will not hit vehicles, planes or other unit types.|3|vehicle|0|",
                          @"40|Hijacker||Ground|10|N|1|6|3|0|2|N||Middle East Federation: Converts 1 plane or vehicle when attacking, then retreats back to previous country. Normal defense.|6|soldier|0|",
                          @"41|Predator Drone||Air|10|N|6|3|1|0|1|N||Latin Alliance: Can fly out 3 spaces and attack any land territory with 2 dice, needing 3 or less to hit. Can ONLY be shot down by Air Defense when attacking. Makes single attack, then flies home. Targets vehicles with technology.|3|fighter|2|",
                          @"42|Battlemaster||Ground|10|N|1|4|4|0|1|N||Communist Dynasty: Powerful tank. 3 dice on attack, defends at a 4.|5|vehicle|3|",
                          @"43|Striker||Ground|10|N|2|3|4|0|0|N||European Union: 2 dice on attack. Has air defense built in and targets vehicles.|5|vehicle|2|",
                          @"44|Terminator|terminator.gif|Ground|11||1|4|2|||N|10/9/2009|Powerful attack piece that targets soldiers.|8|soldier|3|Y",
                          @"45|Navy Seal|800pxusnavysealswithlaserdesignator.jpg|Ground|10||2|4|1|||N|10/17/2009|Precision attack piece, can overwelm a defense quickly.|5|soldier|2|Y",
                          @"46|A-10 Warthog|a10.jpg|Air|15||4|3|3|||N|10/29/2009|A heavily armed fighter with mulitiple attacks that targets tanks.|8|fighter|3|Y",
                          @"47|F-15 Eagle|f15eagle1.jpg|Air|19||6|3|3|||N|11/14/2009|Air supremecy fighter. Armed with AIM-120 AMRAAMs (represented by AD) it can shoot down enemy fighters before being threatened. Gets 2 attacks and targets planes when attacking.|8|fighter|2|Y",
                          @"48|Blue Thunder|btmodel2.jpg|Air|10||2|3|2|||N|12/24/2009|Heavy Advanced Attack Chopper|8|chopper|2|Y",
                          @"49|Artillery Killer|blackhawk.jpg|Air|18||2|3|1|||N|1/14/2010|A chopper that targets artillery first.|8|chopper|5|Y",
                          @"50|KA-52 Alligator|kamov_ka52_alligator.jpg|Air|12||2|4|1|||N|2/6/2010|Long-ranged tank killer.|10|chopper|2|Y",
                          @"51|Lockheed AC-130|ac130.jpg|Air|17||6|4|1|||N|2/15/2010|The AC-130 gunship is a heavily-armed ground attack airplane|10|fighter|3|Y",
                          @"52|AH-64D Longbow|ah64d_longbow.jpg|Air|20||2|4|5|||N|2/20/2010|Fast moving tank killer|10|chopper|3|Y",
                          @"53|Sea King|mi24hindhelicopter.jpg|Air|10||2|5|3|||N|2/21/2010|A fast and agile offensive weapon|9|chopper|1|Y",
                          @"54|RAH-66|apachi.gif|Air|20||2|5|5|||N|5/30/2010|A strong defence and attack chopper|8|chopper|2|Y",
                          @"55|RAH-66|rah66comanchehelicopterwallpapersize600x450.jpg|Air|22||2|4|4|||N|6/2/2010|A fast and strong attack and defence chopper|10|chopper|3|Y",
                          @"56|The Ninja|images.jpg|Air|18||3|3|1|||N|6/11/2010|Sneaky and Tactical|8|bomber|3|Y",
                          @"57|Cobra Rattller|cobrarattler.jpg|Air|22||6|5|3|||N|6/22/2010|Hell bent on World Ctrl..|8|fighter|3|Y",
                          @"58|Hvy. Missile Cruiser|missile_ship.png|Sea|22||2|4|2|||N|6/29/2010|A heavy offensive vessel with shore bombardment capabilities but a relatively weak defense.|11|ship|4|Y",
                          @"59|Sea Shadow|sea_shadow.jpg|Sea|22||3|5|3|||N|7/15/2010|A stealth submarine armed with multiple SAMs and SSMs. Primarily designed as a swift and deadly First Strike weapon to neutralize opposing air force. Prepare your coffins...|12|ship|2|Y",
                          @"60|FA-22 Raptor|300pxlockheedmartinf22araptorjsoh.jpg|Air|21||4|5|5|||N|8/26/2010|Air Superiority Fighter|9|fighter|3|Y",
                          @"61|B52|b17c_icon.jpg|Air|13||6|5|1|||N|9/11/2010|Durable, relatively inexpensive and built in vast quantities by Boeing the The B-52, Models A-H, have been in active service with the USAF since 1955.|9|bomber|1|Y",
                          @"62|M1 Abrams|m1abrams.png|Ground|16||2|4|4|||N|10/5/2010|Strong tank with high defence and attack|10|vehicle|3|Y",
                          @"63|G.I. Joe|gi_joe_roadblock.jpg|Ground|10||1|1|1|||N|10/8/2010|Spreading a blanket of rounds it's almost certain to hit something. Gun points skyward before bearing down on other soldiers.|8|soldier|5|Y",
                          @"64|Combat Engineers|thumbnailcamfs2s5.jpg|Ground|10||2|2|4|||N|3/17/2011|With an array of heavy equipment, mines, ATMs and SAMs, this unit can hold ground better than any other. Will target vehicles and air assets first.|4|vehicle|1|Y",
                          @"65|Scooter|scooter.jpg|Ground|10||3|3|2|||N|5/13/2011|Fast land vehicle designed to hit quickly across distance|9|vehicle|2|Y",
                          @"66|Little Bird|apachi.gif|Air|10||2|5|2|||N|6/12/2011|Special Operations helicopter unit.|8|chopper|1|Y",
                          @"68|Merkava Mk IV|merkava.jpg|Ground|14||2|5|4|||N|3/24/2012|MBT of the Israel Defense Force. With a strong attack and defence. Designed to destroy enemy tanks on the battlefield it is also equipped to deal with infantry attacks.|8|vehicle|2|Y",
                          nil];
    return sp_pieces;
}

+(NSString *)getNameOfPiece:(int)number
{
    NSArray *pieces = [ObjectiveCScripts getPiecesArray];
    if([pieces count]>number) {
        NSString *line = [pieces objectAtIndex:number];
        NSArray *components = [line componentsSeparatedByString:@"|"];
        return [components objectAtIndex:1];
    }
    return nil;
}

+(NSString *)getTypeOfPiece:(int)number
{
    NSArray *pieces = [ObjectiveCScripts getPiecesArray];
    if([pieces count]>number) {
        NSString *line = [pieces objectAtIndex:number];
        NSArray *components = [line componentsSeparatedByString:@"|"];
        return [components objectAtIndex:3];
    }
    return nil;
}

+(int)getPriceOfPiece:(int)number
{
    NSArray *pieces = [ObjectiveCScripts getPiecesArray];
    if([pieces count]>number) {
        NSString *line = [pieces objectAtIndex:number];
        NSArray *components = [line componentsSeparatedByString:@"|"];
        return [[components objectAtIndex:4] intValue];
    }
    return 0;
}

+(NSString *)getPurchaseString {
    return @"0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0";
}

+(NSString *)getNationNameFromId:(int)terrId
{
    NSArray *nations = [ObjectiveCScripts getNations];
    return [nations objectAtIndex:terrId];
}

+(NSArray *)getNations {
    return [NSArray arrayWithObjects:
            @"Empty",
            @"Eastern USA",
            @"Central USA",
            @"Midwest USA",
            @"Western USA",
            @"Alaska",
            @"Hawaii",
            @"Germany",
            @"France",
            @"Spain",
            @"United Kingdom",
            @"Sweden Finland",
            @"Southern Europe",
            @"Russia",
            @"Karelia",
            @"Chechnya",
            @"Caucasus",
            @"Kazakhstan",
            @"Taimyr",
            @"Novosibirsk",
            @"Siberia",
            @"Japan",
            @"Far East",
            @"Okhotsk",
            @"Manchuria",
            @"Peiping",
            @"Taiwan",
            @"Marshall Islands",
            @"Indo-China",
            @"Tibet",
            @"China",
            @"Hong Kong",
            @"Philippines",
            @"Borneo",
            @"Indonesia",
            @"Saudi Arabia",
            @"Turkey",
            @"Syria-Iraq",
            @"Iran",
            @"Afghan-Pakistan",
            @"Egypt",
            @"Libya",
            @"Congo",
            @"West Africa",
            @"Nigeria",
            @"Chad",
            @"Sudan",
            @"Ethiopia",
            @"Kenya",
            @"South Africa",
            @"Brazil",
            @"Mexico",
            @"Panama",
            @"Venezuela",
            @"Peru",
            @"Argentina",
            @"British Columbia",
            @"Central Canada",
            @"Quebec",
            @"Greenland",
            @"Iceland",
            @"Norway",
            @"Ukraine",
            @"Georgia",
            @"Mongolia",
            @"Guam",
            @"Solomon Isls",
            @"New Guinea",
            @"New Zealand",
            @"Austrailia",
            @"India",
            @"Madagascar",
            @"Mozambique",
            @"Angola",
            @"Algeria",
            @"Sierra Leone",
            @"Falkland Isls",
            @"Bolivia",
            @"Cuba",
            @"Alaska Waters",
            @"Gulf of Alaska",
            @"North Pacific Waters",
            @"Western USA Waters",
            @"Hawaii Waters",
            @"S Hawaii Waters",
            @"W. Mexico Waters",
            @"W. Panama Waters",
            @"South Pacific NW",
            @"South Pacific NE",
            @"South Pacific SW",
            @"South Pacific SE",
            @"Peru Waters",
            @"W. Argentina Waters",
            @"E. Argentina Waters",
            @"South Atlantic",
            @"Angola Waters",
            @"Congo Waters",
            @"Sierra Waters",
            @"Brazil Waters",
            @"Cuba Waters",
            @"Gulf of Mexico",
            @"E USA Waters",
            @"North Atlantic N",
            @"North Atlantic S",
            @"West Africa Waters",
            @"Spain Waters",
            @"Quebec Waters",
            @"Labrador Sea",
            @"Hudson Bay",
            @"Denmark Straight",
            @"North Sea",
            @"Arctic W",
            @"Arctic E",
            @"Finland Waters",
            @"Mediterraniean W",
            @"Mediterraniean E",
            @"Black Sea",
            @"Caspian Sea",
            @"Red Sea",
            @"Arabian Sea",
            @"Bay of Bengal",
            @"Kenya Waters",
            @"Mozam Waters",
            @"South African Waters",
            @"South Indian Ocean",
            @"Indian Ocean NW",
            @"Indian Ocean NE",
            @"Indian Ocean SW",
            @"Indian Ocean SE",
            @"Timor Sea",
            @"Indoneasia Waters",
            @"Indo-China Waters",
            @"Coral Sea",
            @"New Zealand waters",
            @"Borneo Waters",
            @"New Guinea Waters",
            @"Solomon Island Waters",
            @"Philippine Waters",
            @"South China Sea",
            @"Taiwan Waters",
            @"Marshall Waters",
            @"Sea of Japan",
            @"E Japan Waters",
            @"Guam Waters",
            @"Bering Sea", nil];
}

+(int)getNationId:(NSString *)nationName {
    NSArray *nations = [ObjectiveCScripts getNations];
    int i=0;
    for(NSString *name in nations) {
        if([name isEqualToString:nationName])
            return i;
        i++;
    }
    return 0;
}

+(UIImage *)getImageForPiece:(int)piece
{
    if(piece!=12 && piece<=14)
        return [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.png", piece]];
    else
        return [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.gif", piece]];
}

+(NSString *)getSuperpowerNameFromId:(int)nation {
    NSArray *names = [NSArray arrayWithObjects:
                      @"Empty",
                      @"United States",
                      @"European Union",
                      @"Russian Republic",
                      @"Imperial Japan",
                      @"Communist China",
                      @"Middle-East Federation",
                      @"African Coalition",
                      @"Latin Alliance",
                      nil];
    return [names objectAtIndex:nation];
}

+(void)addColorToButton:(UIButton *)button color:(UIColor *)color
{
	CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];
	
	float colorAmount = red+green+blue;
	
	[button setBackgroundImage:[ObjectiveCScripts imageFromColor:color]
					  forState:UIControlStateNormal];
	
	if (colorAmount > 1.5)
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	else
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	button.layer.borderColor = [UIColor blackColor].CGColor;
	
	button.layer.masksToBounds = YES;
	button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 8.0f;
}

+ (UIImage *) imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIBarButtonItem *)navigationButtonWithTitle:(NSString *)title selector:(SEL)selector target:(id)target
{
	float fontSize=14;
	int width=40+(int)title.length*7;
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImage:[UIImage imageNamed:@"yellowChromeBut.png"] forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
	//	button.titleLabel.shadowColor = [UIColor colorWithRed:1 green:1 blue:.9 alpha:1];
	//	button.titleLabel.shadowOffset = CGSizeMake(-1.0, -1.0);
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	button.frame = CGRectMake(0, 0, width, 34);
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
	return barButton;
}

+(UIColor *)colofForNation:(int)nation {
	switch (nation) {
  case 0:
			return [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
			break;
  case 1:
			return [UIColor colorWithRed:.8 green:.8 blue:1 alpha:1];
			break;
  case 2:
			return [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];
			break;
  case 3:
			return [UIColor colorWithRed:1 green:.7 blue:.5 alpha:1];
			break;
  case 4:
			return [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];
			break;
  case 5:
			return [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
			break;
  case 6:
			return [UIColor colorWithRed:1 green:1 blue:.5 alpha:1];
			break;
  case 7:
			return [UIColor colorWithRed:1 green:.8 blue:1 alpha:1];
			break;
  case 8:
			return [UIColor colorWithRed:.8 green:1 blue:1 alpha:1];
			break;
			
  default:
			break;
	}
	return [UIColor whiteColor];
}












@end
