//
//  UnitsForPlacementVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import "UnitsForPlacementVC.h"
#import "ObjectiveCScripts.h"
#import "PlaceUnitsVC.h"

@interface UnitsForPlacementVC ()

@end

@implementation UnitsForPlacementVC
@synthesize placeButton, nationLabel, mainTableView, purchaseString, purchaseItems, countryName, checkedItems;
@synthesize purchasePieces, countryWaterFlg, purchaseTypes, callBackViewController, placementString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) placeButtonClicked: (id) sender {
    
    NSString *newPlaceString = [ObjectiveCScripts getPurchaseString];
    NSMutableArray *newPlaceArray = [NSMutableArray arrayWithArray:[newPlaceString componentsSeparatedByString:@"+"]];
    NSMutableArray *purchaseArray = [NSMutableArray arrayWithArray:[self.purchaseString componentsSeparatedByString:@"+"]];
    for(int i=0; i<[self.checkedItems count]; i++) {
        NSString *checked = [self.checkedItems objectAtIndex:i];
        int piece = [[self.purchasePieces objectAtIndex:i] intValue];
        if(piece<[newPlaceArray count] && [checked isEqualToString:@"Y"]) {
            int currentPurCount = [[purchaseArray objectAtIndex:piece] intValue];
            int currentPlaceCount = [[newPlaceArray objectAtIndex:piece] intValue];
            currentPurCount--;
            currentPlaceCount++;
            [purchaseArray replaceObjectAtIndex:piece withObject:[NSString stringWithFormat:@"%d", currentPurCount]];
            [newPlaceArray replaceObjectAtIndex:piece withObject:[NSString stringWithFormat:@"%d", currentPlaceCount]];
            
        }
    }
    
    NSString *newPurStr = [purchaseArray componentsJoinedByString:@"+"];
    NSString *newPlaStr = [newPlaceArray componentsJoinedByString:@"+"];
    
    
    if([self.placementString length]>0)
        newPlaStr = [NSString stringWithFormat:@"%@|%@", newPlaStr, self.placementString];
    
    NSString *returnValue = [NSString stringWithFormat:@"%@:%@<li>%@", self.countryName, newPlaStr, newPurStr];
    
 	[(PlaceUnitsVC *)callBackViewController setReturningValue:returnValue];
	
	[self.navigationController popToViewController:callBackViewController animated:YES];
   
}

-(void)checkButtonClicked:(id)sender {
    if([self.checkedItems count]>0) {
        NSString *checkValue = [self.checkedItems objectAtIndex:0];
        checkValue = ([checkValue isEqualToString:@"Y"])?@"N":@"Y";
        for(int i=0; i<[self.checkedItems count]; i++)
            if([self isCellEditable:i])
                [self.checkedItems replaceObjectAtIndex:i withObject:checkValue];
        [mainTableView reloadData];
    }
}

-(void)loadPurchaseItems {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:200];
    NSMutableArray *tempCheckedArray = [[NSMutableArray alloc] initWithCapacity:200];
    NSMutableArray *tempPiecesArray = [[NSMutableArray alloc] initWithCapacity:200];
    NSMutableArray *tempTypesArray = [[NSMutableArray alloc] initWithCapacity:200];
    NSArray *items = [self.purchaseString componentsSeparatedByString:@"+"];
    int piece=0;
    

    for(NSString *countStr in items) {
        int count = [countStr intValue];
        if(count>0) {
            NSString *name = [ObjectiveCScripts getNameOfPiece:piece];
            NSString *type = [ObjectiveCScripts getTypeOfPiece:piece];
            for(int i=1; i<=count; i++) {
                [tempArray addObject:name];
                [tempCheckedArray addObject:@"N"];
                [tempPiecesArray addObject:[NSString stringWithFormat:@"%d", piece]];
                [tempTypesArray addObject:type];
            }
        }
        piece++;
    }

    self.purchaseItems = [NSArray arrayWithArray:tempArray];
    self.checkedItems = [NSMutableArray arrayWithArray:tempCheckedArray];
    self.purchasePieces = [NSMutableArray arrayWithArray:tempPiecesArray];
    self.purchaseTypes = [NSMutableArray arrayWithArray:tempTypesArray];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self isCellEditable:indexPath.row]) {
        NSString *checkValue = [self.checkedItems objectAtIndex:indexPath.row];
        checkValue = ([checkValue isEqualToString:@"Y"])?@"N":@"Y";
        [self.checkedItems replaceObjectAtIndex:indexPath.row withObject:checkValue];
        [mainTableView reloadData];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Place Units"];
    
    nationLabel.text = self.countryName;
    [self loadPurchaseItems];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Check All" style:UIBarButtonItemStylePlain target:self action:@selector(checkButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [self.purchaseItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

- (BOOL)isCellEditable:(int)rowNum
{
    NSString *type = [self.purchaseTypes objectAtIndex:rowNum];
    if([self.countryWaterFlg isEqualToString:@"Y"] && ![type isEqualToString:@"Sea"])
        return NO;
    
    if(![self.countryWaterFlg isEqualToString:@"Y"] && [type isEqualToString:@"Sea"])
        return NO;
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", indexPath.section, indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    cell.textLabel.text = [self.purchaseItems objectAtIndex:indexPath.row];
    NSString *checkValue = [self.checkedItems objectAtIndex:indexPath.row];
    
    if([checkValue isEqualToString:@"Y"])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    int piece = [[self.purchasePieces objectAtIndex:indexPath.row] intValue];
    
    if([self isCellEditable:indexPath.row])
        cell.backgroundColor = [UIColor whiteColor];
    else
        cell.backgroundColor = [UIColor grayColor];
    
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.gif", piece]];
    
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
