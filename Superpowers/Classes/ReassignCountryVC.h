//
//  ReassignCountryVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/19/16.
//
//

#import "TemplateVC.h"

@interface ReassignCountryVC : TemplateVC

@property (nonatomic, strong) IBOutlet UILabel *countryNameLabel;
@property (atomic, strong) UIBarButtonItem *assignButton;

@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSMutableArray *currentAllies;
@property (nonatomic) int countrySelected;
@property (nonatomic) BOOL countrySelectedFlg;

@end
