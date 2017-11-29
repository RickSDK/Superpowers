//
//  StartVC.m
//  Superpowers
//
//  Created by Rick Medved on 10/30/17.
//
//

#import "StartVC.h"
#import "MainMenuVC.h"
#import "ProfileVC.h"
#import "LoginVC.h"
#import "GamesVC.h"
#import "TrainingVC.h"
#import "CreateSinglePlayerGameVC.h"

@interface StartVC ()

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Main Menu"];
	[self tintNavigationBar:self.navigationController.navigationBar];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"➜" style:UIBarButtonItemStylePlain target:self action:@selector(moreButtonClicked)];
	
	self.mainWebView.hidden=YES;
	
	if([[ObjectiveCScripts getUserDefaultValue:@"initVideo"] length]==0) {
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"initVideo"];
		[self playVideo];
	}
	NSLog(@"Hey!");
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if([ObjectiveCScripts getUserDefaultValue:@"AccountSitUsername"].length>0)
		[self resetLogin];
	
	if([ObjectiveCScripts getUserDefaultValue:@"userName"].length>0) {
		self.popupInfoView.titleLabel.text = [NSString stringWithFormat:@"Welcome %@", [ObjectiveCScripts getUserDefaultValue:@"userName"]];
		[self updateMessage:@"Connecting to the server..." error:NO];
		[self.activityIndicator startAnimating];
		self.gamesButton.enabled=NO;
		[self performSelectorInBackground:@selector(checkWebLogin) withObject:nil];
	} else {
		[self updateMessage:@"Log in to get started..." error:NO];
		[self.gamesButton setTitle:@"Login" forState:UIControlStateNormal];
		self.gamesButton.enabled=YES;
	}
}

