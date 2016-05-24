//
//  DiplomacyVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/3/16.
//
//

#import "DiplomacyVC.h"
#import "GameScreenVC.h"
#import "DiplomacyCell.h"
#import "TreatyObj.h"
#import "GameViewsVC.h"

@interface DiplomacyVC ()

@end

@implementation DiplomacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Diplomacy"];
	
	self.currentAllies = [[NSMutableArray alloc] init];
	
	self.gameTypeLabel.text = self.gameObj.gameType;
	if([self noAlliesAllowed])
		self.topLabel.text = @"Teams Locked";

	
	[self.webServiceView startWithTitle:nil];
	if(self.makeOfferFlg)
		[self performSelectorInBackground:@selector(loadOffers) withObject:nil];
	else
		[self performSelectorInBackground:@selector(loadDiplomacy) withObject:nil];
	
}

- (void)loadOffers {
	@autoreleasepool {
		
		[self.mainArray removeAllObjects];
		[self.currentAllies removeAllObjects];
		int max_allies=3;
		NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileDiplomacyOffers.php?game_id=%d", self.gameObj.gameId];
		NSString *result = [WebServicesFunctions getResponseFromWeb:weblink];
		NSLog(@"result: %@ ", result);
	
		NSArray *parts = [result componentsSeparatedByString:@"<a>"];
		if(parts.count>0) {
			NSArray *components = [[parts objectAtIndex:0] componentsSeparatedByString:@"|"];
			if(components.count>3) {
				max_allies = [[components objectAtIndex:1] intValue];
				NSString *allies = [components objectAtIndex:2];
				self.diplomacyRound = [[components objectAtIndex:3] intValue];
				if(allies.length>0)
					[self.currentAllies addObjectsFromArray:[allies componentsSeparatedByString:@"+"]];
				if(self.currentAllies.count>max_allies)
					[ObjectiveCScripts showAlertPopupWithDelegate:@"Notice!" :@"You are over your limit of allies. Choose one to remove" :self];
			}
		}
		[self showCurrentAllies];
		
		if(parts.count>1) {
			NSArray *treaties = [[parts objectAtIndex:1] componentsSeparatedByString:@"<br>"];
			for(NSString *treaty in treaties) {
				if(treaty.length>10) {
					TreatyObj *treatyObj = [TreatyObj objectFromLine:treaty];
					[self.mainArray addObject:treatyObj];
				}
			}
		}
		
		[self.webServiceView stop];
		[self.mainTableView reloadData];
	}
}

- (void)loadDiplomacy {
	@autoreleasepool {
		
		[self.mainArray removeAllObjects];
		[self.currentAllies removeAllObjects];
		int max_allies=3;
		NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileGetDiplomacy.php?game_id=%d", self.gameObj.gameId];
		NSString *result = [WebServicesFunctions getResponseFromWeb:weblink];
		NSLog(@"result: %@ ", result);
		NSArray *parts = [result componentsSeparatedByString:@"<a>"];
		if(parts.count>0) {
			NSArray *components = [[parts objectAtIndex:0] componentsSeparatedByString:@"|"];
			if(components.count>2) {
				max_allies = [[components objectAtIndex:1] intValue];
				NSString *allies = [components objectAtIndex:2];
				[self.currentAllies addObjectsFromArray:[allies componentsSeparatedByString:@"+"]];
				if(self.currentAllies.count>max_allies)
					[ObjectiveCScripts showAlertPopupWithDelegate:@"Notice!" :@"You are over your limit of allies. Choose one to remove" :self];
			}
		}
		[self showCurrentAllies];
		if(parts.count>1) {
			NSArray *treaties = [[parts objectAtIndex:1] componentsSeparatedByString:@"<br>"];
			for(NSString *treaty in treaties) {
				if(treaty.length>10) {
					TreatyObj *treatyObj = [TreatyObj objectFromLine:treaty];
					if([@"PEACE_OFFER" isEqualToString:treatyObj.type] || [@"ALLY_OFFER" isEqualToString:treatyObj.type])
						[self.mainArray addObject:treatyObj];
				}
			}
		}
		[self.webServiceView stop];
		[self.mainTableView reloadData];
		if(self.mainArray.count==0 && self.currentAllies.count <= max_allies)
			[self.navigationController popViewControllerAnimated:YES];
			
//			[ObjectiveCScripts showAlertPopup:@"Diplomacy Done" :@"Click back button"];
	}
}

