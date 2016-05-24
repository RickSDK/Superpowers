//
//  ForumsVC.m
//  Superpowers
//
//  Created by Rick Medved on 4/28/16.
//
//

#import "ForumsVC.h"
#import "PlayerAttackVC.h"

@interface ForumsVC ()

@end

@implementation ForumsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Forums"];
}

- (IBAction) forumButtonClicked: (id) sender {
	PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
	detailViewController.callBackViewController=self;
	detailViewController.mode=16;
	[self.navigationController pushViewController:detailViewController animated:YES];
}


@end
