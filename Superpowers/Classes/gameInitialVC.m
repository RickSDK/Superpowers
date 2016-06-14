//
//  gameInitialVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/10/13.
//
//

#import "gameInitialVC.h"
#import "GameScreenVC.h"
#import "GameViewsVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "GameDetailsVC.h"
#import "PlayerAttackVC.h"
#import "PlayerCell.h"
#import "ChooseNationVC.h"
#import "PlayerObj.h"
#import "HistoryVC.h"
#import "GameChatVC.h"

@interface gameInitialVC ()

@end

@implementation gameInitialVC
@synthesize gameName, gameId, skipTurnFlg, buttonNumber, mainTableView, chatButton, attRoundLabel, cancelGameFlg;
@synthesize roundLabel, techButton, alliesButton, timerLabel, playerTurn, gameStatus, logsButton, startGameFlg;
@synthesize activityIndicator, activityLabel, activityPopup, gametypeLabel;
@synthesize aiButton, surrenderButton, mapButton, gameDetailsString, gameObj;

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitle:self.gameName];
	
	self.gameObj = [GameObj new];
	
	mapButton.enabled=NO;
	self.accountSitButton.enabled=NO;
	
	self.navigationItem.rightBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:@"Details" selector:@selector(detailsButtonClicked:) target:self];
	
	[ObjectiveCScripts addColorToButton:self.chatButton color:[UIColor blueColor]];
	
	[ObjectiveCScripts addColorToButton:self.aiButton color:[UIColor colorWithRed:1 green:.8 blue:0 alpha:1]];
	[ObjectiveCScripts addColorToButton:self.surrenderButton color:[UIColor colorWithRed:1 green:.8 blue:0 alpha:1]];
	
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if([ObjectiveCScripts getUserDefaultValue:@"AccountSitUsername"].length>0)
		[self resetLogin];
	
	[self loadMainView];
	
}



-(void)gotoView:(int)screenNum {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.gameName = self.gameName;
    detailViewController.gameId = gameId;
    detailViewController.screenNum = screenNum;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) logsButtonClicked: (id) sender {
    [self gotoView:1];
}
- (IBAction) techButtonClicked: (id) sender {
    [self gotoView:2];
}
- (IBAction) alliesButtonClicked: (id) sender {
    [self gotoView:3];
}
- (IBAction) chatButtonClicked: (id) sender {
	GameChatVC *detailViewController = [[GameChatVC alloc] initWithNibName:@"GameChatVC" bundle:nil];
	detailViewController.gameObj=self.gameObj;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) mapButtonClicked: (id) sender {
	
	activityPopup.alpha=1;
	activityLabel.alpha=1;
	[activityIndicator startAnimating];
	self.mapButton.enabled=NO;

	[self performSelectorInBackground:@selector(gotoGameScreenBG) withObject:nil];
}

-(void)gotoGameScreenBG {
	[self performSelectorOnMainThread:@selector(gotoGameScreen) withObject:nil waitUntilDone:YES];
}

-(void)gotoGameScreen {
	GameScreenVC *detailViewController = [[GameScreenVC alloc] initWithNibName:@"GameScreenVC" bundle:nil];
	detailViewController.gameId = gameId;
	detailViewController.gameObj=self.gameObj;
	detailViewController.gameDetailsString = self.gameDetailsString;
	detailViewController.playerTurn=self.playerTurn;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)aiGo
{
	@autoreleasepool {
    
		[NSThread sleepForTimeInterval:2];
		
		activityPopup.alpha=0;
		activityLabel.alpha=0;
		[activityIndicator stopAnimating];
    self.buttonNumber=3;
		[ObjectiveCScripts showAlertPopupWithDelegate:@"Done" :@"" :self];
	}
}

-(void)playerSurrender
{
	@autoreleasepool {
    
        [WebServicesFunctions sendRequestToServer:@"mobileSurrender.php" forGame:self.gameId andString:@"" andMessage:@"You Have Surrendered!" delegate:self];
        
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	[activityIndicator stopAnimating];
        
        self.buttonNumber=3;
    
	
	}
}

