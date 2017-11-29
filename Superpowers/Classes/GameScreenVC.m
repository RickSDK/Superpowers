//
//  GameScreenVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScreenVC.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "PurchaseVC.h"
#import "AttackVC.h"
#import "MovementVC.h"
#import "PlaceUnitsVC.h"
#import "Board.h"
#import "ComputerGoVCViewController.h"
#import "Buy3VC.h"
#import "PlayerAttackVC.h"
#import "GameViewsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "NSArray+ATTArray.h"
#import "PlayerCell.h"
#import "MainMenuVC.h"
#import "MoveUnitsVC.h"
#import "ChooseNationVC.h"
#import "DiplomacyVC.h"
#import "ReassignCountryVC.h"
#import "GameChatVC.h"



@implementation GameScreenVC


@synthesize gameSegment, mainWebView, gameId, gameObj, statusView, bottomGrayToolBar;
@synthesize panelBG, showPanelFlg, buy3_flg;
@synthesize gameDetailsString;
@synthesize playerTurnFlg, playerStatusString, mainScrollView, hueColors;
@synthesize dipomacyString, cruiseFlg, trainingFlg, topAttack2Label, originalMoney, bottomToolBar, detailLoadButton;
@synthesize cpuFlg, detailCruiseButton, terrLastAttackBy, territoryArray, terr_id, buttonNumber, attackZone;
@synthesize unitTextView, detailActionButton, nation, topAttack1Label, alliesButton, undoButton, logsButton;
@synthesize completeButton, detailMoveButton, actionButton, detailFlagView, terrLastAttackRound, playerTurn, purchaseLockFlg;
@synthesize topNationImg, detailXButton, originalBalisticsCount, detailBombButton, specialUnitNumber, mainTableView;
@synthesize showTableViewFlg, takeTurnButton, terrHardId, dipCount, topRound1Label, gameRound, gameStatus;
@synthesize chatButton, detailNameLabel, topRound2Label, topBGImg, attackRound, purchasessButton, originalTechCount;
@synthesize topToolBar, originalRRCount, TechButton;


- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:self.gameObj.name];
	
	self.territoryArray = [[NSMutableArray alloc] init];
	self.yourStatus = [[NSString alloc] init];
	self.place3Array = [[NSMutableArray alloc] init];
	
	self.showPanelFlg=YES;
	[self positionTableView];
	
	self.nChatView.hidden=!self.gameObj.chatFlg;
	
	self.purchaseLockFlg = [[NSString alloc] init];
	
	self.takeTurnButton = [ObjectiveCScripts navigationButtonWithTitle:@"View" selector:@selector(hideButtonClicked) target:self];
	self.navigationItem.rightBarButtonItem = self.takeTurnButton;
	
	NSArray *components = [self.gameDetailsString componentsSeparatedByString:@"|"];
	if([components count]>10) {
		self.playerStatusString = [components objectAtIndex:15];
	}
 
	panelBG.alpha=0;
	self.bottomGrayToolBar.hidden=YES;
	
	self.mainScrollView.contentSize = CGSizeMake(1768, 1040);
	self.territoryDetailView.layer.masksToBounds = NO;
	self.territoryDetailView.layer.shadowOffset = CGSizeMake(15, 15);
	self.territoryDetailView.layer.shadowRadius = 5;
	self.territoryDetailView.layer.shadowOpacity = 0.8;

	
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapGridTapped:)];
	[self.mainScrollView addGestureRecognizer:recognizer];
	
	self.diplomacyView.hidden=!self.gameObj.turnFlg;
	self.place3DoneButton.enabled=NO;
	self.place3ClearButton.enabled=NO;
	self.place3ClearButton.backgroundColor=[UIColor colorWithRed:.8 green:.9 blue:1 alpha:1];
	self.place3DoneButton.backgroundColor=[UIColor colorWithRed:.8 green:.9 blue:1 alpha:1];

	self.topToolBar.hidden=NO;
	
}


-(void)positionWebScreen:(int)type
{
	if(type==0) {
		gameSegment.alpha=1;
//		mainWebView.center = CGPointMake(240, 274);
//		[mainWebView setFrame:CGRectMake(0, 0, 320, 426)];
	} else {
		gameSegment.alpha=0;
//		mainWebView.center = CGPointMake(240, 234);
//		[mainWebView setFrame:CGRectMake(0, 0, 480, 300)];
	}
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		[self positionWebScreen:1];
	}
	else
	{
		[self positionWebScreen:0];
	}
	[self positionTableView];
}

-(void)hideButtonClicked {
	self.bottomToolBar.hidden=!self.bottomToolBar.hidden;
	self.bottomGrayToolBar.hidden=self.bottomToolBar.hidden;
	self.statusView.hidden=self.bottomToolBar.hidden;
	self.topToolBar.hidden=self.bottomToolBar.hidden;
	self.mainTableView.hidden=self.bottomToolBar.hidden;
	self.diplomacyView.hidden=self.bottomToolBar.hidden;
}

-(void)showTopBar {
	self.topToolBar.hidden=NO;
	self.statusView.hidden=NO;
   [self.takeTurnButton setTitle:@"Hide Bar"];
    if([@"Won" isEqualToString:self.playerStatusString] || [@"Loss" isEqualToString:self.playerStatusString]) {
        self.actionButton.enabled=NO;
        self.undoButton.enabled=NO;
        self.completeButton.enabled=NO;
        return;
    }
	self.topToolBar.hidden=!self.playerTurnFlg;
	
    [self positionTableView];
    
    self.undoButton.enabled=YES;
    self.completeButton.enabled=YES;
	[self.actionButton setTitle:self.playerStatusString forState:UIControlStateNormal];
	[self.undoButton setTitle:@"Undo" forState:UIControlStateNormal];
	[self.completeButton setTitle:@"Complete" forState:UIControlStateNormal];
	self.place3View.hidden=YES;
    if([@"Purchase" isEqualToString:self.playerStatusString]) {
		self.diplomacyLabel.text = @"Purchase";
		[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"purchase.png"] forState:UIControlStateNormal];
        self.actionButton.enabled=YES;
        self.undoButton.enabled=NO;
        self.completeButton.enabled=NO;
		[self.undoButton setTitle:@"-" forState:UIControlStateNormal];
		[self.completeButton setTitle:@"-" forState:UIControlStateNormal];
		if(!self.buy3_flg && self.gameObj.round==1 && self.playerTurnFlg) {
			self.diplomacyView.hidden=NO;
			self.place3View.hidden=NO;
			[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"piece2.png"] forState:UIControlStateNormal];
			self.diplomacyLabel.text = @"Place Infantry";
		}
    }
    if([@"Attack" isEqualToString:self.playerStatusString]) {
		[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"attack.png"] forState:UIControlStateNormal];
		self.diplomacyLabel.text = @"Attack";
        self.actionButton.enabled=NO;
		[self.undoButton setTitle:@"Redo Buy" forState:UIControlStateNormal];
        self.undoButton.enabled=YES;
		[self.completeButton setTitle:@"Done" forState:UIControlStateNormal];
        
        
        if([@"Y" isEqualToString:self.purchaseLockFlg])
            self.undoButton.enabled=NO;
        
    }
    if([@"Move" isEqualToString:self.playerStatusString]) {
        self.actionButton.enabled=YES;
		[self.undoButton setTitle:@"Attack" forState:UIControlStateNormal];
		[self.completeButton setTitle:@"Place Units" forState:UIControlStateNormal];
		[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"diplomacy.png"] forState:UIControlStateNormal];
		self.diplomacyLabel.text = @"Diplomacy";
    }
    if([@"Place Units" isEqualToString:self.playerStatusString]) {
		[self.undoButton setTitle:@"Undo" forState:UIControlStateNormal];
        self.actionButton.enabled=YES;
		self.diplomacyLabel.text = @"Press End";
		self.diplomacyView.hidden=self.placeUnitType==0;
		if(self.placeUnitType==0 && self.leaderInCapital) {
			[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"piece11.gif"] forState:UIControlStateNormal];
			self.diplomacyLabel.text = @"Move National Ruler!";
			self.diplomacyView.hidden=NO;
		}
		NSString *purchaseImg = [NSString stringWithFormat:@"piece%d.gif", self.purchasePiece];
		if(self.purchasePiece<=14)
			purchaseImg = [NSString stringWithFormat:@"piece%d.png", self.purchasePiece];
		if(self.purchasePiece==12)
			purchaseImg = @"piece12.gif";
		if(self.placeUnitType==1) {
			[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:purchaseImg] forState:UIControlStateNormal];
			self.diplomacyLabel.text = @"Sea Units";
		}
		if(self.placeUnitType==2) {
			[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:purchaseImg] forState:UIControlStateNormal];
			self.diplomacyLabel.text = @"Ground Units";
		}
		if(self.placeUnitType==3) {
			[self.diplomacyButton setBackgroundImage:[UIImage imageNamed:@"piece15.gif"] forState:UIControlStateNormal];
			self.diplomacyLabel.text = @"Factories";
		}
		[self.completeButton setTitle:@"End Turn" forState:UIControlStateNormal];
    }
    if(self.cpuFlg || !self.playerTurnFlg) {
        self.actionButton.enabled=NO;
        self.undoButton.enabled=NO;
        self.completeButton.enabled=NO;
        
    }
    
    if(self.cpuFlg && !self.playerTurnFlg) {
        [self.detailActionButton setTitle:@"Computer Go!" forState:UIControlStateNormal];
        self.detailActionButton.enabled=YES;
        self.detailActionButton.alpha=1;
    }
    
    if([@"Complete" isEqualToString:self.gameStatus]) {
		[self.undoButton setTitle:@"-" forState:UIControlStateNormal];
		[self.completeButton setTitle:@"-" forState:UIControlStateNormal];
        self.actionButton.enabled=NO;
        self.undoButton.enabled=NO;
        self.completeButton.enabled=NO;
		self.detailActionButton.enabled=NO;
		self.detailActionButton.hidden=YES;
    }
    
    if([@"Choosing" isEqualToString:self.playerStatusString]) {
		[self.undoButton setTitle:@"" forState:UIControlStateNormal];
        self.actionButton.enabled=NO;
		[self.completeButton setTitle:@"Choose Nation" forState:UIControlStateNormal];
        self.undoButton.enabled=NO;
        self.completeButton.enabled=YES;
    }
}

