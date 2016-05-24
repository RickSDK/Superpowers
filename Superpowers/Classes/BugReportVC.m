//
//  BugReportVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/20/13.
//
//

#import "BugReportVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "GameViewsVC.h"

@interface BugReportVC ()

@end

@implementation BugReportVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (IBAction) webButtonClicked: (id) sender {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.screenNum = 8;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webServiceFunction {
	@autoreleasepool {

		NSArray *nameList = [NSArray arrayWithObjects:@"game", @"details", nil];
		NSArray *valueList = [NSArray arrayWithObjects:self.gameTextField.text, self.detailsTextView.text, nil];
		NSString *webAddr = @"http://www.superpowersgame.com/scripts/webSubmitBug.php";
		NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
		if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Ticket Submitted!" :@"":self];
		}

		self.activityPopup.alpha=0;
		[self.activityIndicator stopAnimating];
    
	}
}

-(void)submitButtonClicked:(id)sender {
    
    [self.gameTextField resignFirstResponder];
    [self.detailsTextView resignFirstResponder];
    
    if([self.gameTextField.text length]==0) {
        [ObjectiveCScripts showAlertPopup:@"Error" :@"Enter a game name"];
        return;
    }
    if([self.detailsTextView.text length]<=10) {
        [ObjectiveCScripts showAlertPopup:@"Error" :@"Enter bug description."];
        return;
    }
	self.activityPopup.alpha=1;
	[self.activityIndicator startAnimating];
	[self performSelectorInBackground:@selector(webServiceFunction) withObject:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Bug Report"];

    self.activityPopup.alpha=0;
	[self.activityIndicator stopAnimating];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
