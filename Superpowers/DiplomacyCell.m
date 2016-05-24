//
//  DiplomacyCell.m
//  Superpowers
//
//  Created by Rick Medved on 5/3/16.
//
//

#import "DiplomacyCell.h"

@implementation DiplomacyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 45)];
		self.nameLabel.textAlignment = NSTextAlignmentRight;
		self.nameLabel.textColor = [UIColor blackColor];
		self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
		self.nameLabel.numberOfLines=2;
		self.nameLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.nameLabel];
		
		self.offeredLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
		self.offeredLabel.textAlignment = NSTextAlignmentCenter;
		self.offeredLabel.textColor = [UIColor blackColor];
		self.offeredLabel.font = [UIFont boldSystemFontOfSize:14];
		self.offeredLabel.numberOfLines=2;
		self.offeredLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.offeredLabel];
		
		
		self.flagImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag1.gif"]];
		self.flagImg.frame = CGRectMake(10, 50, 45, 45);
		[self.contentView addSubview:self.flagImg];
		
		self.acceptButton = [[CustomButton alloc] initWithFrame:CGRectMake(70, 50, 115, 44)];
		[self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
		[self.contentView addSubview:self.acceptButton];
		
		self.declineButton = [[CustomButton alloc] initWithFrame:CGRectMake(200, 50, 115, 44)];
		[self.declineButton setTitle:@"Decline" forState:UIControlStateNormal];
		[self.contentView addSubview:self.declineButton];
		
		
		
	}
	return self;
}


@end
