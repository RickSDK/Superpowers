//
//  UnitsForPlacementVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import <UIKit/UIKit.h>

@interface UnitsForPlacementVC : UIViewController {
    IBOutlet UIButton *placeButton;
    IBOutlet UILabel *nationLabel;
    IBOutlet UITableView *mainTableView;
    
    
	UIViewController *callBackViewController;
    NSString *purchaseString;
    NSString *placementString;
    NSString *countryName;
    NSString *countryWaterFlg;
    NSArray *purchaseItems;
    NSArray *purchasePieces;
    NSArray *purchaseTypes;
    NSMutableArray *checkedItems;
}

- (IBAction) placeButtonClicked: (id) sender;

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UIButton *placeButton;
@property (atomic, strong) UILabel *nationLabel;
@property (atomic, strong) UITableView *mainTableView;

@property (atomic, strong) NSString *purchaseString;
@property (atomic, strong) NSString *placementString;
@property (atomic, strong) NSString *countryName;
@property (atomic, strong) NSString *countryWaterFlg;
@property (atomic, strong) NSArray *purchaseItems;
@property (atomic, strong) NSArray *purchasePieces;
@property (atomic, strong) NSArray *purchaseTypes;
@property (atomic, strong) NSMutableArray *checkedItems;

@end
