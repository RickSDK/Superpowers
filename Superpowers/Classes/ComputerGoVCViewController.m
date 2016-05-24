//
//  ComputerGoVCViewController.m
//  Superpowers
//
//  Created by Rick Medved on 2/26/13.
//
//

#import "ComputerGoVCViewController.h"
#import "WebServicesFunctions.h"
#import "GameScreenVC.h"

@interface ComputerGoVCViewController ()

@end

@implementation ComputerGoVCViewController

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
    
        NSLog(@"%@", self.weblink);
        
	NSURL *url = [NSURL URLWithString:self.weblink];
	NSString *page = [WebServicesFunctions getResponseFromWeb:self.weblink];
	[self.mainWebView loadHTMLString:page baseURL:url];
	[NSThread sleepForTimeInterval:0];
	
	self.activityPopup.alpha=0;
	self.activityLabel.alpha=0;
	self.mainWebView.alpha=1;
	[self.activityIndicator stopAnimating];
        self.moreButton.enabled=YES;
	
	}
}

-(void)loadpage:(NSString *)link
{
	self.weblink=link;
	self.activityPopup.alpha=1;
	self.activityLabel.alpha=1;
	self.mainWebView.alpha=0;
	[self.activityIndicator startAnimating];
	[self performSelectorInBackground:@selector(loadpageBackground) withObject:nil];
}

-(void)backButtonClicked:(id)sender {
    
    if(self.callBackViewController) {
        [(GameScreenVC *)self.callBackViewController refreshMap];
        [self.navigationController popToViewController:self.callBackViewController animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.activityPopup.alpha=0;
	self.activityLabel.alpha=0;
    
    [self setTitle:@"CPU Turn"];

    NSString *webSite = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/computer.php?game_id=%d&iPhoneType=99", self.gameId];
    [self loadpage:webSite];

    self.moreButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked:)];
	
	
	self.navigationItem.leftBarButtonItem = self.moreButton;
    self.moreButton.enabled=NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
