//
//  settingsViewController.h
//  
//
//  Created by leonine on 12/10/15.
//
//

#import <UIKit/UIKit.h>

@interface settingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)IBOutlet UITableView *mytableview;
@property(nonatomic,retain)NSMutableArray *myarray1;
@property(nonatomic,retain)NSMutableArray *myarray2;
@property(nonatomic,retain)NSMutableArray *myarray3;
@property(nonatomic,retain)NSMutableArray *generalarray;
@property(nonatomic,retain)NSMutableArray *generalarray2;
@property(nonatomic,retain)NSMutableArray *imagearraystaffing;
@property(nonatomic,retain)NSMutableArray *imagearraystaffing2;
@property(nonatomic,retain)NSIndexPath *k;
@property (weak, nonatomic) IBOutlet UIView *settingscontainsview;
@property (strong, nonatomic) IBOutlet UILabel *settingsLabel;
@end
