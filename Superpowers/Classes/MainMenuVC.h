//
//  MainMenuVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginObj.h"
#import "TemplateVC.h"


@interface MainMenuVC : TemplateVC {

	IBOutlet UIImageView *titleScreen;
	IBOutlet UIImageView *mapImg;
	BOOL showDisolve;
	BOOL screenLock;
	int logoAlpha;
	IBOutlet UILabel *usernameLabel;
	IBOutlet UILabel *versionLabel;
	IBOutlet UILabel *chatLabel;
	IBOutlet UIButton *gamesButton;
	IBOutlet UIButton *retryButton;
	IBOutlet UIButton *profileButton;
	IBOutlet UIButton *leadersButton;
	IBOutlet UIButton *rulesButton;
	IBOutlet UIButton *unitsButton;
	IBOutlet UIButton *chatButton;
	IBOutlet UIBarButtonItem *mailButton;
	IBOutlet UIButton *bugButton;
	IBOutlet UIButton *trainingButton;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

- (IBAction) rulesButtonClicked: (id) sender;
- (IBAction) leadersButtonClicked: (id) sender;
- (IBAction) gamessButtonClicked: (id) sender;
- (IBAction) chatButtonClicked: (id) sender;
- (IBAction) retryButtonClicked: (id) sender;
- (IBAction) unitsButtonClicked: (id) sender;
- (IBAction) profileButtonClicked:(id)sender;
- (IBAction) mailButtonClicked:(id)sender;
- (IBAction) bugButtonClicked:(id)sender;
- (IBAction) rankedButtonClicked:(id)sender;
- (IBAction) nextRankButtonClicked: (id) sender;
- (IBAction) emailButtonClicked: (id) sender;
- (IBAction) rulebookButtonClicked: (id) sender;

@property (nonatomic) BOOL showDisolve;
@property (nonatomic) BOOL screenLock;
@property (nonatomic) int logoAlpha;
@property (nonatomic, strong) UIImageView *titleScreen;
@property (nonatomic, strong) UIImageView *mapImg;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UILabel *rankLabel;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIImageView *rankImageView;
@property (nonatomic, strong) IBOutlet UIButton *matchMakingButton;
@property (nonatomic, strong) IBOutlet UIView *chatView;
@property (nonatomic, strong) IBOutlet UIView *profileView;
@property (nonatomic, strong) IBOutlet UIView *popupView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *chatLabel;
@property (nonatomic, strong) UIButton *gamesButton;
@property (nonatomic, strong) UIButton *retryButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIButton *profileButton;
@property (nonatomic, strong) UIButton *leadersButton;
@property (nonatomic, strong) UIButton *rulesButton;
@property (nonatomic, strong) UIButton *unitsButton;
@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UIBarButtonItem *mailButton;
@property (nonatomic, strong) UIButton *bugButton;
@property (nonatomic, strong) UIButton *trainingButton;
@property (nonatomic, strong) LoginObj *loginObj;


@end
