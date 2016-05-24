//
//  GameBasicsVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameBasicsVC.h"
#import "MainMenuVC.h"
#import "ObjectiveCScripts.h"

@implementation GameBasicsVC
@synthesize step1, step2, textView, nextButton, step, step3;


- (IBAction) nextButtonClicked: (id) sender
{
	self.step++;
	
	[self showProperView];
	
	
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Game Basics"];
	
	step1.alpha=0;
	step2.alpha=0;
	textView.alpha=0;		
    self.combatImg.alpha=0;
	self.nextButton.hidden=YES;
	[self showProperView];
	
}

-(void)showProperView {
	NSLog(@"+++step: %d", self.step);
	self.screenStep2.alpha=0;
	if(step==1) {
		step1.alpha=0;
		step2.alpha=0;
		self.screenStep2.alpha=1;
		textView.alpha=1;
		[ObjectiveCScripts setUserDefaultValue:@"Y" forKey:@"basicsViewed"];
		
	}
	
	if(step==2) {
		step1.alpha=1;
		step2.alpha=0;
		textView.alpha=0;
		step1.image = [UIImage imageNamed:@"basic.PNG"];
	}
	
	if(step==3) {
		self.strategyTextView.hidden=YES;
		step1.alpha=0;
		step2.alpha=1;
		step2.image = [UIImage imageNamed:@"income1.png"];
		self.nextButton.hidden=NO;
	}
	if(step==4) {
		step2.image = [UIImage imageNamed:@"income2.png"];
	}
	if(step==5) {
		step2.image = [UIImage imageNamed:@"income3.png"];
	}
	if(step==6) {
		step2.image = [UIImage imageNamed:@"income4.png"];
	}
	
	if(step>=7)
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}







@end
