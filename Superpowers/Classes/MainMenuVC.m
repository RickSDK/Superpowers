//
//  MainMenuVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuVC.h"
#import "RulesVC.h"
#import "UnitListVC.h"
#import "LeadersVC.h"
#import "LoginVC.h"
#import "GamesVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "ChatVC.h"
#import "NSArray+ATTArray.h"
#import "TrainingVC.h"
#import "UnitsVC.h"
#import "GameScreenVC.h"
#import "GameViewsVC.h"
#import "ProfileVC.h"
#import "BugReportVC.h"
#import "SoundsLib.h"
#import "LadderDetailsVC.h"
#import "CreateSinglePlayerGameVC.h"
#import "ForumsVC.h"
#import "PlayerAttackVC.h"
#import "NewPlayersVC.h"
#import <AVFoundation/AVFoundation.h>



@implementation MainMenuVC
@synthesize titleScreen, showDisolve, screenLock, logoAlpha, usernameLabel, gamesButton;
@synthesize activityIndicator, retryButton, chatLabel, mapImg, mailButton, profileButton, versionLabel, bugButton;
@synthesize leadersButton, unitsButton, rulesButton, chatButton, trainingButton;


- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Main Menu"];
	
	[self styleNavBar];
	
	self.versionLabel.text = [NSString stringWithFormat:@"%@", [ObjectiveCScripts getProjectDisplayVersion]];
	
	self.popupView.hidden=YES;
	
	
	

	
	retryButton.alpha=0;
	
//	titleScreen.frame = [[UIScreen mainScreen] bounds];
	
//	if(titleScreen.frame.size.width>500)
//		self.mapImg.alpha=0;
	
//	titleScreen.alpha=1;
//	[[[[UIApplication sharedApplication] delegate] window] addSubview:titleScreen];
//	[[[[UIApplication sharedApplication] delegate] window] addSubview:activityIndicator];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"⬅" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];

	NSString *userName = [ObjectiveCScripts getUserDefaultValue:@"userName"];
	NSString *buttonName = ([userName length]>0)?@"Logout":@"Login";
	self.navigationItem.rightBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:buttonName selector:@selector(loginButtonClicked:) target:self];
	
	
//	self.navigationItem.leftBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:@"About" selector:@selector(aboutButtonClicked:) target:self];
	
	[ObjectiveCScripts setUserDefaultValue:@"N" forKey:@"serverUp"];
	
	if([userName length]>0) {
		[activityIndicator startAnimating];
	} else {
		usernameLabel.text = @"Log In";
		self.rankLabel.text = @"New Recruit";
		[self showBlankScreen];
	}

//	if(showDisolve) {
//		self.logoAlpha=100;
//		titleScreen.alpha=1;
//		self.screenLock=YES;
//		[self logoDisolve];
//	}

	self.mainWebView.hidden=YES;
	self.hideVideoButton.hidden=YES;
	if([[ObjectiveCScripts getUserDefaultValue:@"initVideo"] length]==0) {
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"initVideo"];
		[self playVideo];
	}
}

-(void)backButtonClicked {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)styleNavBar {
	[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
	if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
		UIImage *image = [UIImage imageNamed:@"BlueGrad.png"];
		[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
		self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:.8 blue:0 alpha:1];
	}
}

-(void)showBlankScreen {
	self.logoAlpha=100;
	titleScreen.alpha=1;
	self.screenLock=YES;
	self.profileButton.enabled=NO;
	self.mailButton.enabled=NO;
	self.bugButton.enabled=NO;
	self.loginView.hidden=NO;
}

-(void)playMovie {
	self.movieController = [[MPMoviePlayerController alloc] init];
	
	self.movieController.controlStyle = MPMovieControlStyleNone;
	self.movieController.scalingMode = MPMovieScalingModeFill; // MPMovieScalingModeAspectFill
	[self.movieController prepareToPlay];
	
	self.blackView = [[UIView alloc] initWithFrame:CGRectZero];
	self.blackView.backgroundColor = [UIColor blackColor];
	[self.blackView addSubview:self.movieController.view];

	[self positionPlayer];
//	[self.view addSubview:self.movieController.view];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(moviePlayBackDidFinish)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:self.movieController];
	
	
	self.movieController.view.hidden=NO;
	NSString *movieFile= [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"mp4"];
	NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:movieFile];
	[self.movieController setContentURL:videoURL];
	[self.movieController setFullscreen:YES animated:YES];
	[self.movieController play];
	
	[[[[UIApplication sharedApplication] delegate] window] addSubview:self.blackView];
//	[[[[UIApplication sharedApplication] delegate] window] addSubview:self.movieController.view];

}

