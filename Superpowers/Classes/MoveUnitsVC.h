//
//  MoveUnitsVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/21/13.
//
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"

@interface MoveUnitsVC : TemplateVC {
    UIViewController *callBackViewController;

    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *nationLabel;
	IBOutlet UIImageView *activityPopup;
	IBOutlet UIImageView *nationImageView;
    IBOutlet UITableView *mainTableView;
    IBOutlet UIButton *attackButton;

    NSString *terrString;
    int gameId;
    int terr_id;
    int mode;
    int transportCount;
	BOOL successFlg;
	BOOL showAllFlg;
	
	NSMutableArray *unitMultiArray;
	NSMutableArray *unitLessMultiArray;
}

- (IBAction) webButtonClicked: (id) sender;
- (IBAction) battleButtonClicked: (id) sender;
- (IBAction) showAllButtonClicked: (id) sender;


@property (atomic, strong) UIViewController *callBackViewController;

@property (atomic, strong) UIActivityIndicatorView *activityIndicator;
@property (atomic, strong) UILabel *nationLabel;
@property (atomic, strong) UIImageView *activityPopup;
@property (atomic, strong) UIImageView *nationImageView;

@property (atomic, copy) NSString *terrString;
@property (atomic) int gameId;
@property (atomic) int terr_id;
@property (atomic) int mode;
@property (atomic) BOOL successFlg;
@property (atomic) BOOL showAllFlg;
@property (atomic) int unitsSelected;
@property (atomic) int transportCount;

@property (atomic, strong) NSMutableArray *unitMultiArray;
@property (atomic, strong) NSMutableArray *unitLessMultiArray;

@property (atomic, strong) UIButton *attackButton;

@end
