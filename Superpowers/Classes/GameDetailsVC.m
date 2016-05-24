//
//  GameDetailsVC.m
//  Superpowers
//
//  Created by Rick Medved on 2/11/13.
//
//

#import "GameDetailsVC.h"

@interface GameDetailsVC ()

@end

@implementation GameDetailsVC
@synthesize nameLabel, typeLabel, statusLabel, fogLabel, skipLabel, descTextView, skipSwitch, fogSwitch, gameObj;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Game Details"];
    
        nameLabel.text = self.gameObj.name;
        typeLabel.text = self.gameObj.gameType;
        statusLabel.text = self.gameObj.status;
        
        self.fogSwitch.on=self.gameObj.fogOfWarFlg;
		self.skipSwitch.on=self.gameObj.autoSkipFlg;
        
        descTextView.text = @"";
        
        if([self.gameObj.gameType isEqualToString:@"freeforall"]) {
            typeLabel.text = @"Free for All";
            descTextView.text = @"Each player is playing solo and the game ends when a single player is able to capture and hold at least 6 capitals for one full round.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"duo_diplomacy"]) {
            descTextView.text = @"You are allowed to have a single teammate so the game will exist with several small teams. The game ends when one team is able to capture and hold at least 6 capitals for one full round.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"firefight"]) {
            descTextView.text = @"This game has two teams of three plus two players fighting by themselves. Alliances can be made or broken at any time. The game ends when one team is able to capture and hold at least 6 capitals for one full round.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"training"]) {
            descTextView.text = @"Through the use of your military you must capture the capitals of both Russia and Indo-China before the Imperial Empire does.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"barbarian"]) {
            descTextView.text = @"Roman Empire verses the barbarians. Three players are teamed up and the rest are playing a free-for-all game. The game ends when either the Roman empire or a single player is able to capture and hold at least 6 capitals for one full round.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"locked"] || [self.gameObj.gameType isEqualToString:@"autobalance"] || [self.gameObj.gameType isEqualToString:@"teams"]) {
            descTextView.text = @"Teams are locked and the game ends when one team is able to capture and hold at least 6 capitals for one full round.";
        }
        
        if([self.gameObj.gameType isEqualToString:@"diplomacy"]) {
            typeLabel.text = @"Diplomacy";
            NSString *restriction = @"";
            if([self.gameObj.userTop1 length]>0)
                restriction = [NSString stringWithFormat:@"The following players are the top rated and cannot be on the same team: %@ & %@", self.gameObj.userTop1, self.gameObj.userTop2];
            descTextView.text = [NSString stringWithFormat:@"Teams are formed throughout the game and each player can have up to %d teammates.\n\nThe game ends when one team captures at least 6 capitals and holds them for one complete round.\n\n%@", self.gameObj.maxAllies, restriction];
        }
}



@end
