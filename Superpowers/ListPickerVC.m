//
//  ListPickerVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/13/13.
//
//

#import "ListPickerVC.h"
#import "PurchaseVC.h"

@interface ListPickerVC ()

@end

@implementation ListPickerVC
@synthesize titleName, items, callBackViewController, selectedItem, picker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) selectClicked: (id) sender {
	[(PurchaseVC *)callBackViewController setReturningValue:self.selectedItem];
	
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
    [self setTitle:self.titleName];
    
    
    int i=0;
    BOOL noneFound=YES;
	for(NSString *value in self.items) {
		if([value isEqualToString:self.selectedItem]) {
			[picker selectRow:i inComponent:0 animated:YES];
            noneFound=NO;
        }
		i++;
	}

    if([self.items count]>0 && noneFound)
        self.selectedItem = [self.items objectAtIndex:0];

    self.selectedLabel.text = self.selectedItem;
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self.items objectAtIndex:row];
	
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedItem=[self.items objectAtIndex:row];
    self.selectedLabel.text = self.selectedItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
