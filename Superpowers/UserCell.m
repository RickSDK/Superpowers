//
//  UserCell.m
//  Superpowers
//
//  Created by Rick Medved on 5/25/16.
//
//

#import "UserCell.h"

@implementation UserCell

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

		self.createdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.createdLabel.textAlignment = NSTextAlignmentLeft;
		self.createdLabel.textColor = [UIColor grayColor];
		self.createdLabel.font = [UIFont systemFontOfSize:14];
		self.createdLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.createdLabel];

		self.lastLoginLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.lastLoginLabel.textAlignment = NSTextAlignmentLeft;
		self.lastLoginLabel.textColor = [UIColor grayColor];
		self.lastLoginLabel.font = [UIFont systemFontOfSize:13];
		self.lastLoginLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.lastLoginLabel];

	}
	return self;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	float width=self.frame.size.width;
	
	self.nameLabel.frame = CGRectMake(75.0, 2, width-85, 25);
	self.createdLabel.frame = CGRectMake(75.0, 22, 150, 22);
	self.lastLoginLabel.frame = CGRectMake(190, 22, 140, 22);
}



@end
