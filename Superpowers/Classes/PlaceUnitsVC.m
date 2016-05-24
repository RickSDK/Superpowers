//
//  PlaceUnitsVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import "PlaceUnitsVC.h"
#import "ObjectiveCScripts.h"
#import "ListPickerVC.h"
#import "UnitsForPlacementVC.h"
#import "LoadOnShipVC.h"
#import "WebServicesFunctions.h"
#import "WebServicesFunctions.h"
#import "NSArray+ATTArray.h"
#import "GameScreenVC.h"

@interface PlaceUnitsVC ()

@end

@implementation PlaceUnitsVC
@synthesize undoButton, doneButton, purchaseString, purchaseView, origPurchaseString, buttonNumber, placeButton;
@synthesize redoButton, countryButton, loadButton, placementView, placementString, countryWaterFlg;
@synthesize availableTerrString, callBackViewController;
@synthesize activityIndicator, activityPopup, activityLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)helpButtonClicked:(id)sender {
    [ObjectiveCScripts showAlertPopup:@"Place Units Help" :@"You can only place units next to factories. Build more factories to create more gateways for new units."];
}


-(void)showPurchases {
    
    doneButton.enabled=YES;
    NSArray *items = [self.purchaseString componentsSeparatedByString:@"+"];
    NSMutableString *purchases = [[NSMutableString alloc] initWithCapacity:100];
    [purchases appendString:@"- Current Purchases -\n"];
    int piece=0;
    int totalCount=0;
    for(NSString *countStr in items) {
        int count = [countStr intValue];
        if(count>0) {
            totalCount+=count;
            doneButton.enabled=NO;
            NSString *name = [ObjectiveCScripts getNameOfPiece:piece];
            [purchases appendString:[NSString stringWithFormat:@"%@: %d\n", name, count]];
        }
        piece++;
    }
    purchaseView.text = purchases;

    NSMutableString *placementText = [[NSMutableString alloc] initWithCapacity:100];
    [placementText appendString:@"- Placements -\n"];
    if([self.placementString length]>0) {
    NSArray *placeNations = [self.placementString componentsSeparatedByString:@"|"];
    for(NSString *line in placeNations) {
        NSArray *components = [line componentsSeparatedByString:@":"];
        NSString *nation = [components objectAtIndex:0];
        [placementText appendString:[NSString stringWithFormat:@"%@\n", nation]];
        NSArray *placeItems = [[components objectAtIndex:1] componentsSeparatedByString:@"+"];
         int piece=0;
        for(NSString *countStr in placeItems) {
            int count = [countStr intValue];
            if(count>0) {
                doneButton.enabled=NO;
                NSString *name = [ObjectiveCScripts getNameOfPiece:piece];
                [placementText appendString:[NSString stringWithFormat:@"  %@: %d\n", name, count]];
            }
            piece++;
        }
    }
    }
    placementView.text = placementText;

    
    undoButton.enabled=YES;
    if([self.origPurchaseString isEqualToString:self.purchaseString]) {
        undoButton.enabled=NO;
        redoButton.enabled=YES;
    }
    placeButton.enabled=YES;
    NSString *butTitle = countryButton.titleLabel.text;
    if([butTitle isEqualToString:@"Country"]) {
        placeButton.enabled=NO;
        loadButton.enabled=NO;
    }
    
    loadButton.enabled=NO;
    if([@"Y" isEqualToString:self.countryWaterFlg])
        loadButton.enabled=YES;
    
    countryButton.enabled=YES;
    if(totalCount==0) {
        doneButton.enabled=YES;
        loadButton.enabled=NO;
        countryButton.enabled=NO;
        placeButton.enabled=NO;
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Place Units"];
    // Do any additional setup after loading the view from its nib.

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
    
    
    activityPopup.alpha=0;
    activityLabel.alpha=0;
    
    self.origPurchaseString = self.purchaseString;
    [self showPurchases];
    
}

-(void)redoMovement
{
	@autoreleasepool {

        [WebServicesFunctions sendRequestToServer:@"mobileRedoMove.php" forGame:self.gameId andString:@"" andMessage:@"Status set to 'Movement'" delegate:self];

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
    [self performSelectorInBackground:@selector(redoMovement) withObject:nil];
    
}

-(void)undoPlacement
{
	@autoreleasepool {

        [WebServicesFunctions sendRequestToServer:@"mobileUndoPlace.php" forGame:self.gameId andString:@"" andMessage:@"Placement starting over" delegate:self];

        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}

- (IBAction) undoButtonClicked: (id) sender {
    self.buttonNumber=2;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(undoPlacement) withObject:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(callBackViewController) {
        if(buttonNumber==1) {
            [(GameScreenVC *)callBackViewController setReturningValue:@"Redo Movement"];
            [self.navigationController popToViewController:callBackViewController animated:YES];
        }
        if(buttonNumber==3) {
           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
    }
   
}

-(void)placeUnitsDone
{
	@autoreleasepool {

        [WebServicesFunctions sendRequestToServer:@"mobilePlaceDone.php" forGame:self.gameId andString:@"" andMessage:@"Turn Completed!" delegate:self];

        activityPopup.alpha=0;
        activityLabel.alpha=0;
        [activityIndicator stopAnimating];
    
	}
}



- (IBAction) doneButtonClicked: (id) sender {
    self.buttonNumber=3;
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(placeUnitsDone) withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
