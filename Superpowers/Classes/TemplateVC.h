//
//  TemplateVC.h
//  Superpowers
//
//  Created by Rick Medved on 1/16/16.
//
//

#import <UIKit/UIKit.h>
#import "ObjectiveCScripts.h"
#import "WebServicesFunctions.h"
#import "WebServiceView.h"
#import "CustomSegment.h"
#import "GameObj.h"
#import "PopupView.h"

@interface TemplateVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet CustomSegment *mainSegment;

@property (strong, nonatomic) IBOutlet WebServiceView *webServiceView;
@property (strong, nonatomic) IBOutlet PopupView *popupInfoView;
@property (strong, nonatomic) IBOutlet UIView *popupView;
@property (strong, nonatomic) NSMutableArray *webServiceElements;
@property (strong, nonatomic) NSMutableArray *textFieldElements;
@property (strong, nonatomic) NSMutableArray *mainArray;
@property (atomic, strong) GameObj *gameObj;
@property (nonatomic) int terr_id;

-(void)startWebService:(SEL)aSelector message:(NSString *)message;
-(void)stopWebService;
-(void)resignResponders;
- (IBAction) segmentChanged: (id) sender;
- (IBAction) xButtonPressed: (id) sender;

@end
