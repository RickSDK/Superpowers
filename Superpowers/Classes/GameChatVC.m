//
//  GameChatVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/6/16.
//
//

#import "GameChatVC.h"
#import "PlayerObj.h"
#import "GameViewsVC.h"

@interface GameChatVC ()

@end

@implementation GameChatVC

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:self.gameObj.name];
	
	self.messages = [NSString new];
	self.chat = [NSString new];
	self.flagImageView.hidden=YES;
	
	self.sendButton.enabled=NO;

	[self.webServiceView start];
	[self performSelectorInBackground:@selector(loagMessages) withObject:nil];
	
}

-(void)editButtonaClicked {
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
	detailViewController.gameName = self.gameObj.name;
	detailViewController.gameId = self.gameObj.gameId;
	detailViewController.screenNum = 4;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)loagMessages {
	@autoreleasepool {
		NSString *website = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_chat.php?game_id=%d&topForm=NO", self.gameObj.gameId];
		NSURL *url = [NSURL URLWithString:website];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[self.webView loadRequest:requestObj];
		[self.webServiceView stop];
		self.sendButton.enabled=YES;
	}
	
}


- (IBAction) submitButtonClicked: (id) sender {
	if(self.messagetextField.text.length==0) {
		return;
	}
	[self.messagetextField resignFirstResponder];
	self.sendButton.enabled=NO;
	[self.webServiceView start];
	[self performSelectorInBackground:@selector(postMessage) withObject:nil];
}

-(void)postMessage {
	@autoreleasepool {
		NSString *recipient = self.allButton.titleLabel.text;
		if([@"-" isEqualToString:recipient]) {
			PlayerObj *playerObj = [self.gameObj.playerList objectAtIndex:self.playerButtonNum];
			recipient = [NSString stringWithFormat:@"%d", playerObj.nation];
		}
		
		NSArray *nameList = [NSArray arrayWithObjects:@"message", @"gameId", @"recipient", nil];
		NSString *message = [self.messagetextField.text stringByReplacingOccurrencesOfString:@"|" withString:@""];
		NSArray *valueList = [NSArray arrayWithObjects:message, [NSString stringWithFormat:@"%d", self.gameObj.gameId], recipient, nil];
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobilePostMessage.php":nameList:valueList];
		NSLog(@"response: %@", responseStr);
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			[self.messagetextField performSelectorOnMainThread:@selector(setText:) withObject:@"" waitUntilDone:NO];
		}
		[self performSelectorInBackground:@selector(loagMessages) withObject:nil];
	}
	
}

- (IBAction) allButtonClicked: (id) sender {
	self.allButtonNum++;
	if(self.allButtonNum>2)
		self.allButtonNum=0;
	self.flagImageView.hidden=self.allButtonNum<2;
	NSArray *titles1 = [NSArray arrayWithObjects:@"All", @"Allies", @"-", nil];
	[self.allButton setTitle:[titles1 objectAtIndex:self.allButtonNum] forState:UIControlStateNormal];
	[self.playerButton setTitle:@"Player" forState:UIControlStateNormal];
	if(self.allButtonNum==2)
		[self showPlayerButton];
}

- (IBAction) playerButtonClicked: (id) sender {
	self.playerButtonNum++;
	if(self.playerButtonNum>=self.gameObj.playerList.count)
		self.playerButtonNum=0;
	
	[self showPlayerButton];
}

-(void)showPlayerButton {
	self.flagImageView.hidden=NO;
	PlayerObj *playerObj = [self.gameObj.playerList objectAtIndex:self.playerButtonNum];
	self.flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", playerObj.nation]];
	[self.playerButton setTitle:playerObj.username forState:UIControlStateNormal];
	[self.allButton setTitle:@"-" forState:UIControlStateNormal];
}

@end
