//
//  PurchaseVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/11/13.
//
//

#import "PurchaseVC.h"
#import "ObjectiveCScripts.h"
#import "UnitsVC.h"
#import "SBCBuildVC.h"
#import "WebServicesFunctions.h"
#import "NSArray+ATTArray.h"
#import "Board.h"
#import "GameViewsVC.h"
#import "GameScreenVC.h"


@interface PurchaseVC ()

@end

@implementation PurchaseVC
@synthesize unitSegment, clearButton, completeButton, techButton, railwayButton, balisticsButton;
@synthesize singleBuy1Button, singleBuy2Button, singleBuy3Button, singleBuy4Button;
@synthesize multiBuy1Button, multiBuy2Button, multiBuy3Button, multiBuy4Button;
@synthesize piece1ImageView, piece2ImageView, piece3ImageView, piece4ImageView;
@synthesize moneyLabel, piece1Label, piece2Label, piece3Label, piece4Label, purchasesTextView;
@synthesize purchasesString, originalMoney, currentMoney, sbcString, playerNation;
@synthesize originalTechCount, originalRRCount, originalBalisticsCount, currentTechCount, currentRRCount, currentBalisticsCount;
@synthesize specUnit1Flg, specUnit2Flg, specUnit3Flg;
@synthesize activityIndicator, activityPopup, activityLabel, callBackViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitle:@"Purchase"];
	
	
	if(playerNation==0)
		self.playerNation=1;
	
	self.specUnit1Flg = @"Y";
	self.specUnit2Flg = @"N";
	self.specUnit3Flg = @"N";
 
	activityPopup.alpha=0;
	activityLabel.alpha=0;
	
	[self clearPurchases];
	[self showPurchaseSheet];
	
	if(self.purchase_done_flg)
		self.techButton.enabled=NO;
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
	
	if(self.trainingFlg && self.round==1)
		[ObjectiveCScripts showAlertPopup:@"Purchase Help" :@"If unsure what to buy, get tanks and infantry"];
	
	// Do any additional setup after loading the view from its nib.
}


-(void)showPurchases {
    currentMoney=originalMoney;
    NSArray *items = [self.purchasesString componentsSeparatedByString:@"+"];
    NSMutableString *purchases = [[NSMutableString alloc] initWithCapacity:100];
    [purchases appendString:@"- Current Purchases -\n"];
    int piece=0;
    for(NSString *countStr in items) {
        int count = [countStr intValue];
        if(count>0) {
            NSString *name = [ObjectiveCScripts getNameOfPiece:piece];
            int price = [ObjectiveCScripts getPriceOfPiece:piece];
            currentMoney -= price*count;
            [purchases appendString:[NSString stringWithFormat:@"%@: %d\n", name, count]];
        }
        piece++;
    }
    purchasesTextView.text = purchases;
    if([self.sbcString length]>0) {
        NSArray *items = [self.sbcString componentsSeparatedByString:@"|"];
        int sbcCost = [[items objectAtIndex:1] intValue];
        currentMoney += 15;
        currentMoney -= sbcCost;
    }
    
    moneyLabel.text = [NSString stringWithFormat:@"%d IC", currentMoney];
    [self showPurchaseSheet];
}

-(void)helpButtonClicked:(id)sender {
    [ObjectiveCScripts showAlertPopup:@"Purchase Help" :@"If you are new, buying infantry and tanks is always good.\n\nAlso, doubling up your factories will boost your income."];
}

