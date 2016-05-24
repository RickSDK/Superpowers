//
//  AttackVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import <UIKit/UIKit.h>

@interface AttackVC : UIViewController {
    IBOutlet UIButton *bombButton;
    IBOutlet UIButton *cruiseButton;
 
    NSString *bombFlg;
    NSString *cruiseFlg;
    NSString *redoMoney;
    
    int buttonNumber;
    int gameId;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	UIViewController *callBackViewController;

}

- (IBAction) redoButtonClicked: (id) sender;
- (IBAction) attackButtonClicked: (id) sender;
- (IBAction) bombButtonClicked: (id) sender;
- (IBAction) cruiseButtonClicked: (id) sender;
- (IBAction) loadButtonClicked: (id) sender;
- (IBAction) moveButtonClicked: (id) sender;
- (IBAction) doneButtonClicked: (id) sender;

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UILabel *activityLabel;


@property (atomic, strong) UIButton *bombButton;
@property (atomic, strong) UIButton *cruiseButton;

@property (atomic, copy) NSString *redoMoney;
@property (atomic, copy) NSString *bombFlg;
@property (atomic, copy) NSString *cruiseFlg;

@property (atomic) int buttonNumber;
@property (atomic) int gameId;

@end
