//
//  MoveUnitsVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/21/13.
//
//

#import "MoveUnitsVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "GameScreenVC.h"
#import "PlayerAttackVC.h"
#import "AttackBoardVC.h"

@interface MoveUnitsVC ()

@end

@implementation MoveUnitsVC
@synthesize activityIndicator, activityPopup, mainTableView, unitMultiArray, undoManager, nationImageView, nationLabel;
@synthesize mode, callBackViewController, attackButton, gameId, terrString, terr_id, transportCount, successFlg, showAllFlg;
@synthesize unitLessMultiArray;


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSArray *titles = [NSArray arrayWithObjects:@"Send Troops", @"x", @"x", @"Load Units", @"Move Units", @"Place Units", nil];
	[self setTitle:[titles objectAtIndex:self.mode]];
	
	self.unitMultiArray = [[NSMutableArray alloc] init];
	self.unitLessMultiArray = [[NSMutableArray alloc] init];
	
	NSArray *components = [self.terrString componentsSeparatedByString:@"|"];
	if([components count]>6) {
		self.nationImageView.image = [UIImage imageNamed:[components objectAtIndex:5]];
		self.nationLabel.text = [ObjectiveCScripts getNationNameFromId:self.terr_id];
	}
	
	NSString *action=@"Add Troops";
	self.attackButton.alpha=0;
	if(self.mode==0)
		self.attackButton.alpha=1;
	
	if(self.mode==5)
		action = @"Place";
	if(self.mode==4)
		action = @"Move";
	if(self.mode==3)
		action = @"Load Troops";
	
	self.navigationItem.rightBarButtonItem = [ObjectiveCScripts navigationButtonWithTitle:action selector:@selector(placeButtonClicked:) target:self];
	
	[self refreshPage];
	
}

- (IBAction) webButtonClicked: (id) sender {
    PlayerAttackVC *detailViewController = [[PlayerAttackVC alloc] initWithNibName:@"PlayerAttackVC" bundle:nil];
    detailViewController.terr_id = self.terr_id;
    detailViewController.gameId = self.gameId;
    detailViewController.callBackViewController=self.callBackViewController;
    detailViewController.mode=self.mode;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction) battleButtonClicked: (id) sender {
    AttackBoardVC *detailViewController = [[AttackBoardVC alloc] initWithNibName:@"AttackBoardVC" bundle:nil];
    detailViewController.terr_id = self.terr_id;
    detailViewController.gameId = self.gameId;
    detailViewController.callBackViewController=self.callBackViewController;
    detailViewController.mode=13;
    [self.navigationController pushViewController:detailViewController animated:YES];
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==99) {
		if (buttonIndex >0) {
		AttackBoardVC *detailViewController = [[AttackBoardVC alloc] initWithNibName:@"AttackBoardVC" bundle:nil];
		detailViewController.terr_id = self.terr_id;
		detailViewController.gameId = self.gameId;
		detailViewController.callBackViewController=self.callBackViewController;
		detailViewController.mode=13;
		[self.navigationController pushViewController:detailViewController animated:YES];
		}

		return;
	}
	if(alertView.tag==98 && buttonIndex >0) {
		[(GameScreenVC *)self.callBackViewController refreshMap];
		[self.navigationController popViewControllerAnimated:YES];
		return;
	}
    if(self.successFlg) {
        if(self.mode==3) {
            [self refreshPage];
        } else {
            [(GameScreenVC *)self.callBackViewController refreshMap];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)webServiceFunction {
	@autoreleasepool {
    
        [self.unitMultiArray removeAllObjects];
		[self.unitLessMultiArray removeAllObjects];
        
        NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"terrId", @"mode", nil];
        NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], [NSString stringWithFormat:@"%d", self.terr_id], [NSString stringWithFormat:@"%d", self.mode], nil];
        NSString *webAddr = @"http://www.superpowersgame.com/scripts/webPlaceUnits.php";
        
        if(self.mode==0 || self.mode==4|| self.mode==3)
            webAddr = @"http://www.superpowersgame.com/scripts/webAttack.php";
        
        
        NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr :nameList :valueList];
        NSLog(@"%d: responseStr=%@", self.mode, responseStr);
        
        if([WebServicesFunctions validateStandardResponse:responseStr :self]) {
            NSArray *parts = [responseStr componentsSeparatedByString:@"<a>"];
            if([parts count]>1) {
                NSArray *territories = [[parts objectAtIndex:1] componentsSeparatedByString:@"<b>"];
                for(NSString *terString in territories) {
                    if([terString length]>0) {
                        NSMutableArray *units = [NSMutableArray arrayWithArray:[terString componentsSeparatedByString:@"|"]];
                        if([units count]>1) {
                            [units removeLastObject];
							[self.unitMultiArray addObject:units];
							NSMutableArray *smallerUnits = [[NSMutableArray alloc] init];
							[smallerUnits addObject:[units objectAtIndex:0]];
							for(NSString *unit in units) {
								NSArray *components = [unit componentsSeparatedByString:@":"];
								if(components.count>1 && [@"Y" isEqualToString:[components objectAtIndex:1]])
									[smallerUnits addObject:unit];
							}
							[self.unitLessMultiArray addObject:smallerUnits];
                        }
                    }
                }
                [self.mainTableView reloadData];
            }
        }

	self.activityPopup.alpha=0;
	[self.activityIndicator stopAnimating];
    
	}
}

