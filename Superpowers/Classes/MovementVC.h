//
//  MovementVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"

@interface MovementVC : TemplateVC {
    IBOutlet UIButton *redoButton;
    IBOutlet UIButton *generalButton;
    
    NSString *redoFlg;
    NSString *generalFlg;
    
    int buttonNumber;
    int gameId;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	UIViewController *callBackViewController;

}
- (IBAction) undoButtonClicked: (id) sender;

- (IBAction) redoButtonClicked: (id) sender;
- (IBAction) moveButtonClicked: (id) sender;
- (IBAction) generalButtonClicked: (id) sender;
- (IBAction) loadButtonClicked: (id) sender;
- (IBAction) diplomacyButtonClicked: (id) sender;
- (IBAction) reassignButtonClicked: (id) sender;
- (IBAction) warButtonClicked: (id) sender;
- (IBAction) doneButtonClicked: (id) sender;
- (IBAction) reassignButtonClicked: (id) sender;

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UILabel *activityLabel;
@property (atomic) BOOL noRetreatFlg;


@property (atomic, strong) UIButton *redoButton;
@property (atomic, strong) UIButton *generalButton;

@property (atomic, strong) NSString *redoFlg;
@property (atomic, strong) NSString *generalFlg;

@property (atomic) int buttonNumber;
@property (atomic) int gameId;

@end
