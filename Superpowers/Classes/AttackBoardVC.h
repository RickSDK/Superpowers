//
//  AttackBoardVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/28/13.
//
//

#import <UIKit/UIKit.h>

@interface AttackBoardVC : UIViewController {
    IBOutlet UIWebView *mainWebView;
    int gameId;
    int terr_id;
    int mode;
    BOOL goBackToBoardFlg;
    
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	IBOutlet UIButton *attackButton;
	IBOutlet UIButton *retreatButton;
	IBOutlet UIButton *generalButton;
	IBOutlet UIButton *planesButton;
	IBOutlet UIButton *bombersButton;
	IBOutlet UIButton *continueButton;

	UIViewController *callBackViewController;
	UIBarButtonItem *rightButton;
	UIBarButtonItem *leftButton;
	
}

- (IBAction) attackButtonClicked: (id) sender;
- (IBAction) retreatButtonClicked: (id) sender;
- (IBAction) generalButtonClicked: (id) sender;
- (IBAction) planesButtonClicked: (id) sender;
- (IBAction) bombersButtonClicked: (id) sender;
- (IBAction) continueButtonClicked: (id) sender;

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic) int gameId;
@property (nonatomic) int terr_id;
@property (nonatomic) int mode;
@property (nonatomic) BOOL goBackToBoardFlg;
@property (nonatomic) BOOL battleRaging;

@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIButton *attackButton;
@property (nonatomic, strong) UIButton *retreatButton;
@property (nonatomic, strong) UIButton *generalButton;
@property (nonatomic, strong) UIButton *planesButton;
@property (nonatomic, strong) UIButton *bombersButton;
@property (nonatomic, strong) UIButton *continueButton;
@property (nonatomic, strong) UIBarButtonItem *rightButton;
@property (nonatomic, strong) UIBarButtonItem *leftButton;

@end
