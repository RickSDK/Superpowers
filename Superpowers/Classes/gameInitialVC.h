//
//  gameInitialVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/10/13.
//
//

#import <UIKit/UIKit.h>
#import "GameObj.h"
#import "TemplateVC.h"

@interface gameInitialVC : TemplateVC {
    NSString *gameName;
    NSString *gameStatus;
    NSString *skipTurnFlg;
    NSString *startGameFlg;
    NSString *cancelGameFlg;
	int gameId;
	int buttonNumber;
	int playerTurn;
    
    IBOutlet UILabel *roundLabel;
    IBOutlet UILabel *gametypeLabel;
    IBOutlet UILabel *attRoundLabel;
    IBOutlet UILabel *timerLabel;
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
    
    IBOutlet UIButton *aiButton;
    IBOutlet UIButton *surrenderButton;
    IBOutlet UIButton *logsButton;
    IBOutlet UIButton *techButton;
    IBOutlet UIButton *alliesButton;
    IBOutlet UIButton *chatButton;
    IBOutlet UIButton *mapButton;
    IBOutlet UITableView *mainTableView;
    
    NSString *gameDetailsString;
	GameObj *gameObj;

}

- (IBAction) logsButtonClicked: (id) sender;
- (IBAction) techButtonClicked: (id) sender;
- (IBAction) alliesButtonClicked: (id) sender;
- (IBAction) chatButtonClicked: (id) sender;
- (IBAction) mapButtonClicked: (id) sender;
- (IBAction) aiButtonClicked: (id) sender;
- (IBAction) surrenderButtonClicked: (id) sender;

@property (atomic, copy) NSString *gameDetailsString;
@property (atomic, copy) NSString *gameStatus;
@property (atomic, copy) NSString *gameName;
@property (atomic, copy) NSString *skipTurnFlg;
@property (atomic, copy) NSString *startGameFlg;
@property (atomic, copy) NSString *cancelGameFlg;
@property (atomic, strong) GameObj *gameObj;


@property (atomic) int gameId;
@property (atomic) int buttonNumber;
@property (atomic) int playerTurn;


@property (atomic, strong) UILabel *roundLabel;
@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UILabel *activityLabel;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UIButton *aiButton;
@property (atomic, strong) UIButton *surrenderButton;
@property (atomic, strong) UIButton *mapButton;
@property (atomic, strong) UIButton *logsButton;
@property (atomic, strong) UIButton *techButton;
@property (atomic, strong) UIButton *alliesButton;
@property (atomic, strong) UIButton *chatButton;
@property (atomic, strong) UILabel *gametypeLabel;
@property (atomic, strong) UILabel *attRoundLabel;
@property (atomic, strong) UILabel *timerLabel;


@end
