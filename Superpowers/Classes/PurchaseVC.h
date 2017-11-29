//
//  PurchaseVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/11/13.
//
//

#import <UIKit/UIKit.h>

@interface PurchaseVC : UIViewController {
    IBOutlet UISegmentedControl *unitSegment;
    IBOutlet UIButton *clearButton;
    IBOutlet UIButton *completeButton;
    IBOutlet UIButton *techButton;
    IBOutlet UIButton *railwayButton;
    IBOutlet UIButton *balisticsButton;
    IBOutlet UIButton *singleBuy1Button;
    IBOutlet UIButton *singleBuy2Button;
    IBOutlet UIButton *singleBuy3Button;
    IBOutlet UIButton *singleBuy4Button;
    IBOutlet UIButton *multiBuy1Button;
    IBOutlet UIButton *multiBuy2Button;
    IBOutlet UIButton *multiBuy3Button;
    IBOutlet UIButton *multiBuy4Button;
    IBOutlet UILabel *moneyLabel;
    IBOutlet UILabel *piece1Label;
    IBOutlet UILabel *piece2Label;
    IBOutlet UILabel *piece3Label;
    IBOutlet UILabel *piece4Label;
    IBOutlet UITextView *purchasesTextView;
    IBOutlet UIImageView *piece1ImageView;
    IBOutlet UIImageView *piece2ImageView;
    IBOutlet UIImageView *piece3ImageView;
    IBOutlet UIImageView *piece4ImageView;

    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;

    NSString *purchasesString;
    NSString *sbcString;
    int originalMoney;
    int currentMoney;
    int originalTechCount;
    int originalRRCount;
    int originalBalisticsCount;

    int currentTechCount;
    int currentRRCount;
    int currentBalisticsCount;
	int round;

    int playerNation;
    int gameId;
    int specialUnitNumber;
    BOOL trainingFlg;
    
    NSString *specUnit1Flg;
    NSString *specUnit2Flg;
    NSString *specUnit3Flg;
	UIViewController *callBackViewController;

}

- (IBAction) unitSegmentChanged: (id) sender;
- (IBAction) clearButtonClicked: (id) sender;
- (IBAction) completeButtonClicked: (id) sender;
- (IBAction) techButtonClicked: (id) sender;
- (IBAction) railwayButtonClicked: (id) sender;
- (IBAction) balisticsButtonClicked: (id) sender;
- (IBAction) info1ButtonClicked: (id) sender;
- (IBAction) info2ButtonClicked: (id) sender;
- (IBAction) info3ButtonClicked: (id) sender;
- (IBAction) info4ButtonClicked: (id) sender;
- (IBAction) singleBuy1ButtonClicked: (id) sender;
- (IBAction) singleBuy2ButtonClicked: (id) sender;
- (IBAction) singleBuy3ButtonClicked: (id) sender;
- (IBAction) singleBuy4ButtonClicked: (id) sender;
- (IBAction) multiBuy1ButtonClicked: (id) sender;
- (IBAction) multiBuy2ButtonClicked: (id) sender;
- (IBAction) multiBuy3ButtonClicked: (id) sender;
- (IBAction) multiBuy4ButtonClicked: (id) sender;
- (IBAction) technologiesButtonClicked: (id) sender;
- (IBAction) autoBuyButtonClicked: (id) sender;
-(void) setReturningValue:(NSString *) value;

@property (atomic, strong) UISegmentedControl *unitSegment;

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UILabel *activityLabel;

@property (atomic) int originalMoney;
@property (atomic) int currentMoney;
@property (atomic) int gameId;
@property (atomic) int specialUnitNumber;
@property (atomic) BOOL trainingFlg;
@property (atomic) BOOL purchase_done_flg;

@property (atomic, strong) UIButton *clearButton;
@property (atomic, strong) UIButton *completeButton;
@property (atomic, strong) UIButton *techButton;
@property (atomic, strong) UIButton *railwayButton;
@property (atomic, strong) UIButton *balisticsButton;
@property (atomic, strong) UIButton *singleBuy1Button;
@property (atomic, strong) UIButton *singleBuy2Button;
@property (atomic, strong) UIButton *singleBuy3Button;
@property (atomic, strong) UIButton *singleBuy4Button;
@property (atomic, strong) UIButton *multiBuy1Button;
@property (atomic, strong) UIButton *multiBuy2Button;
@property (atomic, strong) UIButton *multiBuy3Button;
@property (atomic, strong) UIButton *multiBuy4Button;
@property (atomic, strong) UILabel *moneyLabel;
@property (atomic, strong) UILabel *piece1Label;
@property (atomic, strong) UILabel *piece2Label;
@property (atomic, strong) UILabel *piece3Label;
@property (atomic, strong) UILabel *piece4Label;
@property (atomic, strong) IBOutlet UILabel *numTechsLabel;
@property (atomic, strong) IBOutlet UIButton *autoPurchaseButton;
@property (atomic, strong) UITextView *purchasesTextView;

@property (atomic, strong)  UIImageView *piece1ImageView;
@property (atomic, strong)  UIImageView *piece2ImageView;
@property (atomic, strong)  UIImageView *piece3ImageView;
@property (atomic, strong)  UIImageView *piece4ImageView;

@property (atomic) int originalTechCount;
@property (atomic) int originalRRCount;
@property (atomic) int originalBalisticsCount;
@property (atomic) int round;


@property (atomic) int currentTechCount;
@property (atomic) int currentRRCount;
@property (atomic) int currentBalisticsCount;
@property (atomic) int playerNation;

@property (atomic, copy) NSString *specUnit1Flg;
@property (atomic, copy) NSString *specUnit2Flg;
@property (atomic, copy) NSString *specUnit3Flg;
@property (atomic, copy) NSString *purchasesString;
@property (atomic, copy) NSString *sbcString;


@end
