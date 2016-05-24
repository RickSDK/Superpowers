//
//  RulesVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/4/13.
//
//

#import "RulesVC.h"
#import "GameBasicsVC.h"

@interface RulesVC ()

@end

@implementation RulesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Superpowers"];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction) nextButtonClicked: (UIButton *) button {
	GameBasicsVC *detailViewController = [[GameBasicsVC alloc] initWithNibName:@"GameBasicsVC" bundle:nil];
	detailViewController.step=(int)button.tag;
	[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction) rulebookButtonClicked: (id) sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.superpowersgame.com/docs/manual.pdf"]];
}


@end
