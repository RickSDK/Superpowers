//
//  ReassignCountryVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/19/16.
//
//

#import "ReassignCountryVC.h"

@interface ReassignCountryVC ()

@end

@implementation ReassignCountryVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"ReAssign"];
	
	self.countryNameLabel.text =  self.countryName;

	[self.webServiceView startWithTitle:nil];
	[self performSelectorInBackground:@selector(loadOffers) withObject:nil];
	
	self.assignButton = [ObjectiveCScripts navigationButtonWithTitle:@"Assign" selector:@selector(assignButtonClicked) target:self];
	self.navigationItem.rightBarButtonItem = self.assignButton;
	self.assignButton.enabled=NO;

}

-(void)assignButtonClicked {
	[self.webServiceView startWithTitle:nil];
	[self performSelectorInBackground:@selector(assignCountry) withObject:nil];
	
}

- (void)assignCountry {
	@autoreleasepool {
		int nation = [[self.mainArray objectAtIndex:self.countrySelected] intValue];
		NSString *weblink = [NSString stringWithFormat:@"http://www.superpowersgame.com/scripts/mobileReassign.php?game_id=%d&terr_id=%d&nation=%d", self.gameObj.gameId, self.terr_id, nation];
		NSString *response = [WebServicesFunctions getResponseFromWeb:weblink];
		[self.webServiceView stop];

		if([@"Success" isEqualToString:response]) {
		} else
			[ObjectiveCScripts showAlertPopup:@"Notice" :response];
		NSLog(@"response: %@ ", response);
		[self.navigationController popViewControllerAnimated:YES];
		
	}
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
				[self.mainArray addObjectsFromArray:[allies componentsSeparatedByString:@"+"]];
				NSLog(@"+++%@", allies);
			}
		}
		
		[self.webServiceView stop];
		[self.mainTableView reloadData];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	NSString *ally = [self.mainArray objectAtIndex:indexPath.row];
	cell.textLabel.text=[ObjectiveCScripts getSuperpowerNameFromId:[ally intValue]];
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", [ally intValue]]];
	
	cell.backgroundColor=[ObjectiveCScripts colofForNation:[ally intValue]];

	cell.accessoryType= UITableViewCellAccessoryNone;
	
	if(self.countrySelectedFlg && self.countrySelected == indexPath.row)
		cell.accessoryType= UITableViewCellAccessoryCheckmark;
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.countrySelectedFlg=YES;
	self.countrySelected=indexPath.row;
	[self.mainTableView reloadData];
	self.assignButton.enabled=YES;
}




@end