-(void)playerLeave
{
	@autoreleasepool {
    
        [WebServicesFunctions sendRequestToServer:@"mobileLeave.php" forGame:self.gameId andString:@"" andMessage:@"You Have Left the game" delegate:self];
        
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	[activityIndicator stopAnimating];
        
        self.buttonNumber=3;
    
	
	}
}

-(void)playerCancel
{
	@autoreleasepool {
    
        [WebServicesFunctions sendRequestToServer:@"mobileCancel.php" forGame:self.gameId andString:@"" andMessage:@"Game Cancelled" delegate:self];
        
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	[activityIndicator stopAnimating];
        
        self.buttonNumber=3;
    
	
	}
}

-(void)resetLogin {
	NSLog(@"Resetting Login");
	NSString *username = [ObjectiveCScripts getUserDefaultValue:@"AccountSitUsername"];
	[ObjectiveCScripts setUserDefaultValue:@"" forKey:@"AccountSitUsername"];
	[ObjectiveCScripts setUserDefaultValue:username forKey:@"userName"];
	
	NSArray *nameList = [NSArray arrayWithObjects:@"userName", nil];
	NSArray *valueList = [NSArray arrayWithObjects:username, nil];
	NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileForceLogin.php":nameList:valueList];
	NSLog(@"%@", response);
}

