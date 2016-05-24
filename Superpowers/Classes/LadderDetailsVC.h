//
//  LadderDetailsVC.h
//  Superpowers
//
//  Created by Rick Medved on 4/9/13.
//
//

#import <UIKit/UIKit.h>
#import "LoginObj.h"
#import "TemplateVC.h"

@interface LadderDetailsVC : TemplateVC {

    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIButton *joinButton;
    IBOutlet UIButton *increaseButton;
    IBOutlet UIButton *decreaseButton;
    IBOutlet UILabel *activityLabel;
    IBOutlet UIImageView *activityPopup;
    IBOutlet UITextView *gamestextView;
    int leagueCount;
    int userRank;
}

- (IBAction) joinButtonPressed: (id) sender;
- (IBAction) increaseButtonPressed: (id) sender;
- (IBAction) decreaseButtonPressed: (id) sender;


@property (nonatomic, strong) LoginObj *loginObj;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UISegmentedControl *mainSegment;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UITextView *gamestextView;
@property (nonatomic) int leagueCount;
@property (nonatomic) int userRank;

@end
