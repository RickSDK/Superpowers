//
//  GameCell.h
//  Superpowers
//
//  Created by Rick Medved on 4/11/13.
//
//

#import <UIKit/UIKit.h>
#import "GameObj.h"

@interface GameCell : UITableViewCell

@property (nonatomic, strong) UILabel *gameNameLabel;
@property (nonatomic, strong) UILabel *round1Label;
@property (nonatomic, strong) UILabel *round2Label;
@property (nonatomic, strong) UILabel *turn1Label;
@property (nonatomic, strong) UILabel *turn2Label;
@property (nonatomic, strong) UILabel *attack1Label;
@property (nonatomic, strong) UILabel *attack2Label;
@property (nonatomic, strong) UILabel *time1Label;
@property (nonatomic, strong) UILabel *time2Label;

@property (nonatomic, strong) UILabel *numPlayer1Label;
@property (nonatomic, strong) UILabel *numPlayer2Label;
@property (nonatomic, strong) UILabel *type1Label;
@property (nonatomic, strong) UILabel *type2Label;

@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *autoStartLabel;
@property (nonatomic, strong) UILabel *autoSkipLabel;
@property (nonatomic, strong) UILabel *fogOfWarLabel;

@property (nonatomic, strong) UILabel *playersLabel;
@property (nonatomic, strong) UILabel *lstLogin;

@property (nonatomic, strong) UIImageView *flagImg;
@property (nonatomic, strong) UIView *grayView;


+(void)populateCell:(GameCell *)cell game:(GameObj *)game row:(NSInteger)row;
+(UIColor *)colorForTimeLeft:(NSString *)timeLeft;

@end
