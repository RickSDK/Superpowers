//
//  Buy3VC.h
//  Superpowers
//
//  Created by Rick Medved on 2/27/13.
//
//

#import <UIKit/UIKit.h>

@interface Buy3VC : UIViewController {
	UIViewController *callBackViewController;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;

    IBOutlet UILabel *nationLabel;
	IBOutlet UIImageView *nationImg;
	IBOutlet UITableView *mainTableView;
    UIBarButtonItem *doneButton;
    int nation;
    int rowNumber;
    int gameId;
    NSMutableArray *countryList;

}

@property (nonatomic, strong) UIViewController *callBackViewController;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIImageView *activityPopup;

@property (nonatomic, strong) UILabel *nationLabel;
@property (nonatomic, strong) UIImageView *nationImg;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) NSMutableArray *countryList;

@property (nonatomic) int nation;
@property (nonatomic) int rowNumber;
@property (nonatomic) int gameId;


@end
