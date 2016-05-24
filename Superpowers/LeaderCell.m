//
//  LeaderCell.m
//  Superpowers
//
//  Created by Rick Medved on 4/3/13.
//
//

#import "LeaderCell.h"

@implementation LeaderCell

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
        
        self.winsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.winsLabel.textAlignment = NSTextAlignmentLeft;
        self.winsLabel.textColor = [UIColor blackColor];
        self.winsLabel.font = [UIFont systemFontOfSize:12.0];
        self.winsLabel.backgroundColor = [UIColor clearColor];
        self.winsLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.winsLabel];
        
        self.lossesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lossesLabel.textAlignment = NSTextAlignmentLeft;
        self.lossesLabel.textColor = [UIColor blackColor];
        self.lossesLabel.font = [UIFont systemFontOfSize:12.0];
        self.lossesLabel.backgroundColor = [UIColor clearColor];
        self.lossesLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.lossesLabel];
        
        self.pointsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.pointsLabel.textAlignment = NSTextAlignmentLeft;
        self.pointsLabel.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
        self.pointsLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.pointsLabel.backgroundColor = [UIColor clearColor];
        self.pointsLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.pointsLabel];
        

    }
    return self;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
    
	
	float width=self.frame.size.width;
	int margin=width/8;
	
	self.nameLabel.frame = CGRectMake(50, 2, width-180, 30);
	self.winsLabel.frame = CGRectMake(width-(100+margin), 10, 25, 20);
	self.lossesLabel.frame = CGRectMake(width-(70+margin), 10, 25, 20);
	self.pointsLabel.frame = CGRectMake(width-(42+margin), 10, 40, 20);
	
}


@end
