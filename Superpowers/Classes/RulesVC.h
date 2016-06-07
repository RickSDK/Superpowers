//
//  RulesVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/4/13.
//
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"

@interface RulesVC : TemplateVC

@property (nonatomic, strong) IBOutlet UIWebView *mainWebView;
@property (nonatomic, strong) IBOutlet UIView *nationView;

- (IBAction) nextButtonClicked: (id) sender;
- (IBAction) rulebookButtonClicked: (id) sender;
- (IBAction) video1ButtonClicked: (id) sender;
- (IBAction) video2ButtonClicked: (id) sender;
- (IBAction) nationsButtonClicked: (id) sender;

@end
