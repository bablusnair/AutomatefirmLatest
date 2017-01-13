//
//  delegateViewClass.h
//  
//
//  Created by leonine on 10/8/15.
//
//

#import <UIKit/UIKit.h>

@interface delegateViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *delegateCollectionView;
@property(nonatomic,retain)IBOutlet UITableView *rulesTavleView;
-(IBAction)addNewDelegateAction:(id)sender;

@end
