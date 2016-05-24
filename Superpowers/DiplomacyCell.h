//
//  DiplomacyCell.h
//  Superpowers
//
//  Created by Rick Medved on 5/3/16.
//
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface DiplomacyCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *offeredLabel;
@property (nonatomic, strong) UIImageView *flagImg;
@property (nonatomic, retain) CustomButton *acceptButton;
@property (nonatomic, retain) CustomButton *declineButton;

@end