-(void)showButtons {
    self.showPanelFlg=YES;
    self.logsButton.alpha=1;
    self.TechButton.alpha=1;
    self.alliesButton.alpha=1;
    self.chatButton.alpha=1;
    self.purchasessButton.alpha=1;
    self.bottomToolBar.hidden=NO;

 
    [self showTopBar];
	
	if(self.trainingFlg) {
        self.bottomToolBar.hidden=YES;
	}
}

-(void)updateTrainingMessage:(NSString *)message {
	[self.trainingHelpMessage performSelectorOnMainThread:@selector(setText:) withObject:message waitUntilDone:NO];
	self.trainingHelpView.hidden=NO;
}

-(void)dismissButtons {
    [self.takeTurnButton setTitle:@"Show Bar"];
    self.showPanelFlg=NO;
    self.detailActionButton.alpha=0;
    self.topToolBar.hidden=YES;
    self.bottomToolBar.hidden=YES;
}

-(void)gotoView:(int)screenNum {
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.gameName = self.gameObj.name;
    detailViewController.gameId = gameId;
    detailViewController.screenNum = screenNum;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) logsButtonClicked: (id) sender {
    [self gotoView:1];
}
- (IBAction) techButtonClicked: (id) sender {
    [self gotoView:2];
}
- (IBAction) alliesButtonClicked: (id) sender {
    [self gotoView:3];
}
- (IBAction) chatButtonClicked: (id) sender {
	self.nChatView.hidden=YES;
	GameChatVC *detailViewController = [[GameChatVC alloc] initWithNibName:@"GameChatVC" bundle:nil];
	detailViewController.gameObj=self.gameObj;
	[self.navigationController pushViewController:detailViewController animated:YES];

//    [self gotoView:4];
}
- (IBAction) showPurchasesButtonClicked: (id) sender {
    [self gotoView:5];
}

- (IBAction) incomeButtonClicked: (id) sender {
	[self gotoView:11];
}
- (IBAction) statsButtonClicked: (id) sender {
	[self gotoView:12];
}

- (IBAction) diplomacyButtonClicked: (id) sender {
	if([@"Purchase" isEqualToString:self.playerStatusString]) {
		if(!self.buy3_flg && self.gameObj.round==1 && self.playerTurnFlg) {
			[ObjectiveCScripts showAlertPopup:@"Place Infantry" :@"You get to place 3 infantry units on any land territory of your Superpower. Click on the territories you want to place units." ];
			return;
		}
		[ObjectiveCScripts showAlertPopup:@"Purchase" :@"Click the 'Purchase' button to buy units." ];
		return;
	}
	if([@"Attack" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Attack" :@"Click the territory you would like to attack. Or press 'Done'." ];
		return;
	}
	if([@"Place Units" isEqualToString:self.playerStatusString]) {
		if(self.placeUnitType==0 && self.leaderInCapital) {
			[ObjectiveCScripts showAlertPopup:@"Move National Ruler" :@"Move your Nation Ruler off your capital to increase your income." ];
		}
		if(self.placeUnitType==1)
			[ObjectiveCScripts showAlertPopup:@"Place Sea Units" :@"Click on a water space next to one of your factories to place sea units." ];
		if(self.placeUnitType==2)
			[ObjectiveCScripts showAlertPopup:@"Place Land Units" :@"Click on a factory to place your land units." ];
		if(self.placeUnitType==3)
			[ObjectiveCScripts showAlertPopup:@"Place Factories" :@"Click on any of your territories to place factories." ];
		
		return;
	}
	
	DiplomacyVC *detailViewController = [[DiplomacyVC alloc] initWithNibName:@"DiplomacyVC" bundle:nil];
	detailViewController.gameObj=self.gameObj;
	detailViewController.makeOfferFlg=YES;
	detailViewController.callBackViewController=self;
	[self.navigationController pushViewController:detailViewController animated:YES];

}

- (IBAction) diplomacyXButtonClicked: (id) sender {
	self.diplomacyView.hidden=YES;
}

-(void)redoAction {
	@autoreleasepool {
		self.undoButton.enabled=NO;
        if([@"Attack" isEqualToString:self.playerStatusString]) {
            NSArray *nameList = [NSArray arrayWithObjects:@"game_id", nil];
            NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], nil];
            NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileRedoPurchase.php":nameList:valueList];
            
            NSLog(@"response: %@", response);
            
            NSArray *components = [response componentsSeparatedByString:@"|"];
            if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
                if([[components stringAtIndex:1] isEqualToString:@"Success"]) {
                    if([@"Attack" isEqualToString:self.playerStatusString]) {
                        [ObjectiveCScripts showAlertPopup:@"Redoing Purchase" :@""];
                        self.originalMoney=[[components stringAtIndex:2] intValue];
                        self.playerStatusString=@"Purchase";
						self.undoButton.enabled=NO;
						self.actionButton.enabled=YES;
						self.completeButton.enabled=NO;
						[self.actionButton setTitle:@"Purchase" forState:UIControlStateNormal];
                    }
                 } else
                    [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
            } else
                [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
        }

        if([@"Move" isEqualToString:self.playerStatusString]) {
            [WebServicesFunctions sendRequestToServer:@"mobileRedoAttack.php" forGame:self.gameId andString:@"" andMessage:@"Status set to 'Attack'" delegate:self];
            self.playerStatusString=@"Attack";
        }
        
        if([@"Place Units" isEqualToString:self.playerStatusString]) {
            [WebServicesFunctions sendRequestToServer:@"mobileUndoPlace.php" forGame:self.gameId andString:@"" andMessage:@"You can now replace your units." delegate:self];
        }
        
        [self setupButtons];
 //   [self showButtons];

        [self endThreadedJob];
	}
}