-(int)mappButtonToPiece:(int)rowNumber
{
    switch (unitSegment.selectedSegmentIndex) {
        case 0:
            switch (rowNumber) {
                case 0:
                    return 2;
                    break;
                case 1:
                    return 3;
                    break;
                case 2:
                    return 1;
                    break;
                case 3:
                    return 15;
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (rowNumber) {
                case 0:
                    return 6;
                    break;
                case 1:
                    return 7;
                    break;
                case 2:
                    return 14;
                    break;
                case 3:
                    return 13;
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 2:
            switch (rowNumber) {
                case 0:
                    return 4;
                    break;
                case 1:
                    return 5;
                    break;
                case 2:
                    return 8;
                    break;
                case 3:
                    return 9;
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 3:
            switch (rowNumber) {
                case 0:
                    if(playerNation==1)
                        return 20;
                    if(playerNation==2)
                        return 21;
                    if(playerNation==3)
                        return 22;
                    if(playerNation==4)
                        return 23;
                    if(playerNation==5)
                        return 24;
                    if(playerNation==6)
                        return 25;
                    if(playerNation==7)
                        return 26;
                    if(playerNation==8)
                        return 27;
                    break;
                case 1:
                    if(playerNation==1)
                        return 28;
                    if(playerNation==2)
                        return 29;
                    if(playerNation==3)
                        return 30;
                    if(playerNation==4)
                        return 31;
                    if(playerNation==5)
                        return 32;
                    if(playerNation==6)
                        return 33;
                    if(playerNation==7)
                        return 34;
                    if(playerNation==8)
                        return 35;
                    break;
                case 2:
                    if(playerNation==1)
                        return 36;
                    if(playerNation==2)
                        return 43;
                    if(playerNation==3)
                        return 37;
                    if(playerNation==4)
                        return 38;
                    if(playerNation==5)
                        return 42;
                    if(playerNation==6)
                        return 40;
                    if(playerNation==7)
                        return 39;
                    if(playerNation==8)
                        return 41;
                     break;
                case 3:
                    return 12;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return 0;
}

-(void)addPurchase:(int)pieceNum:(int)amount {
    int price = [ObjectiveCScripts getPriceOfPiece:pieceNum];
    if(price==0)
        return;
    
    int numberAfforable = currentMoney/price;
    if(amount>numberAfforable && numberAfforable>=1)
        amount=numberAfforable;
    
    if(price*amount>currentMoney) {
        [ObjectiveCScripts showAlertPopup:@"Error" :@"You can't afford that!"];
        return;
    }
    NSArray *pieces = [self.purchasesString componentsSeparatedByString:@"+"];
    NSMutableArray *piecesArray = [NSMutableArray arrayWithArray:pieces];
    int current = [[piecesArray objectAtIndex:pieceNum] intValue];
    current += amount;
    [piecesArray replaceObjectAtIndex:pieceNum withObject:[NSString stringWithFormat:@"%d", current]];
    self.purchasesString = [piecesArray componentsJoinedByString:@"+"];
    [self showPurchases];
}

- (IBAction) autoBuyButtonClicked: (id) sender {
	int numTanks = self.currentMoney/10;
	if(numTanks>0)
		[self addPurchase:3:numTanks];
	while (self.currentMoney>=3) {
		[self addPurchase:2:1];
	}
	NSLog(@"+++%d", self.currentMoney);
}

-(void)addUnit:(int)rowNumber:(int)amount {
    int pieceNum = [self mappButtonToPiece:rowNumber];
    [self addPurchase:pieceNum:amount];
}

-(NSString *)purchaseStringForPiece:(int)piece
{
    return [NSString stringWithFormat:@"%@ - %d IC", [ObjectiveCScripts getNameOfPiece:piece], [ObjectiveCScripts getPriceOfPiece:piece]];
}

-(void)showPurchaseSheet
{
    piece1Label.text = [self purchaseStringForPiece:[self mappButtonToPiece:0]];
    piece2Label.text = [self purchaseStringForPiece:[self mappButtonToPiece:1]];
    piece3Label.text = [self purchaseStringForPiece:[self mappButtonToPiece:2]];
    piece4Label.text = [self purchaseStringForPiece:[self mappButtonToPiece:3]];

    [piece1ImageView setImage:[ObjectiveCScripts getImageForPiece:[self mappButtonToPiece:0]]];
    [piece2ImageView setImage:[ObjectiveCScripts getImageForPiece:[self mappButtonToPiece:1]]];
    [piece3ImageView setImage:[ObjectiveCScripts getImageForPiece:[self mappButtonToPiece:2]]];
    [piece4ImageView setImage:[ObjectiveCScripts getImageForPiece:[self mappButtonToPiece:3]]];
    
    
    
    multiBuy4Button.enabled=YES;
    if(unitSegment.selectedSegmentIndex==3)
        multiBuy4Button.enabled=NO;
    
    
    singleBuy4Button.enabled=YES;
    if(unitSegment.selectedSegmentIndex==3 && [self.sbcString length]>0)
        singleBuy4Button.enabled=NO;
    
    techButton.enabled=YES;
    if(currentMoney<10 || currentTechCount+originalTechCount>17)
        techButton.enabled=NO;
    railwayButton.enabled=YES;
    if(currentMoney<10 || currentRRCount+originalRRCount>0)
        railwayButton.enabled=NO;
    balisticsButton.enabled=YES;
    if(currentMoney<10 || currentBalisticsCount+originalBalisticsCount>0)
        balisticsButton.enabled=NO;
	
	self.numTechsLabel.text = [NSString stringWithFormat:@"%d/18", currentTechCount+originalTechCount];

    
    singleBuy1Button.enabled=YES;
    multiBuy1Button.enabled=YES;
    singleBuy2Button.enabled=YES;
    multiBuy2Button.enabled=YES;
    singleBuy3Button.enabled=YES;
    multiBuy3Button.enabled=YES;
    
    if(unitSegment.selectedSegmentIndex==3) {
        if(self.specialUnitNumber==0) {
            singleBuy1Button.enabled=NO;
            multiBuy1Button.enabled=NO;
        }
        if(self.specialUnitNumber<=1) {
            singleBuy2Button.enabled=NO;
            multiBuy2Button.enabled=NO;
        }
        if(self.specialUnitNumber<=2) {
            singleBuy3Button.enabled=NO;
            multiBuy3Button.enabled=NO;
        }
    }

}
- (IBAction) unitSegmentChanged: (id) sender {
    if(self.trainingFlg && self.unitSegment.selectedSegmentIndex>0) {
        [ObjectiveCScripts showAlertPopup:@"Notice" :@"Only ground units allowed in training game"];
        self.unitSegment.selectedSegmentIndex=0;
    } else
        [self showPurchaseSheet];
}

- (IBAction) technologiesButtonClicked: (id) sender {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.gameName = @"Technology";
    detailViewController.gameId = self.gameId;
    detailViewController.screenNum = 2;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)clearPurchases
{
    self.purchasesString = @"0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0";
    self.sbcString=@"";
    self.currentTechCount=0;
    self.currentRRCount=0;
    self.currentBalisticsCount=0;
    [self showPurchases];
}

- (IBAction) clearButtonClicked: (id) sender {
    [self clearPurchases];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(callBackViewController) {
        [(GameScreenVC *)callBackViewController setReturningValue:@"Purchase Complete"];
        
        [self.navigationController popToViewController:callBackViewController animated:YES];
    }
}

-(void)actionDone
{
	@autoreleasepool {
//    [NSThread sleepForTimeInterval:1];

        NSArray *items = [self.purchasesString componentsSeparatedByString:@"+"];
        NSMutableString *purchases = [[NSMutableString alloc] initWithCapacity:100];
        int piece=0;
        for(NSString *countStr in items) {
            int count = [countStr intValue];
            if(count>0) {
                [purchases appendString:[NSString stringWithFormat:@"%d:%d|", piece, count]];
            }
            piece++;
        }
        
//    NSLog(@"+++%@", purchases);
        
        
        NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"purchasesString", @"sbcString", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], purchases, self.sbcString, nil];
	NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobilePurchase.php":nameList:valueList];
        
//    NSLog(@"response: %@", response);
        
        NSArray *components = [response componentsSeparatedByString:@"|"];
        if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
            if([[components stringAtIndex:1] isEqualToString:@"Success"]) {
                NSString *techString = [components stringAtIndex:2];
                if([techString length]>0) {
                    
                    NSArray *techs = [techString componentsSeparatedByString:@"+"];
                    NSMutableArray *techArray = [[NSMutableArray alloc] initWithCapacity:20];
                    for(NSString *techId in techs) {
                        int tech_id = [techId intValue];
                        if(tech_id>0)
                            [techArray addObject:[Board getTechnologyNameFromId:tech_id]];
                    }
                    
 //                   NSString *techNotice = [NSString stringWithFormat:@"Your scientists developed the following technolgy: %@", [techArray componentsJoinedByString:@", "]];
                    [ObjectiveCScripts showAlertPopupWithDelegate:@"Purchase Complete" :@"Your scientists have come through! Check the logs for details" :self];
                } else
                    [ObjectiveCScripts showAlertPopupWithDelegate:@"Purchase Complete" :@"" :self];
            } else
                [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
        } else
            [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers server at this time. Please try again later."];

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




- (IBAction) completeButtonClicked: (id) sender {
    if(currentMoney==originalMoney && currentMoney>=3) {
        [ObjectiveCScripts showAlertPopup:@"Error" :@"You must buy at least one items"];
        return;
    }
    activityPopup.alpha=1;
    activityLabel.alpha=1;
    self.completeButton.enabled=NO;
    [activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(actionDone) withObject:nil];
}

- (IBAction) techButtonClicked: (id) sender {
    self.currentTechCount++;
    [self addPurchase:18:1];
}

- (IBAction) railwayButtonClicked: (id) sender {
    self.currentRRCount++;
    [self addPurchase:16:1];
}

- (IBAction) balisticsButtonClicked: (id) sender {
    self.currentBalisticsCount++;
    [self addPurchase:17:1];
}

-(void)showPiece:(int)piece
{
    NSArray *pieces = [ObjectiveCScripts getPiecesArray];
    NSString *pieceString = [pieces objectAtIndex:piece];
    UnitsVC *detailViewController = [[UnitsVC alloc] initWithNibName:@"UnitsVC" bundle:nil];
	// Pass the selected object to the new view controller.
	detailViewController.piece = pieceString;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction) info1ButtonClicked: (id) sender {
    [self showPiece:[self mappButtonToPiece:0]];
}

- (IBAction) info2ButtonClicked: (id) sender {
    [self showPiece:[self mappButtonToPiece:1]];
}

- (IBAction) info3ButtonClicked: (id) sender {
    [self showPiece:[self mappButtonToPiece:2]];
}

- (IBAction) info4ButtonClicked: (id) sender {
    [self showPiece:[self mappButtonToPiece:3]];
}

- (IBAction) singleBuy1ButtonClicked: (id) sender {
    [self addUnit:0:1];
}

- (IBAction) singleBuy2ButtonClicked: (id) sender {
    [self addUnit:1:1];
}

- (IBAction) singleBuy3ButtonClicked: (id) sender {
    [self addUnit:2:1];
}
- (IBAction) singleBuy4ButtonClicked: (id) sender {
    if(unitSegment.selectedSegmentIndex==3) {
        SBCBuildVC *detailViewController = [[SBCBuildVC alloc] initWithNibName:@"SBCBuildVC" bundle:nil];
        // Pass the selected object to the new view controller.
        detailViewController.currentMoney=currentMoney;
        detailViewController.callBackViewController=self;
        [self.navigationController pushViewController:detailViewController animated:YES];
        return;
    }
    [self addUnit:3:1];
}

- (IBAction) multiBuy1ButtonClicked: (id) sender {
    [self addUnit:0:5];
}

- (IBAction) multiBuy2ButtonClicked: (id) sender {
    [self addUnit:1:5];
}

- (IBAction) multiBuy3ButtonClicked: (id) sender {
    [self addUnit:2:5];
}

- (IBAction) multiBuy4ButtonClicked: (id) sender {
    [self addUnit:3:5];
}

-(void) setReturningValue:(NSString *) value {
    self.sbcString=value;
    [self addUnit:3:1];
}



@end
