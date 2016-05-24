//
//  UnitListVC.m
//  Superpowers
//
//  Created by Rick Medved on 5/3/13.
//
//

#import "UnitListVC.h"
#import "UnitsVC.h"
#import "ObjectiveCScripts.h"

@interface UnitListVC ()

@end

@implementation UnitListVC
@synthesize mainSegment, mainTableView, piecesMultiDimArray;

- (IBAction) segmentChanged: (id) sender
{
	[self buildArray];
    [self.mainTableView reloadData];
}

-(void)buildArray
{
    NSArray *sp_pieces = [NSArray arrayWithObjects:@"Empty",
                          @"1|Artillery|art.gif|Ground|5||1|2|1|0|2|Y||Launch a powerful bombardment of an adjacent land or sea zone. Does not face counter-attack.|2|vehicle|3|",
                          @"2|Infantry|infantry.gif|Ground|3|Y|1|1|2|0|1|Y||Inexpensive and relatively good at defense. Weak attack value.|1|soldier|0|",
                          @"3|Tank|tank.gif|Ground|5||2|3|2|0|2|Y||Powerful attack piece and can move up to 2 spaces per turn.|4|vehicle||",
                          @"4|Transport|transport.gif|Sea|8|Y|2|0|1|4|0|Y||Used to carry troops over water|6|transport||",
                          @"5|Submarine|sub.gif|Sea|8|Y|2|2|2|1|0|Y||Attacks and defends sea zones.|7|ship||",
                          @"6|Fighter|fighter.gif|Air|10||4|3|4|0|2|Y||Good at attack and defense. Must return to the same territory after attacking.|8|fighter|0|",
                          @"7|Bomber|bomber.gif|Air|15||6|4|1|2|0|Y||Powerful attack, but weak defense. Can also carry up to 2 infantry as paratroopers.|9|bomber||",
                          @"8|Aircraft Carrier|carrier.gif|Sea|12|Y|2|1|3|4|0|Y||Strong defense plus can carry up to 2 fighter planes.|9|transport|0|",
                          @"9|Battle Cruiser|battleship.gif|Sea|15||2|4|4|1|0|Y||Kings of the sea, have extremely strong attack and defend capabilities.|10|ship|0|",
                          @"10|General|general.gif|Ground|0||1|0|3|0|1|N||Doubles the attack strength of all infantry in the battle.|12|hero||",
                          @"11|National Ruler|ruler.gif|Ground|0||1|0|1|0|1|N||Boosts income by 10 I.C. as long as he is alive and outside the capital. Also all tanks & infantry defend at 3 if leader is present.|12|hero||",
                          @"12|Super Battle Cruiser|s_battleship.gif|Sea|15||2|4|4|1|0|Y||Mighty upgradable battleship. Limit 1 per player.|11|ship||",
                          @"13|Air Defense|ad.gif|Ground|5||1|0|0|0|2|Y||Defense against planes and nukes.|99|aa||N",
                          @"14|Nuclear Missile|nuke.gif|Ground|20||1|4|0|0|2|Y||Destroys between 4-24 pieces instantly when used.|99|missile|4|N",
                          @"15|Factory|factory.gif|Building|15||0|0|0|0|0|Y||Acts as gateway for new pieces. Add a second factory to boost your income by 5 IC per turn.|99|building||N",
                          @"16|Upgd - Railway|upgrade.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"17|Upgd - Balistics|upgrade.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"18|Technology|tech.gif|Tech|10||0|0|0|0|0|Y|||99|technology||",
                          @"19|Economic Center|econ.gif|Building|15||0|0|0|0|0|Y||Boosts income by 5 IC per turn.|99|building||N",
                          @"20|Humvee|humvee.gif|Ground|4|N|2|2|3|0|2|N||United States: Inexpensive, mobile with a strong defense.|3|vehicle||",
                          @"21|Sniper|sniper.gif|Ground|3|N|1|3|1|0|1|N||European Union: Can only hit soldiers. Casualties do not get to return fire.|0|soldier|0|",
                          @"22|Mig 29|mig29.gif|Air|5|N|2|3|2|0|0|N||Russian Republic: Inexpensive with half the range of a fighter.|4|fighter||",
                          @"23|Kamakazi Plane|jap_fighter.gif|Air|5|N|4|6|1|0|0|N||Imperial Empire: Attacks a single transport, plane or vehicle choosing a target at random. No other ships or pieces can be targets. Both units are casualties.|1|fighter|0|",
                          @"24|Missile Launcher|nuke_cannon.gif|Ground|7|N|1|2|1|0|2|N||Communist Dynasty: Attacks same as artillery except 5 dice needing 2 or less to hit. Upgradable with technology. Requires Infantry or tanks as spotters.|3|vehicle|5|",
                          @"25|Jihad Bomber|terrorist.gif|Ground|5|N|1|6|1|0|1|N||Middle East Federation: Instantly kills self and 2-4 enemy units when attacking. They can attack from transports and no longer require spotters.|2|soldier|0|",
                          @"26|RPG Soldier|rpg.gif|Ground|4|N|1|2|2|0|1|N||African Coalition: Targets tanks on attack and defense.|3|soldier|0|",
                          @"27|Destroyer|destroyer.gif|Sea|10|N|3|3|3|0|0|N||Latin Alliance: Fast with strong attack and defense. All ships in fleet Can return fire when hit by a submarine.|8|ship||",
                          @"28|Medic||Ground|5|N|1|0|1|0|2|N||United States: Heals 1 infantry casualty per battle on offense or defense. Will return to previous country after healing a unit. Once used, he will not be able to heal again until your next turn.|3|soldier||",
                          @"29|Helicopter||Air|6|N|2|2|1|0|1|N||European Union: Attacks on land, sea and air. Subject to air defense. Can occupy a territory by itself.|5|chopper|0|",
                          @"30|Stinger Soldier||Ground|4|N|1|2|2|0|0|N||Russian Republic: Will target planes first, but can hit any piece encountered.|3|soldier||",
                          @"31|Flame Thrower||Ground|3|N|1|2|1|0|0|N||Imperial Empire: Strong attack piece with 2 dice, but can only hit soldiers.|0|soldier|2|",
                          @"32|Insurgent Mob||Ground|2|N|1|0|1|0|2|N||Communist Dynasty: Cheap, disposable pieces used for cannon fodder that can only hit soldiers. When accompanied by a general or when attacking with 8 or more, they will attack at a 1, otherwise no attack at all.|0|soldier|0|",
                          @"33|Scud Launcher||Ground|8|N|1|3|1|0|1|N||Middle East Federation: Fights like artillery only with 4 dice needing 3 to hit. Upgradable with technology. Requires infantry or tank spotters.|3|vehicle|4|",
                          @"34|Rocket Buggy||Ground|6|N|2|4|2|0|1|N||African Coalition: Strong attack piece and weak defender. Targets tanks when fighting.|4|vehicle|0|",
                          @"35|Special Ops||Ground|3|N|1|4|1|0|0|N||Latin Alliance: These units sneak into enemy territory and place exposives then return before the battle begins. They are immune to enemy fire and cannot occupy a territory. Since they have to return, they are unable to attack from ships.|2|soldier|0|",
                          @"36|Apache||Air|10|N|2|3|3|0|2|N||United States: Attacks in air, sea and land. Can occupy a territory by itself.|8|chopper|0|",
                          @"37|Nuke Cannon||Ground|10|N|1|4|1|0|1|N||Russian Republic: Rolls 4 dice needing 4 or less to hit.|3|vehicle|4|",
                          @"38|Cruiser||Sea|10|N|2|3|3|0|0|N||Imperial Empire: Attacks and defends at a 3. Comes equiped with an AD gun and cruise missiles.|8|ship||",
                          @"39|Chemical Bomb||Ground|10|N|1|6|3|0|0|N||African Coalition: Destroys itself and 5-9 enemy infantry in the first round of attack. Targets all soldier class units but will not hit vehicles, planes or other unit types.|3|vehicle|0|",
                          @"40|Hijacker||Ground|10|N|1|6|3|0|2|N||Middle East Federation: Converts 1 plane or vehicle when attacking, then retreats back to previous country. Normal defense.|6|soldier|0|",
                          @"41|Predator Drone||Air|10|N|6|3|1|0|1|N||Latin Alliance: Can fly out 3 spaces and attack any land territory with 2 dice, needing 3 or less to hit. Can ONLY be shot down by Air Defense when attacking. Makes single attack, then flies home. Targets vehicles with technology.|3|fighter|2|",
                          @"42|Battlemaster||Ground|10|N|1|4|4|0|1|N||Communist Dynasty: Powerful tank. 3 dice on attack, defends at a 4.|5|vehicle|3|",
                          @"43|Striker||Ground|10|N|2|3|4|0|0|N||European Union: 2 dice on attack. Has air defense built in and targets vehicles.|5|vehicle|2|",
                          @"44|Terminator|terminator.gif|Ground|11||1|4|2|||N|10/9/2009|Powerful attack piece that targets soldiers.|8|soldier|3|Y",
                          @"45|Navy Seal|800pxusnavysealswithlaserdesignator.jpg|Ground|10||2|4|1|||N|10/17/2009|Precision attack piece, can overwelm a defense quickly.|5|soldier|2|Y",
                          @"46|A-10 Warthog|a10.jpg|Air|15||4|3|3|||N|10/29/2009|A heavily armed fighter with mulitiple attacks that targets tanks.|8|fighter|3|Y",
                          @"47|F-15 Eagle|f15eagle1.jpg|Air|19||6|3|3|||N|11/14/2009|Air supremecy fighter. Armed with AIM-120 AMRAAMs (represented by AD) it can shoot down enemy fighters before being threatened. Gets 2 attacks and targets planes when attacking.|8|fighter|2|Y",
                          @"48|Blue Thunder|btmodel2.jpg|Air|10||2|3|2|||N|12/24/2009|Heavy Advanced Attack Chopper|8|chopper|2|Y",
                          @"49|Artillery Killer|blackhawk.jpg|Air|18||2|3|1|||N|1/14/2010|A chopper that targets artillery first.|8|chopper|5|Y",
                          @"50|KA-52 Alligator|kamov_ka52_alligator.jpg|Air|12||2|4|1|||N|2/6/2010|Long-ranged tank killer.|10|chopper|2|Y",
                          @"51|Lockheed AC-130|ac130.jpg|Air|17||6|4|1|||N|2/15/2010|The AC-130 gunship is a heavily-armed ground attack airplane|10|fighter|3|Y",
                          @"52|AH-64D Longbow|ah64d_longbow.jpg|Air|20||2|4|5|||N|2/20/2010|Fast moving tank killer|10|chopper|3|Y",
                          @"53|Sea King|mi24hindhelicopter.jpg|Air|10||2|5|3|||N|2/21/2010|A fast and agile offensive weapon|9|chopper|1|Y",
                          @"54|RAH-66|apachi.gif|Air|20||2|5|5|||N|5/30/2010|A strong defence and attack chopper|8|chopper|2|Y",
                          @"55|RAH-66|rah66comanchehelicopterwallpapersize600x450.jpg|Air|22||2|4|4|||N|6/2/2010|A fast and strong attack and defence chopper|10|chopper|3|Y",
                          @"56|The Ninja|images.jpg|Air|18||3|3|1|||N|6/11/2010|Sneaky and Tactical|8|bomber|3|Y",
                          @"57|Cobra Rattller|cobrarattler.jpg|Air|22||6|5|3|||N|6/22/2010|Hell bent on World Ctrl..|8|fighter|3|Y",
                          @"58|Hvy. Missile Cruiser|missile_ship.png|Sea|22||2|4|2|||N|6/29/2010|A heavy offensive vessel with shore bombardment capabilities but a relatively weak defense.|11|ship|4|Y",
                          @"59|Sea Shadow|sea_shadow.jpg|Sea|22||3|5|3|||N|7/15/2010|A stealth submarine armed with multiple SAMs and SSMs. Primarily designed as a swift and deadly First Strike weapon to neutralize opposing air force. Prepare your coffins...|12|ship|2|Y",
                          @"60|FA-22 Raptor|300pxlockheedmartinf22araptorjsoh.jpg|Air|21||4|5|5|||N|8/26/2010|Air Superiority Fighter|9|fighter|3|Y",
                          @"61|B52|b17c_icon.jpg|Air|13||6|5|1|||N|9/11/2010|Durable, relatively inexpensive and built in vast quantities by Boeing the The B-52, Models A-H, have been in active service with the USAF since 1955.|9|bomber|1|Y",
                          @"62|M1 Abrams|m1abrams.png|Ground|16||2|4|4|||N|10/5/2010|Strong tank with high defence and attack|10|vehicle|3|Y",
                          @"63|G.I. Joe|gi_joe_roadblock.jpg|Ground|10||1|1|1|||N|10/8/2010|Spreading a blanket of rounds it's almost certain to hit something. Gun points skyward before bearing down on other soldiers.|8|soldier|5|Y",
                          @"64|Combat Engineers|thumbnailcamfs2s5.jpg|Ground|10||2|2|4|||N|3/17/2011|With an array of heavy equipment, mines, ATMs and SAMs, this unit can hold ground better than any other. Will target vehicles and air assets first.|4|vehicle|1|Y",
                          @"65|Scooter|scooter.jpg|Ground|10||3|3|2|||N|5/13/2011|Fast land vehicle designed to hit quickly across distance|9|vehicle|2|Y",
                          @"66|Little Bird|apachi.gif|Air|10||2|5|2|||N|6/12/2011|Special Operations helicopter unit.|8|chopper|1|Y",
                          @"68|Merkava Mk IV|merkava.jpg|Ground|14||2|5|4|||N|3/24/2012|MBT of the Israel Defense Force. With a strong attack and defence. Designed to destroy enemy tanks on the battlefield it is also equipped to deal with infantry attacks.|8|vehicle|2|Y",
                          nil];
    
    NSArray *landUnits = [NSArray arrayWithObjects:[sp_pieces objectAtIndex:1], [sp_pieces objectAtIndex:2], [sp_pieces objectAtIndex:3], [sp_pieces objectAtIndex:10], [sp_pieces objectAtIndex:11], nil];
    NSArray *airUnits = [NSArray arrayWithObjects:[sp_pieces objectAtIndex:6], [sp_pieces objectAtIndex:7], [sp_pieces objectAtIndex:14], [sp_pieces objectAtIndex:13], nil];
    NSArray *seaUnits = [NSArray arrayWithObjects:[sp_pieces objectAtIndex:4], [sp_pieces objectAtIndex:5], [sp_pieces objectAtIndex:8], [sp_pieces objectAtIndex:9], [sp_pieces objectAtIndex:12], nil];
    NSArray *buildUnits = [NSArray arrayWithObjects:[sp_pieces objectAtIndex:15], [sp_pieces objectAtIndex:19], nil];
    
    [self.piecesMultiDimArray removeAllObjects];
    
    if(self.mainSegment.selectedSegmentIndex==0)
        [self.piecesMultiDimArray addObject:landUnits];
    if(self.mainSegment.selectedSegmentIndex==1)
        [self.piecesMultiDimArray addObject:airUnits];
    if(self.mainSegment.selectedSegmentIndex==2)
        [self.piecesMultiDimArray addObject:seaUnits];
    if(self.mainSegment.selectedSegmentIndex==0)
        [self.piecesMultiDimArray addObject:buildUnits];
    
    if(self.mainSegment.selectedSegmentIndex==3) {
    [self.piecesMultiDimArray addObject:[NSArray arrayWithObjects:[sp_pieces objectAtIndex:20], [sp_pieces objectAtIndex:21], [sp_pieces objectAtIndex:22], [sp_pieces objectAtIndex:23], [sp_pieces objectAtIndex:24], [sp_pieces objectAtIndex:25], [sp_pieces objectAtIndex:26], [sp_pieces objectAtIndex:27], nil]];
    [self.piecesMultiDimArray addObject:[NSArray arrayWithObjects:[sp_pieces objectAtIndex:28], [sp_pieces objectAtIndex:29], [sp_pieces objectAtIndex:30], [sp_pieces objectAtIndex:31], [sp_pieces objectAtIndex:32], [sp_pieces objectAtIndex:33], [sp_pieces objectAtIndex:34], [sp_pieces objectAtIndex:35], nil]];
    [self.piecesMultiDimArray addObject:[NSArray arrayWithObjects:[sp_pieces objectAtIndex:36], [sp_pieces objectAtIndex:37], [sp_pieces objectAtIndex:38], [sp_pieces objectAtIndex:39], [sp_pieces objectAtIndex:40], [sp_pieces objectAtIndex:41], [sp_pieces objectAtIndex:42], [sp_pieces objectAtIndex:43], nil]];
    }
   
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Units"];
   
    self.piecesMultiDimArray = [[NSMutableArray alloc] initWithCapacity:1000];
	[self buildArray];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.piecesMultiDimArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [[self.piecesMultiDimArray objectAtIndex:section] count];
}

