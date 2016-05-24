//
//  CreateSinglePlayerGameVC.h
//  Superpowers
//
//  Created by Rick Medved on 1/31/13.
//
//

#import <UIKit/UIKit.h>

@interface CreateSinglePlayerGameVC : UIViewController {

    IBOutlet UISegmentedControl *numPlayersSegment;
    IBOutlet UISegmentedControl *attackRoundSegment;
    IBOutlet UISwitch *fogOfWarSwitch;
    IBOutlet UISwitch *randomNamtionsSwitch;
	IBOutlet UIButton *startButton;

    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;

}

- (IBAction) startButtonClicked: (id) sender;

@property (nonatomic, strong) UISegmentedControl *numPlayersSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *attackRoundSegment;
@property (nonatomic, strong) IBOutlet UISwitch *fogOfWarSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *randomNamtionsSwitch;
@property (nonatomic, strong) IBOutlet UIButton *startButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic) int userRank;

@end
