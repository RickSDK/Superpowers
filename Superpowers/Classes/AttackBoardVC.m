//
//  AttackBoardVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/28/13.
//
//

#import "AttackBoardVC.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "GameScreenVC.h"

@interface AttackBoardVC ()

@end

@implementation AttackBoardVC


- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitle:@"Battle Board"];
	
	self.continueButton.alpha=0;
	
	self.leftButton = [ObjectiveCScripts navigationButtonWithTitle:@"Cancel" selector:@selector(backButtonClicked) target:self];
	self.navigationItem.leftBarButtonItem = self.leftButton;
	
	self.rightButton = [ObjectiveCScripts navigationButtonWithTitle:@"Done" selector:@selector(doneButtonClicked:) target:self];
	self.navigationItem.rightBarButtonItem = self.rightButton;
	
	
	self.battleRaging=YES;
	self.rightButton.enabled=YES;
	
	[self refreshWebView];
	
}

-(void)backButtonClicked {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)checkResults
{
	@autoreleasepool {

        self.continueButton.alpha=1;
        
        NSLog(@"checkResults");
        
        NSString *weblink = nil;
        
        weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/webCheckResults.php?territory=%d&game_id=%d&iPhoneType=101", self.terr_id, self.gameId];
        
        NSString *page = [WebServicesFunctions getResponseFromWeb:weblink];
		NSLog(@"page: %@", page);

        NSArray *parts = [page componentsSeparatedByString:@"|"];
        if([parts count]>9) {
            int attackingUnits = [[parts objectAtIndex:1] intValue];
            int defendingUnits = [[parts objectAtIndex:5] intValue];
            int attackingPlanes = [[parts objectAtIndex:2] intValue];
            int defendingSubs = [[parts objectAtIndex:6] intValue];
			int attackingGroundUnits = [[parts objectAtIndex:7] intValue];
			BOOL generalWithDraw = [@"Y" isEqualToString:[parts objectAtIndex:8]];
			
            self.battleRaging = YES;
            
            if(attackingUnits==0 || defendingUnits==0)
                self.battleRaging = NO;
            
            if(attackingUnits==attackingPlanes && defendingSubs==defendingUnits)
                self.battleRaging = NO;
            
            if(attackingGroundUnits==0 && self.terr_id<79)
                self.battleRaging = NO;
            
            if(self.battleRaging) {
                self.continueButton.alpha=1;
                self.rightButton.enabled=NO;
            } else {
                self.continueButton.alpha=0;
                self.rightButton.enabled=YES;
				if(generalWithDraw)
					self.generalButton.enabled=YES;
				if(generalWithDraw) {
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Battle won!"
																	message:@"Withdraw General?"
																   delegate:self
														  cancelButtonTitle:@"Stay"
														  otherButtonTitles: @"Withdraw", nil];
					alert.tag=999;
					[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
				}
            }
		} else {
			[ObjectiveCScripts showAlertPopup:@"Error" :@"unexpected error. Click battle board button to continue."];
			[self.navigationController popViewControllerAnimated:YES];
		}
			


        [self.activityIndicator stopAnimating];
 	}
}


-(void)loadAttackPage
{
	@autoreleasepool {
        NSString *weblink = nil;
        
        weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/attack.php?territory=%d&game_id=%d&iPhoneType=101", self.terr_id, self.gameId];
        
	NSURL *url = [NSURL URLWithString:weblink];
        
        NSString *page = [WebServicesFunctions getResponseFromWeb:weblink];
        NSArray *components = [page componentsSeparatedByString:@"<a>"];
        if([components count]>1)
            page = [components objectAtIndex:1];
        int bytes=(int)[page length];
        
        if(bytes>0)
            [self.mainWebView loadHTMLString:page baseURL:url];
        else {
            if(self.mode==6 || self.mode==11)
                [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Page timed out but computer took his turn. Press 'Done' button to see results."];
            else {
                [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Reloading..."];
                [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
                [NSThread sleepForTimeInterval:7];
            }
        }
        
        [NSThread sleepForTimeInterval:.5];
        self.activityPopup.alpha=0;
        self.mainWebView.alpha=1;
        
        [self performSelectorInBackground:@selector(checkResults) withObject:nil];
	}
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==999) {
		if(buttonIndex!=alertView.cancelButtonIndex) {
			[self generalBack];
			self.attackButton.enabled=NO;
			[self.navigationController popToViewController:self.callBackViewController animated:YES];
//			[self.navigationController popViewControllerAnimated:YES];
		}
		return;
	}
    if(self.callBackViewController && self.goBackToBoardFlg) {
//        [(GameScreenVC *)self.callBackViewController refreshMap];
        [self.navigationController popToViewController:self.callBackViewController animated:YES];
    } else {
        [self refreshWebView];
    }
}

-(void)cancelAttack {
 	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileCancelAttack.php" forGame:self.gameId andString:@"" andMessage:@"Battle Cancelled" delegate:self];
   
	}
}

- (IBAction) retreatButtonClicked: (id) sender {
    self.goBackToBoardFlg=YES;
    [self startWebTransaction];
    [self performSelectorInBackground:@selector(cancelAttack) withObject:nil];
    
}

-(void)generalBack {
 	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileGeneralBack.php" forGame:self.gameId andString:@"" andMessage:@"General Pulled" delegate:self];
    
	}
}

- (IBAction) generalButtonClicked: (id) sender {
    self.goBackToBoardFlg=NO;
    [self performSelectorInBackground:@selector(generalBack) withObject:nil];
    
}

