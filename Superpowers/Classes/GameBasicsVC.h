//
//  GameBasicsVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameBasicsVC : UIViewController {

	IBOutlet UIImageView *step1;
	IBOutlet UIImageView *step2;
	IBOutlet UIImageView *screenStep2;
	IBOutlet UIImageView *step3;
	IBOutlet UIImageView *combatImg;
	IBOutlet UITextView *textView;
	IBOutlet UITextView *strategyTextView;
	IBOutlet UIButton *nextButton;
	int step;
}

- (IBAction) nextButtonClicked: (id) sender;

@property (nonatomic, strong) UIImageView *step1;
@property (nonatomic, strong) UIImageView *step2;
@property (nonatomic, strong) UIImageView *step3;
@property (nonatomic, strong) UIImageView *combatImg;
@property (nonatomic, strong) UIImageView *screenStep2;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UITextView *strategyTextView;
@property (nonatomic) int step;




@end