-(void)positionPlayer {
	float width=[ObjectiveCScripts screenWidth];
	float height=[ObjectiveCScripts screenHeight];
	[self.blackView setFrame:CGRectMake(0, 0, width*2, height*2)];
	if(width>height)
		[self.movieController.view setFrame:CGRectMake(0, 0, width, height)];
	else
		[self.movieController.view setFrame:CGRectMake(0, height/2-width/4, width, width/2)];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self positionPlayer];
}

-(void)moviePlayBackDidFinish {
	self.blackView.hidden=YES;
	[self.blackView removeFromSuperview];
	NSLog(@"Done!!!");
}

-(void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.mainWebView.hidden=YES;
	self.hideVideoButton.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if([ObjectiveCScripts getUserDefaultValue:@"AccountSitUsername"].length>0)
		[self resetLogin];

	self.loginView.hidden=NO;
	if([ObjectiveCScripts getUserDefaultValue:@"userName"].length>0) {
		usernameLabel.text = [ObjectiveCScripts getUserDefaultValue:@"userName"];
		self.loginView.hidden=YES;
		self.loginObj.level = [[ObjectiveCScripts getUserDefaultValue:@"userRank"] intValue];
		[self performSelectorInBackground:@selector(checkWebLogin) withObject:nil];
	}
	
}




-(void)logoDisolve2
{
	@autoreleasepool {
		self.logoAlpha--;
		if(showDisolve)
			titleScreen.alpha=((float)logoAlpha/100);
		
		[NSThread sleepForTimeInterval:.01];
		if(logoAlpha>0)
			[self performSelectorInBackground:@selector(logoDisolve2) withObject:nil];
	}
}

-(void)startDisolveNow
{
	self.screenLock=NO;
	[self performSelectorInBackground:@selector(logoDisolve2) withObject:nil];
}

-(void)logoDisolve
{
	if(screenLock)
		[self startDisolveNow];
	
}

- (IBAction) retryButtonClicked: (id) sender
{
    [activityIndicator startAnimating];
    retryButton.alpha=0;
	[self performSelectorInBackground:@selector(checkWebLogin) withObject:nil];
    
}

