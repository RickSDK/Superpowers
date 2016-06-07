//
//  HistoryVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/3/16.
//
//

#import "TemplateVC.h"

@interface HistoryVC : TemplateVC

@property (nonatomic, strong) IBOutlet UIWebView *mainWebView;
@property (nonatomic, strong) IBOutlet UIButton *round1Button;
@property (nonatomic, strong) IBOutlet UIButton *lastRoundButton;
@property (nonatomic, strong) IBOutlet UIButton *roundPrevButton;
@property (nonatomic, strong) IBOutlet UIButton *roundNextButton;
@property (nonatomic, strong) IBOutlet UIButton *turnPrevButton;
@property (nonatomic, strong) IBOutlet UIButton *turnNextButton;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;

@property (nonatomic, strong) IBOutlet UIImageView *turnImageView;
@property (nonatomic, strong) IBOutlet UIImageView *prevTurnImageView;
@property (nonatomic, strong) IBOutlet UIImageView *nextTurnImageView;

@property (atomic) int gameId;
@property (atomic) int historyId;
@property (atomic) int round;
@property (atomic) int sequence;
@property (atomic) int maxRound;
@property (atomic) int maxSequence;

- (IBAction) roundUpClicked: (id) sender;
- (IBAction) roundDownClicked: (id) sender;
- (IBAction) firstRoundClicked: (id) sender;
- (IBAction) lastRoundClicked: (id) sender;
- (IBAction) turnUpClicked: (id) sender;
- (IBAction) turnDownClicked: (id) sender;

@end