-(void)showCurrentAllies {
	int i=1;
	for(NSString *ally in self.currentAllies) {
		if(i==1)
			self.ally1ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", [ally intValue]]];
		if(i==2)
			self.ally2ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", [ally intValue]]];
		if(i==3)
			self.ally3ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", [ally intValue]]];
		i++;
	}
	self.ally1ImageView.hidden=(i<=1);
	self.ally2ImageView.hidden=(i<=2);
	self.ally3ImageView.hidden=(i<=3);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select ally to drop" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
	for(NSString *nationStr in self.currentAllies)
		[actionSheet addButtonWithTitle:[ObjectiveCScripts getSuperpowerNameFromId:[nationStr intValue]]];
	
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [actionSheet cancelButtonIndex]) {
		NSLog(@"+++remove: %d %@", (int)buttonIndex, [self.currentAllies objectAtIndex:buttonIndex-1]);
		self.removeNation = [[self.currentAllies objectAtIndex:buttonIndex-1] intValue];
		[self performSelectorInBackground:@selector(removeAlly) withObject:nil];
	}
}


-(void)returnToPreviousPage {
	if(self.callBackViewController) {
		[(GameScreenVC *)self.callBackViewController refreshMap];
		[self.navigationController popToViewController:self.callBackViewController animated:YES];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
	DiplomacyCell *cell = [[DiplomacyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	TreatyObj *treatyObj = [self.mainArray objectAtIndex:indexPath.row];
	
	cell.flagImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", treatyObj.nation]];
	cell.acceptButton.tag=indexPath.row;
	cell.declineButton.tag=indexPath.row;
	cell.offeredLabel.text = @"";

	if(self.makeOfferFlg) {
		cell.backgroundColor=[ObjectiveCScripts colofForNation:treatyObj.nation];

		cell.nameLabel.text = [NSString stringWithFormat:@"Current Diplomacy: %@", (treatyObj.type.length>0)?treatyObj.type:@"Neutral"];
		cell.declineButton.hidden=NO;
		if(treatyObj.peaceOffers>0)
			cell.offeredLabel.text = @"Peace Offered";
		if(treatyObj.allyOffers>0)
			cell.offeredLabel.text = @"Alliance Offered";
		
		if([@"WAR" isEqualToString:treatyObj.type]) {
			[self stlyeButton:cell.acceptButton title:@"Peace" bgColor:[UIColor yellowColor] textColor:[UIColor blackColor]];
			if(treatyObj.peaceOffers>0)
				cell.acceptButton.enabled=NO;
			
			if(self.diplomacyRound==self.gameObj.round)
				cell.acceptButton.enabled=NO;
			
			cell.declineButton.hidden=YES;
			[cell.acceptButton addTarget:self action:@selector(offerPeace:) forControlEvents:UIControlEventTouchDown];
		}
		if([@"PEACE" isEqualToString:treatyObj.type]) {
			[self stlyeButton:cell.acceptButton title:@"Ally" bgColor:[UIColor orangeColor] textColor:[UIColor blackColor]];

			if(treatyObj.allyOffers>0)
				cell.acceptButton.enabled=NO;
			if(self.diplomacyRound==self.gameObj.round)
				cell.acceptButton.enabled=NO;

			[self stlyeButton:cell.declineButton title:@"Declare War" bgColor:[UIColor redColor] textColor:[UIColor whiteColor]];
			[cell.acceptButton addTarget:self action:@selector(offerAlliance:) forControlEvents:UIControlEventTouchDown];
			[cell.declineButton addTarget:self action:@selector(declareWar:) forControlEvents:UIControlEventTouchDown];
			if([self noAlliesAllowed])
				cell.acceptButton.enabled=NO;
		}
		if([@"ALLIANCE" isEqualToString:treatyObj.type]) {
			[self stlyeButton:cell.acceptButton title:@"Declare War" bgColor:[UIColor redColor] textColor:[UIColor whiteColor]];
			cell.declineButton.hidden=YES;
			[cell.acceptButton addTarget:self action:@selector(declareWar:) forControlEvents:UIControlEventTouchDown];
			if([self noAlliesAllowed])
				cell.acceptButton.enabled=NO;


		}
		if(treatyObj.type.length==0) {
			[self stlyeButton:cell.acceptButton title:@"Peace" bgColor:[UIColor yellowColor] textColor:[UIColor blackColor]];
			if(treatyObj.peaceOffers>0)
				cell.acceptButton.enabled=NO;
			if(self.diplomacyRound==self.gameObj.round)
				cell.acceptButton.enabled=NO;

			[cell.acceptButton addTarget:self action:@selector(offerPeace:) forControlEvents:UIControlEventTouchDown];
			[cell.declineButton addTarget:self action:@selector(declareWar:) forControlEvents:UIControlEventTouchDown];
			[self stlyeButton:cell.declineButton title:@"Declare War" bgColor:[UIColor redColor] textColor:[UIColor whiteColor]];
		}
	} else {
		if([@"PEACE_OFFER" isEqualToString:treatyObj.type]) {
			cell.nameLabel.text = [NSString stringWithFormat:@"%@ has offered a peace treaty!", [ObjectiveCScripts getSuperpowerNameFromId:treatyObj.nation]];
			cell.backgroundColor=[UIColor yellowColor];
		} else {
			cell.nameLabel.text = [NSString stringWithFormat:@"%@ has offered an alliance!", [ObjectiveCScripts getSuperpowerNameFromId:treatyObj.nation]];
			cell.backgroundColor=[UIColor orangeColor];
		}
		
		[cell.acceptButton addTarget:self action:@selector(acceptPressed:) forControlEvents:UIControlEventTouchDown];
		[cell.declineButton addTarget:self action:@selector(declinePressed:) forControlEvents:UIControlEventTouchDown];
	}
	
	
	cell.accessoryType= UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(void)stlyeButton:(UIButton *)button title:(NSString *)title bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor {
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:textColor forState:UIControlStateNormal];
	button.backgroundColor=bgColor;
}


-(BOOL)noAlliesAllowed {
	return ([@"autobalance" isEqualToString:self.gameObj.gameType] || [@"locked" isEqualToString:self.gameObj.gameType] || [@"freeforall" isEqualToString:self.gameObj.gameType]);
}

-(void)offerAlliance:(UIButton *)button {
	self.offerAllianceFlg=YES;
	[self.webServiceView startWithTitle:nil];
	self.rowId = (int)button.tag;
	[self performSelectorInBackground:@selector(offerWebService) withObject:nil];
}

-(void)offerPeace:(UIButton *)button {
	self.offerAllianceFlg=NO;
	[self.webServiceView startWithTitle:nil];
	self.rowId = (int)button.tag;
	[self performSelectorInBackground:@selector(offerWebService) withObject:nil];
}

-(void)declareWar:(UIButton *)button {
	[self.webServiceView startWithTitle:nil];
	self.rowId = (int)button.tag;
	[self performSelectorInBackground:@selector(declareWarWebService) withObject:nil];
}

-(void)acceptPressed:(UIButton *)button {
	[self.webServiceView startWithTitle:nil];
	self.acceptTreayFlg=YES;
	self.rowId = (int)button.tag;
	[self performSelectorInBackground:@selector(acceptDeclineOffer) withObject:nil];
}

-(void)declinePressed:(UIButton *)button {
	[self.webServiceView startWithTitle:nil];
	self.acceptTreayFlg=NO;
	self.rowId = (int)button.tag;
	[self performSelectorInBackground:@selector(acceptDeclineOffer) withObject:nil];
}

-(void)offerWebService {
	@autoreleasepool {
		TreatyObj *treatyObj = [self.mainArray objectAtIndex:self.rowId];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"player1", @"player2", @"type", nil];
		NSArray *valueList = [NSArray arrayWithObjects:treatyObj.player1, treatyObj.player2, (self.offerAllianceFlg)?@"ALLY_OFFER":@"PEACE_OFFER", nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileOffer.php":nameList:valueList];
		
		NSLog(@"%@", response);
		[self performSelectorInBackground:@selector(loadOffers) withObject:nil];
	}
}

-(void)declareWarWebService {
	@autoreleasepool {
		TreatyObj *treatyObj = [self.mainArray objectAtIndex:self.rowId];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"player1", @"player2", nil];
		NSArray *valueList = [NSArray arrayWithObjects:treatyObj.player1, treatyObj.player2, nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileDeclareWar.php":nameList:valueList];
		
		NSLog(@"%@", response);
		[self performSelectorInBackground:@selector(loadOffers) withObject:nil];
	}
}

- (void)acceptDeclineOffer {
	@autoreleasepool {
		TreatyObj *treatyObj = [self.mainArray objectAtIndex:self.rowId];
		
		NSArray *nameList = [NSArray arrayWithObjects:@"player1", @"player2", @"type", @"acceptFlg", nil];
		NSArray *valueList = [NSArray arrayWithObjects:treatyObj.player1, treatyObj.player2, treatyObj.type, (self.acceptTreayFlg)?@"Y":@"N", nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileAcceptTreaty.php":nameList:valueList];
		
		NSLog(@"acceptDeclineOffer: %@", response);
		[self performSelectorInBackground:@selector(loadDiplomacy) withObject:nil];
	}
}

- (void)removeAlly {
	@autoreleasepool {
		NSArray *nameList = [NSArray arrayWithObjects:@"player1", @"nation", nil];
		NSArray *valueList = [NSArray arrayWithObjects:self.gameObj.turn, [NSString stringWithFormat:@"%d", self.removeNation], nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobileRemoveAlly.php":nameList:valueList];
		
		NSLog(@"removeAlly: %@", response);
		[self performSelectorInBackground:@selector(loadDiplomacy) withObject:nil];
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (IBAction) treatiesButtonClicked: (id) sender {
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
	detailViewController.gameName = self.gameObj.name;
	detailViewController.gameId = self.gameObj.gameId;
	detailViewController.screenNum = 3;
	[self.navigationController pushViewController:detailViewController animated:YES];
}


@end
