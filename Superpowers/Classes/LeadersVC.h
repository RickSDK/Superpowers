//
//  LeadersVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"


@interface LeadersVC : TemplateVC

@property (nonatomic, strong) IBOutlet UIButton *joinButton;
@property (nonatomic, strong) IBOutlet UIButton *leagueButton;
@property (nonatomic) BOOL ladderFlg;
@property (nonatomic) int userRank;
@property (nonatomic) int tag;

- (IBAction) joinButtonPressed: (id) sender;
- (IBAction) leagueButtonPressed: (id) sender;




@end
