//
//  CreateNewAccount.m
//  PokerTracker
//
//  Created by Rick Medved on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateNewAccount.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "LoginVC.h"


@implementation CreateNewAccount
@synthesize managedObjectContext;
@synthesize neEmail, nePassword, rePassword, firstname, createButton;
@synthesize activityIndicator, activityLabel, activityBG, activityPopup;



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)createAccount
{
	@autoreleasepool {

		NSString *email = [NSString stringWithFormat:@"%@", neEmail.text];
		NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Firstname", @"Password", nil];
		NSArray *valueList = [NSArray arrayWithObjects:neEmail.text, firstname.text, nePassword.text, nil];
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/web_create_account.php":nameList:valueList];
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"Account Created":self];
			[ObjectiveCScripts setUserDefaultValue:email forKey:@"emailAddress"];
			[ObjectiveCScripts setUserDefaultValue:firstname.text forKey:@"userName"];
			[ObjectiveCScripts setUserDefaultValue:firstname.text forKey:@"firstName"];
			[ObjectiveCScripts setUserDefaultValue:firstname.text forKey:@"prevUserName"];
			
			[ObjectiveCScripts setUserDefaultValue:nePassword.text forKey:@"password"];
		}
		
		
		activityPopup.alpha=0;
		activityBG.alpha=0;
		activityLabel.alpha=0;
		[activityIndicator stopAnimating];
	}
}

- (void) createPressed
{
	[neEmail resignFirstResponder];
	[nePassword resignFirstResponder];
	[rePassword resignFirstResponder];
	[firstname resignFirstResponder];
	
	if(self.policySwitch.on==NO) {
		[ObjectiveCScripts showAlertPopup:@"Notice" :@"You must agree to the privacy policy."];
		return;
	}

	BOOL passChecks=YES;
	if([neEmail.text length]<5) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a valid Emaill Address"];
		passChecks=NO;
	}
	if(passChecks && [firstname.text length]==0) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a first name"];
		passChecks=NO;
	}
	if(passChecks && [nePassword.text length]<2) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a valid password"];
		passChecks=NO;
	}
	if(passChecks && [rePassword.text length]<2) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Re-enter your password"];
		passChecks=NO;
	}
	if(passChecks && ![nePassword.text isEqualToString:rePassword.text]) {
		[ObjectiveCScripts showAlertPopup:@"Error" :@"Passwords do not match!"];
		passChecks=NO;
	}
	
	if(passChecks) {
		[activityIndicator startAnimating];
		activityPopup.alpha=1;
		activityBG.alpha=.5;
		activityLabel.alpha=1;
		[self performSelectorInBackground:@selector(createAccount) withObject:nil];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[aTextField resignFirstResponder];
	return YES;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setTitle:@"Create Account"];

    [super viewDidLoad];
	
//	UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(createPressed)];
	self.navigationItem.rightBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:@"Create" selector:@selector(createPressed) target:self];;
	
	activityPopup.alpha=0;
	activityBG.alpha=0;
	activityLabel.alpha=0;
	
	self.policySwitch.on = NO;

}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	LoginVC *detailViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}



@end
