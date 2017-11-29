//
//  StartVC.h
//  Superpowers
//
//  Created by Rick Medved on 10/30/17.
//
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"
#import "LoginObj.h"

@interface StartVC : TemplateVC

@property (nonatomic, strong) IBOutlet UIView *blackView;
@property (nonatomic, strong) IBOutlet UIWebView *mainWebView;
@property (nonatomic, strong) IBOutlet UIButton *gamesButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) LoginObj *loginObj;

- (IBAction) videoButtonClicked: (id) sender;
- (IBAction) gamessButtonClicked: (id) sender;

@end
