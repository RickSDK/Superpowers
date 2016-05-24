//
//  PlaceUnitsVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/12/13.
//
//

#import <UIKit/UIKit.h>

@interface PlaceUnitsVC : UIViewController {
    IBOutlet UIButton *undoButton;
    IBOutlet UIButton *redoButton;
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *placeButton;
    IBOutlet UIButton *countryButton;
    IBOutlet UIButton *loadButton;
    IBOutlet UITextView *purchaseView;
    IBOutlet UITextView *placementView;
	UIViewController *callBackViewController;
    
    NSString *availableTerrString;
    NSString *purchaseString;
    NSString *placementString;
    NSString *origPurchaseString;
    NSString *countryWaterFlg;
    int buttonNumber;
    int gameId;
    
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;

}

- (IBAction) redoButtonClicked: (id) sender;
- (IBAction) undoButtonClicked: (id) sender;
- (IBAction) doneButtonClicked: (id) sender;

-(void) setReturningValue:(NSString *) value;

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UILabel *activityLabel;


@property (atomic, strong) UIButton *redoButton;
@property (atomic, strong) UIButton *undoButton;
@property (atomic, strong) UIButton *doneButton;
@property (atomic, strong) UIButton *placeButton;
@property (atomic, strong) UIButton *countryButton;
@property (atomic, strong) UIButton *loadButton;

@property (atomic, strong) NSString *purchaseString;
@property (atomic, strong) NSString *placementString;
@property (atomic, strong) NSString *origPurchaseString;
@property (atomic, strong) NSString *availableTerrString;
@property (atomic, strong) NSString *countryWaterFlg;

@property (atomic, strong) UITextView *purchaseView;
@property (atomic, strong) UITextView *placementView;
@property (atomic) int buttonNumber;
@property (atomic) int gameId;

@end