- (IBAction) unitsButtonClicked: (id) sender
{
	UnitListVC *detailViewController = [[UnitListVC alloc] initWithNibName:@"UnitListVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
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



-(void)checkWebLogin
{
	@autoreleasepool {
    
		NSString *responseStr = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/verifyLogin.php"];
		NSLog(@"response: %@", responseStr);
		self.loginObj = [LoginObj objectFromLine:responseStr];
		[activityIndicator stopAnimating];
		
		if([self veryifyLogin]) {
			self.loginView.hidden=YES;
			[ObjectiveCScripts setUserDefaultValue:[NSString stringWithFormat:@"%d", self.loginObj.level] forKey:@"userRank"];
			
			self.chatLabel.text = self.loginObj.chatMessage;
			self.announcementLabel.text = self.loginObj.announementMsg;
			[self.gamesButton setBackgroundImage:(self.loginObj.numWaiting>0)?[UIImage imageNamed:@"yellowChromeBut.png"]:[UIImage imageNamed:@"blueChromeBut.png"] forState:UIControlStateNormal];
			
			if(self.loginObj.level==0)
				self.loginObj.level=1;
			
			self.mailButton.backgroundColor=(self.loginObj.mailFlg)?[UIColor yellowColor]:[UIColor clearColor];
			
			self.rankLabel.text = [self rankNameForRank:self.loginObj.level];
			self.rankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%d.gif", self.loginObj.level-1]];
			self.rankImageView.frame = CGRectMake(40, 24, 80, 45);
			if(self.loginObj.level==17)
				self.rankImageView.frame = CGRectMake(30, 24, 100, 45);
			if(self.loginObj.level==18)
				self.rankImageView.frame = CGRectMake(20, 24, 120, 45);
			
			self.matchMakingButton.hidden=self.loginObj.level<=2;
			self.chatView.hidden=self.loginObj.level<=2;
			self.nPlayersButton.hidden=self.loginObj.level<=2;
			

			if(self.loginObj.level==2) {
				[self.gamesButton setTitle:@"Real Game" forState:UIControlStateNormal];
				self.messageLabel.text = @"Play a single player game first. Then compete against real people!";
			}
			if(self.loginObj.level>2) {
				[self.gamesButton setTitle:@"Games" forState:UIControlStateNormal];
				self.messageLabel.text = @"Check games twice a day!";
			}
			if(self.loginObj.level>2 && self.loginObj.phone.length==0) {
				[ObjectiveCScripts showAlertPopup:@"Please add Turn Notification number" :@""];
				ProfileVC *detailViewController = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
				detailViewController.loginObj = self.loginObj;
				[self.navigationController pushViewController:detailViewController animated:YES];
			}

		}
	}
}

-(BOOL)veryifyLogin {
	if(self.loginObj.successFlg) {
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"serverUp"];
		if([[ObjectiveCScripts getUserDefaultValue:@"userName"] length]>0 && self.loginObj.user_id==0) {
			[ObjectiveCScripts showAlertPopup:@"Sync Issue" :@"Try logging out and logging back in."];
			[self showBlankScreen];
			return NO;
		}
		
		float version = [[ObjectiveCScripts getProjectDisplayVersion] floatValue];
		if(version < self.loginObj.version) {
			[ObjectiveCScripts showAlertPopup:@"Notice!" :@"Your version is outdated. Please visit the appStore and click on 'Update' tab to get the latest."];
			self.messageLabel.text = @"Your version is outdated. Please visit the appStore to update.";
			self.gamesButton.enabled=NO;
			[self showBlankScreen];
			return NO;
		}
	} else {
		[ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
		retryButton.alpha=1;
		[[[[UIApplication sharedApplication] delegate] window] addSubview:retryButton];
		[self showBlankScreen];
		return NO;
	}
	
	return YES;
}

- (IBAction) nextRankButtonClicked: (id) sender {
	if(self.loginObj.level==19)
		[ObjectiveCScripts showAlertPopup:@"You are the top rank!" :@""];
	else
		[ObjectiveCScripts showAlertPopup:[NSString stringWithFormat:@"To advance to %@", [self rankNameForRank:self.loginObj.level+1]] :[self requirementForRank:self.loginObj.level]];
}


-(NSString *)requirementForRank:(int)rank {
	NSArray *rankNames = [NSArray arrayWithObjects:
						  @"Unknown",
						  @"Complete Training",
						  @"Complete a single player game",
						  @"Win a game as Private 1st Class",
						  @"Win a 1 vs 1 game against someone ranked Corporal or higher",
						  @"Reach 120 points, then host a game",
						  @"Reach 130 points",
						  @"Win a 1 vs 1 game against someone ranked Master Sergeant or higher",
						  @"Reach 150 points",
						  @"Win a game that you host",
						  @"Win a 1 vs 1 game against someone ranked Chief Warrant or higher",
						  @"Reach 180 points",
						  @"Reach 200 points",
						  @"Reach 220 points, then host and win an 8 player diplomacy game",
						  @"Win a 1 vs 1 game against someone ranked Colonel or higher",
						  @"Reach 270 points",
						  @"Reach 300 points, then host 8-player FFA",
						  @"Win a 1 vs 1 game against someone ranked Lieutenant General or higher",
						  @"Beat the Grand General 1 v 1",
						  @"You are the top rank",
						  @"Error1",
						  @"Error2",
						  nil];
	return [rankNames objectAtIndex:rank];
}

-(NSString *)rankNameForRank:(int)rank {
	NSArray *rankNames = [NSArray arrayWithObjects:
						  @"Unknown",
						  @"New Recruit",
						  @"Private",
						  @"Private 1st Class",
						  @"Corporal",
						  @"Sergeant",
						  @"Staff Sergeant",
						  @"Master Sergeant",
						  @"Warrant Officer 1",
						  @"Warrant Officer 2",
						  @"Chief Warrant",
						  @"Lieutenant",
						  @"Captain",
						  @"Major",
						  @"Colonel",
						  @"Brig General",
						  @"Major General",
						  @"Lieutenant General",
						  @"General",
						  @"Grand General",
						  @"Error1",
						  @"Error2",
						  nil];
	return [rankNames objectAtIndex:rank];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(screenLock) {
		[self startDisolveNow];
		return;
	}

	UITouch *touch = [[event allTouches] anyObject];
	CGPoint startTouchPosition = [touch locationInView:self.view];
	
	
	if(CGRectContainsPoint(self.profileView.frame, startTouchPosition)) {
		ProfileVC *detailViewController = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
		detailViewController.loginObj = self.loginObj;
		[self.navigationController pushViewController:detailViewController animated:YES];
	}

}

-(IBAction)profileButtonClicked:(id)sender
{
    ForumsVC *detailViewController = [[ForumsVC alloc] initWithNibName:@"ForumsVC" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(IBAction)rulesButtonClicked:(id)sender
{
	RulesVC *detailViewController = [[RulesVC alloc] initWithNibName:@"RulesVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) chatButtonClicked: (id) sender
{
	ChatVC *detailViewController = [[ChatVC alloc] initWithNibName:@"ChatVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) leadersButtonClicked: (UIButton *) sender
{
	LeadersVC *detailViewController = [[LeadersVC alloc] initWithNibName:@"LeadersVC" bundle:nil];
    detailViewController.userRank=self.loginObj.level;
	detailViewController.tag = (int)sender.tag;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) newPlayersButtonClicked: (id) sender {
	LadderDetailsVC *detailViewController = [[LadderDetailsVC alloc] initWithNibName:@"LadderDetailsVC" bundle:nil];
	detailViewController.userRank=self.loginObj.rating;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) mailButtonClicked:(id)sender {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.screenNum = 7;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) bugButtonClicked:(id)sender {
    BugReportVC *detailViewController = [[BugReportVC alloc] initWithNibName:@"BugReportVC" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) gamessButtonClicked: (id) sender
{
	if([[ObjectiveCScripts getUserDefaultValue:@"userName"] length]==0) {
		[ObjectiveCScripts showAlertPopup:@"Notice" :@"You must be logged in to play"];
        return;
    }
    
	if([[ObjectiveCScripts getUserDefaultValue:@"serverUp"] isEqualToString:@"N"]) {
		[ObjectiveCScripts showAlertPopup:@"Server Down" :@"Unable to connect to the server at this moment. Try again soon."];
		return;
	}
	if(self.loginObj.level<=1) {
		TrainingVC *detailViewController = [[TrainingVC alloc] initWithNibName:@"TrainingVC" bundle:nil];
		[self.navigationController pushViewController:detailViewController animated:YES];
		return;
	}

	if(self.loginObj.level==2 && [ObjectiveCScripts getUserDefaultValue:@"singlePlayerGame"].length==0) {
		CreateSinglePlayerGameVC *detailViewController = [[CreateSinglePlayerGameVC alloc] initWithNibName:@"CreateSinglePlayerGameVC" bundle:nil];
		detailViewController.userRank=self.loginObj.level;
		[self.navigationController pushViewController:detailViewController animated:YES];
		return;
	}
	self.gamesButton.enabled=NO;
	[self performSelectorInBackground:@selector(gotoGameScreenBG) withObject:nil];

}

-(void)gotoGameScreenBG {
	[self performSelectorOnMainThread:@selector(gotoGameScreen) withObject:nil waitUntilDone:YES];
}

-(void)gotoGameScreen {
	self.gamesButton.enabled=YES;
	GamesVC *detailViewController = [[GamesVC alloc] initWithNibName:@"GamesVC" bundle:nil];
	detailViewController.loginObj=self.loginObj;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)loginButtonClicked:(id)sender {
	if([[ObjectiveCScripts getUserDefaultValue:@"userName"] length]>0) {
		[ObjectiveCScripts setUserDefaultValue:nil forKey:@"emailAddress"];
		[ObjectiveCScripts setUserDefaultValue:nil forKey:@"userName"];
		[ObjectiveCScripts setUserDefaultValue:nil forKey:@"firstName"];
		[ObjectiveCScripts setUserDefaultValue:nil forKey:@"password"];
	}
	LoginVC *detailViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)aboutButtonClicked:(id)sender {
	self.popupView.hidden=!self.popupView.hidden;
}

- (IBAction) rankedButtonClicked:(id)sender {
	LeadersVC *detailViewController = [[LeadersVC alloc] initWithNibName:@"LeadersVC" bundle:nil];
    detailViewController.ladderFlg=YES;
    detailViewController.userRank=self.loginObj.level;
	[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction) emailButtonClicked: (id) sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", @"rickmedved@hotmail.com"]]];
}

- (IBAction) rulebookButtonClicked: (id) sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.superpowersgame.com/docs/manual.pdf"]];
}

- (IBAction) replayButtonClicked: (id) sender {
	[self playVideo];
}

- (IBAction) hideVideoButtonClicked: (id) sender {
	self.mainWebView.hidden=YES;
}

-(void)playVideo {
	if([ObjectiveCScripts screenWidth]>320) {
		self.mainWebView.hidden=NO;
		self.hideVideoButton.hidden=NO;
	}

	NSString *movieFile= [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"mp4"];
	NSURL *url=[[NSURL alloc] initFileURLWithPath:movieFile];
//	NSURL *url = [NSURL URLWithString:@"https://youtu.be/PS1MBaPTEO4?rel=0&autoplay=1"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	self.mainWebView.mediaPlaybackRequiresUserAction = NO;
	[self.mainWebView loadRequest:requestObj];
}

@end
