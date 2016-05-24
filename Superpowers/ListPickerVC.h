//
//  ListPickerVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import <UIKit/UIKit.h>

@interface ListPickerVC : UIViewController {
	NSString *titleName;
	NSString *selectedItem;
    NSArray *items;
	UIViewController *callBackViewController;
    IBOutlet UIPickerView *picker;
    IBOutlet UILabel *selectedLabel;
    
}

- (IBAction) selectClicked: (id) sender;


@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *selectedItem;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UILabel *selectedLabel;

@end
