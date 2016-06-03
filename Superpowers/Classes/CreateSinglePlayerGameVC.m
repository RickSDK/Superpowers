//
//  CreateSinglePlayerGameVC.m
//  Superpowers
//
//  Created by Rick Medved on 1/31/13.
//
//

#import "CreateSinglePlayerGameVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "MainMenuVC.h"

@interface CreateSinglePlayerGameVC ()

@end

@implementation CreateSinglePlayerGameVC
@synthesize numPlayersSegment, attackRoundSegment, fogOfWarSwitch, randomNamtionsSwitch, startButton;
@synthesize activityIndicator, activityPopup, activityLabel;



-(void)webRequestStart
{
	@autoreleasepool {
	//	[NSThread sleepForTimeInterval:2];
	
        int numPlayers = (int)numPlayersSegment.selectedSegmentIndex+3;
        int attackRound = (int)attackRoundSegment.selectedSegmentIndex*2+4;
        NSString *fogOgWar = fogOfWarSwitch.on?@"Y":@"N";
        NSString *randomNations = randomNamtionsSwitch.on?@"Y":@"N";
        
	NSString *data = [NSString stringWithFormat:@"%d|%d|%@|%@", numPlayers, attackRound, fogOgWar, randomNations];
        NSLog(@"%@", data);
	
	NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"data", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], data, nil];
	NSString *webAddr = @"http://www.superpowersgame.com/scripts/iPhoneCreateSingleGame.php";
	NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
        
	if([responseStr length]>=7 && [[responseStr substringToIndex:7] isEqualToString:@"Success"])
		[ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"" :self];
	else
		[ObjectiveCScripts showAlertPopupWithDelegate:@"Done" :@"Game was created or maybe an error occurred. Check game screen." :self];
	
        startButton.enabled=YES;
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	[activityIndicator stopAnimating];
	}
	
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)startWebSearch:(SEL)webRequest
{
	activityPopup.alpha=1;
	activityLabel.alpha=1;
	[activityIndicator startAnimating];
	startButton.enabled=NO;
	[self performSelectorInBackground:webRequest withObject:nil];
}


- (IBAction) startButtonClicked: (id) sender
{
    
    [self startWebSearch:@selector(webRequestStart)];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Single Player Game"];
    
    activityPopup.alpha=0;
	activityLabel.alpha=0;
	
	self.fogOfWarSwitch.on=NO;
	if(self.userRank==2) {
		self.fogOfWarSwitch.enabled=NO;
		self.randomNamtionsSwitch.enabled=NO;
		self.numPlayersSegment.enabled=NO;
		self.attackRoundSegment.enabled=NO;
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"singlePlayerGame"];
	}
}



@end