-(void)checkWebLogin
{
	@autoreleasepool {
		
		NSString *responseStr = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/verifyLogin.php"];
		NSLog(@"response:  [%@]", responseStr);
//		responseStr = @"Superpowers|18|10|1|3|N|(All) Ok thank you|180|169|349|W1|4-6|546|3.8|4255010350|4255010350@txt.att.net|0|Game 1vs1 starting...|";
	//	responseStr = @"Superpowers|1|2252|0|||(All) Ok thank you||||L0|0-0||3.8|||0|Game 1vs1 starting...|";

		self.loginObj = [LoginObj objectFromLine:responseStr];
		[self.activityIndicator stopAnimating];
		[self updateMessage:@"Response Received." error:NO];
		
		if([self veryifyLogin]) {
			self.gamesButton.enabled=YES;
			[ObjectiveCScripts setUserDefaultValue:[NSString stringWithFormat:@"%d", self.loginObj.level] forKey:@"userRank"];
			
			[self.gamesButton setBackgroundColor:(self.loginObj.numWaiting>0)?[UIColor yellowColor]:[UIColor colorWithRed:.1 green:.8 blue:1 alpha:1]];
//			[self.gamesButton setBackgroundImage:(self.loginObj.numWaiting>0)?[UIImage imageNamed:@"yellowChromeBut.png"]:[UIImage imageNamed:@"blueChromeBut.png"] forState:UIControlStateNormal];
			
			if(self.loginObj.level==0)
				self.loginObj.level=1;
			
			if(self.loginObj.level<2) {
				[self updateMessage:@"Welcome new recruit! Step one: Complete Basic Training." error:NO];
				[self.gamesButton setTitle:@"Basic Training" forState:UIControlStateNormal];
			}
			if(self.loginObj.level==2) {
				[self.gamesButton setTitle:@"Real Game" forState:UIControlStateNormal];
				[self updateMessage:@"Play a single player game first. Then compete against real people!" error:NO];
			}
			if(self.loginObj.level>2) {
				[self.gamesButton setTitle:@"Games" forState:UIControlStateNormal];
				[self updateMessage:@"Check games twice a day!"error:NO];
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
			[self updateMessage:@"Sync Issue. Try logging out and logging back in. Click on the arrow at the top to log out." error:YES];
			return NO;
		}
		
		float version = [[ObjectiveCScripts getProjectDisplayVersion] floatValue];
		if(version < self.loginObj.version) {
			[self updateMessage:@"Your version is outdated. Please visit the appStore and click on 'Update' tab to get the latest." error:YES];
			return NO;
		}
	} else {
		[self updateMessage:@"Sorry, unable to reach superpowers sever at this time. Please try again later." error:YES];
		return NO;
	}
	
	return YES;
}

-(void)updateMessage:(NSString *)message error:(BOOL)error {
	if(error) {
		[ObjectiveCScripts showAlertPopup:@"Login Error" :message];
		[self.gamesButton setTitle:@"Login Error" forState:UIControlStateNormal];
	}
	[self.popupInfoView.textView performSelectorOnMainThread:@selector(setText:) withObject:message waitUntilDone:NO];
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

-(void)infoButtonClicked {
	self.popupInfoView.hidden=!self.popupInfoView.hidden;
}

-(void)moreButtonClicked {
	MainMenuVC *detailViewController = [[MainMenuVC alloc] initWithNibName:@"MainMenuVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)tintNavigationBar:(UINavigationBar *)navigationBar {
	[navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:.8 blue:0 alpha:1];
	[self applyBGToNavBar:navigationBar image:[UIImage imageNamed:@"BlueGrad.png"]];
	
	if ([navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
		[navigationBar setBarTintColor:[UIColor whiteColor]];
	} else {
		navigationBar.opaque=YES;
		navigationBar.backgroundColor = [UIColor blueColor];
	}
	
	float width = [[UIScreen mainScreen] bounds].size.width;
	float leftEdge = width/2-105;
	float logoWidth = 140;
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width-70, 64)];
	
	UIImageView *sp = [[UIImageView alloc] initWithFrame:CGRectMake(leftEdge, 5, logoWidth, 44)];
	sp.image = [UIImage imageNamed:@"superpowers.png"];
	
	UILabel *mainMenuLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftEdge, 38, logoWidth, 20)];
	mainMenuLabel.backgroundColor = [UIColor clearColor];
	mainMenuLabel.numberOfLines = 1;
	mainMenuLabel.font = [UIFont boldSystemFontOfSize: 8.0f];
	mainMenuLabel.textAlignment = NSTextAlignmentCenter;
	mainMenuLabel.textColor = [UIColor whiteColor];
	mainMenuLabel.text = @"Main Menu";
	
	[navView addSubview:mainMenuLabel];
	[navView addSubview:sp];
	
	self.navigationItem.titleView = navView;

}

-(void)applyBGToNavBar:(UINavigationBar *)navigationBar image:(UIImage *)image {
	if ([navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
		[navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
	}
}

- (IBAction) videoButtonClicked: (id) sender {
	if(self.mainWebView.hidden)
		[self playVideo];
	else
		self.mainWebView.hidden=YES;
}

-(void)playVideo {
	if([ObjectiveCScripts screenWidth]>320) {
		self.mainWebView.hidden=NO;
	}
	
	NSString *movieFile= [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"mp4"];
	NSURL *url=[[NSURL alloc] initFileURLWithPath:movieFile];
	//	NSURL *url = [NSURL URLWithString:@"https://youtu.be/PS1MBaPTEO4?rel=0&autoplay=1"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	self.mainWebView.mediaPlaybackRequiresUserAction = NO;
	[self.mainWebView loadRequest:requestObj];
}

-(void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.mainWebView.hidden=YES;
}

- (IBAction) gamessButtonClicked: (id) sender
{
	if([[ObjectiveCScripts getUserDefaultValue:@"userName"] length]==0) {
		LoginVC *detailViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
		[self.navigationController pushViewController:detailViewController animated:YES];
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




@end
