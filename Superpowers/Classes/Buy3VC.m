//
//  Buy3VC.m
//  Superpowers
//
//  Created by Rick Medved on 2/27/13.
//
//

#import "Buy3VC.h"
#import "ObjectiveCScripts.h"
#import "Board.h"
#import "ListPickerVC.h"
#import "WebServicesFunctions.h"
#import "NSArray+ATTArray.h"
#import "GameScreenVC.h"

@interface Buy3VC ()

@end

@implementation Buy3VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.callBackViewController) {
        [(GameScreenVC *)self.callBackViewController setReturningValue:@"buy3"];
        
        [self.navigationController popToViewController:self.callBackViewController animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}


-(void)sendData
{
	@autoreleasepool {
    //    [NSThread sleepForTimeInterval:1];
    
		NSArray *nameList = [NSArray arrayWithObjects:@"game_id", @"nations", nil];
		NSArray *valueList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId], [self.countryList componentsJoinedByString:@"|"], nil];
		NSString *response = [WebServicesFunctions getResponseFromServerUsingPost:@"http://www.superpowersgame.com/scripts/mobilePlace3.php":nameList:valueList];

    
    NSArray *components = [response componentsSeparatedByString:@"|"];
    if([[components stringAtIndex:0] isEqualToString:@"Superpowers"]) {
        if([[components stringAtIndex:1] isEqualToString:@"Success"])
            [ObjectiveCScripts showAlertPopupWithDelegate:@"Placement Complete" :@"" :self];
        else
            [ObjectiveCScripts showAlertPopup:@"Error" :[components stringAtIndex:1]];
    } else
        [ObjectiveCScripts showAlertPopup:@"Network Error" :@"Sorry, unable to reach superpowers sever at this time. Please try again later."];
    
    self.activityPopup.alpha=0;
    self.activityLabel.alpha=0;
    [self.activityIndicator stopAnimating];
    
	}
}

-(void)doneButtonClicked:(id)sender {
    self.activityPopup.alpha=1;
    self.activityLabel.alpha=1;
    [self.activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(sendData) withObject:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Start"];
    
    self.nationLabel.text = [Board getSuperpowerNameFromId:self.nation];
    self.nationImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", self.nation]];
    
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonClicked:)];
	self.navigationItem.rightBarButtonItem = self.doneButton;
    self.doneButton.enabled=NO;
    
    self.countryList = [[NSMutableArray alloc] initWithCapacity:3];
    [self.countryList addObject:@"- select -"];
    [self.countryList addObject:@"- select -"];
    [self.countryList addObject:@"- select -"];

    self.activityPopup.alpha=0;
    self.activityLabel.alpha=0;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [self.countryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", indexPath.section, indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = [self.countryList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.rowNumber = indexPath.row;
    ListPickerVC *detailViewController = [[ListPickerVC alloc] initWithNibName:@"ListPickerVC" bundle:nil];
    // Pass the selected object to the new view controller.
    detailViewController.callBackViewController=self;
    detailViewController.titleName = @"Place Infantry";
    detailViewController.items = [Board getNationsForSuperpower:self.nation];
    detailViewController.selectedItem = [self.countryList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void) setReturningValue:(NSString *) value {
    [self.countryList replaceObjectAtIndex:self.rowNumber withObject:value];
    
    BOOL done=YES;
    for(NSString *name in self.countryList) {
        if([name isEqualToString:@"- select -"])
            done=NO;
    }
    if(done)
        self.doneButton.enabled=YES;
    
    [self.mainTableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
