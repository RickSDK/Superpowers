//
//  ChatVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChatVC.h"


@implementation ChatVC
@synthesize webView;



- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Chat"];
	
	self.messages = [NSString new];
	self.chat = [NSString new];
	
	[self.webServiceView start];
	self.sendButton.enabled=NO;
	[self performSelectorInBackground:@selector(loagMessages) withObject:nil];

}

-(void)loagMessages {
	@autoreleasepool {
		
		NSString *responseStr = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/mobile_chat.php"];
		NSArray *components = [responseStr componentsSeparatedByString:@"<a>"];
		if(components.count>2) {
			self.usersLabel.text = [components objectAtIndex:0];
			self.chat = [components objectAtIndex:1];
			self.messages = [components objectAtIndex:2];
		}
//		NSLog(@"response: %@", responseStr);
		[self.webServiceView stop];
		self.sendButton.enabled=YES;
		[webView loadHTMLString:self.chat baseURL:[NSURL URLWithString:@"http://www.superpowersgame.com/scripts/mobile_chat.php"]];
	}
	
}

- (IBAction) segmentChanged: (id) sender {
	[self.mainSegment changeSegment];
	NSString *msg = (self.mainSegment.selectedSegmentIndex==0)?self.chat:self.messages;
	[webView loadHTMLString:msg baseURL:[NSURL URLWithString:@"http://www.superpowersgame.com/scripts/mobile_chat.php"]];
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
		
		NSArray *nameList = [NSArray arrayWithObjects:@"message", nil];
		NSString *message = [self.messagetextField.text stringByReplacingOccurrencesOfString:@"|" withString:@""];
		NSArray *valueList = [NSArray arrayWithObjects:message, nil];
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobilePostMessage.php":nameList:valueList];
		NSLog(@"response: %@", responseStr);
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			[self.messagetextField performSelectorOnMainThread:@selector(setText:) withObject:@"" waitUntilDone:NO];
		}
		[self performSelectorInBackground:@selector(loagMessages) withObject:nil];
	}
	
}




@end
