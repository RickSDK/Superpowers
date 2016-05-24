//
//  LoadOnShipVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/15/13.
//
//

#import "LoadOnShipVC.h"
#import "PlaceUnitsVC.h"

@interface LoadOnShipVC ()

@end

@implementation LoadOnShipVC
@synthesize callBackViewController, mainTableView, countryName, nationNameLabel, cargoLabel;
@synthesize purchaseString, unitString, unitArray, purchaseArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadButtonClicked:(id)sender {
    NSString *returnValue = @"hey";
 	[(PlaceUnitsVC *)callBackViewController setReturningValue:returnValue];
	
	[self.navigationController popToViewController:callBackViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Load Units"];
    cargoLabel.text = @"-";
    nationNameLabel.text=self.countryName;
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(loadButtonClicked:)];
	self.navigationItem.rightBarButtonItem = rightButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSArray *titles = [NSArray arrayWithObjects:@"Select Ship or Bomber", @"Select Cargo to Load", nil];
	return [NSString stringWithFormat:@"%@", [titles objectAtIndex:section]];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", indexPath.section, indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = @"test";
//    cell.textLabel.text = [purchaseItems objectAtIndex:indexPath.row];
//    NSString *checkValue = [checkedItems objectAtIndex:indexPath.row];
/*
    if([checkValue isEqualToString:@"Y"])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    int piece = [[purchasePieces objectAtIndex:indexPath.row] intValue];
    
    if([self isCellEditable:indexPath.row])
        cell.backgroundColor = [UIColor whiteColor];
    else
        cell.backgroundColor = [UIColor grayColor];
    
*/
    int piece = 2;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.gif", piece]];
    
    
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