-(void)doAction {
	@autoreleasepool {

        if([@"Place Units" isEqualToString:self.playerStatusString]) {
            self.buttonNumber=3;
            [WebServicesFunctions sendRequestToServer:@"mobilePlaceDone.php" forGame:self.gameId andString:@"" andMessage:@"Turn Completed!" delegate:self];
            [self dismissButtons];
			[self endThreadedJob];
			return;
        }


        if([@"Move" isEqualToString:self.playerStatusString]) {
            [WebServicesFunctions sendRequestToServer:@"mobileMoveDone.php" forGame:self.gameId andString:@"" andMessage:@"Now place your units." delegate:self];
            self.playerStatusString=@"Place Units";
        }
        
        if([@"Attack" isEqualToString:self.playerStatusString]) {
            if([WebServicesFunctions sendRequestToServer:@"mobileAttackDone.php" forGame:self.gameId andString:@"" andMessage:@"Attack Phase Done. Now move units if needed." delegate:self])
                        self.playerStatusString=@"Move";
            
            
        } //--Attack
		
        [self setupButtons];
        [self showButtons];

        [self endThreadedJob];
		[self checkMessages];
	}
}

- (IBAction) redoToolbarButtonClicked: (id) sender {
    [self executeThreadedJob:@selector(redoAction)];
}

- (IBAction) doneToolbarButtonClicked: (id) sender {
    if([self.playerStatusString isEqualToString:@"Choosing"]) {
        ChooseNationVC *detailViewController = [[ChooseNationVC alloc] initWithNibName:@"ChooseNationVC" bundle:nil];
        detailViewController.gameId = self.gameId;
        [self.navigationController pushViewController:detailViewController animated:YES];
        return;
    }
	self.diplomacyView.hidden=[self.playerStatusString isEqualToString:@"Place Units"];
    [self dismissButtons];
    [self executeThreadedJob:@selector(doAction)];
}


