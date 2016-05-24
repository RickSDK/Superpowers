//
//  ComputerGoVCViewController.h
//  Superpowers
//
//  Created by Rick Medved on 2/26/13.
//
//

#import <UIKit/UIKit.h>

@interface ComputerGoVCViewController : UIViewController {
    IBOutlet UIWebView *mainWebView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	int gameId;
	NSString *weblink;
	UIViewController *callBackViewController;
    UIBarButtonItem *moreButton;
}

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic) int gameId;
@property (nonatomic, strong) NSString *weblink;
@property (nonatomic, strong) UIViewController *callBackViewController;
@property (nonatomic, strong) UIBarButtonItem *moreButton;

@end
