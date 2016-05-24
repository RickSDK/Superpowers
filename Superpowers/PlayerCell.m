//
//  PlayerCell.m
//  Superpowers
//
//  Created by Rick Medved on 3/28/13.
//
//

#import "PlayerCell.h"

@implementation PlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.incomeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.incomeLabel.textAlignment = NSTextAlignmentLeft;
        self.incomeLabel.textColor = [UIColor blackColor];
        self.incomeLabel.font = [UIFont systemFontOfSize:12.0];
        self.incomeLabel.backgroundColor = [UIColor clearColor];
        self.incomeLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.incomeLabel];
        
		self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.moneyLabel.textAlignment = NSTextAlignmentLeft;
		self.moneyLabel.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
		self.moneyLabel.font = [UIFont boldSystemFontOfSize:14.0];
		self.moneyLabel.backgroundColor = [UIColor clearColor];
		self.moneyLabel.textAlignment=NSTextAlignmentCenter;
		[self.contentView addSubview:self.moneyLabel];
		
        self.flagImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag1.gif"]];
        self.flagImg.frame = CGRectMake(0, 0, 35, 35);
		[self.contentView addSubview:self.flagImg];

        
        self.nukeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nuke.gif"]];
        self.nukeImg.frame = CGRectMake(25, 0, 30, 30);
		[self.contentView addSubview:self.nukeImg];
        
        self.satImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sat.png"]];
        self.satImg.frame = CGRectMake(45, 0, 15, 30);
		[self.contentView addSubview:self.satImg];
        
        self.genImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green.png"]];
        self.genImg.frame = CGRectZero;
		[self.contentView addSubview:self.genImg];
        
        self.leadImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green.png"]];
        self.leadImg.frame = CGRectZero;
		[self.contentView addSubview:self.leadImg];
        
        
    }
    return self;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
    
	float width=self.frame.size.width;
	int margin=width/8;
	
	self.nameLabel.frame = CGRectMake(65.0, 2, width-210, 30);
	self.genImg.frame = CGRectMake(width-(100+margin), 10, 18, 18);
	self.leadImg.frame = CGRectMake(width-(80+margin), 10, 18, 18);
	self.incomeLabel.frame = CGRectMake(width-(62+margin), 2, 30, 30);
	self.moneyLabel.frame = CGRectMake(width-(30+margin), 2, 30, 30);
}


+(void)populateCell:(PlayerCell *)cell playerObj:(PlayerObj *)playerObj playerTurn:(int)playerTurn {
	if(playerObj.generalFlg)
		cell.genImg.image = [UIImage imageNamed:@"green.png"];
	else
		cell.genImg.image = [UIImage imageNamed:@"red.png"];
	
	if(playerObj.leaderFlg)
		cell.leadImg.image = [UIImage imageNamed:@"green.png"];
	else
		cell.leadImg.image = [UIImage imageNamed:@"red.png"];
	
	cell.backgroundColor=[UIColor colorWithRed:.7 green:.9 blue:1 alpha:1];
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	if(playerTurn==playerObj.player_id) {
		cell.accessoryType= UITableViewCellAccessoryCheckmark;
		cell.nameLabel.textColor=[UIColor colorWithRed:.7 green:0 blue:0 alpha:1];
		cell.nameLabel.text=[NSString stringWithFormat:@"*%@", playerObj.username];
	} else {
		cell.accessoryType= UITableViewCellAccessoryNone;
		cell.nameLabel.textColor=[UIColor blackColor];
		cell.nameLabel.text=playerObj.username;
	}
	
	if(playerObj.team>0) {
		switch (playerObj.team) {
			case 1:
				cell.backgroundColor=[UIColor colorWithRed:.5 green:.7 blue:.9 alpha:1];
				break;
			case 2:
				cell.backgroundColor=[UIColor colorWithRed:.9 green:.7 blue:.5 alpha:1];
				break;
			case 3:
				cell.backgroundColor=[UIColor colorWithRed:.5 green:.9 blue:.7 alpha:1];
				break;
			case 4:
				cell.backgroundColor=[UIColor colorWithRed:.7 green:.9 blue:.5 alpha:1];
				break;
				
			default:
				break;
		}
	}
	
	if([@"Loss" isEqualToString:playerObj.status]) {
		cell.backgroundColor=[UIColor colorWithRed:1 green:.5 blue:.5 alpha:1];
		cell.nameLabel.textColor=[UIColor grayColor];
	}
	if([@"Win" isEqualToString:playerObj.status])
		cell.backgroundColor=[UIColor colorWithRed:.5 green:1 blue:.5 alpha:1];
	
	if(playerObj.nukeCount>0)
		cell.nukeImg.alpha=1;
	else
		cell.nukeImg.alpha=0;
	if(playerObj.satFlg)
		cell.satImg.alpha=1;
	else
		cell.satImg.alpha=0;
	cell.incomeLabel.text=playerObj.income;
	cell.moneyLabel.text=playerObj.money;
	cell.flagImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"flag%d.gif", playerObj.nation]];
}


@end
