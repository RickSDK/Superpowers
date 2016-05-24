//
//  ChooseNationVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/24/13.
//
//

#import <UIKit/UIKit.h>

@interface ChooseNationVC : UIViewController {
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
    IBOutlet UITableView *mainTableView;
    
    int gameId;
    int selectedNation;
    int formNumber;
    NSMutableArray *playerArray;

}

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong)  NSMutableArray *playerArray;

@property (nonatomic) int gameId;
@property (nonatomic) int selectedNation;
@property (nonatomic) int formNumber;

@end
