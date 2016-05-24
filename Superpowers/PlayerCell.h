//
//  PlayerCell.h
//  Superpowers
//
//  Created by Rick Medved on 3/28/13.
//
//

#import <UIKit/UIKit.h>
#import "PlayerObj.h"

@interface PlayerCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *flagImg;
@property (nonatomic, strong) UIImageView *nukeImg;
@property (nonatomic, strong) UIImageView *satImg;
@property (nonatomic, strong) UIImageView *genImg;
@property (nonatomic, strong) UIImageView *leadImg;

+(void)populateCell:(PlayerCell *)cell playerObj:(PlayerObj *)playerObj playerTurn:(int)playerTurn;

@end
