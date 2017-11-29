//
//  PtpButton.m
//  PokerTracker
//
//  Created by Rick Medved on 8/11/17.
//
//

#import "PtpButton.h"

@implementation PtpButton

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit
{
	[self assignMode:(int)self.tag];
	[self setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

-(void)assignMode:(int)mode {
	// 0 = yellow
	// 1 = green
	// 2 = light-gray
	// 3 = red
	// 4 = gray (disabled)
	self.mode=mode;
	[self newButtonLook:self mode:mode];
}

-(void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	if(enabled) {
		[self newButtonLook:self mode:self.mode];
		self.alpha=1;
	} else {
		[self newButtonLook:self mode:4];
		[self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		self.alpha=.8;
	}
}

-(void)newButtonLook:(UIButton *)button mode:(int)mode {
	int themeNumber = 0;
	
	// all buttons------
	[button setTitleShadowColor:nil forState:UIControlStateNormal];
	// all buttons------
	
	if(themeNumber == 2)
		[self changeToClassicThemeForButton:button mode:mode];
	else
		[self changeToModernThemeForButton:button mode:mode theme:themeNumber];
	
}

-(void)changeToClassicThemeForButton:(UIButton *)button mode:(int)mode {
	button.layer.masksToBounds = YES;
	button.backgroundColor=[UIColor clearColor];
	button.layer.borderWidth = 0;
	if(mode==0) {
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"yellowChromeBut.png"] forState:UIControlStateNormal];
	}
	if(mode==1) {
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"greenChromeBut.png"] forState:UIControlStateNormal];
	}
	if(mode==2) {
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"whiteChromeBut.png"] forState:UIControlStateNormal];
	}
	if(mode==3) {
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"redChromeBut.png"] forState:UIControlStateNormal];
	}
	if(mode==4) {
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"whiteChromeBut.png"] forState:UIControlStateNormal];
	}
	if(mode==5) {
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"blueChromeBut.png"] forState:UIControlStateNormal];
	}
}

-(void)changeToModernThemeForButton:(UIButton *)button mode:(int)mode theme:(int)theme {
	//	UIColor *color = [UIColor colorWithRed:1 green:.85 blue:0 alpha:1];
	[button setBackgroundImage:nil forState:UIControlStateNormal];
	
	UIColor *primaryButtonColor = [UIColor colorWithRed:1 green:.8 blue:0 alpha:1];
	UIColor *themeBGColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
	
	UIColor *highBgColor = (mode==1)?primaryButtonColor:themeBGColor;
	UIColor *highTextColor = (mode!=1)?primaryButtonColor:themeBGColor;
	[button setBackgroundImage:[self imageFromColor:highBgColor]
					  forState:UIControlStateHighlighted];
	[button setTitleColor:highTextColor forState:UIControlStateHighlighted];
	
	if(theme==0) { // modern
		button.layer.cornerRadius = 7;
		button.layer.masksToBounds = NO;
		button.layer.shadowColor = [UIColor blackColor].CGColor;
		button.layer.shadowOffset = CGSizeMake(4, 4);
		button.layer.shadowRadius = 5;
		button.layer.shadowOpacity = 0.85;
		button.layer.borderWidth = 0;
	} else if (theme==1) { //flat
		button.layer.cornerRadius = 0;
		button.layer.masksToBounds = YES;
		button.layer.shadowOffset = CGSizeMake(0, 0);
		button.layer.shadowRadius = 0;
		button.layer.shadowOpacity = 0;
		button.layer.borderWidth = 0;
	} else { // outline
		button.layer.cornerRadius = 4;
		button.layer.masksToBounds = NO;
		button.layer.shadowOffset = CGSizeMake(2, 2);
		button.layer.shadowRadius = 5;
		button.layer.shadowOpacity = 1;
		button.layer.shadowColor = [UIColor whiteColor].CGColor;
		button.layer.borderColor = [UIColor blackColor].CGColor;
		button.layer.borderWidth = 1;
	}
	
	if(mode==0) { // yellow
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundColor:primaryButtonColor];
		
	}
	if(mode==1) { // green
		button.layer.borderColor = [UIColor whiteColor].CGColor;
		button.layer.borderWidth = 1;
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundColor:themeBGColor];
		//[UIColor colorWithRed:.2 green:.8 blue:.2 alpha:1]
	}
	if(mode==2) { // gray
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1]];
		
	}
	if(mode==3) { // red
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
		
	}
	if(mode==4) { // dark gray
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor colorWithRed:.6 green:.6 blue:.6 alpha:1]];
		
	}
	if(mode==5) { // blue
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor colorWithRed:0 green:.6 blue:1 alpha:1]];
		
	}
	
}
- (UIImage *) imageFromColor:(UIColor *)color {
	CGRect rect = CGRectMake(0, 0, 1, 1);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end
