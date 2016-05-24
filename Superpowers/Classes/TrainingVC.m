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

- (IBAction) basicsButtonClicked: (id) sender
{
	RulesVC *detailViewController = [[RulesVC alloc] initWithNibName:@"RulesVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
	
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
	activityPopup.alpha=1;
	activityLabel.alpha=1;
	[activityIndicator startAnimating];
    practiceButton.enabled=NO;
	[self performSelectorInBackground:@selector(webRequest) withObject:nil];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Training"];
	
	activityPopup.alpha=0;
	activityLabel.alpha=0;

}





@end