- (IBAction) actionToolbarButtonClicked: (id) sender {
    
    if([@"Purchase" isEqualToString:self.playerStatusString]) {
		if(self.dipCount>0 && [@"Purchase" isEqualToString:self.playerStatusString]) {
			[self dismissButtons];
			self.buttonNumber=2;
			[ObjectiveCScripts showAlertPopupWithDelegate:@"Notice" :@"You have official diplomatic business to take care of." :self];
			return;
		}

        if(!self.buy3_flg && self.gameObj.round==1 && self.playerTurnFlg) {
			[ObjectiveCScripts showAlertPopup:@"Place Infantry" :@"Click on territories you own to place your 3 starting infantry."];
			return;
            Buy3VC *detailViewController = [[Buy3VC alloc] initWithNibName:@"Buy3VC" bundle:nil];
            // Pass the selected object to the new view controller.
            detailViewController.callBackViewController=self;
            detailViewController.nation = self.nation;
            detailViewController.gameId=self.gameId;
            [self.navigationController pushViewController:detailViewController animated:YES];
        } else {
            PurchaseVC *detailViewController = [[PurchaseVC alloc] initWithNibName:@"PurchaseVC" bundle:nil];
            // Pass the selected object to the new view controller.
            detailViewController.callBackViewController=self;
            detailViewController.originalMoney=self.originalMoney;
            detailViewController.gameId=self.gameObj.gameId;
            detailViewController.playerNation=self.nation;
            detailViewController.trainingFlg=self.trainingFlg;
            detailViewController.originalTechCount=self.originalTechCount;
            detailViewController.originalRRCount=self.originalRRCount;
            detailViewController.specialUnitNumber=self.specialUnitNumber;
			detailViewController.round=self.gameRound;
            detailViewController.originalBalisticsCount=self.originalBalisticsCount;
			detailViewController.purchase_done_flg = self.purchase_done_flg;
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
    }
    if([@"Attack" isEqualToString:self.playerStatusString]) {
        AttackVC *detailViewController = [[AttackVC alloc] initWithNibName:@"AttackVC" bundle:nil];
        detailViewController.callBackViewController=self;
        detailViewController.gameId=self.gameId;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    if([@"Move" isEqualToString:self.playerStatusString] || [@"Place Units" isEqualToString:self.playerStatusString]) {
        MovementVC *detailViewController = [[MovementVC alloc] initWithNibName:@"MovementVC" bundle:nil];
        // Pass the selected object to the new view controller.
        detailViewController.callBackViewController=self;
        detailViewController.gameId=self.gameId;
		detailViewController.gameObj=self.gameObj;
		detailViewController.noRetreatFlg=self.noRetreatFlg;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

- (IBAction) actionButtonClicked: (id) sender
{
    [self dismissDetailView];
	[self dismissButtons];
    
    if(self.cpuFlg) {
		self.cpuFlg=NO;
        PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=11;
        [self.navigationController pushViewController:detailViewController animated:YES];
        return;
    }
    if([self.playerStatusString isEqualToString:@"Move"]) {
        
        MoveUnitsVC *detailViewController = [[MoveUnitsVC alloc] initWithNibName:@"MoveUnitsVC" bundle:nil];
        if([self.territoryArray count]>self.terr_id)
            detailViewController.terrString = [self.territoryArray objectAtIndex:self.terr_id];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=4;
        [self.navigationController pushViewController:detailViewController animated:YES];

        
    }
    if([self.playerStatusString isEqualToString:@"Attack"]) {
		if(self.gameObj.battleZoneNumber>0 && self.gameObj.battleZoneNumber != self.terr_id) {
			[ObjectiveCScripts showAlertPopup:@"Notice!" :[NSString stringWithFormat:@"You have started a battle in %@. You must finish that battle first.", self.gameObj.battleZoneName]];
			return;
		}
        if(self.attackZone != self.terrHardId) {
        if(self.gameRound<self.attackRound && [self.dipomacyString length]>0) {
            [ObjectiveCScripts showAlertPopup:@"Notice!" :[NSString stringWithFormat:@"You cannot attack other players until round %d.", self.attackRound]];
            return;
        }
        if(self.terrLastAttackRound==self.gameRound && self.terrLastAttackBy==self.playerTurn) {
            [ObjectiveCScripts showAlertPopup:@"Notice!" :@"You cannot attack the same country twice in the same round."];
            return;
        }
        if([@"None" isEqualToString:self.dipomacyString]) {
            [ObjectiveCScripts showAlertPopup:@"Notice!" :@"You are not at war with this nation! It will cost you 5 IC to attack."];
        }
        if([@"PEACE" isEqualToString:self.dipomacyString]) {
            [ObjectiveCScripts showAlertPopup:@"Notice!" :@"You have a peace treat with this nation! It will cost you 10 IC to attack."];
        }
        if([@"ALLIANCE" isEqualToString:self.dipomacyString]) {
            [ObjectiveCScripts showAlertPopup:@"Notice!" :@"You have an alliance with this nation! It will cost you 15 IC to attack."];
        }
        
        }
        MoveUnitsVC *detailViewController = [[MoveUnitsVC alloc] initWithNibName:@"MoveUnitsVC" bundle:nil];
        if([self.territoryArray count]>self.terr_id)
            detailViewController.terrString = [self.territoryArray objectAtIndex:self.terr_id];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=0;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
    if([self.playerStatusString isEqualToString:@"Place Units"]) {
        
        MoveUnitsVC *detailViewController = [[MoveUnitsVC alloc] initWithNibName:@"MoveUnitsVC" bundle:nil];
        
        if([self.territoryArray count]>self.terr_id)
            detailViewController.terrString = [self.territoryArray objectAtIndex:self.terr_id];
        
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=5;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }

}
- (IBAction) bombButtonClicked: (id) sender {
    if([self.playerStatusString isEqualToString:@"Attack"]) {
        PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=1;
        [self.navigationController pushViewController:detailViewController animated:YES];
	} else {
		ReassignCountryVC *detailViewController = [[ReassignCountryVC alloc] initWithNibName:@"ReassignCountryVC" bundle:nil];
		detailViewController.terr_id = self.terr_id;
		detailViewController.countryNameLabel.text = [Board getNationNameFromId:self.terr_id];
		detailViewController.countryName = [Board getNationNameFromId:self.terr_id];
		detailViewController.gameObj=self.gameObj;
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}
- (IBAction) cruiseButtonClicked: (id) sender {
    if([self.playerStatusString isEqualToString:@"Attack"]) {
        PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=2;
        [self.navigationController pushViewController:detailViewController animated:YES];
	} else {
		DiplomacyVC *detailViewController = [[DiplomacyVC alloc] initWithNibName:@"DiplomacyVC" bundle:nil];
		detailViewController.gameObj=self.gameObj;
		detailViewController.makeOfferFlg=YES;
		detailViewController.callBackViewController=self;
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}
- (IBAction) loadButtonClicked: (id) sender {
    MoveUnitsVC *detailViewController = [[MoveUnitsVC alloc] initWithNibName:@"MoveUnitsVC" bundle:nil];
    if([self.territoryArray count]>self.terr_id)
        detailViewController.terrString = [self.territoryArray objectAtIndex:self.terr_id];
    detailViewController.terr_id = self.terr_id;
    detailViewController.gameId = self.gameId;
    detailViewController.callBackViewController=self;
    detailViewController.mode=3;
    [self.navigationController pushViewController:detailViewController animated:YES];

}
- (IBAction) moveButtonClicked: (id) sender {
    MoveUnitsVC *detailViewController = [[MoveUnitsVC alloc] initWithNibName:@"MoveUnitsVC" bundle:nil];
    if([self.territoryArray count]>self.terr_id)
        detailViewController.terrString = [self.territoryArray objectAtIndex:self.terr_id];
    detailViewController.terr_id = self.terr_id;
    detailViewController.gameId = self.gameId;
    detailViewController.callBackViewController=self;
    detailViewController.mode=4;
    [self.navigationController pushViewController:detailViewController animated:YES];
    /*
        PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
        detailViewController.terr_id = self.terr_id;
        detailViewController.gameId = self.gameId;
        detailViewController.callBackViewController=self;
        detailViewController.mode=4;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
     */
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.buttonNumber==1)
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
    if(self.buttonNumber==2 && [@"Purchase" isEqualToString:self.playerStatusString]) {
        DiplomacyVC *detailViewController = [[DiplomacyVC alloc] initWithNibName:@"DiplomacyVC" bundle:nil];
		detailViewController.gameObj=self.gameObj;
        detailViewController.callBackViewController=self;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    if(self.buttonNumber==3) {
        self.playerTurnFlg=NO;

        [self refreshMap2];

    }
    if(self.buttonNumber==99) {
        MainMenuVC *detailViewController = [[MainMenuVC alloc] initWithNibName:@"MainMenuVC" bundle:nil];
        detailViewController.showDisolve=YES;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


-(void)setupButtons {
    
    NSLog(@"playerStatusString: %@", self.playerStatusString);
 
	if([@"Win" isEqualToString:self.yourStatus]) {
		[ObjectiveCScripts showAlertPopup:@"Congratulations!" :@"You have won!"];
	}
	if([@"Loss" isEqualToString:self.yourStatus]) {
		[ObjectiveCScripts showAlertPopup:@"Sorry!" :@"You have lost."];
	}
    if(self.cpuFlg)
        return;
    
    if(!playerTurnFlg) {
        return;
    }
    if([self.playerStatusString isEqualToString:@"Attack"]) {
        [self.detailActionButton setTitle:@"Attack!" forState:UIControlStateNormal];
    }
    if([self.playerStatusString isEqualToString:@"Move"]) {
        [self.detailActionButton setTitle:@"Move Here" forState:UIControlStateNormal];
    }
    if([self.playerStatusString isEqualToString:@"Place Units"]) {
        [self.detailActionButton setTitle:@"Place Units" forState:UIControlStateNormal];
    }
    if([self.playerStatusString isEqualToString:@"Done"]) {
    }


}

-(BOOL)checkTrainingSteps
{
	self.actionButton.enabled=NO;
	
   if([[ObjectiveCScripts getUserDefaultValue:@"germanyClick"] length]==0) {
	   if(self.terr_id==0) {
		   [self updateTrainingMessage:@"The board is a map of the world. Scroll around and find Germany. That is your capital. Click on it."];
		   //[ObjectiveCScripts showAlertPopup:@"Initial Turn" :@"The board is a map of the world. Scroll around and find Germany. That is your capital. Click on it."];
		   return NO;
	   }
        if(self.terr_id==7) {
            [ObjectiveCScripts showAlertPopup:@"Good work!" :@"You control all the gray countries of the European Union. Next find and click on Japan."];
            [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"germanyClick"];
			[self updateTrainingMessage:@"Find and click on Japan."];
            return YES;
        } else {
            [ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Germany and click on it. You must click on the flag."];
            return NO;
        }
    } //<-- germanyClick
    if([[ObjectiveCScripts getUserDefaultValue:@"japanClick"] length]==0) {
        if(self.terr_id==21) {
            [ObjectiveCScripts showAlertPopup:@"Good work!" :@"Your first goal is to invade and conquer Russia. Now find Russia on the map and click on it."];
			[self updateTrainingMessage:@"Find and click on Russia."];
            [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"japanClick"];
            return YES;
        } else {
            [ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Japan and click on it. You must click on the flag."];
            return NO;
        }
    } //<-- germanyClick
    if([[ObjectiveCScripts getUserDefaultValue:@"russiaClick"] length]==0) {
        if(self.terr_id==13) {
            [ObjectiveCScripts showAlertPopup:@"Good work!" :@"You also want to take over Indo China, so find that nation and click on it."];
			[self updateTrainingMessage:@"Find and click on Indo China."];
            [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"russiaClick"];
            return YES;
        } else {
            [ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Russia and click on it. You must click on the flag."];
            return NO;
        }
    } //<-- russiaClick
    if([[ObjectiveCScripts getUserDefaultValue:@"indoClick"] length]==0) {
        if(self.terr_id==28) {
            [ObjectiveCScripts showAlertPopup:@"Good work!" :@"Click on the 'Purchase' button to purchase units. Tanks and infantry are going to be best for this game."];
			[self updateTrainingMessage:@"Click on the 'Purchase' button."];
            [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"indoClick"];
            self.takeTurnButton.enabled=YES;
			self.actionButton.enabled=YES;
            return YES;
        } else {
            [ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Indo China and click on it. (South of China). You must click on the flag."];
            return NO;
        }
    } //<-- indoClick
    self.takeTurnButton.enabled=YES;
    self.actionButton.enabled=YES;
    
    if([@"Attack" isEqualToString:self.playerStatusString]) {
        if([[ObjectiveCScripts getUserDefaultValue:@"ukraineClick"] length]==0) {
			[self updateTrainingMessage:@"Find Ukraine and click on it."];
           if(self.terr_id==62) {
                [ObjectiveCScripts showAlertPopup:@"Good work!" :@"Click the attack button and send in all your tanks and infantry, plus your general."];
                [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"ukraineClick"];
                self.takeTurnButton.enabled=YES;
				self.actionButton.enabled=NO;
				self.undoButton.enabled=NO;
				self.completeButton.enabled=NO;
                return YES;
            } else {
				if(self.terr_id>0)
					[ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Ukraine and click on it"];
                return NO;
            }
        }
		if(self.terr_id!=62) {
			[ObjectiveCScripts showAlertPopup:@"Attacks Done" :@"You are done with attacks for this round so click the 'Done' button."];
			self.actionButton.enabled=NO;
			return NO;
		}
        return YES;
    }

    if([@"Move" isEqualToString:self.playerStatusString]) {
        if([[ObjectiveCScripts getUserDefaultValue:@"southernClick"] length]==0) {
			[self updateTrainingMessage:@"Send your Ruler to Southern Europe."];
            if(self.terr_id==12) {
                [ObjectiveCScripts showAlertPopup:@"Good work!" :@"Send your Ruler to Southern Europe if he is still in Germany by clicking the 'Move Here' button."];
                [ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"southernClick"];
                self.takeTurnButton.enabled=YES;
                return YES;
            } else {
				if(self.terr_id>0)
					[ObjectiveCScripts showAlertPopup:@"Sorry" :@"Find Southern Europe and click on it"];
                return NO;
            }
        }
		[self updateTrainingMessage:@"Press the 'Place Units' button."];
        [ObjectiveCScripts showAlertPopup:@"Movement Done" :@"Press the 'Place Units' button."];
		self.actionButton.enabled=NO;
		self.undoButton.enabled=NO;
        return NO;
    }
    if([@"Place Units" isEqualToString:self.playerStatusString]) {
        if(self.terr_id!=7) {
			[self updateTrainingMessage:@"Place your units on Germany."];
            [ObjectiveCScripts showAlertPopup:@"Place Units" :@"Place your units on Germany (it has a factory), then click 'End Turn'."];
			self.actionButton.enabled=NO;
        }
    }


    return YES;
}

- (void) mapGridTapped:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self.mainScrollView];
    [self dismissDetailView];

    int xVal = (point.x+50)/45;
    int yVal = (point.y+50)/66;
    int grid=(yVal-1)*40+xVal;
    self.terr_id = [Board getTerrFromGrid:grid];
	
	if(self.trainingFlg && self.gameRound==1) {
		if(![self checkTrainingSteps])
			return;
	}
		
    if(self.terr_id>0 && [self.territoryArray count]>self.terr_id) {
        NSString *name = [Board getNationNameFromId:self.terr_id];
        NSString *terrString = [self.territoryArray objectAtIndex:self.terr_id];
        NSLog(@"terrString: %@", terrString);
        
        NSArray *components = [terrString componentsSeparatedByString:@"|"];
        if([components count]<2)
            return;
        
        NSString *units = [components objectAtIndex:9];
        self.unitTextView.text = units;
        self.detailNameLabel.text=name;
        self.detailFlagView.image = [UIImage imageNamed:[components objectAtIndex:5]];
        self.terrHardId = [[components objectAtIndex:0] intValue];
        int numUnits = [[components objectAtIndex:3] intValue];
        int facCount = [[components objectAtIndex:11] intValue];
        NSString *ownerCode = [components objectAtIndex:12];
        self.dipomacyString = [components objectAtIndex:12];
        NSString *placeAble = [components objectAtIndex:14];
        self.terrLastAttackRound = [[components objectAtIndex:15] intValue];
        self.terrLastAttackBy = [[components objectAtIndex:16] intValue];
		
		if(self.gameObj.round==1 && self.playerTurnFlg && !self.buy3_flg) {
			self.place3ClearButton.enabled=YES;
			if([ownerCode isEqualToString:@"Self"]) {
				if(self.place3Array.count==0) {
					[self.place3Array addObject:name];
					self.place3Label1.text = name;
				} else if(self.place3Array.count==1) {
					[self.place3Array addObject:name];
					self.place3Label2.text = name;
				} else if(self.place3Array.count==2) {
					[self.place3Array addObject:name];
					self.place3Label3.text = name;
					self.place3DoneButton.enabled=YES;
				} else
					[ObjectiveCScripts showAlertPopup:@"Press Done" :@""];
				
				
			} else {
				[ObjectiveCScripts showAlertPopup:@"Notice" :@"You must place infantry on your own territory"];
			}
			return;
		}

		
		self.unitTextView.alpha=1;
		self.detailNameLabel.alpha=1;
		self.detailFlagView.alpha=1;
		self.territoryDetailView.hidden=NO;
       if([@"Attack" isEqualToString:self.playerStatusString]) {
		   [self.detailBombButton setTitle:@"Strategic Bombing" forState:UIControlStateNormal];
		   [self.detailBombButton setBackgroundImage:[UIImage imageNamed:@"redChromeBut.png"] forState:UIControlStateNormal];
		   [self.detailCruiseButton setTitle:@"Cruise Missiles" forState:UIControlStateNormal];
		   [self.detailCruiseButton setBackgroundImage:[UIImage imageNamed:@"redChromeBut.png"] forState:UIControlStateNormal];
            if([ownerCode isEqualToString:@"Self"]) {
                self.detailActionButton.enabled=NO;
                self.detailBombButton.enabled=NO;
                self.detailCruiseButton.enabled=NO;
                self.detailLoadButton.enabled=YES;
            } else {
                self.detailActionButton.enabled=YES;
                self.detailBombButton.enabled=YES;
                self.detailCruiseButton.enabled=YES;
                self.detailLoadButton.enabled=NO;
            }
            
            if(facCount==0)
                self.detailBombButton.enabled=NO;

            self.detailMoveButton.enabled=YES;
            if(self.terr_id<=78)
                self.detailMoveButton.enabled=NO;
            
            if(numUnits>0 && self.terr_id>78)
                self.detailLoadButton.enabled=YES;
            
            if(self.cruiseFlg && self.terr_id<=78)
                self.detailCruiseButton.enabled=YES;
            else
                self.detailCruiseButton.enabled=NO;


            self.detailActionButton.alpha=1;
            self.detailBombButton.alpha=1;
            self.detailCruiseButton.alpha=1;
            self.detailLoadButton.alpha=1;
            self.detailMoveButton.alpha=1;
        }
        if([@"Move" isEqualToString:self.playerStatusString]) {
			[self displayDiplomacyButtons:ownerCode];
            self.detailActionButton.alpha=1;
			self.detailBombButton.alpha=1;
			self.detailCruiseButton.alpha=1;
            self.detailLoadButton.alpha=1;
            self.detailMoveButton.alpha=1;
            self.detailActionButton.enabled=NO;
            if([ownerCode isEqualToString:@"Self"] || [ownerCode isEqualToString:@"Open Water"] || [ownerCode isEqualToString:@"ALLIANCE"]) {
                self.detailActionButton.enabled=YES;
            }
            if([ownerCode isEqualToString:@"Self"] || [ownerCode isEqualToString:@"ALLIANCE"] || self.terr_id>78) {
                self.detailLoadButton.enabled=YES;
                self.detailMoveButton.enabled=YES;
            } else {
                self.detailLoadButton.enabled=NO;
                self.detailMoveButton.enabled=NO;
            }
        }
        if([@"Place Units" isEqualToString:self.playerStatusString]) {
            self.detailActionButton.alpha=1;
			[self displayDiplomacyButtons:ownerCode];
           if([ownerCode isEqualToString:@"Self"] || [placeAble isEqualToString:@"yes"]) {
                self.detailActionButton.enabled=YES;
            } else {
                self.detailActionButton.enabled=NO;
            }
            if([ownerCode isEqualToString:@"Self"] || [ownerCode isEqualToString:@"ALLIANCE"] || self.terr_id>78) {
                self.detailLoadButton.enabled=YES;
                self.detailMoveButton.enabled=YES;
                self.detailLoadButton.alpha=1;
                self.detailMoveButton.alpha=1;
            } else {
                self.detailLoadButton.enabled=NO;
                self.detailMoveButton.enabled=NO;
            }
        }
    }
    
    if(!self.playerTurnFlg) {
        self.detailActionButton.alpha=0;
        self.detailBombButton.alpha=0;
        self.detailCruiseButton.alpha=0;
        self.detailLoadButton.alpha=0;
        self.detailMoveButton.alpha=0;
    }
}

-(void)displayDiplomacyButtons:(NSString *)ownerCode {
	[self.detailBombButton setTitle:@"Reassign Country" forState:UIControlStateNormal];
	[self.detailBombButton setBackgroundImage:[UIImage imageNamed:@"blueChromeBut.png"] forState:UIControlStateNormal];
	[self.detailCruiseButton setTitle:@"Diplomacy" forState:UIControlStateNormal];
	[self.detailCruiseButton setBackgroundImage:[UIImage imageNamed:@"blueChromeBut.png"] forState:UIControlStateNormal];
	self.detailBombButton.alpha=1;
	self.detailCruiseButton.alpha=1;
	self.detailBombButton.enabled=[ownerCode isEqualToString:@"Self"];
	self.detailCruiseButton.enabled=![ownerCode isEqualToString:@"Self"];
}



-(void)layoutGrid {
    int xMax=40;
    int yMax=16;
    int grid=0;
	
	self.mainScrollView.hidden=YES;
	NSLog(@"layoutGrid");
	
//	UIScrollView *localScrollview = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	localScrollview.contentSize = CGSizeMake(1768, 1040);
	
	UIView *localView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1768, 1040)];
	UIImage *boardImg = [UIImage imageNamed:@"board1800.jpg"];
	UIImageView *boardImgView = [[UIImageView alloc] initWithImage:boardImg];
	[self.mainScrollView addSubview:boardImgView];
	[localView addSubview:boardImgView];

//	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapGridTapped:)];
//	[localScrollview addGestureRecognizer:recognizer];

    for(int y=1;y<=yMax;y++) {
        for(int x=1;x<=xMax;x++) {
            grid++;
            int terrId = [Board getTerrFromGrid:grid];
            NSString *terrString = [self.territoryArray objectAtIndex:terrId];
            NSArray *components = [terrString componentsSeparatedByString:@"|"];
          
            if([components count]<5)
                continue;

//            int nationId = [[components objectAtIndex:1] intValue];
            NSString *pieceCount = [components objectAtIndex:3];
            NSString *pieceImg = [components objectAtIndex:4];
            NSString *flagImg = [components objectAtIndex:5];
            NSString *pieceType = [components objectAtIndex:10];
            if(terrId>0) {
				int terr_idLoc = terrId;
				int xLoc = (45*x)-50;
				int yLoc = (66*y)-50;
				int pieceCt = [pieceCount intValue];
				UIImageView *mapIcon = [ [UIImageView alloc ] initWithFrame:CGRectMake(xLoc, yLoc, 40, 40) ];
				if(terr_idLoc>=79 && pieceCt==0) {
					mapIcon.alpha=.3;
					flagImg = @"bloo.png";
				}
				[mapIcon setImage:[UIImage imageNamed:flagImg]];
				[localView addSubview:mapIcon];
//				[self.mainScrollView addSubview:mapIcon];
				
				if([@"none" isEqualToString:pieceImg])
					continue;
				
				if([@"Sea" isEqualToString:pieceType] && terr_idLoc>=79) {
					if(pieceCt>0) {
						UIImageView *pieceIcon = [ [UIImageView alloc ] initWithFrame:CGRectMake(xLoc, yLoc+40, 40, 20) ];
						[pieceIcon setImage:[UIImage imageNamed:pieceImg]];
						[localView addSubview:pieceIcon];
//						[self.mainScrollView addSubview:pieceIcon];
					}
				} else  { // <-- land
					if(terr_idLoc<79 || pieceCt>0) {
						UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
						countLabel.text = pieceCount;
						countLabel.frame = CGRectMake(xLoc, yLoc+40, 20, 20);
						countLabel.font = [UIFont boldSystemFontOfSize:12];
						countLabel.textAlignment = NSTextAlignmentCenter;
						countLabel.backgroundColor = [UIColor blackColor];
						countLabel.textColor = [UIColor whiteColor];
						[localView addSubview:countLabel];
//						[self.mainScrollView addSubview:countLabel];
					}
					
					if([pieceImg length]>0 && ![@"none" isEqualToString:pieceImg]) {
						
						UILabel *pirceBG = [[UILabel alloc] initWithFrame:CGRectZero];
						pirceBG.text = @"";
						pirceBG.frame = CGRectMake(xLoc+20, yLoc+40, 20, 20);
						pirceBG.font = [UIFont boldSystemFontOfSize:12];
						pirceBG.textAlignment = NSTextAlignmentCenter;
						pirceBG.backgroundColor = [UIColor whiteColor];
						pirceBG.textColor = [UIColor whiteColor];
						[localView addSubview:pirceBG];
//						[self.mainScrollView addSubview:pirceBG];
						pirceBG.alpha=.5;
						
						UIImageView *pieceIcon = [ [UIImageView alloc ] initWithFrame:CGRectMake(xLoc+20, yLoc+40, 20, 20) ];
						[pieceIcon setImage:[UIImage imageNamed:pieceImg]];
						[localView addSubview:pieceIcon];
//						[self.mainScrollView addSubview:pieceIcon];
					}
				}
				
//                [self insertFlagImage:terrId atX:(45*x)-50 atY:(66*y)-50 pieceCount:pieceCount pieceImg:pieceImg flagImg:flagImg pieceType:pieceType localScrollview:localScrollview];
			}
        }
    }

	

//	[self.view addSubview:localScrollview];
	
	[self.mainScrollView addSubview:localView];
	self.mainScrollView.hidden=NO;
	NSLog(@"layoutGrid end");
	
}

-(void)insertFlagImage:(int)terr_idLoc
                   atX:(int)x
                   atY:(int)y
            pieceCount:(NSString *)pieceCount
              pieceImg:(NSString *)pieceImg
               flagImg:(NSString *)flagImg
             pieceType:(NSString *)pieceType
{
    
    

}

-(void)loadTerritories {
	NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"game", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], [NSString stringWithFormat:@"%d", gameId], nil];
	NSString *webAddr = @"http://www.superpowersgame.com/scripts/iphone_map.php";
	NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
    NSArray *components = [responseStr componentsSeparatedByString:@"<a>"];
    
	
    if([responseStr length]<1000)
        NSLog(@"+++ERROR!!: %@", responseStr);
    
	if([components count]<=3 || ![[components objectAtIndex:0] isEqualToString:@"Superpowers"]) {
		[ObjectiveCScripts showAlertPopup:@"Network Error" :@"Reload Map."];
        return;
    }
    NSString *gameParts = [components objectAtIndex:1];
    NSLog(@"gameParts: %@", gameParts);

	NSArray *parts = [gameParts componentsSeparatedByString:@"|"];
    if([parts count]<7)
        return;
    self.playerStatusString = [parts objectAtIndex:1];
	
    self.gameStatus = [parts objectAtIndex:4];
    NSString *pTurn = [parts objectAtIndex:2];

    self.playerTurn = [[parts objectAtIndex:0] intValue];
    self.playerTurnFlg = [pTurn isEqualToString:@"Y"];
    if(self.playerTurnFlg)
        [self showTopBar];
    
    self.cpuFlg = [[parts objectAtIndex:3] intValue]==30;
    self.nation = [[parts objectAtIndex:5] intValue];
    self.originalMoney = [[parts objectAtIndex:6] intValue];
    self.buy3_flg = [@"Y" isEqualToString:[parts objectAtIndex:7]];
    self.topRound2Label.text=[parts objectAtIndex:11];
    self.topAttack2Label.text=[parts objectAtIndex:12];
    self.topNationImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", self.nation]];
    self.gameRound = [[parts objectAtIndex:11] intValue];
	self.gameObj.round = self.gameRound;
    self.attackRound = [[parts objectAtIndex:12] intValue];
	
	[self.territoryArray removeAllObjects];
	[self.territoryArray addObjectsFromArray:[[components objectAtIndex:2] componentsSeparatedByString:@"<li>"]];
    self.dipCount = [[parts objectAtIndex:14] intValue];
    self.purchaseLockFlg=[parts objectAtIndex:15];
    self.cruiseFlg=[@"Y" isEqualToString:[parts objectAtIndex:16]];
    self.originalTechCount=[[parts objectAtIndex:17] intValue];
    self.originalRRCount=[[parts objectAtIndex:18] intValue];
    self.originalBalisticsCount=[[parts objectAtIndex:19] intValue];
    self.attackZone = [[parts objectAtIndex:21] intValue];
    self.specialUnitNumber = [[parts objectAtIndex:22] intValue];
	self.placeUnitType = [[parts objectAtIndex:23] intValue];
	self.leaderInCapital = [@"Y" isEqualToString:[parts objectAtIndex:24]];
	self.yourStatus = [parts objectAtIndex:25];
	self.purchase_done_flg = [@"Y" isEqualToString:[parts objectAtIndex:26]];
	self.noRetreatFlg = [@"Y" isEqualToString:[parts objectAtIndex:27]];
	self.purchasePiece = [[parts objectAtIndex:28] intValue];
	self.gameObj.battleZoneNumber = [[parts objectAtIndex:29] intValue];
	self.gameObj.battleZoneName = [parts objectAtIndex:30];

    self.takeTurnButton.enabled = YES;
	if([@"training" isEqualToString:[parts objectAtIndex:20]] && self.playerTurnFlg)
        self.trainingFlg=YES;

	NSLog(@"self.trainingFlg: %@", (self.trainingFlg)?@"Y":@"N");
	self.trainingHelpView.hidden=!self.trainingFlg;

	NSString *players = [components objectAtIndex:3];
	NSArray *playerArray = [players componentsSeparatedByString:@"<li>"];
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	for(NSString *player in playerArray) {
		if(player.length>10)
			[temp addObject:[PlayerObj objectFromLine:player]];
	}
	self.gameObj.playerList = temp;
	
}


-(void)buildMap {
	@autoreleasepool {
        [self loadTerritories];
		[self setupButtons];

        self.mainScrollView.alpha=1;
		[self.mainTableView reloadData];
		
		[self showTopBar];
		[self checkMessages];
		
		if([self.territoryArray count]>100)
			[self layoutGrid];
		if([@"Purchase" isEqualToString:self.playerStatusString])
			[self scrollMap];
		[self endThreadedJob];
	}
}


-(void)scrollMap {
    int x=0;
    int y=0;
    if(self.nation==1) {
        x=249; y=208;
    }
    if(self.nation==2) {
        x=700; y=86;
    }
    if(self.nation==3) {
        x=1012; y=36;
    }
    if(self.nation==4) {
        x=1457; y=156;
    }
    if(self.nation==5) {
        x=1211; y=401;
    }
    if(self.nation==6) {
        x=933; y=427;
    }
    if(self.nation==7) {
        x=753; y=547;
    }
    if(self.nation==8) {
        x=328; y=501;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainScrollView scrollRectToVisible:CGRectMake(x, y, 320, self.mainScrollView.frame.size.height) animated:YES];
    }
                   );
	
 	if(self.gameObj.round==1 && self.playerTurnFlg && [@"Purchase" isEqualToString:self.playerStatusString]) {
		if(self.trainingFlg)
			[ObjectiveCScripts showAlertPopup:[NSString stringWithFormat:@"You are %@!", [ObjectiveCScripts getSuperpowerNameFromId:self.nation]] :@""];
		else if (!self.buy3_flg)
			[ObjectiveCScripts showAlertPopup:[NSString stringWithFormat:@"You are %@!", [ObjectiveCScripts getSuperpowerNameFromId:self.nation]] :@"You start by placing 3 infantry units. Choose any of your territories to place them."];
	}

}

-(void) setReturningValueRedo:(NSString *) value {
    self.originalMoney=[value intValue];
    self.playerStatusString=@"Purchase";
    [self setupButtons];
    [self showButtons];
}

-(void) setReturningValue:(NSString *) value {
    if([@"Purchase Complete" isEqualToString:value]) {
        self.playerStatusString=@"Attack";
        [self setupButtons];
        [self showButtons];
        if(self.trainingFlg && [[ObjectiveCScripts getUserDefaultValue:@"ukraineClick"] length]==0) {
//            [ObjectiveCScripts showAlertPopup:@"First Attack!" :@"For your first attack let's invade Ukraine. Find that country (next to germany) and click on it."];
        }
    }
    if([@"Redo Attack" isEqualToString:value]) {
        self.playerStatusString=@"Attack";
        [self setupButtons];
        [self showButtons];
    }
    if([@"Attacks Complete" isEqualToString:value]) {
        self.playerStatusString=@"Move";
        [self setupButtons];
        [self showButtons];
        if(self.trainingFlg && [[ObjectiveCScripts getUserDefaultValue:@"southernClick"] length]==0) {
            [ObjectiveCScripts showAlertPopup:@"Movement Phase" :@"You receive a 10 IC bonus every round your Ruler is not on the capital so lets move him to Southern Europe. Find that nation and click on it and move him there."];
        }
    }
    if([@"Redo Movement" isEqualToString:value]) {
        self.playerStatusString=@"Move";
        [self setupButtons];
        [self showButtons];
    }
    if([@"Move Complete" isEqualToString:value]) {
        self.playerStatusString=@"Place Units";
        [self setupButtons];
        [self showButtons];
        if(self.trainingFlg && self.gameRound==1)
            [ObjectiveCScripts showAlertPopup:@"Place Units" :@"Its now time to place the units you purchased at the beginning of your turn. They can only be placed where you have a factory, so click on Germany."];
    }
    if([@"Redo Placement" isEqualToString:value]) {
        self.playerStatusString=@"Place Units";
        [self setupButtons];
        [self showButtons];
    }
    if([@"Placement Complete" isEqualToString:value]) {
        self.playerStatusString=@"Done";
        [self setupButtons];
        [self showButtons];
    }
    if([@"buy3" isEqualToString:value]) {
        self.buy3_flg=NO;
        [self setupButtons];
        [self showButtons];
    }
}

- (void)executeThreadedJob:(SEL)aSelector {
	[self startWebService:aSelector message:nil];
}

-(void)endThreadedJob {
	[self stopWebService];
}


-(void)dismissDetailView {
	self.territoryDetailView.hidden=YES;
 //   self.detailNameLabel.alpha=0;
 //   self.detailFlagView.alpha=0;
 //   self.unitTextView.alpha=0;
    self.detailActionButton.alpha=0;
    self.detailBombButton.alpha=0;
    self.detailCruiseButton.alpha=0;
    self.detailLoadButton.alpha=0;
    self.detailMoveButton.alpha=0;
}

- (IBAction) dismissDetailButtonClicked: (id) sender {
    [self dismissDetailView];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if(cell==nil)
		cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	PlayerObj *playerObj = [self.gameObj.playerList objectAtIndex:indexPath.row];
	[PlayerCell populateCell:cell playerObj:playerObj playerTurn:self.playerTurn];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gameObj.playerList.count;
}

-(void)positionTableView
{
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
	
    float tableWidth=self.mainTableView.frame.size.width;
    float margin=30;
    
    if(self.showTableViewFlg)
        self.mainTableView.center=CGPointMake(width/2+30, height/2+20);
    else
        self.mainTableView.center=CGPointMake(tableWidth/2+width-(margin), height/2+20);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.showTableViewFlg=!self.showTableViewFlg;
    [self positionTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (IBAction) xButtonClicked: (id) sender {
	self.statusView.hidden=!self.statusView.hidden;
	self.bottomToolBar.hidden = self.statusView.hidden;
	self.mainTableView.hidden = self.statusView.hidden;
	if(self.mainTableView.hidden) {
		self.bottomGrayToolBar.hidden=YES;
		self.diplomacyView.hidden=YES;
		self.topToolBar.hidden=YES;
	} else
		[self showButtons];
}

- (IBAction) helpButtonClicked: (id) sender {
    if([@"Complete" isEqualToString:self.gameStatus] && !showPanelFlg) {
        [ObjectiveCScripts showAlertPopup:@"Game has ended.":@""];
		return;
    }
    if(!playerTurnFlg && showPanelFlg) {
		
		if(self.cpuFlg)
			[ObjectiveCScripts showAlertPopup:[Board getSuperpowerNameFromId:self.nation] :@"Press 'Computer Go!' to let the computer take its turn."];
		else
			[ObjectiveCScripts showAlertPopup:[Board getSuperpowerNameFromId:self.nation] :@"Each player has 24 hours to take their turn. Check back soon."];

        return;
    }
	
	if([@"Purchase" isEqualToString:self.playerStatusString]) {
        [ObjectiveCScripts showAlertPopup:@"Purchase":@"Press the 'Purchase' Button."];
		return;
	}
	if([@"Attack" isEqualToString:self.playerStatusString]) {
        [ObjectiveCScripts showAlertPopup:@"Attack":@"Click on any territories you want to attack. Then press 'Done' when done with all attacks."];
		return;
	}
	if([@"Move" isEqualToString:self.playerStatusString]) {
        [ObjectiveCScripts showAlertPopup:@"Move":@"You can now move any units then click 'Place Units'."];
		return;
	}
	if([@"Place Units" isEqualToString:self.playerStatusString]) {
        [ObjectiveCScripts showAlertPopup:@"Place Units":@"Place your units, then press 'End Turn'."];
		return;
	}

}

-(void)turnButtonClicked:(id)sender {
    if([@"Complete" isEqualToString:self.gameStatus] && !showPanelFlg) {
        [ObjectiveCScripts showAlertPopup:@"Game has ended.":@""];
    }
    [self scrollMap];
    
    showPanelFlg = !showPanelFlg;
    if(showPanelFlg) {
        [self showButtons];
    } else {
        [self dismissButtons];
    }
    if(self.cpuFlg && showPanelFlg) {
        [self showTopBar];
        return;
    }

}

-(void)refreshMap {
 //   self.mainScrollView.alpha=0;
    
 //   [self dismissDetailView];
 //   self.showPanelFlg=YES;
	
	
//	[self showTopBar];
	
	
 //   [self executeThreadedJob:@selector(buildMap)];
    
}

-(void)refreshMap2 {
    self.mainScrollView.alpha=0;
    
    [self dismissDetailView];
    self.showPanelFlg=YES;
	
	[self performSelectorOnMainThread:@selector(buildMap) withObject:nil waitUntilDone:NO];
//	[self buildMap];
//    [self executeThreadedJob:@selector(buildMap)];
    
}

-(void)checkMessages {
	if(self.trainingFlg && self.playerTurnFlg)
		[self checkTrainingMessages];
	
}

-(void)checkTrainingMessages {
	if([@"Purchase" isEqualToString:self.playerStatusString]) {
		[self updateTrainingMessage:@"Press 'Purchase' button."];
	}
	if([@"Attack" isEqualToString:self.playerStatusString]) {
		[self updateTrainingMessage:@"Click on a country to attack, or press 'Done'."];
	}
	if([@"Move" isEqualToString:self.playerStatusString]) {
		[self updateTrainingMessage:@"Move units, then press 'Place Units'."];
	}
	if([@"Place Units" isEqualToString:self.playerStatusString]) {
		[self updateTrainingMessage:@"Place units on your factory, then press 'End Turn'."];
	}
	
	if([@"Won" isEqualToString:self.playerStatusString]) {
		self.buttonNumber=99;
		[self updateTrainingMessage:@"You have won!"];
		[ObjectiveCScripts showAlertPopupWithDelegate:@"Congratulations!" :@"You haved earned the rank of private and can now play real games." :self];
		
		return;
	}
		
	if(self.gameRound==1) {
		[self checkTrainingSteps];
		
		
		if([@"Purchase" isEqualToString:self.playerStatusString]) {
			[self updateTrainingMessage:@"Press purchase button."];
		}
		if([@"Attack" isEqualToString:self.playerStatusString]) {
			if([[ObjectiveCScripts getUserDefaultValue:@"ukraineClick"] length]==0) {
				[self updateTrainingMessage:@"Click on Ukraine to attack."];
				[ObjectiveCScripts showAlertPopup:@"First Attack!" :@"Let's invade Ukraine. Find that country (next to germany) and click on it."];
			}
		}
		if([@"Move" isEqualToString:self.playerStatusString]) {
			[self updateTrainingMessage:@"Move units, then press done."];
			if([[ObjectiveCScripts getUserDefaultValue:@"southernClick"] length]==0) {
				[self updateTrainingMessage:@"Move your Ruler to Southern Europe."];
				[ObjectiveCScripts showAlertPopup:@"Movement Phase" :@"Move your Ruler to Southern Europe. You want to keep him off your campital."];
			}
		}
		if([@"Place Units" isEqualToString:self.playerStatusString]) {
			[self updateTrainingMessage:@"Place units on germany, then press 'End Turn'."];
			self.undoButton.enabled=NO;
			self.actionButton.enabled=NO;
		}
	}
	if(self.gameRound==2 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 2!" :@"Check out where Japan is moving his troops."];
	}
	if(self.gameRound==3 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 3!" :@"Its always good to have a nice mix of tanks and infantry in your attacks."];
	}
	if(self.gameRound==4 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 4!" :@"Factories are important. Try buying one and placing it near your front lines. Also double up factories for added income."];
	}
	if(self.gameRound==5 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 5!" :@"Capitals are well defended. Make sure you have lots of tanks and infantry before attacking."];
	}
	if(self.gameRound==6 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 6!" :@"As you get close to Japan, try to keep most of your tanks back and keep mostly infantry on the front lines."];
	}
	if(self.gameRound==7 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 7!" :@"Try attacking Japan where he has a high tank to infantry ratio. Tanks are expensive but defend the same as infantry."];
	}
	if(self.gameRound==8 && [@"Purchase" isEqualToString:self.playerStatusString]) {
		[ObjectiveCScripts showAlertPopup:@"Round 8!" :@"Try claiming all of the brown countries. You income is boosted by 10 IC per turn for each complete Superpower you control."];
	}
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];

	self.nChatView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width*2/3, self.nChatView.center.y);

    [self refreshMap2];
    [self showButtons];
}

- (IBAction) trainingXButtonClicked: (id) sender {
	self.trainingHelpView.hidden=YES;
}
- (IBAction) moreButtonClicked: (id) sender {
	self.bottomGrayToolBar.hidden=!self.bottomGrayToolBar.hidden;
}
- (IBAction) botXButtonClicked: (id) sender {
	self.bottomGrayToolBar.hidden=YES;
}

- (IBAction) place3InfoButtonClicked: (id) sender {
	[ObjectiveCScripts showAlertPopup:@"Place 3 Infantry" :@"Click on any country in your Superpower to place 3 infantry units."];
}

- (IBAction) place3ClearButtonClicked: (id) sender {
	[self.place3Array removeAllObjects];
	self.place3Label1.text = @"Select";
	self.place3Label2.text = @"Select";
	self.place3Label3.text = @"Select";
	self.place3DoneButton.enabled=NO;
	self.place3ClearButton.enabled=NO;
}
- (IBAction) place3DoneButtonClicked: (id) sender {
	[self executeThreadedJob:@selector(sendPlace3Data)];
}

-(void)sendPlace3Data
{
	@autoreleasepool {
		//    [NSThread sleepForTimeInterval:1];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"nations", nil];
		NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], [self.place3Array componentsJoinedByString:@"|"], nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobilePlace3.php":nameList:valueList];
		
		
		NSArray *components = [response componentsSeparatedByString:@"|"];
		if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
			if(![[components stringAtIndex:1] isEqualToString:@"Success"])
				[ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
		} else
			[ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
		
		self.diplomacyView.hidden=NO;
		[self refreshMap2];
		
	}
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint startTouchPosition = [touch locationInView:self.view];
	
	
	if(CGRectContainsPoint(self.place3View.frame, startTouchPosition)) {
		self.startTouchPosition = startTouchPosition;
		self.movingPlace3Flg=YES;
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint newTouchPosition = [touch locationInView:self.view];
	if(self.movingPlace3Flg)
		self.place3View.center=newTouchPosition;

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	self.movingPlace3Flg=NO;
}











@end