- (void)accountSit {
	@autoreleasepool {
		NSString *username = [ObjectiveCScripts getUserDefaultValue:@"userName"];
		[ObjectiveCScripts setUserDefaultValue:username forKey:@"AccountSitUsername"];
		[ObjectiveCScripts setUserDefaultValue:self.gameObj.turnName forKey:@"userName"];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"userName", nil];
		NSArray *valueList = [NSArray arrayWithObjects:self.gameObj.turnName, nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileForceLogin.php":nameList:valueList];

		self.buttonNumber=12;
		[ObjectiveCScripts showAlertPopupWithDelegate:response :@"" :self];
		
	}
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(self.buttonNumber==12) {
		GameScreenVC *detailViewController = [[GameScreenVC alloc] initWithNibName:@"GameScreenVC" bundle:nil];
		detailViewController.gameId = gameId;
		detailViewController.gameObj=self.gameObj;
		detailViewController.gameDetailsString = self.gameDetailsString;
		detailViewController.playerTurn=self.playerTurn;
		[self.navigationController pushViewController:detailViewController animated:YES];
		return;
	}

	if(self.buttonNumber==11) {
		if(alertView.cancelButtonIndex != buttonIndex) {
			self.accountSitButton.enabled=NO;
			[self performSelectorInBackground:@selector(accountSit) withObject:nil];
		}
		return;
	}
	if(self.buttonNumber==3) {
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
	}

    if(buttonIndex==1) {
        if(self.buttonNumber==1) {
            int mode=11;
            if(self.surrenderButton.enabled)
                mode=6;
            if([@"Y" isEqualToString:self.skipTurnFlg])
                mode=14;
            if([@"Y" isEqualToString:self.startGameFlg])
                mode=15;
            
            self.aiButton.enabled=NO;
            PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
            detailViewController.gameId = self.gameId;
            detailViewController.callBackViewController=self;
            detailViewController.mode=mode;
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
        if(self.buttonNumber==2) {
            activityPopup.alpha=1;
            activityLabel.alpha=1;
            [activityIndicator startAnimating];
            
            if([@"C" isEqualToString:self.cancelGameFlg])
                [self performSelectorInBackground:@selector(playerCancel) withObject:nil];
            else if([@"L" isEqualToString:self.cancelGameFlg])
                [self performSelectorInBackground:@selector(playerLeave) withObject:nil];
            else
                [self performSelectorInBackground:@selector(playerSurrender) withObject:nil];
        }
    }
}

- (IBAction) aiButtonClicked: (id) sender {
    self.buttonNumber=1;
    
    if([@"Y" isEqualToString:self.startGameFlg]) {
        [ObjectiveCScripts showConfirmationPopup:@"Start Game?" :@"" :self];
        return;
    }
    if([@"Y" isEqualToString:self.skipTurnFlg]) {
		if(self.gameObj.currentTurnUserId==30)
			[ObjectiveCScripts showConfirmationPopup:@"Take Computer Turn?" :@"" :self];
		else
			[ObjectiveCScripts showConfirmationPopup:@"Skip Turn?" :@"Are you sure you want to skip this turn?" :self];
        return;
    }
    if(self.surrenderButton.enabled)
        [ObjectiveCScripts showConfirmationPopup:@"AI Take Turn!" :@"Are you sure you want the computer to take your turn?" :self];
    else
        [ObjectiveCScripts showConfirmationPopup:@"Computer Go?" :@"" :self];
}
- (IBAction) surrenderButtonClicked: (id) sender {
    if([@"Picking Nations" isEqualToString:self.gameStatus]) {
        ChooseNationVC *detailViewController = [[ChooseNationVC alloc] initWithNibName:@"ChooseNationVC" bundle:nil];
        detailViewController.gameId = self.gameId;
        [self.navigationController pushViewController:detailViewController animated:YES];
        return;
    }
    self.buttonNumber=2;
    
    if([@"C" isEqualToString:self.cancelGameFlg])
        [ObjectiveCScripts showConfirmationPopup:@"Cancel Game" :@"Are you sure you want to cancel this game?" :self];
    else if([@"L" isEqualToString:self.cancelGameFlg])
        [ObjectiveCScripts showConfirmationPopup:@"Leave" :@"Are you sure you want to leave this game?" :self];
        else
            [ObjectiveCScripts showConfirmationPopup:@"Surrender!" :@"Are you sure you want to surrender?" :self];
}

-(void)detailsButtonClicked:(id)sender {
    
    if([self.gameDetailsString length]>0) {
        GameDetailsVC *detailViewController = [[GameDetailsVC alloc] initWithNibName:@"GameDetailsVC" bundle:nil];
		detailViewController.gameObj=self.gameObj;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

-(void)displayNameLabel:(UILabel *)nameLabel name:(NSString *)name turn:(int)turn player:(int)player {
    if(turn==player) {
        nameLabel.text = [NSString stringWithFormat:@"*%@", name];
        nameLabel.textColor = [UIColor yellowColor];
    } else {
        nameLabel.text = name;
        nameLabel.textColor = [UIColor whiteColor];
    }
}


- (void)loadMapWebView {
	@autoreleasepool {
    
		NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileGetGameDetails.php?game_id=%d", gameId];
		NSString *result = [WebServicesFunctions getResponseFromWeb:weblink];
		
		[activityIndicator stopAnimating];
		activityLabel.alpha=0;
		activityPopup.alpha=0;

        NSLog(@"result: %@ ", result);
        if(result.length < 20) {
            [ObjectiveCScripts showAlertPopup:@"Error" :@"Site not responding. Try back soon"];
            return;
        }
		
		self.gameObj = [GameObj objectDetailsFromLine:result];
		self.gameObj.gameId=self.gameId;
		
        NSArray *components = [result componentsSeparatedByString:@"<br>"];
        
        if([components count]>1) {
            
			[self.aiButton setTitle:@"A.I. Take Turn" forState:UIControlStateNormal];
			[self.surrenderButton setTitle:@"Surrender" forState:UIControlStateNormal];
			
            self.gameDetailsString = [components objectAtIndex:0];
//			NSLog(@"gameDetailsString: %@", self.gameDetailsString);
			
            NSArray *gameDetails = [[components objectAtIndex:0] componentsSeparatedByString:@"|"];
 //           NSArray *players = [[components objectAtIndex:1] componentsSeparatedByString:@"<li>"];
            int userTurn=0;
            if([gameDetails count]>27) {
                self.cancelGameFlg = [gameDetails objectAtIndex:24];
				self.gameObj.turnName = [gameDetails objectAtIndex:25];
				self.accountSitButton.enabled = [@"Y" isEqualToString:[gameDetails objectAtIndex:26]];
				self.gameObj.accountSitReason = [gameDetails objectAtIndex:27];
                self.skipTurnFlg = [gameDetails objectAtIndex:22];
                if([@"Y" isEqualToString:self.skipTurnFlg]) {
					[ObjectiveCScripts addColorToButton:self.aiButton color:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
                    self.aiButton.enabled=YES;
					[self.aiButton setTitle:@"Skip Turn" forState:UIControlStateNormal];
               }
				self.gameObj.chatFlg=[[gameDetails objectAtIndex:17] isEqualToString:@"Y"];
                if(self.gameObj.chatFlg) {
					[ObjectiveCScripts addColorToButton:self.chatButton color:[UIColor yellowColor]];
                }
                
                if([@"Open" isEqualToString:[gameDetails objectAtIndex:1]]) {
                    mapButton.enabled=NO;
                    mapButton.alpha=0;
                    self.aiButton.enabled=NO;
                    self.surrenderButton.enabled=NO;
                    self.chatButton.enabled=NO;
                    self.logsButton.enabled=NO;
                    self.techButton.enabled=NO;
                    self.alliesButton.enabled=NO;
                } else
                    mapButton.enabled=YES;

                
                userTurn = [[gameDetails objectAtIndex:5] intValue];
				self.gameObj.currentTurnUserId=userTurn;
                roundLabel.alpha=1;
                roundLabel.text = [gameDetails objectAtIndex:3];
                self.gametypeLabel.text = [gameDetails objectAtIndex:8];
                self.attRoundLabel.text = [gameDetails objectAtIndex:18];
                self.timerLabel.text = [gameDetails objectAtIndex:19];
                int victoryRound = [[gameDetails objectAtIndex:20] intValue];
				NSString *status = [gameDetails objectAtIndex:1];
				int round = [[gameDetails objectAtIndex:3] intValue];
				int attackRound = [[gameDetails objectAtIndex:18] intValue];
				if(round==attackRound)
					[ObjectiveCScripts showAlertPopup:@"Attack Round!" :@"This is the attack round! Each player can lose at most one territory this round and you can only claim one player territory this round. Nuke attacks and bombing raids are NOT limited."];
				
                if(victoryRound>0 && [[gameDetails objectAtIndex:3] intValue]>4 && ![@"Complete" isEqualToString:status])
                    [ObjectiveCScripts showAlertPopup:@"Victory Conditions Met!" :[NSString stringWithFormat:@"A team has captured at least 6 capitals and the game will end in round %d unless they are stopped!", victoryRound]];
                
                NSString *countryAttacked = [gameDetails objectAtIndex:21];
                if([countryAttacked length]>0)
                    [ObjectiveCScripts showAlertPopup:@"You have been attacked!" :[NSString stringWithFormat:@"%@ has been attacked! Check the logs for complete list of attacks.", countryAttacked]];
				
                if([@"Time is up. Host can skip this turn." isEqualToString:[gameDetails objectAtIndex:19]])
                    self.timerLabel.text = @"Time is Up";
                self.playerTurn = [[gameDetails objectAtIndex:16] intValue];
                if([[gameDetails objectAtIndex:6] isEqualToString:@"Y"]) {
                    aiButton.enabled=YES;
                    surrenderButton.enabled=YES;
                }
                if([@"Complete" isEqualToString:[gameDetails objectAtIndex:1]]) {
                    aiButton.enabled=NO;
                    surrenderButton.enabled=NO;
                }
                self.gameStatus = [gameDetails objectAtIndex:1];
                if([@"Picking Nations" isEqualToString:self.gameStatus] && [@"Choosing" isEqualToString:[gameDetails objectAtIndex:15]]) {
                    aiButton.enabled=NO;
                    surrenderButton.enabled=YES;
					[self.surrenderButton setTitle:@"Choose" forState:UIControlStateNormal];
                }
                 if(![@"Purchase" isEqualToString:[gameDetails objectAtIndex:15]]) {
                    aiButton.enabled=NO;
                }
                if(userTurn==30) {
                    aiButton.enabled=YES;
					[self.aiButton setTitle:@"Computer Go" forState:UIControlStateNormal];
                    surrenderButton.enabled=NO;
                }
                
				NSLog(@"self.gameStatus %@", self.gameStatus);
				if([@"Open" isEqualToString:self.gameStatus]) {
					NSLog(@"start!");
					[self.aiButton setTitle:@"Start" forState:UIControlStateNormal];
				}

                if([@"C" isEqualToString:self.cancelGameFlg]) {
 					[self.surrenderButton setTitle:@"Cancel" forState:UIControlStateNormal];
                    surrenderButton.enabled=YES;
                }
                if([@"L" isEqualToString:self.cancelGameFlg]) {
 					[self.surrenderButton setTitle:@"Leave" forState:UIControlStateNormal];
                    surrenderButton.enabled=YES;
                }

                self.startGameFlg = [gameDetails objectAtIndex:23];
                if([@"Y" isEqualToString:self.startGameFlg]) {
					[ObjectiveCScripts addColorToButton:self.aiButton color:[UIColor colorWithRed:0 green:.8 blue:0 alpha:1]];
                    self.aiButton.enabled=YES;
                }
                
            }
            
            if([@"training" isEqualToString:[gameDetails objectAtIndex:8]]) {
                self.aiButton.enabled=NO;
                self.surrenderButton.enabled=NO;
                self.chatButton.enabled=NO;
                self.logsButton.enabled=NO;
                self.techButton.enabled=NO;
                self.alliesButton.enabled=NO;
                
                if([@"1" isEqualToString:[gameDetails objectAtIndex:3]]) {
                    [ObjectiveCScripts showAlertPopup:@"Welcome to Superpowers!" :@"You are the European Union and are playing against the computer, who is the Imperial Empire."];
                }
            }
        } else {
            [ObjectiveCScripts showAlertPopup:@"Error" :@"No response from server. Try back later."];
        }
	
        [self.mainTableView reloadData];
		
    

	}
}

-(void)loadMainView {
    [activityIndicator startAnimating];
    activityLabel.alpha=1;
    activityPopup.alpha=1;

    roundLabel.alpha=0;
    mapButton.enabled=NO;
    

    aiButton.enabled=NO;
    surrenderButton.enabled=NO;

    [self performSelectorInBackground:@selector(loadMapWebView) withObject:nil];
    
}

-(void)refreshMap {
//    [self loadMainView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if(cell==nil)
		cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	PlayerObj *playerObj = [self.gameObj.playerList objectAtIndex:indexPath.row];
	[PlayerCell populateCell:cell playerObj:playerObj playerTurn:self.playerTurn];

	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.gameObj.playerList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	PlayerObj *playerObj = [self.gameObj.playerList objectAtIndex:indexPath.row];
	
	if(playerObj.user_id != 30) {
		GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
		detailViewController.userId = playerObj.user_id;
		detailViewController.screenNum = 6;
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (IBAction) accountSitButtonClicked: (id) sender {
	self.buttonNumber=11;
	[ObjectiveCScripts showConfirmationPopup:@"Account Sit?" :[NSString stringWithFormat:@"Take %@'s turn?", self.gameObj.turnName] :self];
}


- (IBAction) infoButtonClicked: (id) sender {
	if(self.gameObj.accountSitReason.length>0)
		[ObjectiveCScripts showAlertPopup:@"Account Sit" :[NSString stringWithFormat:@"Once an ally's timer reaches 12 hours, you can take their turn for them.\n\nNot availble right now for this reason: %@", self.gameObj.accountSitReason]];
	else
		[ObjectiveCScripts showAlertPopup:@"Account Sit" :@"You are able to take this player's turn for them because you are an ally and the timer is down to 12 hours."];
}

- (IBAction) statsButtonClicked: (id) sender {
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
	detailViewController.gameName = self.gameObj.name;
	detailViewController.gameId = gameId;
	detailViewController.screenNum = 12;
	[self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) historyButtonClicked: (id) sender {
	HistoryVC *detailViewController = [[HistoryVC alloc] initWithNibName:@"HistoryVC" bundle:nil];
	detailViewController.title = self.gameObj.name;
	detailViewController.gameId = gameId;
	[self.navigationController pushViewController:detailViewController animated:YES];
}










@end
