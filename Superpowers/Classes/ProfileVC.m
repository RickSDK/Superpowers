//
//  ProfileVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/20/13.
//
//

#import "ProfileVC.h"
#import "ObjectiveCScripts.h"
#import "GameViewsVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC
@synthesize gamesLabel, ratingLabel;
@synthesize usernameLabel, last10Label, streakLabel, lossesLabel, winsLabel, rankLabel, rankImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"User Profile"];
    
        self.usernameLabel.text = [ObjectiveCScripts getUserDefaultValue:@"userName"];
        NSArray *ranks = [NSArray arrayWithObjects:
                          @"New Recruit",
                          @"Private",
                          @"Private First Class",
                          @"Corporal",
                          @"Sergeant",
                          @"Staff Sergeant",
                          @"Master Sergeant",
                          @"Warrant Officer W1",
                          @"Warrant Officer W2",
                          @"Chief Warrent Officer",
                          @"Lieutenant",
                          @"Captain",
                          @"Major",
                          @"Colonel",
                          @"Brig General",
                          @"Major General",
                          @"Lieutenant General",
                          @"General",
                          @"Grand General",
                          @"Empty",
                          nil];
        self.winsLabel.text = [NSString stringWithFormat:@"%d", self.loginObj.wins];
        self.lossesLabel.text = [NSString stringWithFormat:@"%d", self.loginObj.losses];
        self.gamesLabel.text = [NSString stringWithFormat:@"%d", self.loginObj.games];
        self.streakLabel.text = self.loginObj.streak;
        self.last10Label.text = self.loginObj.last10;
        self.ratingLabel.text = [NSString stringWithFormat:@"%d", self.loginObj.rating];
        
        int rank = self.loginObj.level;
        rank--;
        if(rank>14)
            rank=14;
        self.rankLabel.text = [ranks objectAtIndex:rank];
        self.rankImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"rank%d.gif", rank]];

	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Ranks" style:UIBarButtonItemStylePlain target:self action:@selector(ranksButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
}


-(void)ranksButtonClicked:(id)sender {
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.screenNum = 9;
	[self.navigationController pushViewController:detailViewController animated:YES];
}


@end
