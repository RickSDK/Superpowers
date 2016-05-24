//
//  GamesVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"
#import "LoginObj.h"

@interface GamesVC : TemplateVC

@property (nonatomic, strong) LoginObj *loginObj;
@property (atomic, strong) IBOutlet UILabel *gamesLabel;
@property (atomic, strong) IBOutlet UILabel *openGamesLabel;
@property (atomic, strong) IBOutlet UIButton *joinButton;
@property (atomic, strong) IBOutlet UIButton *leagueButton;
	
//@property (atomic) int userRank;
//@property (atomic) int user_id;
	
@property (atomic) int selectedRow;
@property (atomic) int buttonNumber;
@property (atomic) int challengeId;
    

- (IBAction) joinButtonPressed: (id) sender;
- (IBAction) leagueButtonPressed: (id) sender;





@end
