//
//  LoginVC.h
//  PokerTracker
//
//  Created by Rick Medved on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginVC : UIViewController {
	//---Passed In----------------------------
	//---XIB----------------------------
	IBOutlet UITextField *loginEmail;
	IBOutlet UITextField *loginPassword;
	IBOutlet UIButton *loginButton;
	IBOutlet UIButton *forgotButton;

	IBOutlet UITextField *neEmail;
	IBOutlet UITextField *nePassword;
	IBOutlet UITextField *rePassword;
	IBOutlet UIButton *createButton;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityBG;
	IBOutlet UIImageView *activityPopup;

	IBOutlet UIButton *rickButton;
	IBOutlet UIButton *robbButton;
	IBOutlet UIButton *testButton;

	//---Gloabls----------------------------
	
}

- (IBAction) rickPressed: (id) sender;
- (IBAction) robbPressed: (id) sender;
- (IBAction) testPressed: (id) sender;
- (IBAction) loginPressed: (id) sender;
- (IBAction) forgotPressed: (id) sender;
- (IBAction) createPressed: (id) sender;


@property (nonatomic, strong) UITextField *loginEmail;
@property (nonatomic, strong) UITextField *loginPassword;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgotButton;

@property (nonatomic, strong) UITextField *neEmail;
@property (nonatomic, strong) UITextField *nePassword;
@property (nonatomic, strong) UITextField *rePassword;
@property (nonatomic, strong) UIButton *createButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityBG;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;

@property (nonatomic, strong) UIButton *rickButton;
@property (nonatomic, strong) UIButton *robbButton;
@property (nonatomic, strong) UIButton *testButton;



@end
