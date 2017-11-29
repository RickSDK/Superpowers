//
//  TemplateVC.m
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import "TemplateVC.h"

@interface TemplateVC ()

@end

@implementation TemplateVC

- (void)viewDidLoad {
    [super viewDidLoad];

	self.webServiceElements = [[NSMutableArray alloc] init];
	self.textFieldElements = [[NSMutableArray alloc] init];
	self.mainArray = [[NSMutableArray alloc] init];

	float height = [ObjectiveCScripts screenHeight]+200;
	float width = [ObjectiveCScripts screenWidth]+200;
	if(width<1600)
		width=1600;
	if(height<1000)
		height=1000;
	
	self.popupView.hidden=YES;
	self.popupInfoView.hidden=(self.popupInfoView.tag==0);

	
	UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(-200, -200, width, height)];
	bg.image = [UIImage imageNamed:@"bg_gray.jpg"];
	[self.view addSubview:bg];
	[self.view sendSubviewToBack:bg];

	self.webServiceView = [[WebServiceView alloc] initWithFrame:CGRectMake(36, 203, 257, 178)];
	[self.view addSubview:self.webServiceView];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)])
		[self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(BOOL)shouldAutorotate
{
	return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", (int)indexPath.section, (int)indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	cell.textLabel.text=@"test";
	cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
	cell.accessoryType= UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.mainArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

-(void)startWebService:(SEL)aSelector message:(NSString *)message {
	for(UIControl *button in self.webServiceElements)
		button.enabled=NO;
	[self resignResponders];
	
//	[self.mainArray removeAllObjects];
	self.mainTableView.alpha=0;
	[self.webServiceView startWithTitle:message];
	[self performSelectorInBackground:aSelector withObject:nil];
}


-(void)stopWebService {
	for(UIControl *button in self.webServiceElements)
		button.enabled=YES;
	[self.webServiceView stop];
	[self.mainTableView reloadData];
	self.mainTableView.alpha=1;
}

-(void)resignResponders {
	for(UIControl *textField in self.textFieldElements)
		[textField resignFirstResponder];
}

- (IBAction) segmentChanged: (id) sender {
	[self.mainSegment changeSegment];
}

- (IBAction) xButtonPressed: (id) sender {
	self.popupView.hidden=YES;
}



@end
