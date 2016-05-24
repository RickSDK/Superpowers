//
//  CreateNewAccount.h
//  PokerTracker
//
//  Created by Rick Medved on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateNewAccount : UIViewController {
 	//---Passed In----------------------------
	NSManagedObjectContext *managedObjectContext;
	//---XIB----------------------------
	
	IBOutlet UITextField *neEmail;
	IBOutlet UITextField *firstname;
	IBOutlet UITextField *nePassword;
	IBOutlet UITextField *rePassword;
	IBOutlet UIButton *createButton;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityBG;
	IBOutlet UIImageView *activityPopup;

	IBOutlet UISwitch *policySwitch;

	//---Gloabls----------------------------
}

- (IBAction) switchPressed: (id) sender;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@property (nonatomic, strong) UITextField *neEmail;
@property (nonatomic, strong) UITextField *firstname;
@property (nonatomic, strong) UITextField *nePassword;
@property (nonatomic, strong) UITextField *rePassword;
@property (nonatomic, strong) UIButton *createButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityBG;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UISwitch *policySwitch;


@end
