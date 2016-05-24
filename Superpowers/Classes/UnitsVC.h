//
//  UnitsVC.h
//  Superpowers
//
//  Created by Rick Medved on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitsVC : UIViewController {

    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *attLabel;
    IBOutlet UILabel *defLabel;
    IBOutlet UILabel *moveLabel;
    IBOutlet UILabel *typeLabel;
    IBOutlet UILabel *subtypeLabel;
    IBOutlet UILabel *retreatsLabel;
    IBOutlet UILabel *cargoLabel;
    IBOutlet UILabel *costLabel;
    IBOutlet UIImageView *picImageView;
    IBOutlet UITextView *descTextView;
    IBOutlet UITextView *moreTextView;
    NSString *piece;
    BOOL moreFlg;
    int pieceId;
}

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) NSString *piece;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UITextView *descTextView;
@property (nonatomic, strong) UILabel *attLabel;
@property (nonatomic, strong) UILabel *defLabel;
@property (nonatomic, strong) UILabel *moveLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *subtypeLabel;
@property (nonatomic, strong) UILabel *retreatsLabel;
@property (nonatomic, strong) UILabel *cargoLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic) BOOL *moreFlg;
@property (nonatomic) int pieceId;
@property (nonatomic, strong) UITextView *moreTextView;




@end
