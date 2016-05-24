//
//  GameScreenVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameObj.h"
#import "TemplateVC.h"


@interface GameScreenVC : TemplateVC {
	IBOutlet UISegmentedControl *gameSegment;
	IBOutlet UIWebView *mainWebView;
	IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIToolbar *topToolBar;
    IBOutlet UIButton *undoButton;
    IBOutlet UIButton *actionButton;
    IBOutlet UIButton *completeButton;
	GameObj *gameObj;
	
	IBOutlet UIToolbar *bottomToolBar;
	IBOutlet UIToolbar *bottomGrayToolBar;
    UIBarButtonItem *takeTurnButton;
//	NSString *gameName;
	BOOL buy3_flg;
	int gameId;
	int nation;
    int originalMoney;
    int terr_id;
    int buttonNumber;
    int dipCount;
	BOOL showPanelFlg;
	BOOL cpuFlg;
    NSString *gameDetailsString;
    NSString *playerStatusString;
    NSString *gameStatus;
	BOOL playerTurnFlg;
    NSMutableArray *territoryArray;
    NSString *dipomacyString;
    NSString *purchaseLockFlg;
    BOOL trainingFlg;
	IBOutlet UIView *statusView;
	IBOutlet UIImageView *panelBG;
    
	NSMutableArray *hueColors;

    IBOutlet UIImageView *detailView;
    IBOutlet UIImageView *detailFlagView;
    IBOutlet UITextView *unitTextView;
	IBOutlet UILabel *detailNameLabel;
	IBOutlet UIButton *detailXButton;
    
	IBOutlet UIButton *purchasessButton;
	IBOutlet UILabel *topRound1Label;
	IBOutlet UILabel *topRound2Label;
	IBOutlet UILabel *topAttack1Label;
	IBOutlet UILabel *topAttack2Label;
    IBOutlet UIImageView *topNationImg;
    IBOutlet UIImageView *topBGImg;

    IBOutlet UIButton *logsButton;
    IBOutlet UIButton *TechButton;
	IBOutlet UIButton *alliesButton;
	IBOutlet UIButton *chatButton;

	IBOutlet UIButton *detailActionButton;
	IBOutlet UIButton *detailBombButton;
	IBOutlet UIButton *detailCruiseButton;
	IBOutlet UIButton *detailLoadButton;
	IBOutlet UIButton *detailMoveButton;

    
    IBOutlet UITableView *mainTableView;
	int playerTurn;
    BOOL showTableViewFlg;
    BOOL cruiseFlg;
    int originalTechCount;
    int originalRRCount;
    int originalBalisticsCount;
    int gameRound;
    int attackRound;
    int terrLastAttackRound;
    int terrLastAttackBy;
    int attackZone;
    int terrHardId;
    int specialUnitNumber;

}


- (IBAction) dismissDetailButtonClicked: (id) sender;
- (IBAction) diplomacyXButtonClicked: (id) sender;

- (IBAction) actionButtonClicked: (id) sender;
- (IBAction) bombButtonClicked: (id) sender;
- (IBAction) cruiseButtonClicked: (id) sender;
- (IBAction) loadButtonClicked: (id) sender;
- (IBAction) moveButtonClicked: (id) sender;

- (IBAction) showPurchasesButtonClicked: (id) sender;
- (IBAction) logsButtonClicked: (id) sender;
- (IBAction) techButtonClicked: (id) sender;
- (IBAction) alliesButtonClicked: (id) sender;
- (IBAction) statsButtonClicked: (id) sender;
- (IBAction) incomeButtonClicked: (id) sender;
- (IBAction) chatButtonClicked: (id) sender;
- (IBAction) diplomacyButtonClicked: (id) sender;

- (IBAction) actionToolbarButtonClicked: (id) sender;
- (IBAction) redoToolbarButtonClicked: (id) sender;
- (IBAction) doneToolbarButtonClicked: (id) sender;
- (IBAction) helpButtonClicked: (id) sender;
- (IBAction) xButtonClicked: (id) sender;
- (IBAction) moreButtonClicked: (id) sender;
- (IBAction) botXButtonClicked: (id) sender;

- (IBAction) place3InfoButtonClicked: (id) sender;
- (IBAction) place3ClearButtonClicked: (id) sender;
- (IBAction) place3DoneButtonClicked: (id) sender;

-(void)refreshMap;
-(void) setReturningValueRedo:(NSString *) value;
-(void) setReturningValue:(NSString *) value;

