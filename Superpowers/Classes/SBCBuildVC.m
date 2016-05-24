//
//  SBCBuildVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import "SBCBuildVC.h"
#import "ObjectiveCScripts.h"
#import "PurchaseVC.h"

@interface SBCBuildVC ()

@end

@implementation SBCBuildVC
@synthesize costLabel, nameField, rightButton, callBackViewController;
@synthesize att5Switch, attDice1Switch, attDice2Switch, def5Switch, defDice1Switch, defDice2Switch;
@synthesize hp1Switch, hp2Switch, ad1Switch, ad2Switch, currentMoney;

-(BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[nameField resignFirstResponder];
	return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(int)getCostOfSBC {
    int cost=15;
    if(att5Switch.on)
        cost+=3;
    if(attDice1Switch.on)
        cost+=3;
    if(attDice2Switch.on)
        cost+=3;
    if(def5Switch.on)
        cost+=3;
    if(defDice1Switch.on)
        cost+=3;
    if(defDice2Switch.on)
        cost+=3;
    if(hp1Switch.on)
        cost+=3;
    if(hp2Switch.on)
        cost+=3;
    if(ad1Switch.on)
        cost+=3;
    if(ad2Switch.on)
        cost+=3;
    return cost;
}

-(NSString *)getPurchaseString {
    int cost = [self getCostOfSBC];
    NSString *shipName = nameField.text;
    if([shipName length]==0)
        shipName = @"Super BC";
    NSMutableString *purchaseString = [[NSMutableString alloc] initWithCapacity:50];
    [purchaseString appendString:shipName];
    [purchaseString appendString:[NSString stringWithFormat:@"|%d|", cost]];
    [purchaseString appendString:(att5Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(attDice1Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(attDice2Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(def5Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(defDice1Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(defDice2Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(hp1Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(hp2Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(ad1Switch.on)?@"Y|":@"N|"];
    [purchaseString appendString:(ad2Switch.on)?@"Y|":@"N|"];
    return purchaseString;
}

- (IBAction) switchChanged: (id) sender {
    int cost = [self getCostOfSBC];
    if(cost>currentMoney) {
        [ObjectiveCScripts showAlertPopup:@"Error" :@"You can't afford that"];
        rightButton.enabled=NO;
    } else {
        rightButton.enabled=YES;
    }
        
    costLabel.text = [NSString stringWithFormat:@"%d IC", cost];
}

-(void)buyButtonClicked:(id)sender {
    NSString *purchaseString = [self getPurchaseString];
    NSLog(@"+++%@", purchaseString);
	[(PurchaseVC *)callBackViewController setReturningValue:purchaseString];
	
	[self.navigationController popToViewController:callBackViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"SBC"];
    
	rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Buy" style:UIBarButtonItemStylePlain target:self action:@selector(buyButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
