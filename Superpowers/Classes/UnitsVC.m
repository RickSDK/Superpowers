//
//  UnitsVC.m
//  Superpowers
//
//  Created by Rick Medved on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UnitsVC.h"
#import "ObjectiveCScripts.h"

@implementation UnitsVC

@synthesize nameLabel, piece, picImageView, descTextView;
@synthesize attLabel, defLabel, moveLabel, typeLabel, subtypeLabel, retreatsLabel, cargoLabel, costLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) moreButtonPressed: (id) sender
{
    if(self.pieceId>19) {
        [ObjectiveCScripts showAlertPopup:@"No more info on this piece" :@""];
        return;
    }

    self.moreFlg=!self.moreFlg;
    if(self.moreFlg)
        self.moreTextView.alpha=1;
    else
        self.moreTextView.alpha=0;
}

-(void)setupMore:(int)piece_id {
    NSArray *pieceDesc = [NSArray arrayWithObjects:@"Empty",
                          @"ARTILLERY: These are special attack weapons that have very limited defense capabilities.\n\nArtillery units attack into an adjacent territory without actually entering it. Each unit rolls 3 dice and a hit is scored for each roll of 2 or lower. They attack at the same time as the other attacking units, but are only used in the first round of battle. Artillery are not placed on the combat board and remain in their original territory during and after the battle.\n\nCasualties of artillery are still able to fire back, and the artillery units themselves cannot be used as hits by the attacker.\n\nDefending artillery units have no defense roll, but can be used as hits by the defender.\n\nAll artillery attacks require field spotters. Meaning artillery can only be used in attacks involving ground troops as well; one tank or infantry per attacking artillery. This means, if a player wants to conduct an attack using 3 artillery units, at least three ground units must be involved as well. Paratroopers cannot be used as spotters.\n\nUnits used in the attack phase of your turn cannot be moved during the movement phase of that same turn.\n\nAs an alternative to attacking, artillery units can be moved into combat with other units. When used in this manor they do not attack, but can be used as hits. If the battle is won, the artillery units stay in the newly occupied territory.\nArtillery cannot attack into sea zones and do not fire from transports during amphibious assaults. They can, however, fire across land bridges and can be used as coastal defense.",
                          @"INFANTRY: Infantry are necessary for a strong defense as each costs only 2.5 IC’s and they defend at the same rate as tanks. Each unit represents one division of soldiers. They have a movement value of 1 and can be transported by bomber or transport ship.\n\nAlso, any infantry unit can act as a paratrooper division and get dropped into action by Bombers. See Bombers for more information on paratroopers.",
                          @"TANKS: Tank units can attack and defend in land territories. They can also be transported across sea zones by transport ships.\n\nTanks have a movement value of 2, however to move two spaces, the first move must be into a friendly or unoccupied territory. They cannot move into or through newly conquered territories.\n\nBlitzkrieg - Once a tank attacks, it cannot move any additional spaces. The only exception to this rule is if it Blitzkriegs through an unoccupied enemy territory on it’s first move. In this case it is free to move on to another enemy occupied, enemy unoccupied or friendly territory. For this maneuver, the tanks move through an unoccupied territory without stopping. Control of the territory is turned over to the attacker and the production chart should be adjusted. It is not necessary to leave any units behind when this happens.\n\nAmphibious assaults - Tanks, like infantry, have the ability to be picked up by transport ships and dropped directly into an enemy controlled territory. However, cargo must be on the coast at the beginning of the turn, and cannot move once dropped off. Blitzing is not an option for tanks following an amphibious landing.",
                          @"TRANSPORTS: Transports are special ships used to move land units from one coastal territory or island to another. Transports cannot attack, but defend with a “1”.\n\nOne transport can carry up to 4 infantry or 2 tanks or 2 artillery or 2 nuclear missiles. They can also carry combinations of each.\n\nIn addition they can carry up to 2 air defense units which do not take up cargo space. These units will help defend the fleet against air attacks.\n\nA transport can pick up cargo, move and unload all in the same turn. For example a transport could pick up two infantry units, move 1 space, pick up a tank, move another space and unload all in the same turn. All cargo must be dropped off at the same location, and once it unloads, its turn is over.\n\nAll cargo must be on the coast at the beginning of the turn, and cannot move once unloaded. For example, tanks cannot move one space, and then get picked up by a transport, all in the same turn.\n\nAny air defense units on board are able to defend against planes. Other cargo units are not able to attack or defend when loaded on the transport and cannot be used as hits. If the transport is sunk, all the cargo goes down with it.\n\nTransports have no attack factor, but can be used as “cannon fodder” to take hits and be chosen as casualties over costlier, more valuable units. This applies to both sea battles and amphibious assaults.\n\nWhen conducting amphibious assaults, it is best to clear the sea zone of enemy ships before moving transports in. To do this, roll the sea battle first, and then roll the land battle separately, but in the same turn. If you fail to clear the zone, you still have the option of rushing your transports through the enemy controlled waters and onto the beaches.\n\nTransports, unlike other ships, can move through enemy controlled waters. When this happens though, all defending sea & air units roll one round of counter-attack using their defense capabilities. Any transport hit goes down with its cargo. The surviving ships are free to pass through. If using this maneuver for an amphibious assault, transports would still be susceptible to any possible coastal defense, but would then drop off their cargo and could be used as cannon fodder during the assault. Following the battle, any surviving transports are automatically removed from the board if they are sitting in enemy controlled waters.\n\nBridging: Transports have the ability to carry and drop off two loads of cargo in the same turn if it can do so without moving. For instance, a transport sitting off the coast of France could transport two loads of cargo to England. This maneuver is only possible during the non-combat movement phase and only applies if the transport was not used that turn.",
                          @"SUBMARINE: Subs attack and defend in sea zones. They cannot transport any units except for Rulers and Generals.\n\nSubs attack and defend at a relatively weak die roll of “2”, but they conduct a deadly sneak attack. This means any hits from attacking subs are removed from the board without the chance of counter-attack. This advantage extends to all rounds of combat. Regardless of whether the sub hits or misses, they are still susceptible to enemy counter- attacks from all remaining units. Defending subs do not get this advantage.\n\nSpecial Withdraw Capability: Both attacking and defending subs have the ability to retreat at any round of the battle. This means at any point in the battle, instead of rolling a die, a sub can opt to retreat to an available sea zone. The retreating subs do not face counterattack, and the battle would then continue without them.\n\nTo use the special retreat capability, the subs must move to a friendly or unoccupied adjacent sea zone. If none are available, the subs cannot withdraw. If the attacking force consists exclusively of planes, the subs have the option of diving. This means they stay in the same territory. For this maneuver, the planes each get one free round of attack, and then return to base.\n\nSubs can attack enemy ships, but not planes. They can however be hit by planes. This means any hit scored by a sub, must be used against a ship. For example say an aircraft carrier and a fighter attack a sub. If the sub scores a hit, the carrier goes down. At the end of the battle, the fighter would need to find a safe place to land or crash into the sea. If a defending carrier is sunk, all its planes would be lost after the battle.",
                          @"FIGHTER PLANES: Fighters can attack and defend in land and sea zones, and have a flight range of 4 spaces.\n\nFighters must always land safely. This usually means flying out two spaces, attacking, and flying back two spaces to land in the original territory. They however, are not restricted to this exact formula and can take any flight path so long as they return to a territory owned by yourself or member of your alliance. They do not have the option of moving out 4 spaces to attack, as there are no “kamikaze” attacks allowed.\n\nWhen launched from carriers, taking off and landing does not require a movement, only crossing black lines. Also, fighters get four spaces from the original location of the carrier, meaning the fighter actually takes off before the carrier moves, but then can rendezvous back to the carrier’s new location. You cannot first move the carrier 2 spaces, and then launch the fighter another two spaces and have it return back to the carrier.",
                          @"BOMBERS: Just as an infantry unit represents an entire division of troops, a bomber unit actually represents an entire squadron of bombers with a few transport planes mixed in as well.\n\nBombers, like fighters, must land in friendly land zones at the end of your turn. They cannot land in enemy, neutral or newly conquered territories. They also cannot land on aircraft carriers.\n\nBombers have a movement value of 6 and have two types of attacks, conventional and strategic bombing raids. When used for conventional attacks, they also have the option of dropping up to 2 paratroopers.\n\nSee Strategic Bombing Runs on page 17 for more information on Bomber attacks.\n\nBombers are allowed only one action per turn; either conventional attack or strategic bombing raid. Any bombers not used in an attack can be used to move up to 2 infantry units during the movement phase of your turn.\n\nPARA- TROOPERS: Paratroopers are regular infantry units, which can be picked up by a bomber and dropped into an embattled territory. Paratroopers can only be dropped into battles when accompanied by other ground forces; at least one tank or regular infantry unit per bomber. Artillery spotters and other paratroopers cannot be counted as ground support. This is to prevent quick land grabs deep in enemy territory.\n\nBombers use the first round of battle to drop their paratroopers and do not attack in that round. They continue to fight in their normal way for all additional rounds. If they are shot down by AD fire in the first round, both the bomber and the paratroopers are removed from the board without a chance for return fire.\n\nBombers can only pick up paratroopers if both are on the same territory before the turn began. For Example, you cannot move your bomber one space, pick up paratroopers and then drop them off somewhere else. This same rule applies during the Movement phase of your turn.",
                          @"AIRCRAFT CARRIER: Carriers attack and defend in sea zones. They cannot carry infantry or tanks, but can transport fighters and AD units. When armed with an AD unit, it assists in defense against planes.\n\nIf a carrier is attacked, its fighter planes are considered defending in the air. A player can choose to take a fighter as a casualty instead of the carrier. Exception: submarine hits cannot be against planes, and therefore must be used against the carrier. If the carrier is sunk, the fighters continue until the battle is over, at which time they crash into the sea.\n\nNewly purchased AD Guns and fighters can be placed directly on existing carriers.",
                          @"BATTLESHIPS: Battleships are kings of the sea. They attack and defend in sea zones. They also have the ability to launch cruise missiles into an enemy coastal territory during an amphibious assault.\n\nThey have a movement value of 2 and attack and defend at 4. They can be involved in combat with any other sea units or planes. They can also attack ground troops during amphibious assaults.\n\nIf a battleship accompanies a transport in an amphibious assault, it fires a one-shot support attack. Any roll of 4 or less is considered a casualty - still capable of returning fire in the defender’s counterattack.\n\nNOTE: During an amphibious assault, any battleship involved in clearing a sea zone is not eligible for the one-shot support attack.",
                          @"GENERALS: Each player begins the game with one General, who is used to help boost the attacking skills of all infantry he accompanies into battle.\n\nGenerals have a movement value of 1 and attack along side other military pieces. When your general accompanies the attack, all infantry attack with a “2” for as long as he remains in the battle.\n\nGenerals also have the ability to withdraw after the first round of battle. This means you can take advantage of higher infantry attacks for one round, and then move him back to his original territory so as not to be left on the front lines. Even if the entire battle only lasts one round, the General can still return to his original territory.\n\nGenerals, themselves, do not attack, but defend with a value of 3. Once killed, he is finished and gets removed from the game.\n\nYour General can be transported by bomber or any naval ship and does not take up cargo space. Generals will assist when defending sea battles as well.",
                          @"RULERS: Each player begins the game with one ruler. These pieces are used to boost moral of the nation when visiting troops.\n\nEach superpower’s ruler functions the same although their names are different. These names are indicated on the Nation Card. Rulers cannot be created and once killed, they are finished.\n\nAs long as your ruler is outside your capital, the national production is increased by 10 IC’s. This shows the nation that he is not afraid to move about his empire. Once he retreats back to the capital, the income drops back to its regular level.\n\nAlso, if a territory containing the ruler is attacked, all infantry and tanks defend with a “3” for each round of the battle. This bonus applies to all territories except for the capital.\n\nThe ruler can be carried by bomber or any naval ship and does not take up cargo space. Keep in mind that the economic bonus only applies when the ruler is in territories of his own empire. Sitting on naval ships or alliance controlled territories does not count.",
                          @"SUPER BATTLESHIPS: Each superpower is allowed one Super Battleship. These ships have special upgrades, which are paid for at the time of purchase. Mark these ships by placing a control flag under the unit.\n\nWhen purchasing a Super Battleship, write down all of your upgrades and be sure to announce it’s full capabilities to the other players.\n\nMultiple upgrades can be done on a single ship. Some attributes, like hit points and attacks, can be upgraded twice. See the Super Battleship Construction Chart for details about all possible upgrades.\n\nA damaged battleship fights exactly as a healthy one and the sub pot-shot advantages are only implemented on the ship’s final hit point. A damaged ship can be restored to full strength by docking at any friendly port and then paying 15 IC’s.\n\nEach player is allowed only one Super Battleship at a time, however at any time, a player can decommission a ship to a regular battleship in order to purchase a better one. No credit is given for the lost attributes in this case.",
                          @"AIR DEFENSE UNITS: Missile defense batteries are special defense units used against planes and nukes.\n\nIn combat involving planes, the AD units are the first pieces to fire at the beginning of each round of battle. The defender rolls one die for each AD unit per attacking plane. For example if a territory is defended with two AD units and four planes attack, the defender would roll 8 dice. Any roll of “1” strikes a hit. The attacker removes any casualties immediately without a chance of firing. Any paratroopers being carried are killed before having a chance to jump. The battle would then continue like normal. This procedure is repeated for each round of battle.\n\nAD units have a movement value of 1 or can be transported by transport ship or aircraft carrier and do not take up any cargo space. When on a transport or carrier, they help defend against enemy air strikes.\n\nNo more than 2 AD units can be active on any single territory. If a country has more than 2 units, only 2 will defend against the planes or nukes.\n\nAD units can be purchased at the same time as new complexes and placed on the board together. Also, newly purchased guns can be placed on any territory containing a complex. Even one just captured in the same turn.\n\nAD units only fire when they are attacked directly. Planes are free to fly over enemy AD units without facing attacks.",
                          @"NUCLEAR MISSILES: These intercontinental ballistic weapons of mass destruction are very costly to produce, but can be devastating to your enemies.\n\nNukes have a movement value 1 but once launched, have a range of 2 spaces. A basic nuke inflicts 12 casualties, 15 hits with Chemical Warheads tech and 18 hits with Anthrax tech. The defenders are removed from the board and do not fight back.\n\nThe only defense against nukes is through air defense units. Air defense units reduce the total number of hits by 2 per AD unit (up to 3 AD units max). With anti-balistics tech, AD units reduce the total hits by 4 per unit. So a fully upgraded nuke going against a fully defended territory will always get 6 hits.\n\nNukes can attack sea zones as well, except hits are reduced in half. For these attacks, fighters and cargo cannot be used as hits and go down with their ships.\n\nWhen a nuke is used, that player cannot attack the same territory on that turn using conventional weapons. For example, a player cannot attack with a nuke and then move tanks into the same territory, all on the same turn. In fact, no player can attack that same territory until the defender’s turn. If, on the other hand, the nuke is shot down, the player can then attack using conventional forces.\n\nNukes, like AD units can never be destroyed. When attacked, they do not defend and are turned over to the attacker if the territory is lost. Other nukes, AD units and Industrial Complexes are not affected by nuclear strikes.",
                          @"MILITARY INDUSTRIAL COMPLEXES: Factories are important in that they serve as a gateway for the placement of newly purchased units. You start the game with one complex on your capital and additional complexes can be purchased to serve one of two purposes:\n\nPRODUCTION FACTORY: Additional complexes can be purchased and placed on other territories to act as gateways for newly purchased units. This can greatly speed up the time needed to get troops to the front lines. These can be placed on any territory you controlled since the beginning of your turn. New units can be placed on any territory that contains a complex. No economic bonus is received for these.\n\nECONOMIC CENTER: Purchasing additional complexes (use the green chips) increases your income by 5 IC’s per turn. This can be a great way to expand your economic base without risking units in war.\n\nYou can place complexes on as many territories as you wish, but are limited to having a maximum of 2 complexes per territory, meaning 1 production factory and 1 economic center. Your main capital can have a total of 3 complexes.\n\nIt is important to know, you can only place new units on territories which you controlled AND had a complex on at the beginning of your turn. AD guns are an exception in that you can place them next to any complex you own, including newly purchased or newly conquered.",
                          @"",
                          @"",
                          @"",
                          @"ECONOMIC CENTER: Purchasing additional complexes (use the green chips) increases your income by 5 IC’s per turn. This can be a great way to expand your economic base without risking units in war.\n\nYou can place complexes on as many territories as you wish, but are limited to having a maximum of 2 complexes per territory, meaning 1 production factory and 1 economic center. Your main capital can have a total of 3 complexes.\n\nIt is important to know, you can only place new units on territories which you controlled AND had a complex on at the beginning of your turn. AD guns are an exception in that you can place them next to any complex you own, including newly purchased or newly conquered.",
                          nil];
    if([pieceDesc count]>piece_id)
        self.moreTextView.text = [pieceDesc objectAtIndex:piece_id];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Unit"];
    NSArray *components = [self.piece componentsSeparatedByString:@"|"];
    
    nameLabel.text=[components objectAtIndex:1];

    int numAttacks = [[components objectAtIndex:16] intValue];
    attLabel.text=[components objectAtIndex:7];
    if(numAttacks>1)
        attLabel.text=[NSString stringWithFormat:@"%@ x %d", [components objectAtIndex:7], numAttacks];
    defLabel.text=[components objectAtIndex:8];
    moveLabel.text=[components objectAtIndex:6];
    typeLabel.text=[components objectAtIndex:3];
    subtypeLabel.text=[components objectAtIndex:15];
//    retreatsLabel.text=[components objectAtIndex:1];
  //  cargoLabel.text=[components objectAtIndex:1];

    costLabel.text = [NSString stringWithFormat:@"%@ IC", [components objectAtIndex:4]];
    self.pieceId = [[components objectAtIndex:0] intValue];
    [self setupMore:self.pieceId];
    picImageView.image = [ObjectiveCScripts getImageForPiece:self.pieceId];
    descTextView.text = [components objectAtIndex:13];

    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"More Info" style:UIBarButtonItemStylePlain target:self action:@selector(moreButtonPressed:)];
	self.navigationItem.rightBarButtonItem = addButton;

    self.moreTextView.alpha=0;
    
}





@end