@property (atomic, strong) GameObj *gameObj;
@property (atomic, strong) UIToolbar *bottomGrayToolBar;;
@property (atomic, strong) UIToolbar *bottomToolBar;
@property (atomic, strong) UIToolbar *topToolBar;
@property (atomic, strong) UIButton *undoButton;
@property (atomic, strong) UIButton *actionButton;
@property (atomic, strong) UIButton *completeButton;

@property (atomic, strong) UIBarButtonItem *takeTurnButton;
@property (atomic, strong) UIButton *purchasessButton;
@property (atomic, strong) UILabel *topRound1Label;
@property (atomic, strong) UILabel *topRound2Label;
@property (atomic, strong) UILabel *topAttack1Label;
@property (atomic, strong) UILabel *topAttack2Label;
@property (atomic, strong) UIImageView *topNationImg;
@property (atomic, strong) UIImageView *topBGImg;

@property (atomic, strong) UIButton *logsButton;
@property (atomic, strong) UIButton *TechButton;
@property (atomic, strong) UIButton *alliesButton;
@property (atomic, strong) UIButton *chatButton;

@property (atomic, strong) IBOutlet UIButton *diplomacyButton;
@property (atomic, strong) IBOutlet UIView *diplomacyView;
@property (atomic, strong) IBOutlet UILabel *diplomacyLabel;

@property (atomic, strong) IBOutlet UIView *territoryDetailView;
@property (atomic, strong) UIImageView *detailFlagView;
@property (atomic, strong) UILabel *detailNameLabel;
@property (atomic, strong) UIButton *detailXButton;
@property (atomic, strong) UITextView *unitTextView;

@property (atomic, copy) NSString *dipomacyString;
@property (atomic, copy) NSString *gameDetailsString;
@property (atomic, copy) NSString *playerStatusString;
@property (atomic, copy) NSString *gameStatus;
//@property (atomic, copy) NSString *gameName;
@property (atomic) BOOL buy3_flg;
@property (atomic, copy) NSString *purchaseLockFlg;
@property (atomic, copy) NSString *yourStatus;

//@property (atomic, strong) NSMutableArray *playerArray;
@property (atomic, strong) NSMutableArray *territoryArray;
@property (atomic, strong) NSMutableArray *hueColors;

@property (atomic) BOOL cpuFlg;
@property (atomic) BOOL showTableViewFlg;
@property (atomic) BOOL trainingFlg;
@property (atomic) BOOL leaderInCapital;
@property (atomic) BOOL purchase_done_flg;
@property (atomic) BOOL noRetreatFlg;
@property (atomic) int placeUnitType;

@property (atomic) int playerTurn;
@property (atomic) BOOL cruiseFlg;
@property (atomic) int originalTechCount;
@property (atomic) int originalRRCount;
@property (atomic) int originalBalisticsCount;
@property (atomic) int gameRound;
@property (atomic) int attackRound;
@property (atomic) int terrLastAttackRound;
@property (atomic) int terrLastAttackBy;
@property (atomic) int attackZone;
@property (atomic) int terrHardId;



@property (atomic, strong) UIButton *detailActionButton;
@property (atomic, strong) UIButton *detailBombButton;
@property (atomic, strong) UIButton *detailCruiseButton;
@property (atomic, strong) UIButton *detailLoadButton;
@property (atomic, strong) UIButton *detailMoveButton;


@property (atomic) BOOL playerTurnFlg;
@property (atomic, strong) UISegmentedControl *gameSegment;
@property (atomic, strong) UIWebView *mainWebView;
@property (atomic) int gameId;
@property (atomic) int originalMoney;
@property (atomic) int nation;
//@property (atomic) int terr_id;
@property (atomic) int buttonNumber;
@property (atomic) int dipCount;
@property (atomic) int specialUnitNumber;
@property (atomic) int purchasePiece;
@property (atomic) BOOL showPanelFlg;
@property (atomic) CGPoint startTouchPosition;
@property (atomic) BOOL movingPlace3Flg;

@property (atomic, strong) UIScrollView *mainScrollView;
@property (atomic, strong) UIView *statusView;
@property (atomic, strong) UIImageView *panelBG;

@property (atomic, strong) IBOutlet UIView *place3View;
@property (atomic, strong) IBOutlet UIView *nChatView;
@property (atomic, strong) NSMutableArray *place3Array;
@property (atomic, strong) IBOutlet UILabel *place3Label1;
@property (atomic, strong) IBOutlet UILabel *place3Label2;
@property (atomic, strong) IBOutlet UILabel *place3Label3;
@property (atomic, strong) IBOutlet UIButton *place3ClearButton;
@property (atomic, strong) IBOutlet UIButton *place3DoneButton;




@end
