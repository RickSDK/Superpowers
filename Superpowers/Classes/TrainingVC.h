//
//  TrainingVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrainingVC : UIViewController {

	IBOutlet UIButton *practiceButton;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	
	int game_id;
	
}

- (IBAction) basicsButtonClicked: (id) sender;
- (IBAction) practiceButtonClicked: (id) sender;


@property (nonatomic, strong) UIButton *practiceButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic) int game_id;


@end