-(void)planesBack {
 	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobilePlanesBack.php" forGame:self.gameId andString:@"" andMessage:@"Planes Sent Back" delegate:self];
    
	}
}
- (IBAction) planesButtonClicked: (id) sender {
    self.goBackToBoardFlg=NO;
    [self performSelectorInBackground:@selector(planesBack) withObject:nil];
    
}

-(void)bombersBack {
 	@autoreleasepool {
        [WebServicesFunctions sendRequestToServer:@"mobileBombersBack.php" forGame:self.gameId andString:@"" andMessage:@"Bombers Sent Back" delegate:self];
    
	}
}
- (IBAction) bombersButtonClicked: (id) sender {
    self.goBackToBoardFlg=NO;
    [self performSelectorInBackground:@selector(bombersBack) withObject:nil];
    
}

-(void)doneButtonClicked:(id)sender {
    if(self.callBackViewController) {
        [(GameScreenVC *)self.callBackViewController refreshMap];
        [self.navigationController popToViewController:self.callBackViewController animated:YES];
    }
}

- (IBAction) attackButtonClicked: (id) sender {
    self.mainWebView.alpha=0;
    [self.activityIndicator startAnimating];
	self.attackButton.enabled=NO;
	self.retreatButton.enabled=NO;
	self.generalButton.enabled=NO;
	self.planesButton.enabled=NO;
	self.bombersButton.enabled=NO;
    self.rightButton.enabled=NO;
	self.leftButton.enabled=NO;
    [self performSelectorInBackground:@selector(loadAttackPage) withObject:nil];
}


- (IBAction) continueButtonClicked: (id) sender
{
    self.continueButton.alpha=0;
    [self refreshWebView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)doTheWorkAndShow:(BOOL)showFlg {
    NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/web_player_attack.php?territory=%d&game_id=%d&iPhoneType=101", self.terr_id, self.gameId];
    
	NSURL *url = [NSURL URLWithString:weblink];
    
    NSString *page = [WebServicesFunctions getResponseFromWeb:weblink];
	
    NSArray *components = [page componentsSeparatedByString:@"<a>"];
    if([components count]>1)
        page = [components objectAtIndex:1];
    int bytes=(int)[page length];
    
    if(bytes>0) {
        if(showFlg)
            [self.mainWebView loadHTMLString:page baseURL:url];
    } else {
        if(self.mode==6 || self.mode==11)
            [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Page timed out but computer took his turn. Press 'Done' button to see results."];
        else {
            [ObjectiveCScripts showAlertPopup:@"Page Timed Out" :@"Reloading..."];
            [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
            [NSThread sleepForTimeInterval:2];
        }
    }
    
    [NSThread sleepForTimeInterval:.5];
    
    if([components count]>0) {
		NSLog(@"components: %@", [components objectAtIndex:0]);
		
        NSArray *parts = [[components objectAtIndex:0] componentsSeparatedByString:@"|"];
        if([parts count]>9) {
            int attackingUnits = [[parts objectAtIndex:1] intValue];
            int attackingPlanes = [[parts objectAtIndex:2] intValue];
            int attackingBombers = [[parts objectAtIndex:3] intValue];
            //            int attackingChoppers = [[parts objectAtIndex:4] intValue];
            int defendingUnits = [[parts objectAtIndex:5] intValue];
            //           int defendingSubs = [[parts objectAtIndex:6] intValue];
            //         int attackingGroundUnits = [[parts objectAtIndex:7] intValue];
            NSString *generalWithdrawFlg = [parts objectAtIndex:8];
            NSString *battleStartedFlg = [parts objectAtIndex:9];
            
			if(attackingUnits>0 && ![@"Y" isEqualToString:battleStartedFlg]) {
                self.attackButton.enabled=YES;
				self.rightButton.enabled=NO;
			}
			
			if(attackingUnits>0 && self.continueButton.alpha==0) {
                self.attackButton.enabled=YES;
				self.rightButton.enabled=NO;
			}
				
            if(defendingUnits>0)
                self.retreatButton.enabled=YES;
            
            if([@"Y" isEqualToString:generalWithdrawFlg])
                self.generalButton.enabled=YES;
            
            if(attackingPlanes>0)
                self.planesButton.enabled=YES;
            if(attackingBombers>0)
                self.bombersButton.enabled=YES;
            
            if([@"Y" isEqualToString:battleStartedFlg])
                [self.retreatButton setTitle:@"Retreat!" forState:UIControlStateNormal];
            
            
            if((attackingUnits==0 || defendingUnits==0) && [@"Y" isEqualToString:battleStartedFlg]) {
                self.rightButton.enabled=YES;
                self.continueButton.alpha=0;
            }
            
            if([@"N" isEqualToString:battleStartedFlg] && attackingUnits==0)
                [ObjectiveCScripts showAlertPopup:@"Send Troops" :@"Click the back button and add troops to the battlefield"];
        }
    }
    
}

-(void)loadPage
{
	@autoreleasepool {
		NSLog(@"loadPage");
		self.rightButton.enabled=YES;
		
		if(self.battleRaging)
			[self doTheWorkAndShow:YES];
   
        [self.activityIndicator stopAnimating];
        self.activityLabel.alpha=0;
        self.activityPopup.alpha=0;
        self.mainWebView.alpha=1;
    
	}
}

-(void)startWebTransaction {
    self.mainWebView.alpha=0;
    [self.activityIndicator startAnimating];
	self.attackButton.enabled=NO;
	self.retreatButton.enabled=NO;
	self.generalButton.enabled=NO;
	self.planesButton.enabled=NO;
	self.bombersButton.enabled=NO;
    self.rightButton.enabled=NO;
}

-(void)refreshWebView {
    [self startWebTransaction];
    [self performSelectorInBackground:@selector(loadPage) withObject:nil];
    
}





@end
