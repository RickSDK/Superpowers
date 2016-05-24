//
//  CreateGameVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateGameVC.h"


@implementation CreateGameVC
@synthesize mainWebView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Create Game"];
	[mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.superpowersgame.com/scripts/web_create_game.php"]]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}






@end
