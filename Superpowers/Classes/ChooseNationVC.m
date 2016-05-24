//
//  ChooseNationVC.m
//  Superpowers
//
//  Created by Rick Medved on 6/24/13.
//
//

#import "ChooseNationVC.h"
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"

@interface ChooseNationVC ()

@end

@implementation ChooseNationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(int)getTeamForPlayer:(int)player {
    if(player > [self.playerArray count])
        return 0;
    
    NSString *playerStr = [self.playerArray objectAtIndex:player];
    
    NSArray *components = [playerStr componentsSeparatedByString:@"|"];
    if([components count]>=3)
        return [[components objectAtIndex:2] intValue];
    
    return 0;
}

-(void)getNationInfo {
	@autoreleasepool {

        NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"game_id", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], [NSString stringWithFormat:@"%d", self.gameId], nil];
	NSString *webAddr = @"http://www.superpowersgame.com/scripts/mobileShowNations.php";
	NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
        
        NSArray *players = [responseStr componentsSeparatedByString:@"<a>"];
        for(NSString *player in players) {
            NSArray *components = [player componentsSeparatedByString:@"|"];
            if([components count]>=3) {
                int nation = [[components objectAtIndex:2] intValue];
                if(nation>0)
                    [self.playerArray replaceObjectAtIndex:nation-1 withObject:player];
            }
        }
        
        
        self.mainTableView.alpha=1;
        self.activityPopup.alpha=0;
        [self.activityIndicator stopAnimating];
        [self.mainTableView reloadData];
	}

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Choose Nation"];
    
    self.playerArray = [[NSMutableArray alloc] initWithCapacity:8];
    for(int i=1; i<=8; i++)
        [self.playerArray addObject:[ObjectiveCScripts getSuperpowerNameFromId:i]];
    
    self.mainTableView.alpha=0;
    self.activityPopup.alpha=1;
    [self.activityIndicator startAnimating];
    
    if(self.gameId>0)
        [self performSelectorInBackground:@selector(getNationInfo) withObject:nil];
    // Do any additional setup after loading the view from its nib.

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
	    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSString *playerStr= [self.playerArray objectAtIndex:indexPath.row];
    cell.textLabel.text=playerStr;
    int nation = [self getTeamForPlayer:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", indexPath.row+1]];
   
    if(nation>0) {
        NSArray *components = [playerStr componentsSeparatedByString:@"|"];
        if([components count]>2) {
            cell.textLabel.text=[NSString stringWithFormat:@"%@ (Team %@)", [components objectAtIndex:0], [components objectAtIndex:1]];
        }
        cell.backgroundColor=[UIColor grayColor];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    } else {
        cell.backgroundColor=[UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    }
        
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.playerArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int nation = [self getTeamForPlayer:indexPath.row];
    self.selectedNation=indexPath.row+1;
    if(nation==0)
        [ObjectiveCScripts showConfirmationPopup:[ObjectiveCScripts getSuperpowerNameFromId:indexPath.row+1] :@"" :self];
}

-(void)selectNation {
	@autoreleasepool {
    
        NSArray *nameList = [NSArray arrayWithObjects:@"Username", @"Password", @"game_id", @"nation", nil];
	NSArray *valueList = [NSArray arrayWithObjects:[ObjectiveCScripts getUserDefaultValue:@"userName"], [ObjectiveCScripts getUserDefaultValue:@"password"], [NSString stringWithFormat:@"%d", self.gameId], [NSString stringWithFormat:@"%d", self.selectedNation], nil];
	NSString *webAddr = @"http://www.superpowersgame.com/scripts/mobileChooseNation.php";
	NSString *responseStr = [WebServicesFunctions getResponseFromServerUsingPost:webAddr:nameList:valueList];
        NSLog(@"+++%@", responseStr);
        
        self.formNumber=99;
	if([WebServicesFunctions validateStandardResponse:responseStr:nil]) {
            [ObjectiveCScripts showAlertPopupWithDelegate:@"Success!" :@"" :self];
	}
        
        
        self.mainTableView.alpha=1;
        self.activityPopup.alpha=0;
        [self.activityIndicator stopAnimating];
    
 
	}
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(self.formNumber==99) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        return;
    }
    
    if(buttonIndex==1) {
        self.activityPopup.alpha=1;
        [self.activityIndicator startAnimating];
        
        if(self.gameId>0)
            [self performSelectorInBackground:@selector(selectNation) withObject:nil];
    }
}


@end
