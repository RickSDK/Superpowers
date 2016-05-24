//
//  MovementVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import "MovementVC.h"
#import "ObjectiveCScripts.h"
#import "ListPickerVC.h"
#import "WebServicesFunctions.h"
#import "NSArray+ATTArray.h"
#import "PlayerAttackVC.h"
#import "GameViewsVC.h"
#import "GameScreenVC.h"
#import "DiplomacyVC.h"

@interface MovementVC ()

@end

@implementation MovementVC
@synthesize redoButton, generalButton, redoFlg, generalFlg, buttonNumber;
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
    [ObjectiveCScripts showAlertPopup:@"Movement Help" :@"This is your chance to move any units that were not involved in combat.\n\nThe goal is to get troops to your front lines and prepare for counter attacks."];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Options"]; 
    
    activityPopup.alpha=0;
    activityLabel.alpha=0;

    if(self.noRetreatFlg)
		self.generalButton.enabled=NO;
	
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) setReturningValue:(NSString *) value {
    NSLog(@"+++%@ [%d]", value, buttonNumber);
    switch (buttonNumber) {
        case 1:
            //
            break;
            
        default:
            break;
    }
}


-(void)redoAttack
{
	@autoreleasepool {

        [WebServicesFunctions sendRequestToServer:@"mobileRedoAttack.php" forGame:self.gameId andString:@"" andMessage:@"Status set to 'Attack'" delegate:self];
        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}

- (IBAction) redoButtonClicked: (id) sender {
    self.buttonNumber=1;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(redoAttack) withObject:nil];
  
}

-(void)undoMoves
{
	@autoreleasepool {
 //   [NSThread sleepForTimeInterval:1];
        [WebServicesFunctions sendRequestToServer:@"mobileUndoMoves.php" forGame:self.gameId andString:@"" andMessage:@"Moves Undone" delegate:self];
        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}


- (IBAction) undoButtonClicked: (id) sender {
    self.buttonNumber=1;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(undoMoves) withObject:nil];
}


- (IBAction) generalButtonClicked: (id) sender {
    buttonNumber=1;
    [WebServicesFunctions sendRequestToServer:@"mobilePullGeneral.php" forGame:self.gameId andString:@"" andMessage:@"General Retreated" delegate:self];
    
}

- (IBAction) reassignButtonClicked: (id) sender {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.gameId = self.gameId;
    detailViewController.screenNum = 10;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) diplomacyButtonClicked: (id) sender {
	DiplomacyVC *detailViewController = [[DiplomacyVC alloc] initWithNibName:@"DiplomacyVC" bundle:nil];
	detailViewController.gameObj=self.gameObj;
	detailViewController.makeOfferFlg=YES;
	detailViewController.callBackViewController=self;
	[self.navigationController pushViewController:detailViewController animated:YES];

//    PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
  //  detailViewController.gameId = self.gameId;
//    detailViewController.callBackViewController=self;
//    detailViewController.mode=9;
//    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) warButtonClicked: (id) sender {
	DiplomacyVC *detailViewController = [[DiplomacyVC alloc] initWithNibName:@"DiplomacyVC" bundle:nil];
	detailViewController.gameObj=self.gameObj;
	detailViewController.makeOfferFlg=YES;
	detailViewController.callBackViewController=self;
	[self.navigationController pushViewController:detailViewController animated:YES];

//    PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
  //  detailViewController.gameId = self.gameId;
//    detailViewController.callBackViewController=self;
  //  detailViewController.mode=8;
    //[self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.callBackViewController) {
        if(buttonNumber==1) {
            [(GameScreenVC *)self.callBackViewController refreshMap];
            [self.navigationController popToViewController:callBackViewController animated:YES];
        }
        if(buttonNumber==5) {
            [(GameScreenVC *)self.callBackViewController setReturningValue:@"Move Complete"];
            [self.navigationController popToViewController:callBackViewController animated:YES];
        }
    }
}

-(void)actionDone
{
	@autoreleasepool {

        [WebServicesFunctions sendRequestToServer:@"mobileMoveDone.php" forGame:self.gameId andString:@"" andMessage:@"Movement Phase Done" delegate:self];

        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}



- (IBAction) doneButtonClicked: (id) sender {
    self.buttonNumber=5;
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
