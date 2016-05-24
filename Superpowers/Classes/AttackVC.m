//
//  AttackVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import "AttackVC.h"
#import "ObjectiveCScripts.h"
#import "ListPickerVC.h"
#import "WebServicesFunctions.h"
#import "NSArray+ATTArray.h"
#import "PlayerAttackVC.h"
#import "GameScreenVC.h"


@interface AttackVC ()

@end

@implementation AttackVC
@synthesize bombButton, cruiseButton, bombFlg, cruiseFlg, buttonNumber;
@synthesize activityIndicator, activityPopup, activityLabel, callBackViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)helpButtonClicked:(id)sender {
    [ObjectiveCScripts showAlertPopup:@"Attack Help" :@"Gain income and troops by taking over countries.\n\nYou may need to mass troops on the border before attacking.\n\nClick the 'Attack' button to see what the battlefield will look like."];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Attack"];
    
    self.bombFlg = @"Y";
    self.cruiseFlg = @"Y";
    
    bombButton.enabled=NO;
    if([self.bombFlg isEqualToString:@"Y"])
        bombButton.enabled=YES;
    cruiseButton.enabled=NO;
    if([self.cruiseFlg isEqualToString:@"Y"])
        cruiseButton.enabled=YES;

    activityPopup.alpha=0;
    activityLabel.alpha=0;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
   
    // Do any additional setup after loading the view from its nib.
}

-(void) setReturningValue:(NSString *) value {
    switch (buttonNumber) {
        case 1:
            //
            break;
            
        default:
            break;
    }
}


-(void)actionRedo
{
	@autoreleasepool {
//    [NSThread sleepForTimeInterval:1];

        NSArray *nameList = [NSArray arrayWithObjects:@"game_id", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], nil];
	NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileRedoPurchase.php":nameList:valueList];
        
        NSLog(@"response: %@", response);
        
        NSArray *components = [response componentsSeparatedByString:@"|"];
        if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
            if([[components stringAtIndex:1] isEqualToString:@"Success"]) {
                self.redoMoney=[components stringAtIndex:2];
                [ObjectiveCScripts showAlertPopupWithDelegate:@"Redoing Purchase" :@"" :self];
            } else
                [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
        } else
            [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];

        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}


- (IBAction) redoButtonClicked: (id) sender {
    self.buttonNumber=7;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(actionRedo) withObject:nil];
    
}
- (IBAction) attackButtonClicked: (id) sender {
    self.buttonNumber=1;
    PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
 //   detailViewController.titleName = @"Country";
 //   detailViewController.items = [NSArray arrayWithObjects:@"USA", @"Canada", nil];
 //   detailViewController.callBackViewController=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) bombButtonClicked: (id) sender {
    self.buttonNumber=2;
    ListPickerVC *detailViewController = [[ListPickerVC alloc] initWithNibName:@"ListPickerVC" bundle:nil];
    detailViewController.titleName = @"Country";
    detailViewController.items = [NSArray arrayWithObjects:@"USA", @"Canada", nil];
    detailViewController.callBackViewController=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) cruiseButtonClicked: (id) sender {
    self.buttonNumber=3;
    ListPickerVC *detailViewController = [[ListPickerVC alloc] initWithNibName:@"ListPickerVC" bundle:nil];
    detailViewController.titleName = @"Country";
    detailViewController.items = [NSArray arrayWithObjects:@"USA", @"Canada", nil];
    detailViewController.callBackViewController=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) loadButtonClicked: (id) sender {
    self.buttonNumber=4;
    ListPickerVC *detailViewController = [[ListPickerVC alloc] initWithNibName:@"ListPickerVC" bundle:nil];
    detailViewController.titleName = @"Country";
    detailViewController.items = [NSArray arrayWithObjects:@"USA", @"Canada", nil];
    detailViewController.callBackViewController=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) moveButtonClicked: (id) sender {
    self.buttonNumber=5;
    ListPickerVC *detailViewController = [[ListPickerVC alloc] initWithNibName:@"ListPickerVC" bundle:nil];
    detailViewController.titleName = @"Country";
    detailViewController.items = [NSArray arrayWithObjects:@"USA", @"Canada", nil];
    detailViewController.callBackViewController=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(callBackViewController) {
        if(buttonNumber==6)
            [(GameScreenVC *)callBackViewController setReturningValue:@"Attacks Complete"];
        if(buttonNumber==7)
            [(GameScreenVC *)callBackViewController setReturningValueRedo:self.redoMoney];
	
        [self.navigationController popToViewController:callBackViewController animated:YES];
    }
    
}

-(void)actionDone
{
	@autoreleasepool {
//    [NSThread sleepForTimeInterval:1];

        NSArray *nameList = [NSArray arrayWithObjects:@"game_id", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], nil];
	NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileAttackDone.php":nameList:valueList];
        
        NSLog(@"response: %@", response);
        
        NSArray *components = [response componentsSeparatedByString:@"|"];
        if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
            if([[components stringAtIndex:1] isEqualToString:@"Success"]) {
                [ObjectiveCScripts showAlertPopupWithDelegate:@"Attack Phase Done" :@"" :self];
            } else
                [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
        } else
            [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];

        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}



- (IBAction) doneButtonClicked: (id) sender {
    self.buttonNumber=6;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(actionDone) withObject:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
