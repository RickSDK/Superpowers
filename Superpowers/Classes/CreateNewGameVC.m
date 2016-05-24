//
//  CreateNewGameVC.m
//  Superpowers
//
//  Created by Rick Medved on 1/31/13.
//
//

#import "CreateNewGameVC.h"
#import "CreateSinglePlayerGameVC.h"
#import "CreateMultiPlayerGameVC.h"

@interface CreateNewGameVC ()

@end

@implementation CreateNewGameVC

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

- (IBAction) singlePlayerButtonClicked: (id) sender
{
 	CreateSinglePlayerGameVC *detailViewController = [[CreateSinglePlayerGameVC alloc] initWithNibName:@"CreateSinglePlayerGameVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
   
}

- (IBAction) multiPlayerButtonClicked: (id) sender
{
  	CreateMultiPlayerGameVC *detailViewController = [[CreateMultiPlayerGameVC alloc] initWithNibName:@"CreateMultiPlayerGameVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Start New Game!"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
