//
//  GameCell.m
//  Superpowers
//
//  Created by Rick Medved on 4/11/13.
//
//

#import "GameCell.h"
#import "ObjectiveCScripts.h"

@implementation GameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		int yRow=31;
		int row2 = yRow+20;
		int row3 = yRow+40;
		int row4 = yRow+60;

        self.round1Label = [[UILabel alloc] initWithFrame:CGRectMake(4, yRow, 37, 20)];
        self.round1Label.textAlignment = NSTextAlignmentLeft;
        self.round1Label.font = [UIFont systemFontOfSize:10];
        self.round1Label.text=@"Round:";
        self.round1Label.textColor=[UIColor blackColor];
        self.round1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.round1Label];
        
        self.round2Label = [[UILabel alloc] initWithFrame:CGRectMake(41, yRow, 25, 20)];
        self.round2Label.textAlignment = NSTextAlignmentLeft;
        self.round2Label.textColor = [UIColor blackColor];
        self.round2Label.font = [UIFont boldSystemFontOfSize:15];
        self.round2Label.text=@"-";
        self.round2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.round2Label];
        
        self.turn1Label = [[UILabel alloc] initWithFrame:CGRectMake(61, yRow, 35, 20)];
        self.turn1Label.textAlignment = NSTextAlignmentLeft;
        self.turn1Label.font = [UIFont systemFontOfSize:10];
        self.turn1Label.text=@"Turn:";
        self.turn1Label.textColor=[UIColor blackColor];
        self.turn1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.turn1Label];
        
        self.turn2Label = [[UILabel alloc] initWithFrame:CGRectMake(92, yRow, 95, 20)];
        self.turn2Label.textAlignment = NSTextAlignmentLeft;
        self.turn2Label.textColor = [UIColor blackColor];
        self.turn2Label.font = [UIFont boldSystemFontOfSize:15];
        self.turn2Label.text=@"-";
        self.turn2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.turn2Label];
        
        self.attack1Label = [[UILabel alloc] initWithFrame:CGRectMake(4, row2, 37, 20)];
        self.attack1Label.textAlignment = NSTextAlignmentLeft;
        self.attack1Label.font = [UIFont systemFontOfSize:10];
        self.attack1Label.textColor=[UIColor blackColor];
        self.attack1Label.text=@"Attack:";
        self.attack1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.attack1Label];
        
        self.attack2Label = [[UILabel alloc] initWithFrame:CGRectMake(41, row2, 25, 20)];
        self.attack2Label.textAlignment = NSTextAlignmentLeft;
        self.attack2Label.text=@"-";
        self.attack2Label.textColor=[UIColor redColor];
        self.attack2Label.font = [UIFont boldSystemFontOfSize:15];
        self.attack2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.attack2Label];
		
		UILabel *lastLogin = [[UILabel alloc] initWithFrame:CGRectMake(61, row2, 35, 20)];
		lastLogin.textAlignment = NSTextAlignmentLeft;
		lastLogin.textColor=[UIColor blackColor];
		lastLogin.font = [UIFont systemFontOfSize:10];
		lastLogin.text=@"Login:";
		lastLogin.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lastLogin];
		
		self.lstLogin = [[UILabel alloc] initWithFrame:CGRectMake(92, row2, 95, 20)];
		self.lstLogin.textAlignment = NSTextAlignmentLeft;
		self.lstLogin.font = [UIFont systemFontOfSize:12];
		self.lstLogin.textColor=[UIColor blackColor];
		self.lstLogin.text=@"-";
		self.lstLogin.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.lstLogin];
		
		
        self.time1Label = [[UILabel alloc] initWithFrame:CGRectMake(61, row3, 35, 20)];
        self.time1Label.textAlignment = NSTextAlignmentLeft;
        self.time1Label.textColor=[UIColor blackColor];
        self.time1Label.font = [UIFont systemFontOfSize:10];
        self.time1Label.text=@"Time:";
        self.time1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.time1Label];
        
        self.time2Label = [[UILabel alloc] initWithFrame:CGRectMake(92, row3, 95, 20)];
        self.time2Label.textAlignment = NSTextAlignmentLeft;
        self.time2Label.font = [UIFont boldSystemFontOfSize:15];
        self.time2Label.textColor=[UIColor blueColor];
        self.time2Label.text=@"-";
        self.time2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.time2Label];
        
        self.numPlayer1Label = [[UILabel alloc] initWithFrame:CGRectMake(4, row3, 35, 20)];
        self.numPlayer1Label.textAlignment = NSTextAlignmentLeft;
        self.numPlayer1Label.textColor=[UIColor blackColor];
        self.numPlayer1Label.font = [UIFont systemFontOfSize:10];
        self.numPlayer1Label.text=@"# Pl:";
        self.numPlayer1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.numPlayer1Label];
        
        self.numPlayer2Label = [[UILabel alloc] initWithFrame:CGRectMake(41, row3, 95, 20)];
        self.numPlayer2Label.textAlignment = NSTextAlignmentLeft;
        self.numPlayer2Label.font = [UIFont boldSystemFontOfSize:15];
        self.numPlayer2Label.textColor=[UIColor blueColor];
        self.numPlayer2Label.text=@"-";
        self.numPlayer2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.numPlayer2Label];
        
        self.type1Label = [[UILabel alloc] initWithFrame:CGRectMake(61, row4, 35, 20)];
        self.type1Label.textAlignment = NSTextAlignmentLeft;
        self.type1Label.textColor=[UIColor blackColor];
        self.type1Label.font = [UIFont systemFontOfSize:10];
        self.type1Label.text=@"Type:";
        self.type1Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.type1Label];
        
        self.type2Label = [[UILabel alloc] initWithFrame:CGRectMake(92, row4, 95, 20)];
        self.type2Label.textAlignment = NSTextAlignmentLeft;
        self.type2Label.font = [UIFont systemFontOfSize:15];
        self.type2Label.textColor=[UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
        self.type2Label.text=@"-";
        self.type2Label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.type2Label];
		
		UILabel *size = [[UILabel alloc] initWithFrame:CGRectMake(4, row4, 95, 20)];
		size.textAlignment = NSTextAlignmentLeft;
		size.textColor=[UIColor blackColor];
		size.font = [UIFont systemFontOfSize:10];
		size.text=@"Size:";
		size.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:size];
		
		self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, row4, 95, 20)];
		self.sizeLabel.textAlignment = NSTextAlignmentLeft;
		self.sizeLabel.textColor=[UIColor blackColor];
		self.sizeLabel.font = [UIFont systemFontOfSize:14];
		self.sizeLabel.text=@"2";
		self.sizeLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.sizeLabel];
		
		self.autoSkipLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, yRow+75, 95, 20)];
		self.autoSkipLabel.textAlignment = NSTextAlignmentLeft;
		self.autoSkipLabel.textColor=[UIColor redColor];
		self.autoSkipLabel.font = [UIFont systemFontOfSize:10];
		self.autoSkipLabel.text=@"Auto Skip";
		self.autoSkipLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.autoSkipLabel];
		
		self.autoStartLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, yRow+75, 95, 20)];
		self.autoStartLabel.textAlignment = NSTextAlignmentLeft;
		self.autoStartLabel.textColor=[UIColor orangeColor];
		self.autoStartLabel.font = [UIFont systemFontOfSize:10];
		self.autoStartLabel.text=@"Auto Start";
		self.autoStartLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.autoStartLabel];
		
		self.fogOfWarLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, yRow+75, 95, 20)];
		self.fogOfWarLabel.textAlignment = NSTextAlignmentLeft;
		self.fogOfWarLabel.textColor=[UIColor blueColor];
		self.fogOfWarLabel.font = [UIFont systemFontOfSize:10];
		self.fogOfWarLabel.text=@"Fog of War";
		self.fogOfWarLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.fogOfWarLabel];
		
        self.playersLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 30, 135, 135)];
        self.playersLabel.textAlignment = NSTextAlignmentLeft;
        self.playersLabel.numberOfLines=8;
        self.playersLabel.font = [UIFont fontWithName:@"Verdana" size:9];
        self.playersLabel.textColor=[UIColor blackColor];
        self.playersLabel.text=@"-";
        self.playersLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.playersLabel];
        
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
		[self.grayView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:self.grayView];

		
        self.gameNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.gameNameLabel.textAlignment = NSTextAlignmentLeft;
        self.gameNameLabel.textColor = [UIColor whiteColor];
        self.gameNameLabel.font = [UIFont boldSystemFontOfSize:21];
        self.gameNameLabel.backgroundColor = [UIColor clearColor];
        self.gameNameLabel.shadowColor = [UIColor blackColor];
        self.gameNameLabel.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:self.gameNameLabel];

        self.flagImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag1.gif"]];
		[self.contentView addSubview:self.flagImg];

    }
    return self;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
    
	float width=self.frame.size.width;
	
	self.gameNameLabel.frame = CGRectMake(5.0, 0, width, 25);
	self.flagImg.frame = CGRectMake(width-50, 2, 40, 40);
	self.grayView.frame = CGRectMake(0, 0, width, 25);
	self.playersLabel.frame = CGRectMake(width-135, 20, 135, 104);
	
}


