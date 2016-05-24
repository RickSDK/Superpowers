//
//  UnitListVC.h
//  Superpowers
//
//  Created by Rick Medved on 5/3/13.
//
//

#import <UIKit/UIKit.h>

@interface UnitListVC : UIViewController {
    
	IBOutlet UISegmentedControl *mainSegment;
    IBOutlet UITableView *mainTableView;
    
    NSMutableArray *piecesMultiDimArray;
}

- (IBAction) segmentChanged: (id) sender;


@property (nonatomic, strong) UISegmentedControl *mainSegment;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *piecesMultiDimArray;

@end
