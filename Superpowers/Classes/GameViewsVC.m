//
//  GameViewsVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/10/13.
//
//

#import "GameViewsVC.h"
#import "WebServicesFunctions.h"

@interface GameViewsVC ()

@end

@implementation GameViewsVC
@synthesize gameName, gameId, screenNum, mainWebView, weblink;
@synthesize activityIndicator, activityPopup, activityLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadpageBackground
{
	@autoreleasepool {
    
//	NSURL *url = [NSURL URLWithString:weblink];
//	NSString *page = [WebServicesFunctions getResponseFromWeb:weblink];
//	[self.mainWebView loadHTMLString:page baseURL:url];
		[NSThread sleepForTimeInterval:1];
		
		activityPopup.alpha=0;
		activityLabel.alpha=0;
		mainWebView.alpha=1;
		[activityIndicator stopAnimating];
	
	}
}

-(void)loadpage:(NSString *)link
{
	self.weblink=link;
	activityPopup.alpha=1;
	activityLabel.alpha=1;
	mainWebView.alpha=0;
	[activityIndicator startAnimating];
    
    
    
    NSURL *url = [NSURL URLWithString:link];
	NSLog(@"Loading page: %@", link);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:requestObj];
    
	[self performSelectorInBackground:@selector(loadpageBackground) withObject:nil];
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
}
*/ 

-(void)loadWebView {
    switch (screenNum) {
		case 0: {
			break;
		}
		case 1: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_logs.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 2: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_technology.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 3: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_allies.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 4: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_chat.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 5: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_show_purchase.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 6: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/show_user.php?user_id=%d", self.userId];
			[self loadpage:webSite];
			break;
		}
		case 7: {
			NSString *webSite = @"http://www.superpowersgame.com/scripts/view_mail.php";
			[self loadpage:webSite];
			break;
		}
		case 8: {
			NSString *webSite = @"http://www.superpowersgame.com/scripts/report_bugWeb.php";
			[self loadpage:webSite];
			break;
		}
		case 9: {
			NSString *webSite = @"http://www.superpowersgame.com/scripts/show_ranks.php";
			[self loadpage:webSite];
			break;
		}
		case 10: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/player_give_country.php?game_id=%d&iPhone=99", gameId];
			[self loadpage:webSite];
			break;
		}
		case 11: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_income.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		case 12: {
			NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/iphone_stats.php?game_id=%d", gameId];
			[self loadpage:webSite];
			break;
		}
		default:
			break;
	}

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)backButtonClicked:(id)sender {
    if ([self.mainWebView canGoBack])
        [self.mainWebView goBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWebView];
    
    NSArray *titles = [NSArray arrayWithObjects:@"Empty", @"Logs", @"Technology", @"Allies", @"Chat", @"Purchases", @"User", @"Mail", @"Report Bug", @"Ranks", @"Country Assign", @"Income", @"Stats", @"12", @"13", @"14", nil];
    [self setTitle:[titles objectAtIndex:screenNum]];


}



@end