-(void)placeServiceFunction {
	@autoreleasepool {
        NSMutableString *data = [[NSMutableString alloc] initWithCapacity:1000];
		if(self.showAllFlg)
			for(NSArray *terrArray in self.unitMultiArray)
				[data appendString:[NSString stringWithFormat:@"%@|",[terrArray componentsJoinedByString:@"|"]]];
		else
			for(NSArray *terrArray in self.unitLessMultiArray)
				[data appendString:[NSString stringWithFormat:@"%@|",[terrArray componentsJoinedByString:@"|"]]];
		
        NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"terrId", @"data", nil];
        NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], [NSString stringWithFormat:@"%d", self.terr_id], data, nil];
        NSString *webAddr = @"http://www.superpowersgame.com/scripts/webMoveUnits.php";
        if(self.mode==5)
            webAddr = @"http://www.superpowersgame.com/scripts/webPlaceUnits2.php";
        if(self.mode==3)
            webAddr = @"http://www.superpowersgame.com/scripts/webLoadUnits.php";
        if(self.mode==0)
            webAddr = @"http://www.superpowersgame.com/scripts/webMoveUnitsAttack.php";
        
        NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr :nameList :valueList];
        
        
        self.successFlg=NO;
        if([WebServicesFunctions validateStandardResponse:responseStr :self]) {
            self.successFlg=YES;
           if(self.mode==5)
                [ObjectiveCScripts showAlertPopupWithDelegate:@"Units Placed" :@"" :self];
            if(self.mode==4)
                [ObjectiveCScripts showAlertPopupWithDelegate:@"Units Moved" :@"" :self];
            if(self.mode==3) {
 				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Units Loaded"
																message:@""
															   delegate:self
													  cancelButtonTitle:@"Load More"
													  otherButtonTitles: @"Done", nil];
				alert.tag=98;
				[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
			}
            
            if(self.mode==0) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Units Added"
																message:@"Troops are in position!"
															   delegate:self
													  cancelButtonTitle:@"Add More"
													  otherButtonTitles: @"Battle!", nil];
				alert.tag=99;
				[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
				//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
                [self webServiceFunction];
            }
        }

        self.activityPopup.alpha=0;
	[self.activityIndicator stopAnimating];
    
	}
}


-(void)placeButtonClicked:(id)sender {
	if(self.unitsSelected==0) {
		[ObjectiveCScripts showAlertPopup:@"First select one or more units" :@""];
		return;
	}
	self.attackButton.enabled=YES;

    if(self.mode==3 && self.transportCount==0) {
        [ObjectiveCScripts showAlertPopup:@"Notice" :@"Select a bomber or ship to load"];
        return;
    }

	self.activityPopup.alpha=1;
	[self.activityIndicator startAnimating];
	self.unitsSelected=0;
    [self performSelectorInBackground:@selector(placeServiceFunction) withObject:nil];
}

-(void)refreshPage {
    self.transportCount=0;
	self.activityPopup.alpha=1;
	[self.activityIndicator startAnimating];
	self.unitsSelected=0;
    [self performSelectorInBackground:@selector(webServiceFunction) withObject:nil];
}



