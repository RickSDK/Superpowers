//
//  LoginVC.m
//  PokerTracker
//
//  Created by Rick Medved on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "CreateNewAccount.h"
#import "MainMenuVC.h"


@implementation LoginVC
@synthesize loginEmail, loginPassword, neEmail, nePassword, rePassword, loginButton, forgotButton, createButton;
@synthesize activityIndicator, activityLabel, activityBG, activityPopup;
@synthesize rickButton, robbButton, testButton;



- (IBAction) rickPressed: (id) sender {
	loginEmail.text = @"Rick";
	loginPassword.text = @"rick23";
}

- (IBAction) testPressed: (id) sender {
	loginEmail.text = @"Test101";
	loginPassword.text = @"test";
}

- (IBAction) robbPressed: (id) sender {
	loginEmail.text = @"robbmedvedyahoo.com";
	loginPassword.text = @"buhner";
}

-(void)createNewAccountPressed:(id)sender {
	CreateNewAccount *detailViewController = [[CreateNewAccount alloc] initWithNibName:@"CreateNewAccount" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) createPressed: (id) sender {
	CreateNewAccount *detailViewController = [[CreateNewAccount alloc] initWithNibName:@"CreateNewAccount" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	MainMenuVC *detailViewController = [[MainMenuVC alloc] initWithNibName:@"MainMenuVC" bundle:nil];
	detailViewController.showDisolve=YES;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)loginToSystem
{
	@autoreleasepool {
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", nil];
		NSArray *valueList = [NSArray arrayWithObjects:loginEmail.text, loginPassword.text, nil];
		NSString *webAddr = @"http://www.superpowersgame.com/scripts/iPhoneLogin.php";
		NSString *responseStr = @"";
		responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
//	NSLog(@"responseStr: %@", responseStr);
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			NSArray *items = [responseStr componentsSeparatedByString:@"|"];
			NSString *firstName = @"";
			if([items count]>1)
				firstName = [items objectAtIndex:1];
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"User Logged in":self];
			[ObjectiveCScripts setUserDefaultValue:loginEmail.text forKey:@"prevUserName"];
			[ObjectiveCScripts setUserDefaultValue:loginEmail.text forKey:@"userName"];
			[ObjectiveCScripts setUserDefaultValue:firstName forKey:@"firstName"];
			[ObjectiveCScripts setUserDefaultValue:loginPassword.text forKey:@"password"];
		}

		activityPopup.alpha=0;
		activityBG.alpha=0;
		activityLabel.alpha=0;
		[activityIndicator stopAnimating];

	}
}

-(void)forgotPassword
{
	@autoreleasepool {
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", nil];
		NSArray *valueList = [NSArray arrayWithObjects:loginEmail.text, loginPassword.text, nil];
		NSString *webAddr = @"http://www.superpowersgame.com/scripts/web_forgot_my_password.php";
		NSString *responseStr = @"";
		responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"Your password has been emailed.":self];
		}
		activityPopup.alpha=0;
		activityBG.alpha=0;
		activityLabel.alpha=0;
		[activityIndicator stopAnimating];
	
	}
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)executeThreadedJob:(SEL)aSelector
{
	[activityIndicator startAnimating];
	activityPopup.alpha=1;
	activityBG.alpha=.5;
	activityLabel.alpha=1;
	[self performSelectorInBackground:aSelector withObject:nil];
}


- (IBAction) loginPressed: (id) sender
{
	[loginEmail resignFirstResponder];
	[loginPassword resignFirstResponder];
	BOOL passChecks=YES;
	if([loginEmail.text length]<1) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a valid Username"];
		passChecks=NO;
	}
	if(passChecks && [loginPassword.text length]<2) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a valid password"];
		passChecks=NO;
	}
	if(passChecks) {
		[self executeThreadedJob:@selector(loginToSystem)];
	}
}

- (IBAction) forgotPressed: (id) sender
{
	if([loginEmail.text length]<5) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a valid Emaill Address"];
		return;
	}
	[self executeThreadedJob:@selector(forgotPassword)];
}

-(BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[aTextField resignFirstResponder];
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Login"];

	activityPopup.alpha=0;
	activityBG.alpha=0;
	activityLabel.alpha=0;

//	UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Create New Account" style:UIBarButtonItemStylePlain target:self action:@selector(createNewAccountPressed:)];
//	self.navigationItem.rightBarButtonItem = homeButton;
	
	loginEmail.text = [ObjectiveCScripts getUserDefaultValue:@"prevUserName"];

	if([ObjectiveCScripts getProductionMode]) {
		rickButton.alpha=0;
		robbButton.alpha=0;
		testButton.alpha=0;
	}
}






@end
