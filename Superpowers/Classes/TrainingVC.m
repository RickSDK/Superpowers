//
//  TrainingVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TrainingVC.h"
#import "GameBasicsVC.h"
#import "ObjectiveCScripts.h"
#import "PraticeGameVC.h"
#import "WebServicesFunctions.h"
#import "gameInitialVC.h"
#import "RulesVC.h"


@implementation TrainingVC
@synthesize practiceButton, game_id;
@synthesize activityIndicator, activityPopup, activityLabel;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Training"];
	
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	self.mainWebView.hidden=YES;
	
}

- (IBAction) basicsButtonClicked: (id) sender
{
	[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"videoWatchedFlg"];
	if(self.mainWebView.hidden) {
		NSString *movieFile= [[NSBundle mainBundle] pathForResource:@"bt" ofType:@"mp4"];
		[self playVideo:movieFile];
	} else
		self.mainWebView.hidden=YES;

}

-(void)playVideo:(NSString *)videoStr {
	if([ObjectiveCScripts screenWidth]>320) {
		self.mainWebView.hidden=NO;
	}
	
	NSURL *url = [NSURL URLWithString:videoStr];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	self.mainWebView.mediaPlaybackRequiresUserAction = NO;
	[self.mainWebView loadRequest:requestObj];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(game_id>0) {
        gameInitialVC *detailViewController = [[gameInitialVC alloc] initWithNibName:@"gameInitialVC" bundle:nil];
        detailViewController.gameName = @"Training";
        detailViewController.gameId = game_id;
        [self.navigationController pushViewController:detailViewController animated:YES];
	}
}
-(void)webRequest
{
	@autoreleasepool {
	//	[NSThread sleepForTimeInterval:2];
	
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", nil];
		NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], nil];
		NSString *webAddr = @"http://www.superpowersgame.com/scripts/web_training.php";
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
		NSLog(@"responseStr: %@", responseStr);
		
		activityPopup.alpha=0;
		activityLabel.alpha=0;
		[activityIndicator stopAnimating];
		self.game_id=[responseStr intValue];
		if(game_id>0) {
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Training Game" :@"Good Luck!":self];
		} else
        [ObjectiveCScripts showAlertPopup:@"Error" :@"Error setting up game. Try again"];
    
	}
	
}

- (IBAction) practiceButtonClicked: (id) sender
{
	if([ObjectiveCScripts getUserDefaultValue:@"videoWatchedFlg"].length==0) {
		[ObjectiveCScripts showAlertPopup:@"Watch the 'Basic Training' video first.":@""];
		return;
	}
	activityPopup.alpha=1;
	activityLabel.alpha=1;
	[activityIndicator startAnimating];
    practiceButton.enabled=NO;
	[self performSelectorInBackground:@selector(webRequest) withObject:nil];
	
}







@end
