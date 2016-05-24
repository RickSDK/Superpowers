//
//  GamesVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamesVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "GameScreenVC.h"
#import "NSArray+ATTArray.h"
#import "CreateNewGameVC.h"
#import "gameInitialVC.h"
#import "LadderDetailsVC.h"
#import "GameCell.h"
#import "LeadersVC.h"
#import "GameObj.h"



@implementation GamesVC

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Games"];
	
	
	if(![ObjectiveCScripts getUserDefaultValue:@"newGames"])
	{
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"newGames"];
		[ObjectiveCScripts showAlertPopup:@"Welcome to the Games!" :@"Check the open games to join, or press the + button to host one. Games are turn based and you typically only take one turn per day."];
	}
	
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createPressed:)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	[self doWebRequest];
	
	
}
/*
-(void)checkWebLogin
{
	@autoreleasepool {
		NSString *response = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/verifyLogin.php"];
		self.loginObj = [LoginObj objectFromLine:response];
		NSLog(@"response: %@", response);
		
		if(self.loginObj.count==0) {
			self.joinButton.alpha=1;
			self.leagueButton.alpha=1;
		}
		
		if(self.loginObj.successFlg) {
			[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"serverUp"];
		} else
			[ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
	}
}
*/
- (void) createPressed: (id) sender
{
	if(self.loginObj.level<=1) {
        [ObjectiveCScripts showAlertPopup:@"Notice" :@"You must complete training before playing a real game."];
		return;
	}
	CreateNewGameVC *detailViewController = [[CreateNewGameVC alloc] initWithNibName:@"CreateNewGameVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) joinButtonPressed: (id) sender
{
    self.joinButton.alpha=0;
    self.leagueButton.alpha=0;
    [WebServicesFunctions sendRequestToServer:@"mobileJoinLeague.php" forGame:0 andString:@"" andMessage:@"You have joined!" delegate:self];
 
}

-(void)webRequest
{
	@autoreleasepool {
    
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"version", nil];
		NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], [ObjectiveCScripts getProjectDisplayVersion], nil];
		NSString *webAddr = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/web_games2.php?type=%d", (int)self.mainSegment.selectedSegmentIndex];
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
		
		int numOpenGames=0;
		if([WebServicesFunctions validateStandardResponse:responseStr :self]) {
			NSArray *games = [responseStr componentsSeparatedByString:@"<a>"];
			if([games count]>0) {
				NSArray *components = [[games objectAtIndex:0] componentsSeparatedByString:@"|"];
				if([components count]>1) {
					numOpenGames = [[components objectAtIndex:1] intValue];
					self.openGamesLabel.text=[NSString stringWithFormat:@"%d", numOpenGames];
				}
				if([components count]>2) {
					NSString *challenge = [components objectAtIndex:2];
					if([challenge length]>0) {
						NSArray *chalComp = [challenge componentsSeparatedByString:@":"];
						if([chalComp count]>1) {
							self.challengeId = [[chalComp objectAtIndex:0] intValue];
							self.buttonNumber=1;
							[ObjectiveCScripts showAcceptDeclinePopup:@"Notice!" message:[NSString stringWithFormat:@"You have been challenged to a 1v1 game by %@", [chalComp objectAtIndex:1]] delegate:self];
						}
					}
				}
			}
			for(NSString *game in games) {
				if(game.length>30) {
					[self.mainArray addObject:[GameObj objectFromLine:game]];
				}
			}
			
			
    }

		
		if([self.mainArray count]==0 && self.mainSegment.selectedSegmentIndex==0) {
			self.mainSegment.selectedSegmentIndex=1;
			[self.mainSegment changeSegment];
			if(numOpenGames>0) {
				[self doWebRequest];
				return;
			}
		}
  

    if([self.mainArray count]==0 && self.mainSegment.selectedSegmentIndex==1)
			[ObjectiveCScripts showAlertPopup:@"No open games" :@"No games right now. Start one yourself by hitting the + button! May take a day or 2 for it to fill up."];

    if(self.loginObj.level==2 && [self.mainArray count]==0 && self.mainSegment.selectedSegmentIndex==0)
        [ObjectiveCScripts showAlertPopup:@"Welcome to the Games!" :@"Press the 'Open' tab to see if any games are ready to join, or press '+' button to start your own."];
		
	}
	
	self.gamesLabel.text = [NSString stringWithFormat:@"%d", (int)[self.mainArray count]];
	[self stopWebService];
	[self.mainTableView reloadData];


}