-(UIImage *)getImageForPiece:(int)piece {
    if(piece!=12 && piece<=13)
        return [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.png", piece]];
    else
        return [UIImage imageNamed:[NSString stringWithFormat:@"piece%d.gif", piece]];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    
	NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifierSection%dRow%d", indexPath.section, indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if(cell==nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSString *piece = [[self.piecesMultiDimArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSArray *components = [piece componentsSeparatedByString:@"|"];
    
    int row_id = [[components objectAtIndex:0] intValue];
    cell.imageView.image = [ObjectiveCScripts getImageForPiece:row_id];
    cell.textLabel.text = [components objectAtIndex:1];
    
    if(indexPath.section>=4)
        cell.backgroundColor=[UIColor colorWithRed:.7 green:.9 blue:1 alpha:1];
    else
        cell.backgroundColor=[UIColor whiteColor];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (self.mainSegment.selectedSegmentIndex) {
        case 0:
            if(section==0)
                return @"Basic Ground Units";
            else
                return @"Building Units";
            break;
        case 1:
            return @"Basic Air Units";
            break;
        case 2:
            return @"Basic Sea Units";
            break;
        case 3:
            if(section==0)
                return @"Sergeant Units";
            if(section==1)
                return @"Warrant Units";
            if(section==2)
                return @"Officer Units";
            break;
            
        default:
            break;
    }
    NSArray *titles = [NSArray arrayWithObjects:@"Basic Ground Units", @"Basic Air Units", @"Basic Sea Units", @"Building Units", @"Sergeant Units", @"Warrant Units", @"Officer Units", nil];
    return [titles objectAtIndex:section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UnitsVC *detailViewController = [[UnitsVC alloc] initWithNibName:@"UnitsVC" bundle:nil];
	detailViewController.piece = [[self.piecesMultiDimArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:detailViewController animated:YES];
}



@end
