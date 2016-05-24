//
//  LeadersVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LeadersVC.h"
#import "WebServicesFunctions.h"
#import "ObjectiveCScripts.h"
#import "GameViewsVC.h"
#import "LeaderCell.h"
#import "LadderDetailsVC.h"


@implementation LeadersVC


- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Leaders"];
	
	self.mainArray = [NSMutableArray new];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Ranks" style:UIBarButtonItemStylePlain target:self action:@selector(ranksButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
	
//	self.mainSegment.selectedSegmentIndex=(self.ladderFlg)?0:1;
	self.mainSegment.selectedSegmentIndex=self.tag;
	[self.mainSegment changeSegment];
	[self loadViewStart];
}

- (IBAction) segmentChanged: (id) sender
{
	[super segmentChanged:sender];
    [self loadViewStart];
}

-(void)loadViewStart {
    self.mainTableView.alpha=0;
    self.joinButton.alpha=0;
    self.leagueButton.alpha=0;
	[self.mainArray removeAllObjects];
	[self startWebService:@selector(loadLeaders) message:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
    LeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
	    cell = [[LeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSString *line=[self.mainArray objectAtIndex:indexPath.row];
    NSArray *components = [line componentsSeparatedByString:@"|"];
    cell.nameLabel.text = [components objectAtIndex:0];
    cell.winsLabel.text = [components objectAtIndex:5];
    cell.lossesLabel.text = [components objectAtIndex:6];
    cell.pointsLabel.text = [components objectAtIndex:4];
	cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    int rank = [[components objectAtIndex:3] intValue];
    
    if(rank>14)
        rank=14;
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"rank%d.gif", rank]];
    
    if([[components objectAtIndex:1] intValue] == [[components objectAtIndex:2] intValue])
        cell.backgroundColor = [UIColor yellowColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (IBAction) leagueButtonPressed: (id) sender {
	LadderDetailsVC *detailViewController = [[LadderDetailsVC alloc] initWithNibName:@"LadderDetailsVC" bundle:nil];
    detailViewController.userRank=self.userRank;
	[self.navigationController pushViewController:detailViewController animated:YES];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *line=[self.mainArray objectAtIndex:indexPath.row];
    
    NSArray *components = [line componentsSeparatedByString:@"|"];
    GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.userId = [[components objectAtIndex:1] intValue];
    detailViewController.screenNum = 6;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (IBAction) joinButtonPressed: (id) sender
{
    if(self.userRank<3) {
        [ObjectiveCScripts showAlertPopup:@"Notice" :@"You must be Corporal or higher to join ladder"];
        return;
    }
    [WebServicesFunctions sendRequestToServer:@"mobileJoinLeague.php" forGame:0 andString:@"" andMessage:@"You have joined!" delegate:self];
    
    [self loadViewStart];
    
}

- (void)loadLeaders {
	@autoreleasepool {
    
        NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileLeaders.php?type=%d", (int)self.mainSegment.selectedSegmentIndex];
	NSString *result = [WebServicesFunctions getResponseFromWeb:weblink];
        
        NSLog(@"result: %@ ", result);
        NSArray *components = [result componentsSeparatedByString:@"<br>"];
        if([components count]>2) {
            int inLeagueCount = [[components objectAtIndex:1] intValue];
            if(inLeagueCount==0 && self.mainSegment.selectedSegmentIndex==0 && [[ObjectiveCScripts getUserDefaultValue:@"userName"] length]>0) {
                self.joinButton.alpha=1;
                self.leagueButton.alpha=1;
            } else {
                self.joinButton.alpha=0;
            }
            if(self.mainSegment.selectedSegmentIndex==0)
                self.leagueButton.alpha=1;
            else
                self.leagueButton.alpha=0;

            
            
            NSString *playerStr = [components objectAtIndex:2];
            NSArray *players = [playerStr componentsSeparatedByString:@"<li>"];
            [self.mainArray addObjectsFromArray:players];
            [self.mainArray removeLastObject];
        }
		[self stopWebService];
		
	}
}



-(void)ranksButtonClicked:(id)sender {
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
    detailViewController.screenNum = 9;
	[self.navigationController pushViewController:detailViewController animated:YES];
}



@end
