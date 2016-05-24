//
//  GameDetailsVC.h
//  Superpowers
//
//  Created by Rick Medved on 2/11/13.
//
//

#import <UIKit/UIKit.h>
#import "GameObj.h"
#import "TemplateVC.h"

@interface GameDetailsVC : TemplateVC {
    IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *typeLabel;
	IBOutlet UILabel *statusLabel;
	IBOutlet UILabel *fogLabel;
	IBOutlet UILabel *skipLabel;
	IBOutlet UITextView *descTextView;
	IBOutlet UISwitch *fogSwitch;
	IBOutlet UISwitch *skipSwitch;
    
	GameObj *gameObj;

}

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *fogLabel;
@property (nonatomic, strong) UILabel *skipLabel;
@property (nonatomic, strong) UITextView *descTextView;
@property (nonatomic, strong) UISwitch *fogSwitch;
@property (nonatomic, strong) UISwitch *skipSwitch;

@property (nonatomic, strong) GameObj *gameObj;


@end