+(void)populateCell:(GameCell *)cell game:(GameObj *)game row:(NSInteger)row {
	cell.type2Label.text = game.gameType;
	cell.numPlayer2Label.text = [NSString stringWithFormat:@"%d", game.numPlayers];
	
	cell.gameNameLabel.text=game.name;
	cell.flagImg.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"flag%d.gif", game.flag]];
	if(game.flag==0)
		cell.flagImg.alpha=0;
	
	cell.turn2Label.text=game.turn;
	cell.round2Label.text=[NSString stringWithFormat:@"%d", game.round];
	cell.attack2Label.text=[NSString stringWithFormat:@"%d", game.attackRound];
	cell.time2Label.text=game.timeLeft;
	cell.time2Label.textColor = [GameCell colorForTimeLeft:game.timeLeft];
	cell.lstLogin.text = game.lastLogin;
	
	NSString *playerText = [game.playerListString stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
	cell.playersLabel.text = playerText;
	
	cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
	cell.autoStartLabel.hidden = !game.autoStartFlg;
	cell.autoSkipLabel.hidden = !game.autoSkipFlg;
	cell.fogOfWarLabel.hidden = !game.fogOfWarFlg;
	
	cell.sizeLabel.text = [NSString stringWithFormat:@"%d", game.size];
	
	if(row%2==0)
		cell.backgroundColor=[UIColor colorWithRed:.7 green:.9 blue:1 alpha:1];
	else
		cell.backgroundColor=[UIColor colorWithRed:.5 green:.7 blue:.9 alpha:1];
	
	if([game.highlight isEqualToString:@"Y"] || [game.turn isEqualToString:[ObjectiveCScripts getUserDefaultValue:@"userName"]])
		cell.backgroundColor = [UIColor yellowColor];
	
	if([@"Open" isEqualToString:game.status]) {
		if(row%2==0)
			cell.backgroundColor = [UIColor colorWithRed:.9 green:1 blue:.9 alpha:1];
		else
			cell.backgroundColor = [UIColor colorWithRed:.8 green:.9 blue:.8 alpha:1];
	}
	
	if([@"Complete" isEqualToString:game.status]) {
		if(row%2==0)
			cell.backgroundColor = [UIColor colorWithRed:1 green:.9 blue:.9 alpha:1];
		else
			cell.backgroundColor = [UIColor colorWithRed:.9 green:.8 blue:.8 alpha:1];
	}
}

+(UIColor *)colorForTimeLeft:(NSString *)timeLeft {
	if([@"-Times up-" isEqualToString:timeLeft])
		return [UIColor blackColor];
	
	NSArray *components = [timeLeft componentsSeparatedByString:@" "];
	if(components.count>1) {
		if([@"hours" isEqualToString:[components objectAtIndex:1]]) {
			int hours = [[components objectAtIndex:0] intValue];
			if(hours>=20)
				return [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
			if(hours>=8)
				return [UIColor purpleColor];
		}
	}
	return [UIColor redColor];
}

@end
