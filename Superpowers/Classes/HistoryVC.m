//
//  HistoryVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/3/16.
//
//

#import "HistoryVC.h"

@interface HistoryVC ()

@end

@implementation HistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:@"Hide" selector:@selector(hideButtonClicked) target:self];
	
	self.round=1;
	self.roundLabel.text = @"-";
	self.roundPrevButton.enabled=NO;
	self.turnPrevButton.enabled=NO;
	self.round1Button.enabled=NO;
	
	self.popupView.hidden=NO;
	[self loadPage];

}

-(void)loadPage {
	[self.webServiceView start];
	[self performSelectorInBackground:@selector(loadpageInBackground) withObject:nil];
}

-(void)loadpageInBackground
{
	
	NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/board_historyMob.php?game_id=%d&hist_id=%d&sequence=%d&round=%d", self.gameId, self.historyId, self.sequence, self.round];
	
	NSURL *url = [NSURL URLWithString:webSite];

	NSString *result = [WebServicesFunctions getResponseFromWeb:webSite];
	NSArray *parts = [result componentsSeparatedByString:@"<sp>"];
	if(parts.count>1) {
		NSLog(@"%@", [parts objectAtIndex:0]);
		NSArray *components = [[parts objectAtIndex:0] componentsSeparatedByString:@"|"];
		if(components.count>6) {
			self.maxRound=[[components objectAtIndex:0] intValue];
			self.round=[[components objectAtIndex:1] intValue];
			self.maxSequence=[[components objectAtIndex:2] intValue];
			self.sequence=[[components objectAtIndex:3] intValue];
			
			self.turnImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif",[[components objectAtIndex:4] intValue] ]];
			self.prevTurnImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif",[[components objectAtIndex:5] intValue] ]];
			self.nextTurnImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif",[[components objectAtIndex:6] intValue] ]];
			
			[self displayButtonsAndLabels];
		}
		[self.mainWebView loadHTMLString:[parts objectAtIndex:1] baseURL:url];
		
	} else
		[ObjectiveCScripts showAlertPopup:@"Network Error" :@""];
	
	[self.webServiceView stop];

	
}

-(void)hideButtonClicked {
	self.popupView.hidden=!self.popupView.hidden;
}

-(void)displayButtonsAndLabels {
	self.roundLabel.text = [NSString stringWithFormat:@"%d/%d", self.round, self.maxRound];
	self.roundPrevButton.enabled=(self.round>1);
	self.round1Button.enabled=(self.round>1);
	self.roundNextButton.enabled=(self.round<self.maxRound);
	self.lastRoundButton.enabled=(self.round<self.maxRound);
	
	self.turnPrevButton.enabled=(self.sequence>1);
	self.turnNextButton.enabled=(self.sequence<self.maxSequence);
	self.prevTurnImageView.hidden=(self.sequence==1);
	self.nextTurnImageView.hidden=(self.sequence==self.maxSequence);

}

- (IBAction) roundUpClicked: (id) sender {
	self.round++;
	[self roundChange];
}
- (IBAction) roundDownClicked: (id) sender {
	self.round--;
	[self roundChange];
}
- (IBAction) firstRoundClicked: (id) sender {
	self.round=1;
	[self roundChange];
}
- (IBAction) lastRoundClicked: (id) sender {
	self.round=self.maxRound;
	[self roundChange];
}

-(void)roundChange {
	[self displayButtonsAndLabels];
	self.historyId=0;
	self.sequence=0;
	[self loadPage];
}

- (IBAction) turnUpClicked: (id) sender {
	self.sequence++;
	[self turnChange];
}
- (IBAction) turnDownClicked: (id) sender {
	self.sequence--;
	[self turnChange];
}

-(void)turnChange {
	[self displayButtonsAndLabels];
	self.historyId=0;
	self.round=0;
	[self loadPage];
}


@end
