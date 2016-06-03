//
//  CreateMultiPlayerGameVC.m
//  Superpowers
//
//  Created by Rick Medved on 1/31/13.
//
//

#import "CreateMultiPlayerGameVC.h"
#import "CreateGameVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"

@interface CreateMultiPlayerGameVC ()

@end

@implementation CreateMultiPlayerGameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[self.nameField resignFirstResponder];
	return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}


-(void)webRequestStart
{
	@autoreleasepool {
	//	[NSThread sleepForTimeInterval:2];
	
        int numPlayers = (int)self.numPlayersSegment.selectedSegmentIndex+2;
        int attackRound = (int)self.attackRoundSegment.selectedSegmentIndex*2+4;
        NSString *fogOgWar = self.fogOfWarSwitch.on?@"Y":@"N";
        NSString *randomNations = self.randomNamtionsSwitch.on?@"Y":@"N";
        
        NSString *name = self.nameField.text;
        if([name length]==0)
            name = [NSString stringWithFormat:@"%@'s Game!", [ObjectiveCScripts getUserDefaultValue:@"userName"]];
        
	NSString *data = [NSString stringWithFormat:@"%@|%@|%d|%d|%@|%@", name, self.typeButton.titleLabel.text, numPlayers, attackRound, fogOgWar, randomNations];
        NSLog(@"%@", data);
	
	NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"data", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], data, nil];
	NSString *webAddr = @"http://www.superpowersgame.com/scripts/iPhoneCreateMultiGame.php";
	NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
        
	if([responseStr length]>=7 && [[responseStr substringToIndex:7] isEqualToString:@"Success"])
		[ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"Game has been created. It sometimes takes a few days to fill up with players so check back often." :self];
	else
		[ObjectiveCScripts showAlertPopup:@"Error" :responseStr];
	
        self.startButton.enabled=YES;
	self.activityPopup.alpha=0;
	self.activityLabel.alpha=0;
	[self.activityIndicator stopAnimating];
	}
	
}

-(void)startWebSearch:(SEL)webRequest
{
	self.activityPopup.alpha=1;
	self.activityLabel.alpha=1;
	[self.activityIndicator startAnimating];
	self.startButton.enabled=NO;
	[self performSelectorInBackground:webRequest withObject:nil];
}


- (IBAction) startButtonClicked: (id) sender
{
    
    [self startWebSearch:@selector(webRequestStart)];
    
}

- (IBAction) typeButtonClicked: (id) sender {
    self.type++;
    if(self.type>3)
        self.type=0;
if(self.type==3)
    self.numPlayersSegment.selectedSegmentIndex=1;
    
    NSArray *types = [NSArray arrayWithObjects:@"diplomacy", @"freeforall", @"autobalance", @"coop", nil];
    [self.typeButton setTitle:[types objectAtIndex:self.type] forState:UIControlStateNormal];

    
    NSArray *typeDescs = [NSArray arrayWithObjects:@"Players make alliances during the game",
                          @"No Teams. Game ends when one player controls at least 6 capitals.",
                          @"Fixed teams and balanced by rank.",
                          @"Co-Op: 3 humans vs 5 cpu",
                          nil];

    self.typeDescTextView.text = [typeDescs objectAtIndex:self.type];
    
}


-(void)advancedButtonClicked:(id)sender {
 	CreateGameVC *detailViewController = [[CreateGameVC alloc] initWithNibName:@"CreateGameVC" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Create Game"];
    
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithTitle:@"Advanced" style:UIBarButtonItemStylePlain target:self action:@selector(advancedButtonClicked:)];
	self.navigationItem.rightBarButtonItem = moreButton;

    self.activityPopup.alpha=0;
	self.activityLabel.alpha=0;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
