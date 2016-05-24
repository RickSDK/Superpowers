//
//  DiplomacyVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/3/16.
//
//

#import "TemplateVC.h"

@interface DiplomacyVC : TemplateVC <UIActionSheetDelegate>

@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) NSMutableArray *currentAllies;
@property (nonatomic) BOOL acceptTreayFlg;
@property (nonatomic) int rowId;
@property (nonatomic) int removeNation;
@property (nonatomic) int diplomacyRound;
@property (nonatomic) BOOL makeOfferFlg;
@property (nonatomic) BOOL offerAllianceFlg;

@property (nonatomic, strong) IBOutlet UIImageView *ally1ImageView;
@property (nonatomic, strong) IBOutlet UIImageView *ally2ImageView;
@property (nonatomic, strong) IBOutlet UIImageView *ally3ImageView;
@property (nonatomic, strong) IBOutlet UILabel *topLabel;
@property (nonatomic, strong) IBOutlet UILabel *gameTypeLabel;

- (IBAction) treatiesButtonClicked: (id) sender;


@end
