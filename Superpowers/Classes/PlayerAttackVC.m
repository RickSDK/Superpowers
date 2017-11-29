//
//  PlayerAttackVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/28/13.
//
//

#import "PlayerAttackVC.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "GameScreenVC.h"

@interface PlayerAttackVC ()

@end

@implementation PlayerAttackVC



-(void)loadPage
{
	@autoreleasepool {

        NSString *weblink = nil;
        if(self.mode==0)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_attack.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==1)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/strategic_bombing.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==2)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_cruise.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==3)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/load_transport.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==4)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_move_to.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==5)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_place.php?territory=%d&game_id=%d&iPhoneType=99", self.terr_id, self.gameId];
        
        if(self.mode==6)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/computer.php?game_id=%d&iPhoneType=99&mode=Force", self.gameId];
        
        if(self.mode==7)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/sidebar.php?game_id=%d&iPhoneType=99", self.gameId];

        if(self.mode==8)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_war.php?game_id=%d&iPhoneType=99", self.gameId];
        
        if(self.mode==9)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_diplomacy.php?game_id=%d&iPhoneType=99", self.gameId];
        
        if(self.mode==10)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_war.php?game_id=%d&iPhoneType=99", self.gameId];
        
        if(self.mode==11)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/computer.php?game_id=%d&iPhoneType=99", self.gameId];
        
        if(self.mode==12)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobilePullGeneral.php?game_id=%d&iPhoneType=99", self.gameId];
        
        if(self.mode==13)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_attack.php?territory=%d&game_id=%d&iPhoneType=101", self.terr_id, self.gameId];
        
        if(self.mode==14)
            weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/computer.php?game_id=%d&iPhoneType=99&action=skip_turn", self.gameId];
        
		if(self.mode==15)
			weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileStartGame.php?game_id=%d", self.gameId];
		
		if(self.mode==16)
			weblink = @"http://www.superpowersgame.com/scripts/forum.php?view=web";
		
		if(self.mode==17)
			weblink = @"http://www.superpowersgame.com/docs/manual.pdf";
		
		
		
	NSURL *url = [NSURL URLWithString:weblink];
        
        NSString *page = [WebServicesFunctions getResponseFromWeb:weblink];
        int bytes=(int)[page length];
        self.byteslabel.text = [NSString stringWithFormat:@"%d bytes", bytes];
        
        if(bytes>0)
            [self.mainWebView loadHTMLString:page baseURL:url];
        else {
            if(self.mode==6 || self.mode==11)
                [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Page timed out but computer took his turn. Press 'Done' button to see results."];
            else {
                [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Reloading..."];
                [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [NSThread sleepForTimeInterval:7];
            }
        }
        
        [NSThread sleepForTimeInterval:.3];

        
 //       [self.activityIndicator stopAnimating];
		[self.webServiceView stop];
        self.mainWebView.alpha=1;
        if(self.mode<=4)
            [self performSelectorInBackground:@selector(wait8Sec) withObject:nil];
        else
            self.rightButton.enabled=YES;
		
		self.logsButton.enabled=YES;
		self.mapButton.enabled=YES;
		
		if(1) {
			self.mainWebView.hidden=NO;
			self.logsButton.hidden=YES;
			self.mapButton.hidden=YES;
		}

	}
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)doneButtonClicked:(id)sender {
    if(self.callBackViewController) {
        [(GameScreenVC *)self.callBackViewController refreshMap];
        [self.navigationController popToViewController:self.callBackViewController animated:YES];
    }
}

-(void)wait8Sec {
	@autoreleasepool {
        [NSThread sleepForTimeInterval:7];
        self.rightButton.enabled=YES;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *titles = [NSArray arrayWithObjects:@"Attack", @"Bombing Run", @"Cruise Attack", @"Load Units", @"Move To", @"Place Units", @"Computer AI", @"Diplomacy", @"Declare War", @"Diplomacy", @"Pull General", @"CPU Turn", @"Pull General", @"Attack", @"Skip Turn", @"Start Game", @"Forums", @"Rules", @"hey!!!", nil];
    [self setTitle:[titles objectAtIndex:self.mode]];


    
    if(self.mode != 8 && self.mode != 9&& self.mode != 16) {
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
		self.rightButton = [ObjectiveCScripts navigationButtonWithTitle:@"Done" selector:@selector(doneButtonClicked:) target:self];

        self.navigationItem.rightBarButtonItem = self.rightButton;
        self.rightButton.enabled=NO;
    }
 
	self.logsButton.hidden=YES;
	self.mapButton.hidden=YES;

	if(self.mode==6 || self.mode==11 || self.mode==14) {
		self.mainWebView.hidden=YES;
		self.logsButton.hidden=NO;
		self.mapButton.hidden=NO;
	}

	self.logsButton.enabled=NO;
	self.mapButton.enabled=NO;

    self.mainWebView.alpha=0;
	[self.webServiceView startWithTitle:nil];

//    [self.activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(loadPage) withObject:nil];

    // Do any additional setup after loading the view from its nib.
}

- (IBAction) mapButtonClicked: (id) sender {
	[self.navigationController popViewControllerAnimated:YES];
	
}
- (IBAction) logsButtonClicked: (id) sender {
	self.mainWebView.hidden=NO;
	self.logsButton.hidden=YES;
	self.mapButton.hidden=YES;
}



@end
