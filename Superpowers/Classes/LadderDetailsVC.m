//
//  LadderDetailsVC.m
//  Superpowers
//
//  Created by Rick Medved on 4/9/13.
//
//

#import "LadderDetailsVC.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"

@interface LadderDetailsVC ()

@end

@implementation LadderDetailsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)startWebServiceCall {
    self.joinButton.enabled=NO;
    self.increaseButton.enabled=NO;
    self.decreaseButton.enabled=NO;
    [self.activityIndicator startAnimating];
    self.activityLabel.alpha=1;
    self.activityPopup.alpha=1;
}

-(void)checkWebLogin
{
	@autoreleasepool {
		NSString *response = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/verifyLogin.php"];
		self.loginObj = [LoginObj objectFromLine:response];
		
//    NSLog(@"response: %@", response);
		NSArray *components = [response componentsSeparatedByString:@"|"];
    NSString *confirmStr = nil;
    if([components count]>4) {
        confirmStr = [components objectAtIndex:0];
        self.leagueCount = [[components objectAtIndex:3] intValue];
        int gamesMax = [[components objectAtIndex:4] intValue];
        if(self.leagueCount==0) {
            [self.joinButton setTitle:@"Join League" forState:UIControlStateNormal];
            [self.joinButton setBackgroundImage:[UIImage imageNamed:@"greenChromeBut.png"] forState:UIControlStateNormal];
            self.joinButton.enabled=YES;
            self.increaseButton.enabled=NO;
            self.increaseButton.enabled=NO;
            [self.gamestextView performSelectorOnMainThread:@selector(setText: ) withObject:@"-" waitUntilDone:YES];
        } else {
            [self.joinButton setTitle:@"Exit League" forState:UIControlStateNormal];
            [self.joinButton setBackgroundImage:[UIImage imageNamed:@"redChromeBut.png"] forState:UIControlStateNormal];
            self.joinButton.enabled=YES;
            if(gamesMax>2)
                self.increaseButton.enabled=NO;
            else
                self.increaseButton.enabled=YES;
            if(gamesMax<1)
                self.decreaseButton.enabled=NO;
            else
                self.decreaseButton.enabled=YES;
            
            [self.gamestextView performSelectorOnMainThread:@selector(setText: ) withObject:[NSString stringWithFormat:@"%d", gamesMax] waitUntilDone:YES];
           
        }
        if([[ObjectiveCScripts getUserDefaultValue:@"userName"] length]==0)
            self.joinButton.enabled=NO;
    }
		if([@"Superpowers" isEqualToString:confirmStr])
        [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"serverUp"];
    else
			[ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
		
    [self endWebServiceCall];
	}
}

-(void)checkLeagueStatus {
    [self startWebServiceCall];
    [self performSelectorInBackground:@selector(checkWebLogin) withObject:nil];

}


-(void)endWebServiceCall {
    [self.activityIndicator stopAnimating];
    self.activityLabel.alpha=0;
    self.activityPopup.alpha=0;
}

-(void)joinLeague
{
    
	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileJoinLeague.php" forGame:0 andString:@"" andMessage:@"You have joined!" delegate:self];
        [self endWebServiceCall];
        [self checkLeagueStatus];
	}
}

-(void)exitLeague
{
	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileExitLeague.php" forGame:0 andString:@"" andMessage:@"You have left the league." delegate:self];
        [self endWebServiceCall];
        [self checkLeagueStatus];
	}
}

- (IBAction) joinButtonPressed: (id) sender {
    
    if(self.userRank<3) {
        [ObjectiveCScripts showAlertPopup:@"Notice" :@"You must be Corporal or higher to join ladder"];
        return;
    }

    
    [self startWebServiceCall];
    if(self.leagueCount==0)
        [self performSelectorInBackground:@selector(joinLeague) withObject:nil];
    else
        [self performSelectorInBackground:@selector(exitLeague) withObject:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)increaseGames
{
	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileIncGames.php" forGame:0 andString:@"" andMessage:@"Games Increased." delegate:self];
        [self endWebServiceCall];
        [self checkLeagueStatus];
	}
}

-(void)descreaseGames
{
	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileDecGames.php" forGame:0 andString:@"" andMessage:@"Games Decreased." delegate:self];
        [self endWebServiceCall];
        [self checkLeagueStatus];
	}
}


- (IBAction) increaseButtonPressed: (id) sender {
    [self performSelectorInBackground:@selector(increaseGames) withObject:nil];
}
- (IBAction) decreaseButtonPressed: (id) sender {
    [self performSelectorInBackground:@selector(descreaseGames) withObject:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Ladder"];

    NSLog(@"+++userRank: %d", self.userRank);

    [self checkLeagueStatus];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
