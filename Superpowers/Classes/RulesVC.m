//
//  RulesVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/4/13.
//
//

#import "RulesVC.h"
#import "GameBasicsVC.h"

@interface RulesVC ()

@end

@implementation RulesVC



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Rules"];
	
	self.nationView.hidden=YES;
	
}


- (IBAction) nextButtonClicked: (UIButton *) button {
	GameBasicsVC *detailViewController = [[GameBasicsVC alloc] initWithNibName:@"GameBasicsVC" bundle:nil];
	detailViewController.step=(int)button.tag;
	[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction) rulebookButtonClicked: (id) sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.superpowersgame.com/docs/manual.pdf"]];
}

- (IBAction) video1ButtonClicked: (id) sender {
	[self playVideo:@"https://youtu.be/PS1MBaPTEO4?rel=0&autoplay=1"];
}

- (IBAction) video2ButtonClicked: (id) sender {
	[self playVideo:@"https://youtu.be/hPTlEo8z4iQ?rel=0&autoplay=1"];
	[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"videoWatchedFlg"];
}

-(void)playVideo:(NSString *)videoStr {
	self.popupView.hidden=YES;
	if([ObjectiveCScripts screenWidth]>320) {
		self.popupView.hidden=NO;
	}
	
	NSURL *url = [NSURL URLWithString:videoStr];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	self.mainWebView.mediaPlaybackRequiresUserAction = NO;
	[self.mainWebView loadRequest:requestObj];
}


- (IBAction) nationsButtonClicked: (id) sender {
	self.nationView.hidden=NO;
}

- (IBAction) xButtonPressed: (id) sender {
	self.popupView.hidden=YES;
	self.nationView.hidden=YES;
}


@end
