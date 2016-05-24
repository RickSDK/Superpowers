//
//  LoadOnShipVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/15/13.
//
//

#import <UIKit/UIKit.h>

@interface LoadOnShipVC : UIViewController {
    IBOutlet UITableView *mainTableView;
    IBOutlet UILabel *nationNameLabel;
    IBOutlet UILabel *cargoLabel;
    
    
	UIViewController *callBackViewController;
    NSString *countryName;
    
    NSString *purchaseString;
    NSString *unitString;
    NSArray *unitArray;
    NSArray *purchaseArray;

}

@property (atomic, strong) UIViewController *callBackViewController;
@property (atomic, strong) UITableView *mainTableView;
@property (atomic, strong) UILabel *nationNameLabel;
@property (atomic, strong) UILabel *cargoLabel;

@property (atomic, strong) NSString *countryName;
@property (atomic, strong) NSString *purchaseString;
@property (atomic, strong) NSString *unitString;
@property (atomic, strong) NSArray *unitArray;
@property (atomic, strong) NSArray *purchaseArray;


@end
