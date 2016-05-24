//
//  BugReportVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/20/13.
//
//

#import <UIKit/UIKit.h>

@interface BugReportVC : UIViewController {
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UIImageView *activityPopup;

    IBOutlet UITextField *gameTextField;
	IBOutlet UITextView *detailsTextView;

}

- (IBAction) webButtonClicked: (id) sender;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;

@property (nonatomic, strong) UITextField *gameTextField;
@property (nonatomic, strong) UITextView *detailsTextView;

@end
