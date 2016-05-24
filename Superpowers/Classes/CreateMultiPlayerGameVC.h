//
//  CreateMultiPlayerGameVC.h
//  Superpowers
//
//  Created by Rick Medved on 1/31/13.
//
//

#import <UIKit/UIKit.h>

@interface CreateMultiPlayerGameVC : UIViewController {
    IBOutlet UISegmentedControl *numPlayersSegment;
    IBOutlet UISegmentedControl *attackRoundSegment;
    IBOutlet UISwitch *fogOfWarSwitch;
    IBOutlet UISwitch *randomNamtionsSwitch;
	IBOutlet UIButton *startButton;
	IBOutlet UIButton *typeButton;
    IBOutlet UILabel *typeDescTextView;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
    IBOutlet UITextField *nameField;
    
    int type;
}

- (IBAction) startButtonClicked: (id) sender;
- (IBAction) typeButtonClicked: (id) sender;

@property (nonatomic, strong) UISegmentedControl *numPlayersSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *attackRoundSegment;
@property (nonatomic, strong) IBOutlet UISwitch *fogOfWarSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *randomNamtionsSwitch;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *typeButton;
@property (nonatomic, strong) IBOutlet UILabel *typeDescTextView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;

@property (nonatomic, strong) UITextField *nameField;


@property (nonatomic) int type;

@end
