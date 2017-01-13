//
//  addNewDelegateClass.h
//  
//
//  Created by leonine on 10/8/15.
//
//

#import <UIKit/UIKit.h>

@interface addNewDelegateClass : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)IBOutlet UITableView *moduleTableView;
@property(nonatomic,retain)NSMutableArray *moduleArray;
@property(nonatomic,retain)NSMutableArray *moduleIconArray;
@property(nonatomic,retain)NSMutableArray *moduleIconArray1;
-(IBAction)doneButtonAction:(id)sender;
@end
