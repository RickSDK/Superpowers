//
//  GameViewsVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/10/13.
//
//

#import <UIKit/UIKit.h>

@interface GameViewsVC : UIViewController {
    NSString *gameName;
	int gameId;
    int screenNum;
    int userId;
	IBOutlet UIWebView *mainWebView;
 
    IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *activityLabel;
	IBOutlet UIImageView *activityPopup;
	NSString *weblink;

}

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *weblink;
@property (nonatomic) int gameId;
@property (nonatomic) int screenNum;
@property (nonatomic) int userId;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *activityPopup;
@property (nonatomic, strong) UILabel *activityLabel;


@end