-(void)webRequestJoin
{
	@autoreleasepool {
	
		if(self.selectedRow>=self.mainArray.count) {
			[ObjectiveCScripts showAlertPopup:@"Whoa" :@"Something messed up!"];
			NSLog(@"+++%d games", (int)self.mainArray.count);
			return;
		}
		GameObj *game = [self.mainArray objectAtIndex:self.selectedRow];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"game_id", nil];
		NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], [NSString stringWithFormat:@"%d", game.gameId], nil];
		NSString *webAddr = @"http://www.superpowersgame.com/scripts/web_join_game.php";
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
		
		if([responseStr isEqualToString:@"Success"])
			[ObjectiveCScripts showAlertPopup:@"Success!" :@""];
		else
			[ObjectiveCScripts showAlertPopup:@"Error" :responseStr];
		
		[self stopWebService];
		[self doWebRequest];

	}
	
}

- (IBAction) segmentChanged: (id) sender
{
	[super segmentChanged:sender];
	[self doWebRequest];
}

-(void)doWebRequest {
	[self.mainArray removeAllObjects];
	[self startWebService:@selector(webRequest) message:nil];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 124;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
	
	GameCell *cell = [[GameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	if(self.mainArray.count>indexPath.row) {
		GameObj *game = [self.mainArray objectAtIndex:indexPath.row];
		[GameCell populateCell:cell game:game row:indexPath.row];
	}
	
	return cell;
	
}	

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"+++%d games", (int)self.mainArray.count);
    if(self.buttonNumber==1) {
        self.buttonNumber=0;
        if(buttonIndex==0) {
            NSLog(@"decline: %d", self.challengeId);
            [WebServicesFunctions sendRequestToServer:@"mobileDeclineChallenge.php" forGame:self.challengeId andString:@"" andMessage:@"You have declined!" delegate:self];

        } else {
            NSLog(@"accepted");
            [WebServicesFunctions sendRequestToServer:@"mobileAcceptChallenge.php" forGame:self.challengeId andString:@"" andMessage:@"You have accepted!" delegate:self];
        }
        return;
    }
	if(buttonIndex==1)
		[self startWebService:@selector(webRequestJoin) message:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	self.selectedRow=(int)indexPath.row;
    // Navigation logic may go here. Create and push another view controller.
	GameObj *game = [self.mainArray objectAtIndex:indexPath.row];
	NSLog(@"+++game: %d %d", game.gameId, game.round);

	if(self.mainSegment.selectedSegmentIndex==1) {
		if(self.loginObj.level<=2) {
			[ObjectiveCScripts showAlertPopup:@"Noteice" :@"You must complete a single player game before playing against people."];
			return;
		}
		[ObjectiveCScripts showConfirmationPopup:@"Join this Game?" :@"" :self];
		return;
	}
	if(game.gameId>0) {
		gameInitialVC *detailViewController = [[gameInitialVC alloc] initWithNibName:@"gameInitialVC" bundle:nil];
		detailViewController.gameName = game.name;
		detailViewController.gameId = game.gameId;
		detailViewController.gameObj=game;
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}

- (IBAction) leagueButtonPressed: (id) sender {
	LeadersVC *detailViewController = [[LeadersVC alloc] initWithNibName:@"LeadersVC" bundle:nil];
    detailViewController.ladderFlg=YES;
	[self.navigationController pushViewController:detailViewController animated:YES];
    
}





@end