- (IBAction) showAllButtonClicked: (id) sender {
	self.showAllFlg=!self.showAllFlg;
	[self.mainTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
	    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	NSArray *units = [NSArray new];
	if(self.showAllFlg)
		units = [self.unitMultiArray objectAtIndex:indexPath.section];
	else
		units = [self.unitLessMultiArray objectAtIndex:indexPath.section];
	
	
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
	cell.accessoryType= UITableViewCellAccessoryNone;
    if(indexPath.row==0) {
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:.6 alpha:1];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text=[units objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor whiteColor];
        NSArray *compnents = [[units objectAtIndex:indexPath.row] componentsSeparatedByString:@":"];
        if([compnents count]>3) {
            int piece = [[compnents objectAtIndex:0] intValue];
            NSString *selectable = [compnents objectAtIndex:1];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.gif", piece]];
            cell.textLabel.text=[ObjectiveCScripts getNameOfPiece:piece];
            int cargoCount=0;
            if([compnents count]>4)
                cargoCount = [[compnents objectAtIndex:4] intValue];
            if(cargoCount>0)
                cell.textLabel.text=[NSString stringWithFormat:@"%@ (%d)", [ObjectiveCScripts getNameOfPiece:piece], cargoCount];
            if([@"Y" isEqualToString:[compnents objectAtIndex:2]]) {
				self.unitsSelected++;
                cell.accessoryType= UITableViewCellAccessoryCheckmark;
                cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:.8 alpha:1];
                if(self.mode==3) {
                    if(piece==7 || piece==4 || piece==5 || piece==8 || piece==9 || piece==12 || piece==27 || piece==38)
                        cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:1 alpha:1];
                }
           }
            
            if([@"N" isEqualToString:selectable]) {
                cell.backgroundColor = [UIColor colorWithWhite:.7 alpha:1];
                cell.textLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
            }

        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0)
        return 30;
    else
        return 44;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(self.showAllFlg)
		return [self.unitMultiArray count];
	else
		return [self.unitLessMultiArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(self.showAllFlg)
		return [[self.unitMultiArray objectAtIndex:section] count];
	else
		return [[self.unitLessMultiArray objectAtIndex:section] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSArray *units = [NSArray new];
	if(self.showAllFlg)
		units = [self.unitMultiArray objectAtIndex:indexPath.section];
	else
		units = [self.unitLessMultiArray objectAtIndex:indexPath.section];

    NSMutableArray *unitsMut = [NSMutableArray arrayWithArray:units];
	self.unitsSelected=0;
    
    if(indexPath.row==0) {
        if([units count]>1) {
            NSArray *compnents = [[units objectAtIndex:1] componentsSeparatedByString:@":"];
            NSString *checkMark = [compnents objectAtIndex:2];
            checkMark = [@"Y" isEqualToString:checkMark]?@"N":@"Y";
            int i=0;
            self.transportCount=0;
            for(NSString *unitStr in units) {
                NSArray *compnents2 = [unitStr componentsSeparatedByString:@":"];
                if([compnents2 count]>2) {
                    int piece = [[compnents2 objectAtIndex:0] intValue];
                    NSString *editAble = [compnents2 objectAtIndex:1];
                    NSString *row_id = [compnents2 objectAtIndex:3];
                    NSString *cargo = @"0";
                    NSString *localCheckMark = checkMark;
                    if([compnents2 count]>4)
                        cargo = [compnents2 objectAtIndex:4];

                    BOOL isCargoFlg = NO;
                    if(piece==7 || piece==4 || piece==5 || piece==8 || piece==9 || piece==12 || piece==27 || piece==38)
                        isCargoFlg=YES;

                    if(self.mode==3 && isCargoFlg) {
                        if([@"Y" isEqualToString:checkMark]) {
                            self.transportCount++;
                            if(self.transportCount>1) {
                                self.transportCount=1;
                                localCheckMark=@"N";
                            }
                        }
                    }
					
					if([@"Y" isEqualToString:localCheckMark])
						self.unitsSelected++;

                    if([@"Y" isEqualToString:editAble])
                        [unitsMut replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d:%@:%@:%@:%@", piece, editAble, localCheckMark, row_id, cargo]];
                }
                i++;
            }
			
			if(self.showAllFlg)
				[self.unitMultiArray replaceObjectAtIndex:indexPath.section withObject:unitsMut];
			else
				[self.unitLessMultiArray replaceObjectAtIndex:indexPath.section withObject:unitsMut];
			
            [self.mainTableView reloadData];
       }
        [self.mainTableView reloadData];
        return;
    }
    
    NSArray *compnents = [[units objectAtIndex:indexPath.row] componentsSeparatedByString:@":"];
    if([compnents count]>2) {
        int piece = [[compnents objectAtIndex:0] intValue];
        NSString *editAble = [compnents objectAtIndex:1];
        if([@"Y" isEqualToString:editAble]) {
            NSString *checkMark = [compnents objectAtIndex:2];
            NSString *row_id = [compnents objectAtIndex:3];
            NSString *cargo = @"0";
            if([compnents count]>4)
                cargo = [compnents objectAtIndex:4];
            
            checkMark = [@"Y" isEqualToString:checkMark]?@"N":@"Y";
            BOOL isCargoFlg = NO;
            if(piece==7 || piece==4 || piece==5 || piece==8 || piece==9 || piece==12 || piece==27 || piece==38)
                isCargoFlg=YES;
           
            
            if(self.mode==3 && isCargoFlg) {
                if([@"Y" isEqualToString:checkMark]) {
                    self.transportCount++;
                    if(self.transportCount>1) {
                        self.transportCount=1;
                        checkMark=@"N";
                        [ObjectiveCScripts showAlertPopup:@"Notice" :@"Only load one bomber/ship at a time"];
                    }
                } else {
                    self.transportCount--;
                    if(self.transportCount<0) {
                        self.transportCount=0;
                    }
                }
            }
			if([@"Y" isEqualToString:checkMark])
				self.unitsSelected++;
           

            [unitsMut replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d:Y:%@:%@:%@", piece, checkMark, row_id, cargo]];
            
			if(self.showAllFlg)
				[self.unitMultiArray replaceObjectAtIndex:indexPath.section withObject:unitsMut];
			else
				[self.unitLessMultiArray replaceObjectAtIndex:indexPath.section withObject:unitsMut];
            [self.mainTableView reloadData];
        }
    }
    
}



@end
