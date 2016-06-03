//
//  ProfileVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/20/13.
//
//

#import <UIKit/UIKit.h>
#import "LoginObj.h"
#import "TemplateVC.h"

@interface ProfileVC : TemplateVC {

    IBOutlet UILabel *usernameLabel;
	IBOutlet UILabel *rankLabel;
	IBOutlet UILabel *winsLabel;
	IBOutlet UILabel *lossesLabel;
	IBOutlet UILabel *gamesLabel;
	IBOutlet UILabel *streakLabel;
	IBOutlet UILabel *last10Label;
	IBOutlet UILabel *ratingLabel;
	IBOutlet UIImageView *rankImageView;

}


@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *winsLabel;
@property (nonatomic, strong) UILabel *lossesLabel;
@property (nonatomic, strong) UILabel *gamesLabel;
@property (nonatomic, strong) UILabel *streakLabel;
@property (nonatomic, strong) UILabel *last10Label;
@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, strong) LoginObj *loginObj;

@property (nonatomic, strong) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) IBOutlet UIButton *phoneButton;
@property (nonatomic, strong) IBOutlet UIButton *testButton;
@property (nonatomic, strong) IBOutlet UIButton *updateButton;

- (IBAction) infoButtonClicked: (id) sender;
- (IBAction) updateButtonClicked: (id) sender;
- (IBAction) testButtonClicked: (id) sender;
- (IBAction) phoneButtonClicked: (id) sender;

@end
