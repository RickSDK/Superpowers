//
//  SBCBuildVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import <UIKit/UIKit.h>

@interface SBCBuildVC : UIViewController {
	UIViewController *callBackViewController;

    IBOutlet UILabel *costLabel;
    IBOutlet UITextField *nameField;
    IBOutlet UISwitch *att5Switch;
    IBOutlet UISwitch *attDice1Switch;
    IBOutlet UISwitch *attDice2Switch;
    IBOutlet UISwitch *def5Switch;
    IBOutlet UISwitch *defDice1Switch;
    IBOutlet UISwitch *defDice2Switch;

    IBOutlet UISwitch *hp1Switch;
    IBOutlet UISwitch *hp2Switch;
    IBOutlet UISwitch *ad1Switch;
    IBOutlet UISwitch *ad2Switch;
    
    int currentMoney;
    UIBarButtonItem *rightButton;

}

- (IBAction) switchChanged: (id) sender;

@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UISwitch *att5Switch;
@property (nonatomic, strong) UISwitch *attDice1Switch;
@property (nonatomic, strong) UISwitch *attDice2Switch;
@property (nonatomic, strong) UISwitch *def5Switch;
@property (nonatomic, strong) UISwitch *defDice1Switch;
@property (nonatomic, strong) UISwitch *defDice2Switch;

@property (nonatomic, strong) UISwitch *hp1Switch;
@property (nonatomic, strong) UISwitch *hp2Switch;
@property (nonatomic, strong) UISwitch *ad1Switch;
@property (nonatomic, strong) UISwitch *ad2Switch;
@property (nonatomic, strong) UIBarButtonItem *rightButton;
@property (nonatomic) int currentMoney;



@end
