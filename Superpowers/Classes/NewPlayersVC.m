//
//  NewPlayersVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/25/16.
//
//

#import "NewPlayersVC.h"
#import "UserObj.h"
#import "UserCell.h"
#import "GameViewsVC.h"

@interface NewPlayersVC ()

@end

@implementation NewPlayersVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self performSelectorInBackground:@selector(loagPlayers) withObject:nil];
}

-(void)loagPlayers {
	@autoreleasepool {
		[self.mainArray removeAllObjects];
		NSString *responseStr = [WebServicesFunctions getResponseFromWeb:@"http://www.superpowersgame.com/scripts/newPlayers.php"];
		
		NSArray *components = [responseStr componentsSeparatedByString:@"<br>"];
		for (NSString *line in components)
			if(line.length>5)
				[self.mainArray addObject:[UserObj objectFromLine:line]];
		[self.mainTableView reloadData];
		NSLog(@"response: %@", responseStr);
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
	UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if(cell==nil)
		cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	UserObj *obj = [self.mainArray objectAtIndex:indexPath.row];
	cell.nameLabel.text=obj.name;
	cell.createdLabel.text=obj.created;
	cell.lastLoginLabel.text=obj.lastLogin;
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%d.gif", obj.rank]];
	
	cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UserObj *obj = [self.mainArray objectAtIndex:indexPath.row];
	
	GameViewsVC *detailViewController = [[GameViewsVC alloc] initWithNibName:@"GameViewsVC" bundle:nil];
	detailViewController.userId = obj.userId;
	detailViewController.screenNum = 6;
	[self.navigationController pushViewController:detailViewController animated:YES];
}


@end
