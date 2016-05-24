//
//  PlayerAttackVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/28/13.
//
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"

@interface PlayerAttackVC : UIViewController {
    IBOutlet UIWebView *mainWebView;
    int gameId;
    int terr_id;
    int mode;

	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UILabel *byteslabel;
	IBOutlet UIImageView *activityPopup;
	UIViewController *callBackViewController;
    UIBarButtonItem *rightButton;

}

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic) int gameId;
@property (nonatomic) int terr_id;
@property (nonatomic) int mode;

@property (nonatomic, strong) IBOutlet UIButton *mapButton;
@property (nonatomic, strong) IBOutlet UIButton *logsButton;
@property (nonatomic, strong) IBOutlet WebServiceView *webServiceView;
@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UILabel *byteslabel;
@property (nonatomic, strong) UIBarButtonItem *rightButton;

- (IBAction) mapButtonClicked: (id) sender;
- (IBAction) logsButtonClicked: (id) sender;


@end
